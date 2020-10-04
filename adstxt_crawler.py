#!/usr/bin/env python

########################################################################################################
# Copyright 2017 Hebbian Labs, LLC
# Copyright 2017 IAB TechLab & OpenRTB Group
#
# Author: Neal Richter, neal@hebbian.io
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided
# that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
#    following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
#    the following disclaimer in the documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
########################################################################################################


########################################################################################################
# See README.md file
#
# This is a reference implemenation of an ads.txt crawler that downloads, parses and dumps the data to a SQLiteDB
# The code assumes that you have SQLLite installed and created the DB with the associated SQL file
#
# This code would be suitable for a small scale crawler, however it is missing many production features
# for large scale use, such as parallel HTTP download and parsing of the data files, stateful recovery
# of target servers being down, usage of a real production DB server etc.  Use as a reference for your own
# implementations or harden and enhance this code as needed.
#
########################################################################################################

########################################################################################################
# Hat Tips for code contributions
# Ian Trider
# jhpacker
# brk212
# bradlucas
# nag4
# AntoineJac
# markparolisi 
# sean-mcmann
#
########################################################################################################

import sys
import os
import csv
import socket
import sqlite3
import logging
from optparse import OptionParser
# OR from urllib.parse import urlparse
from urlparse import urlparse
import requests
import re
from requests.packages.urllib3.exceptions import InsecureRequestWarning

requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

#################################################################
# FUNCTION process_row_to_db.
#  handle one row and push to the DB
#
#################################################################

def process_row_to_db(conn, data_row, comment, hostname, adsystem_id):
    insert_stmt = "INSERT OR IGNORE INTO adstxt (SITE_DOMAIN, EXCHANGE_DOMAIN, ADSYSTEM_DOMAIN, SELLER_ACCOUNT_ID, ACCOUNT_TYPE, TAG_ID, ENTRY_COMMENT) VALUES (?, ?, ?, ?, ?, ?, ? );"
    exchange_host     = ''
    seller_account_id = ''
    account_type      = ''
    tag_id            = ''

    if len(data_row) >= 3:
        exchange_host     = data_row[0].lower().strip()
        seller_account_id = data_row[1].lower().strip()
        account_type      = data_row[2].lower().strip()

    if len(data_row) == 4:
        tag_id            = data_row[3].lower().strip()

    #data validation heurstics
    data_valid = 1  

    # Minimum length of a domain name is 1 character, not including extensions.
    # Domain Name Rules - Nic AG
    # www.nic.ag/rules.htm
    if(len(hostname) < 3):
        data_valid = 0

    if(len(exchange_host) < 3):
        data_valid = 0

    if not isinstance(adsystem_id, int):
        data_valid = 0

    # could be single digit integers
    if(len(seller_account_id) < 1):
        data_valid = 0

    # ads.txt supports 'DIRECT' and 'RESELLER'
    if(len(account_type) < 6):
        data_valid = 0

    if(data_valid > 0):
        logging.debug( "%s | %s | %s | %s | %s | %s | %s" % (hostname, exchange_host, adsystem_id, seller_account_id, account_type, tag_id, comment))

        # Insert a row of data using bind variables (protect against sql injection)
        c = conn.cursor()
        try:
            c.execute(insert_stmt, (hostname, exchange_host, adsystem_id, seller_account_id, account_type, tag_id, comment))
            # Save (commit) the changes
            conn.commit()
        except sqlite3.OperationalError as err:
            print(err)
            print(insert_stmt)
            print(hostname, exchange_host, adsystem_id,
                  seller_account_id, account_type, tag_id, comment)

        return 1

    return 0

# end process_row_to_db  #####

#################################################################
# FUNCTION crawl_to_db.
#  crawl the URLs, parse the data, validate and dump to a DB
#
#################################################################

def crawl_to_db(conn, crawl_url_queue):

    rowcnt = 0

    myheaders = {
            'User-Agent': 'AdsTxtCrawler/1.0; +https://github.com/InteractiveAdvertisingBureau/adstxtcrawler',
            'Accept': 'text/plain',
        }

    for aurl in crawl_url_queue:
        ahost = crawl_url_queue[aurl]
        logging.info(" Crawling  %s : %s " % (aurl, ahost))

        # if we can't connect just log a warning and move on.
        try:
            r = requests.get(aurl, headers=myheaders, timeout=2, verify=False)
        except requests.exceptions.RequestException as e:
            logging.warning(e)
            continue

        logging.info("  %d" % r.status_code)

        # disallow anything where r.history > 3 or r.url is not simply /ads.txt
        if(len(r.history) > 3):
            logging.warning("too many redirects")
            continue

        if (re.search('\/ads\.txt$', r.url) is None):
            logging.warning("URL doesn't look look ads.txt")
            continue

        if(r.status_code == 200):
            # HTML content, probably a 404 with the wrong return code
            if (re.search('(<html|<head|<script)', r.text) is not None):
                logging.warning("looks like HTML, skipping")
                continue

            # some line should contain schema-appropriate results
            if (re.search('^([^,]+,){2,3}?[^,]+$', r.text, re.MULTILINE) is None):
                logging.warning("nothing schema appropriate, skipping")
                continue

            logging.debug("-------------")
            logging.debug(r.request.headers)
            logging.debug("-------------")
            logging.debug("%s" % r.text)
            logging.debug("-------------")

            tmpfile = 'tmpads.txt'
            with open(tmpfile, 'wb') as tmp_csv_file:
                r.encoding = 'utf-8'
                tmp_csv_file.write(r.text.strip().encode('ascii', 'ignore').decode('ascii'))
                tmp_csv_file.close()


            # added 'U' for sites that return different newline chars
            with open(tmpfile, 'rU') as tmp_csv_file:
                #read the line, split on first comment and keep what is to the left (if any found)
                line_reader = csv.reader(tmp_csv_file, delimiter='#', quotechar='|')
                comment = ''

                for line in line_reader:
                    logging.debug("DATA:  %s" % line)

                    try:
                        data_line = line[0]
                    except:
                        data_line = ""

                    # determine delimiter, conservative = do it per row
                    if data_line.find(",") != -1:
                        data_delimiter = ','
                    elif data_line.find("\t") != -1:
                        data_delimiter = '\t'
                    else:
                        data_delimiter = ' '

                    data_reader = csv.reader([data_line], delimiter=',', quotechar='|')
                    for row in data_reader:

                        if len(row) > 0 and row[0].startswith('#'):
                            continue

                        if len(row) < 3:
                            continue

                        if (len(line) > 1) and (len(line[1]) > 0):
                             comment = line[1]

                        adsystem_id = fetch_adsystem_id(conn, row[0])
                        rowcnt = rowcnt + process_row_to_db(conn, row, comment, ahost, adsystem_id)

    return rowcnt

# end crawl_to_db  #####

#################################################################
# FUNCTION load_url_queue
#  Load the target set of URLs and reduce to an ads.txt domains queue
#
#################################################################

def load_url_queue(csvfilename, url_queue):
    cnt = 0

    with open(csvfilename, 'rU') as csvfile:
        targets_reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in targets_reader:

            if len(row) < 1 or row[0].startswith('#'):
                continue

            for item in row:
                host = "localhost"

                if "http:" in item or "https:" in item :
                    logging.info( "URL: %s" % item)
                    parsed_uri = urlparse(row[0])
                    host = parsed_uri.netloc
                else:
                    host = item
                    logging.info("HOST: %s" % item)

            skip = 0

            try:
                #print "Checking DNS: %s" % str(host)
                ip = socket.gethostbyname(host)

                if "127.0.0" in ip:
                    skip = 0 # swap to 1 to skip localhost testing
                elif "0.0.0.0" in ip:
                    skip = 1
                else:
                    logging.info("  Validated Host IP: %s" % ip)
            except:
                skip = 1

            if(skip < 1):
                ads_txt_url = 'http://{thehost}/ads.txt'.format(thehost=host).encode('utf-8')
                logging.info("  pushing %s" % ads_txt_url)
                url_queue[ads_txt_url] = host
                cnt = cnt + 1

    return cnt

# end load_url_queue  #####

#################################################################
# FUNCTION fetch_adsystem_id
#  fetch adsystem ID from 'adsystem_domain' table
#
#################################################################

def fetch_adsystem_id(conn, adsystem_domain):
    select_stmt = "SELECT ID FROM adsystem_domain WHERE DOMAIN=?"
    c = conn.cursor()
    c.execute(select_stmt, (adsystem_domain, ))
    return c.fetchone()[0]

# end fetch_adsystem_id  #####

#################################################################
# FUNCTION set_log_file
# setup the log file
#
#################################################################

def set_log_file(log_level):
    """
    Create a log file for the job
    """
    file_name = 'adstxt_crawler.log'
    log_format = '%(asctime)s %(filename)s:%(lineno)d:%(levelname)s  %(message)s'
    log_level = logging.WARNING
    if log_level == 1:
        log_level = logging.INFO
    elif log_level != 2:
        log_level = logging.DEBUG
    logging.basicConfig(filename=file_name, level=log_level, format=log_format)

# end set_log_file  #####


#################################################################
# FUNCTION init_database
# initialize connection and test the DB is alive
#
#################################################################

def init_database(db_name, conn):
    """
    Setup the DB connection and seed with data if needed
    """
    conn = sqlite3.connect(db_name)
    conn.text_factory = lambda x: unicode(x, 'utf-8', 'ignore')
    with open('adstxt_crawler.sql') as fp:
        conn.cursor().executescript(fp.read())

    return conn

# end init_database  #####

#### MAIN ####
# if __name__ == '__main__': ???

# Set default values for persistent data
conn = None
crawl_url_queue = {}
cnt_urls = 0
cnt_records = 0
cnt_urls_processed = 0 # TBA


arg_parser = OptionParser()
arg_parser.add_option("-t", "--targets", dest="target_filename",
                  help="list of domains to crawl ads.txt from", metavar="FILE")
arg_parser.add_option("-d", "--database", dest="target_database",
                  help="Database to dump crawled data into", metavar="FILE")
arg_parser.add_option("-v", "--verbose", dest="verbose", action='count',
                  help="Increase verbosity (specify multiple times for more)")

(options, args) = arg_parser.parse_args()

# Exit with help info if no args passed
if len(sys.argv)==1:
    arg_parser.print_help()
    exit(1)

set_log_file(options.verbose)

# Exit with help if no DB file passed
if options.target_database and len(options.target_database) > 1:
    conn = init_database(options.target_database, conn)
else:
    print("%sMissing Database file name argument %s" %
          ('\033[91m', '\033[0m'))
    arg_parser.print_help()
    exit(1)

# Exit with help if no target domains file passed
if options.target_filename and len(options.target_filename) > 1:
    cnt_urls = load_url_queue(options.target_filename, crawl_url_queue)
else:
    print("%sMissing target domains file name argument %s" %
          ('\033[91m', '\033[0m'))
    arg_parser.print_help()
    exit(1)

if (cnt_urls > 0) and options.target_database and (len(options.target_database) > 1):
    conn = sqlite3.connect(options.target_database)

with conn:
    cnt_records = crawl_to_db(conn, crawl_url_queue)
    if(cnt_records > 0):
        conn.commit()
    #conn.close()


    print("%sWrote %d records from %d URLs to %s %s" %
          ('\033[92m', cnt_records, cnt_urls, options.target_database, '\033[0m'))

logging.warning("Wrote %d records from %d URLs to %s" % (cnt_records, cnt_urls, options.target_database))
logging.warning("Finished.")
