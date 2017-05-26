DROP TABLE IF EXISTS adstxt;

CREATE TABLE adstxt(
       SITE_DOMAIN                  TEXT    NOT NULL,
       EXCHANGE_DOMAIN              TEXT    NOT NULL,
       SELLER_ACCOUNT_ID            TEXT    NOT NULL,
       ACCOUNT_TYPE                 TEXT    NOT NULL,
       TAG_ID                       TEXT    NOT NULL,
       UPDATED                      DATE    DEFAULT (datetime('now','localtime')),
    PRIMARY KEY (SITE_DOMAIN,EXCHANGE_DOMAIN,SELLER_ACCOUNT_ID)
);

select * from adstxt;
