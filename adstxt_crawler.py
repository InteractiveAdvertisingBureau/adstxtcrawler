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

import sys
import csv
import socket
import sqlite3
import logging
from optparse import OptionParser
from urlparse import urlparse
#pip install requests
import requests

#################################################################
# FUNCTION crawl_to_db.
#  crawl the URLs, parse the data, validate and dump to a DB
#
#################################################################

def crawl_to_db(conn, crawl_url_queue):

    rowcnt = 0
    insert_stmt = "INSERT OR IGNORE INTO adstxt (SITE_DOMAIN, EXCHANGE_DOMAIN, SELLER_ACCOUNT_ID, ACCOUNT_TYPE, TAG_ID) VALUES (?, ?, ?, ?, ? );"

    for aurl in crawl_url_queue:
        ahost = crawl_url_queue[aurl]
        logging.info("  %s : %s " % (aurl, ahost))
        r = requests.get(aurl)
        logging.info("  %d" % r.status_code)

        if(r.status_code == 200):
            logging.debug("-------------")
            logging.debug("%s" % r.text)
            logging.debug("-------------")

            tmpfile = 'tmpads.txt'
            with open(tmpfile, 'wb') as tmp_csv_file:
                tmp_csv_file.write(r.text)
                tmp_csv_file.close()

            with open(tmpfile, 'rb') as tmp_csv_file:
                data_reader = csv.reader(tmp_csv_file, delimiter=',', quotechar='|')
                for row in data_reader:

                    if len(row) > 0 and row[0].startswith( '#' ):
                        continue

                    exchange_host     = ''
                    seller_account_id = ''
                    account_type      = ''
                    tag_id            = ''

                    if len(row) >= 3:
                        exchange_host     = row[0]
                        seller_account_id = row[1]
                        account_type      = row[2]

                    if len(row) == 4:
                        tag_id            = row[3]


                    data_valid = 1;


                    #data validation heurstics

                    # Minimum length of a domain name is 1 character, not including extensions.
                    # Domain Name Rules - Nic AG
                    # www.nic.ag/rules.htm
                    if(len(ahost) < 3):
                        data_valid = 0

                    if(len(exchange_host) < 3):
                        data_valid = 0

                    # could be single digit integers
                    if(len(seller_account_id) < 1):
                        data_valid = 0

                    ## ads.txt supports 'DIRECT' and 'RESELLER'
                    if(len(account_type) < 6):
                        data_valid = 0


                    if(data_valid > 0):
                        logging.debug( "%s | %s | %s | %s | %s" % (ahost, exchange_host, seller_account_id, account_type, tag_id))

                        # Insert a row of data using bind variables (protect against sql injection)
                        c = conn.cursor()
                        c.execute(insert_stmt, (ahost, exchange_host, seller_account_id, account_type, tag_id))
                        rowcnt = rowcnt + 1

                        # Save (commit) the changes
                        conn.commit()

    return rowcnt

# end crawl_to_db  #####

#################################################################
# FUNCTION load_url_queue
#  Load the target set of URLs and reduce to an ads.txt domains queue
#
#################################################################

def load_url_queue(csvfilename, url_queue):
    cnt = 0

    with open(csvfilename, 'rb') as csvfile:
        targets_reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in targets_reader:

            if row[0].startswith( '#' ):
                continue

            for item in row:
                host = "localhost"

                if  "http:" in item or "https:" in item :
                    logging.info( "URL: %s" % item)
                    parsed_uri = urlparse(row[0])
                    host = parsed_uri.netloc
                else:
                    host = item
                    logging.info( "HOST: %s" % item)

                #print "Checking DNS: %s" % host
                ip = socket.gethostbyname(host)

            skip = 0
            if "127.0.0" in ip:
                skip = 1
            elif "0.0.0.0" in ip:
                skip = 1
            else:
                logging.info("  Validated Host IP: %s" % ip)

            ads_txt_url = 'http://{thehost}/ads.txt'.format(thehost=host)

            logging.info("  pushing %s" % ads_txt_url)
            url_queue[ads_txt_url] = host
            cnt = cnt + 1

    return cnt

# end load_url_queue  #####

#### MAIN ####

arg_parser = OptionParser()
arg_parser.add_option("-t", "--targets", dest="target_filename",
                  help="list of domains to crawl ads.txt from", metavar="FILE")
arg_parser.add_option("-d", "--database", dest="target_database",
                  help="Database to dump crawled data into", metavar="FILE")
arg_parser.add_option("-v", "--verbose", dest="verbose", action='count',
                  help="Increase verbosity (specify multiple times for more)")

(options, args) = arg_parser.parse_args()

if len(sys.argv)==1:
    arg_parser.print_help()
    exit(1)

log_level = logging.WARNING # default
if options.verbose == 1:
    log_level = logging.INFO
elif options.verbose >= 2:
    log_level = logging.DEBUG
logging.basicConfig(filename='adstxt_crawler.log',level=log_level,format='%(asctime)s %(filename)s:%(lineno)d:%(levelname)s  %(message)s')

crawl_url_queue = {}
conn = None
cnt_urls = 0
cnt_records = 0

cnt_urls = load_url_queue(options.target_filename, crawl_url_queue)

if (cnt_urls > 0) and options.target_database and (len(options.target_database) > 1):
    conn = sqlite3.connect(options.target_database)

with conn:
    cnt_records = crawl_to_db(conn, crawl_url_queue)
    if(cnt_records > 0):
        conn.commit()
    #conn.close()

print "Wrote %d records from %d URLs to %s" % (cnt_records, cnt_urls, options.target_database)

logging.warning("Wrote %d records from %d URLs to %s" % (cnt_records, cnt_urls, options.target_database))
logging.warning("Finished.")

