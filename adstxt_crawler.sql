BEGIN TRANSACTION;

DROP TABLE IF EXISTS adstxt;

CREATE TABLE adstxt(
       SITE_DOMAIN                  TEXT    NOT NULL,
       EXCHANGE_DOMAIN              TEXT    NOT NULL,
       ADSYSTEM_DOMAIN		    INTEGER     NOT NULL DEFAULT (0),
       SELLER_ACCOUNT_ID            TEXT    NOT NULL,
       ACCOUNT_TYPE                 TEXT    NOT NULL,
       TAG_ID                       TEXT    NOT NULL,
       ENTRY_COMMENT                TEXT    NOT NULL,
       UPDATED                      DATE    DEFAULT (datetime('now','utc')),
    PRIMARY KEY (SITE_DOMAIN,EXCHANGE_DOMAIN,SELLER_ACCOUNT_ID)
);

DROP TABLE IF EXISTS adstxt_contentdistributor;

CREATE TABLE adstxt_contentdistributor(
       SITE_DOMAIN                  TEXT    NOT NULL,
       PRODUCER_DOMAIN           TEXT    NOT NULL,
       ENTRY_COMMENT                TEXT    NOT NULL,
       UPDATED                      DATE    DEFAULT (datetime('now','utc')),
    PRIMARY KEY (SITE_DOMAIN,PRODUCER_DOMAIN)
);

DROP TABLE IF EXISTS adstxt_contentproducer;

CREATE TABLE adstxt_contentproducer(
       SITE_DOMAIN                  TEXT    NOT NULL,
       DISTRIBUTOR_DOMAIN              TEXT    NOT NULL,
       ENTRY_COMMENT                TEXT    NOT NULL,
       UPDATED                      DATE    DEFAULT (datetime('now','utc')),
    PRIMARY KEY (SITE_DOMAIN,DISTRIBUTOR_DOMAIN)
);

DROP TABLE IF EXISTS adsystem_domain;

CREATE TABLE "adsystem_domain" (
	DOMAIN	TEXT,
	ID	INTEGER,
	PRIMARY KEY(DOMAIN,ID)
);

--  VALUES BELOW

INSERT INTO `adsystem_domain` VALUES ('adtech.com',11);
INSERT INTO `adsystem_domain` VALUES ('aolcloud.net',11);
INSERT INTO `adsystem_domain` VALUES ('appnexus.com',84);
INSERT INTO `adsystem_domain` VALUES ('districtm.io',96);
INSERT INTO `adsystem_domain` VALUES ('google.com',8);
INSERT INTO `adsystem_domain` VALUES ('indexechange.com',48);
INSERT INTO `adsystem_domain` VALUES ('indexexchange.com',48);
INSERT INTO `adsystem_domain` VALUES ('indexexchnage.com',48);
INSERT INTO `adsystem_domain` VALUES ('openx.com',4);
INSERT INTO `adsystem_domain` VALUES ('pubmatic.com',3);
INSERT INTO `adsystem_domain` VALUES ('rubicon.com',1);
INSERT INTO `adsystem_domain` VALUES ('rubiconproject.com',1);
INSERT INTO `adsystem_domain` VALUES ('spotx.tv',44);
INSERT INTO `adsystem_domain` VALUES ('spotxchange.com',44);
INSERT INTO `adsystem_domain` VALUES ('spx.smaato.com',17);
INSERT INTO `adsystem_domain` VALUES ('teads.tv',94);
INSERT INTO `adsystem_domain` VALUES ('pulsepoint.com',95);
INSERT INTO `adsystem_domain` VALUES ('aol.com',15);
INSERT INTO `adsystem_domain` VALUES ('liveintent.com',12);
INSERT INTO `adsystem_domain` VALUES ('triplelift.com',83);
INSERT INTO `adsystem_domain` VALUES ('teads.com',94);
INSERT INTO `adsystem_domain` VALUES ('contextweb.com',95);
INSERT INTO `adsystem_domain` VALUES ('sharethrough.com',97);
INSERT INTO `adsystem_domain` VALUES ('districtm.ca',96);
INSERT INTO `adsystem_domain` VALUES ('sovrn.com',23);
INSERT INTO `adsystem_domain` VALUES ('smaato.com',17);
INSERT INTO `adsystem_domain` VALUES ('coxmt.com',86);
INSERT INTO `adsystem_domain` VALUES ('lijit.com',23);
INSERT INTO `adsystem_domain` VALUES ('www.indexexchange.com',48);
INSERT INTO `adsystem_domain` VALUES ('tremorhub.com',77);
INSERT INTO `adsystem_domain` VALUES ('appnexus',84);
INSERT INTO `adsystem_domain` VALUES ('advertising.com',88);
INSERT INTO `adsystem_domain` VALUES ('fastlane.rubiconproject.com',1);
INSERT INTO `adsystem_domain` VALUES ('33across.com',2);
INSERT INTO `adsystem_domain` VALUES ('facebook.com',5);
INSERT INTO `adsystem_domain` VALUES ('gumgum.com',6);
INSERT INTO `adsystem_domain` VALUES ('kargo.com',7);
INSERT INTO `adsystem_domain` VALUES ('brealtime.com',9);
INSERT INTO `adsystem_domain` VALUES ('c.amazon-adsystem.com',10);
INSERT INTO `adsystem_domain` VALUES ('yieldmo.com',13);
INSERT INTO `adsystem_domain` VALUES ('taboola.com',18);
INSERT INTO `adsystem_domain` VALUES ('sofia.trustx.org',19);
INSERT INTO `adsystem_domain` VALUES ('a9.com',10);
INSERT INTO `adsystem_domain` VALUES ('amazon.com',10);
INSERT INTO `adsystem_domain` VALUES ('lkqd.com',20);
INSERT INTO `adsystem_domain` VALUES ('criteo.com',21);
INSERT INTO `adsystem_domain` VALUES ('exponential.com',22);
INSERT INTO `adsystem_domain` VALUES ('yldbt.com',25);
INSERT INTO `adsystem_domain` VALUES ('rhythmone.com',24);
INSERT INTO `adsystem_domain` VALUES ('technorati.com',26);
INSERT INTO `adsystem_domain` VALUES ('bidfluence.com',27);
INSERT INTO `adsystem_domain` VALUES ('switch.com',28);
INSERT INTO `adsystem_domain` VALUES ('amazon-adsystem.com',10);
INSERT INTO `adsystem_domain` VALUES ('conversantmedia.com',30);
INSERT INTO `adsystem_domain` VALUES ('sonobi.com',31);
INSERT INTO `adsystem_domain` VALUES ('spoutable.com',32);
INSERT INTO `adsystem_domain` VALUES ('trustx.org',19);
INSERT INTO `adsystem_domain` VALUES ('freewheel.tv',33);
INSERT INTO `adsystem_domain` VALUES ('connatix.com',34);
INSERT INTO `adsystem_domain` VALUES ('lkqd.net',20);
INSERT INTO `adsystem_domain` VALUES ('positivemobile.com',36);
INSERT INTO `adsystem_domain` VALUES ('memeglobal.com',37);
INSERT INTO `adsystem_domain` VALUES ('kixer.com',38);
INSERT INTO `adsystem_domain` VALUES ('sekindo.com',39);
INSERT INTO `adsystem_domain` VALUES ('360yield.com',40);
INSERT INTO `adsystem_domain` VALUES ('cdn.stickyadstv.com',33);
INSERT INTO `adsystem_domain` VALUES ('adform.com',41);
INSERT INTO `adsystem_domain` VALUES ('streamrail.net',45);
INSERT INTO `adsystem_domain` VALUES ('mathtag.com',46);
INSERT INTO `adsystem_domain` VALUES ('adyoulike.com',47);
INSERT INTO `adsystem_domain` VALUES ('kiosked.com',50);
INSERT INTO `adsystem_domain` VALUES ('video.unrulymedia.com',51);
INSERT INTO `adsystem_domain` VALUES ('meridian.sovrn.com',23);
INSERT INTO `adsystem_domain` VALUES ('brightcom.com',52);
INSERT INTO `adsystem_domain` VALUES ('smartadserver.com',64);
INSERT INTO `adsystem_domain` VALUES ('apnexus.com',84);
INSERT INTO `adsystem_domain` VALUES ('jadserve.postrelease.com',56);
INSERT INTO `adsystem_domain` VALUES ('rs-stripe.com',53);
INSERT INTO `adsystem_domain` VALUES ('fyber.com',54);
INSERT INTO `adsystem_domain` VALUES ('inner-active.com',43);
INSERT INTO `adsystem_domain` VALUES ('tidaltv.com',55);
INSERT INTO `adsystem_domain` VALUES ('critero.com',21);
INSERT INTO `adsystem_domain` VALUES ('advertising.amazon.com',10);
INSERT INTO `adsystem_domain` VALUES ('nativo.com',56);
INSERT INTO `adsystem_domain` VALUES ('media.net',57);
INSERT INTO `adsystem_domain` VALUES ('www.yumenetworks.com',58);
INSERT INTO `adsystem_domain` VALUES ('revcontent.com',59);
INSERT INTO `adsystem_domain` VALUES ('adtech.net',11);
INSERT INTO `adsystem_domain` VALUES ('go.sonobi.com',31);
INSERT INTO `adsystem_domain` VALUES ('outbrain.com',60);
INSERT INTO `adsystem_domain` VALUES ('ib.adnxs.com',84);
INSERT INTO `adsystem_domain` VALUES ('freeskreen.com',62);
INSERT INTO `adsystem_domain` VALUES ('bidtellect.com',63);
INSERT INTO `adsystem_domain` VALUES ('loopme.com',65);
INSERT INTO `adsystem_domain` VALUES ('vidazoo.com',66);
INSERT INTO `adsystem_domain` VALUES ('videoflare.com',67);
INSERT INTO `adsystem_domain` VALUES ('yahoo.com',68);
INSERT INTO `adsystem_domain` VALUES ('yume.com',58);
INSERT INTO `adsystem_domain` VALUES ('pixfuture.com',69);
INSERT INTO `adsystem_domain` VALUES ('advertising.com',70);
INSERT INTO `adsystem_domain` VALUES ('kargo.com',71);
INSERT INTO `adsystem_domain` VALUES ('aps.amazon.com',72);
INSERT INTO `adsystem_domain` VALUES ('behave.com',73);
INSERT INTO `adsystem_domain` VALUES ('engagebdr.com',74);
INSERT INTO `adsystem_domain` VALUES ('my6sense.com',75);
INSERT INTO `adsystem_domain` VALUES ('nobid.io',76);
INSERT INTO `adsystem_domain` VALUES ('synacor.com',77);
INSERT INTO `adsystem_domain` VALUES ('telaria.com',78);
INSERT INTO `adsystem_domain` VALUES ('themediagrid.com',79);
INSERT INTO `adsystem_domain` VALUES ('tribalfusion.com',80);
INSERT INTO `adsystem_domain` VALUES ('undertone.com',81);
INSERT INTO `adsystem_domain` VALUES ('sortable.com',82);
INSERT INTO `adsystem_domain` VALUES ('deployads.com',82);

INSERT INTO `adsystem_domain` VALUES ('green_ssp.com',1001);
INSERT INTO `adsystem_domain` VALUES ('violet_ssp.com',1002);
INSERT INTO `adsystem_domain` VALUES ('grey_ssp.com',1003);

DROP TABLE IF EXISTS adsystem;
CREATE TABLE "adsystem" (
	ID	INTEGER,
	NAME	TEXT,
	CANONICAL_DOMAIN	TEXT,
	PRIMARY KEY(ID)
);
INSERT INTO `adsystem` VALUES (1,'Rubicon',"rubiconproject.com");
INSERT INTO `adsystem` VALUES (2,'33Across',NULL);
INSERT INTO `adsystem` VALUES (3,'PubMatic','pubmatic.com');
INSERT INTO `adsystem` VALUES (4,'OpenX','openx.com');
INSERT INTO `adsystem` VALUES (5,'Facebook',NULL);
INSERT INTO `adsystem` VALUES (6,'GumGum',NULL);
INSERT INTO `adsystem` VALUES (7,'Kargo',NULL);
INSERT INTO `adsystem` VALUES (8,'Google','google.com');
INSERT INTO `adsystem` VALUES (9,'bRealtime',NULL);
INSERT INTO `adsystem` VALUES (10,'Amazon',NULL);
INSERT INTO `adsystem` VALUES (11,'One by AOL: Display',NULL);
INSERT INTO `adsystem` VALUES (12,'LiveIntent',NULL);
INSERT INTO `adsystem` VALUES (13,'Yieldmo',NULL);
INSERT INTO `adsystem` VALUES (14,'MoPub',NULL);
INSERT INTO `adsystem` VALUES (15,'One by AOL: Mobile','aol.com');
INSERT INTO `adsystem` VALUES (17,'Smaato',NULL);
INSERT INTO `adsystem` VALUES (18,'Taboola',NULL);
INSERT INTO `adsystem` VALUES (19,'TrustX',NULL);
INSERT INTO `adsystem` VALUES (20,'LKQD',NULL);
INSERT INTO `adsystem` VALUES (21,'Criteo',NULL);
INSERT INTO `adsystem` VALUES (22,'Exponential',NULL);
INSERT INTO `adsystem` VALUES (23,'Sovrn',NULL);
INSERT INTO `adsystem` VALUES (24,'RhythmOne',NULL);
INSERT INTO `adsystem` VALUES (25,'Yieldbot',NULL);
INSERT INTO `adsystem` VALUES (26,'Technorati',NULL);
INSERT INTO `adsystem` VALUES (27,'Bidfluence',NULL);
INSERT INTO `adsystem` VALUES (28,'Switch Concepts',NULL);
INSERT INTO `adsystem` VALUES (29,'BrightRoll Exchange',NULL);
INSERT INTO `adsystem` VALUES (30,'Conversant',NULL);
INSERT INTO `adsystem` VALUES (31,'Sonobi',NULL);
INSERT INTO `adsystem` VALUES (32,'Spoutable',NULL);
INSERT INTO `adsystem` VALUES (33,'FreeWheel',NULL);
INSERT INTO `adsystem` VALUES (34,'Connatix',NULL);
INSERT INTO `adsystem` VALUES (35,'Centro Brand Exchange',NULL);
INSERT INTO `adsystem` VALUES (36,'Positive Mobile',NULL);
INSERT INTO `adsystem` VALUES (37,'MemeGlobal',NULL);
INSERT INTO `adsystem` VALUES (38,'Kixer',NULL);
INSERT INTO `adsystem` VALUES (39,'Sekindo',NULL);
INSERT INTO `adsystem` VALUES (40,'Improve Digital','improvedigital.com');
INSERT INTO `adsystem` VALUES (41,'AdForm',NULL);
INSERT INTO `adsystem` VALUES (42,'MADS',NULL);
INSERT INTO `adsystem` VALUES (43,'Inneractive','inner-active.com');
INSERT INTO `adsystem` VALUES (44,'SpotX',NULL);
INSERT INTO `adsystem` VALUES (45,'StreamRail',NULL);
INSERT INTO `adsystem` VALUES (46,'MediaMath',NULL);
INSERT INTO `adsystem` VALUES (47,'AdYouLike',NULL);
INSERT INTO `adsystem` VALUES (48,'Index Exchange','indexexchange.com');
INSERT INTO `adsystem` VALUES (49,'e-Planning',NULL);
INSERT INTO `adsystem` VALUES (50,'Kiosked',NULL);
INSERT INTO `adsystem` VALUES (51,'UnrulyX',NULL);
INSERT INTO `adsystem` VALUES (52,'Brightcom',NULL);
INSERT INTO `adsystem` VALUES (53,'PowerInbox',NULL);
INSERT INTO `adsystem` VALUES (54,'Fyber','fyber.com');
INSERT INTO `adsystem` VALUES (55,'TidalTV',NULL);
INSERT INTO `adsystem` VALUES (56,'Nativo',NULL);
INSERT INTO `adsystem` VALUES (57,'Media.net',NULL);
INSERT INTO `adsystem` VALUES (58,'YuMe',NULL);
INSERT INTO `adsystem` VALUES (59,'RevContent',NULL);
INSERT INTO `adsystem` VALUES (60,'Outbrain',NULL);
INSERT INTO `adsystem` VALUES (61,'Zedo',NULL);
INSERT INTO `adsystem` VALUES (62,'SlimCut Media',NULL);
INSERT INTO `adsystem` VALUES (63,'Bidtellect',NULL);
INSERT INTO `adsystem` VALUES (64,'Smart RTB+',NULL);
INSERT INTO `adsystem` VALUES (65,'LoopMe',NULL);
INSERT INTO `adsystem` VALUES (66,'Vidazoo',NULL);
INSERT INTO `adsystem` VALUES (67,'Videoflare',NULL);
INSERT INTO `adsystem` VALUES (68,'Yahoo Ad Exchange',NULL);
INSERT INTO `adsystem` VALUES (69,'PixFuture',NULL);
INSERT INTO `adsystem` VALUES (77,'Tremor',NULL);
INSERT INTO `adsystem` VALUES (82,'Sortable','sortable.com');
INSERT INTO `adsystem` VALUES (83,'TripleLift',NULL);
INSERT INTO `adsystem` VALUES (84,'AppNexus','appnexus.com');
INSERT INTO `adsystem` VALUES (86,'COMET',NULL);
INSERT INTO `adsystem` VALUES (88,'One by AOL: Video','advertising.com');
INSERT INTO `adsystem` VALUES (94,'Teads','teads.tv');
INSERT INTO `adsystem` VALUES (95,'PulsePoint',NULL);
INSERT INTO `adsystem` VALUES (96,'District M',NULL);
INSERT INTO `adsystem` VALUES (97,'Sharethrough',NULL);

INSERT INTO `adsystem` VALUES (1001,'Green SSP (Demo)','green_ssp.com');
INSERT INTO `adsystem` VALUES (1002,'Violet SSP (Demo)','violet_ssp.com');
INSERT INTO `adsystem` VALUES (1003,'Grey SSP (Demo)','grey_ssp.com');

COMMIT;

