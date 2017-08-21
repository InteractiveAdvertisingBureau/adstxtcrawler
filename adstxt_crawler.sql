BEGIN TRANSACTION;
DROP TABLE IF EXISTS adstxt;

CREATE TABLE adstxt(
       SITE_DOMAIN                  TEXT    NOT NULL,
       EXCHANGE_DOMAIN              TEXT    NOT NULL,
       SELLER_ACCOUNT_ID            TEXT    NOT NULL,
       ACCOUNT_TYPE                 TEXT    NOT NULL,
       TAG_ID                       TEXT    NOT NULL,
       ENTRY_COMMENT                TEXT    NOT NULL,
       UPDATED                      DATE    DEFAULT (datetime('now','localtime')),
    PRIMARY KEY (SITE_DOMAIN,EXCHANGE_DOMAIN,SELLER_ACCOUNT_ID)
);

CREATE TABLE "AdSystemDomain" (
	`domain`	TEXT,
	`adSystem_adSystemId`	INTEGER,
	PRIMARY KEY(`domain`,`adSystem_adSystemId`)
);
INSERT INTO `AdSystemDomain` VALUES ('adtech.com',11);
INSERT INTO `AdSystemDomain` VALUES ('aolcloud.net',11);
INSERT INTO `AdSystemDomain` VALUES ('appnexus.com',84);
INSERT INTO `AdSystemDomain` VALUES ('districtm.io',96);
INSERT INTO `AdSystemDomain` VALUES ('google.com',8);
INSERT INTO `AdSystemDomain` VALUES ('indexechange.com',48);
INSERT INTO `AdSystemDomain` VALUES ('indexexchange.com',48);
INSERT INTO `AdSystemDomain` VALUES ('indexexchnage.com',48);
INSERT INTO `AdSystemDomain` VALUES ('openx.com',4);
INSERT INTO `AdSystemDomain` VALUES ('pubmatic.com',3);
INSERT INTO `AdSystemDomain` VALUES ('rubicon.com',1);
INSERT INTO `AdSystemDomain` VALUES ('rubiconproject.com',1);
INSERT INTO `AdSystemDomain` VALUES ('spotx.tv',44);
INSERT INTO `AdSystemDomain` VALUES ('spotxchange.com',44);
INSERT INTO `AdSystemDomain` VALUES ('spx.smaato.com',17);
INSERT INTO `AdSystemDomain` VALUES ('teads.tv',94);
INSERT INTO `AdSystemDomain` VALUES ('pulsepoint.com',95);
INSERT INTO `AdSystemDomain` VALUES ('aol.com',15);
INSERT INTO `AdSystemDomain` VALUES ('liveintent.com',12);
INSERT INTO `AdSystemDomain` VALUES ('triplelift.com',83);
INSERT INTO `AdSystemDomain` VALUES ('teads.com',94);
INSERT INTO `AdSystemDomain` VALUES ('contextweb.com',95);
INSERT INTO `AdSystemDomain` VALUES ('sharethrough.com',97);
INSERT INTO `AdSystemDomain` VALUES ('districtm.ca',96);
INSERT INTO `AdSystemDomain` VALUES ('sovrn.com',23);
INSERT INTO `AdSystemDomain` VALUES ('smaato.com',17);
INSERT INTO `AdSystemDomain` VALUES ('coxmt.com',86);
INSERT INTO `AdSystemDomain` VALUES ('lijit.com',23);
INSERT INTO `AdSystemDomain` VALUES ('www.indexexchange.com',48);
INSERT INTO `AdSystemDomain` VALUES ('tremorhub.com',77);
INSERT INTO `AdSystemDomain` VALUES ('appnexus',84);
INSERT INTO `AdSystemDomain` VALUES ('advertising.com',88);
INSERT INTO `AdSystemDomain` VALUES ('fastlane.rubiconproject.com',1);
INSERT INTO `AdSystemDomain` VALUES ('33across.com',2);
INSERT INTO `AdSystemDomain` VALUES ('facebook.com',5);
INSERT INTO `AdSystemDomain` VALUES ('gumgum.com',6);
INSERT INTO `AdSystemDomain` VALUES ('kargo.com',7);
INSERT INTO `AdSystemDomain` VALUES ('brealtime.com',9);
INSERT INTO `AdSystemDomain` VALUES ('c.amazon-adsystem.com',10);
INSERT INTO `AdSystemDomain` VALUES ('yieldmo.com',13);
INSERT INTO `AdSystemDomain` VALUES ('taboola.com',18);
INSERT INTO `AdSystemDomain` VALUES ('sofia.trustx.org',19);
INSERT INTO `AdSystemDomain` VALUES ('a9.com',10);
INSERT INTO `AdSystemDomain` VALUES ('amazon.com',10);
INSERT INTO `AdSystemDomain` VALUES ('lkqd.com',20);
INSERT INTO `AdSystemDomain` VALUES ('criteo.com',21);
INSERT INTO `AdSystemDomain` VALUES ('exponential.com',22);
INSERT INTO `AdSystemDomain` VALUES ('yldbt.com',25);
INSERT INTO `AdSystemDomain` VALUES ('rhythmone.com',24);
INSERT INTO `AdSystemDomain` VALUES ('technorati.com',26);
INSERT INTO `AdSystemDomain` VALUES ('bidfluence.com',27);
INSERT INTO `AdSystemDomain` VALUES ('switch.com',28);
INSERT INTO `AdSystemDomain` VALUES ('amazon-adsystem.com',10);
INSERT INTO `AdSystemDomain` VALUES ('conversantmedia.com',30);
INSERT INTO `AdSystemDomain` VALUES ('sonobi.com',31);
INSERT INTO `AdSystemDomain` VALUES ('spoutable.com',32);
INSERT INTO `AdSystemDomain` VALUES ('trustx.org',19);
INSERT INTO `AdSystemDomain` VALUES ('freewheel.tv',33);
INSERT INTO `AdSystemDomain` VALUES ('connatix.com',34);
INSERT INTO `AdSystemDomain` VALUES ('lkqd.net',20);
INSERT INTO `AdSystemDomain` VALUES ('positivemobile.com',36);
INSERT INTO `AdSystemDomain` VALUES ('memeglobal.com',37);
INSERT INTO `AdSystemDomain` VALUES ('kixer.com',38);
INSERT INTO `AdSystemDomain` VALUES ('sekindo.com',39);
INSERT INTO `AdSystemDomain` VALUES ('360yield.com',40);
INSERT INTO `AdSystemDomain` VALUES ('cdn.stickyadstv.com',33);
INSERT INTO `AdSystemDomain` VALUES ('adform.com',41);
INSERT INTO `AdSystemDomain` VALUES ('streamrail.net',45);
INSERT INTO `AdSystemDomain` VALUES ('mathtag.com',46);
INSERT INTO `AdSystemDomain` VALUES ('adyoulike.com',47);
INSERT INTO `AdSystemDomain` VALUES ('kiosked.com',50);
INSERT INTO `AdSystemDomain` VALUES ('video.unrulymedia.com',51);
INSERT INTO `AdSystemDomain` VALUES ('meridian.sovrn.com',23);
INSERT INTO `AdSystemDomain` VALUES ('brightcom.com',52);
INSERT INTO `AdSystemDomain` VALUES ('smartadserver.com',64);
INSERT INTO `AdSystemDomain` VALUES ('apnexus.com',84);
INSERT INTO `AdSystemDomain` VALUES ('jadserve.postrelease.com',56);
INSERT INTO `AdSystemDomain` VALUES ('rs-stripe.com',53);
INSERT INTO `AdSystemDomain` VALUES ('fyber.com',54);
INSERT INTO `AdSystemDomain` VALUES ('inner-active.com',43);
INSERT INTO `AdSystemDomain` VALUES ('tidaltv.com',55);
INSERT INTO `AdSystemDomain` VALUES ('critero.com',21);
INSERT INTO `AdSystemDomain` VALUES ('advertising.amazon.com',10);
INSERT INTO `AdSystemDomain` VALUES ('nativo.com',56);
INSERT INTO `AdSystemDomain` VALUES ('media.net',57);
INSERT INTO `AdSystemDomain` VALUES ('www.yumenetworks.com',58);
INSERT INTO `AdSystemDomain` VALUES ('revcontent.com',59);
INSERT INTO `AdSystemDomain` VALUES ('adtech.net',11);
INSERT INTO `AdSystemDomain` VALUES ('go.sonobi.com',31);
INSERT INTO `AdSystemDomain` VALUES ('outbrain.com',60);
INSERT INTO `AdSystemDomain` VALUES ('ib.adnxs.com',84);
INSERT INTO `AdSystemDomain` VALUES ('freeskreen.com',62);
INSERT INTO `AdSystemDomain` VALUES ('bidtellect.com',63);
INSERT INTO `AdSystemDomain` VALUES ('loopme.com',65);
INSERT INTO `AdSystemDomain` VALUES ('vidazoo.com',66);
INSERT INTO `AdSystemDomain` VALUES ('videoflare.com',67);
INSERT INTO `AdSystemDomain` VALUES ('yahoo.com',68);
INSERT INTO `AdSystemDomain` VALUES ('yume.com',58);
INSERT INTO `AdSystemDomain` VALUES ('pixfuture.com',69);
CREATE TABLE "AdSystem" (
	`adSystemId`	INTEGER,
	`name`	TEXT,
	`canonicalDomain`	TEXT,
	PRIMARY KEY(`adSystemId`)
);
INSERT INTO `AdSystem` VALUES (1,'Rubicon',NULL);
INSERT INTO `AdSystem` VALUES (2,'33Across',NULL);
INSERT INTO `AdSystem` VALUES (3,'PubMatic','pubmatic.com');
INSERT INTO `AdSystem` VALUES (4,'OpenX','openx.com');
INSERT INTO `AdSystem` VALUES (5,'Facebook',NULL);
INSERT INTO `AdSystem` VALUES (6,'GumGum',NULL);
INSERT INTO `AdSystem` VALUES (7,'Kargo',NULL);
INSERT INTO `AdSystem` VALUES (8,'Google','google.com');
INSERT INTO `AdSystem` VALUES (9,'bRealtime',NULL);
INSERT INTO `AdSystem` VALUES (10,'Amazon',NULL);
INSERT INTO `AdSystem` VALUES (11,'One by AOL: Display',NULL);
INSERT INTO `AdSystem` VALUES (12,'LiveIntent',NULL);
INSERT INTO `AdSystem` VALUES (13,'Yieldmo',NULL);
INSERT INTO `AdSystem` VALUES (14,'MoPub',NULL);
INSERT INTO `AdSystem` VALUES (15,'One by AOL: Mobile','aol.com');
INSERT INTO `AdSystem` VALUES (17,'Smaato',NULL);
INSERT INTO `AdSystem` VALUES (18,'Taboola',NULL);
INSERT INTO `AdSystem` VALUES (19,'TrustX',NULL);
INSERT INTO `AdSystem` VALUES (20,'LKQD',NULL);
INSERT INTO `AdSystem` VALUES (21,'Criteo',NULL);
INSERT INTO `AdSystem` VALUES (22,'Exponential',NULL);
INSERT INTO `AdSystem` VALUES (23,'Sovrn',NULL);
INSERT INTO `AdSystem` VALUES (24,'RhythmOne',NULL);
INSERT INTO `AdSystem` VALUES (25,'Yieldbot',NULL);
INSERT INTO `AdSystem` VALUES (26,'Technorati',NULL);
INSERT INTO `AdSystem` VALUES (27,'Bidfluence',NULL);
INSERT INTO `AdSystem` VALUES (28,'Switch Concepts',NULL);
INSERT INTO `AdSystem` VALUES (29,'BrightRoll Exchange',NULL);
INSERT INTO `AdSystem` VALUES (30,'Conversant',NULL);
INSERT INTO `AdSystem` VALUES (31,'Sonobi',NULL);
INSERT INTO `AdSystem` VALUES (32,'Spoutable',NULL);
INSERT INTO `AdSystem` VALUES (33,'FreeWheel',NULL);
INSERT INTO `AdSystem` VALUES (34,'Connatix',NULL);
INSERT INTO `AdSystem` VALUES (35,'Centro Brand Exchange',NULL);
INSERT INTO `AdSystem` VALUES (36,'Positive Mobile',NULL);
INSERT INTO `AdSystem` VALUES (37,'MemeGlobal',NULL);
INSERT INTO `AdSystem` VALUES (38,'Kixer',NULL);
INSERT INTO `AdSystem` VALUES (39,'Sekindo',NULL);
INSERT INTO `AdSystem` VALUES (40,'Improve Digital','improvedigital.com');
INSERT INTO `AdSystem` VALUES (41,'AdForm',NULL);
INSERT INTO `AdSystem` VALUES (42,'MADS',NULL);
INSERT INTO `AdSystem` VALUES (43,'Inneractive','inner-active.com');
INSERT INTO `AdSystem` VALUES (44,'SpotX',NULL);
INSERT INTO `AdSystem` VALUES (45,'StreamRail',NULL);
INSERT INTO `AdSystem` VALUES (46,'MediaMath',NULL);
INSERT INTO `AdSystem` VALUES (47,'AdYouLike',NULL);
INSERT INTO `AdSystem` VALUES (48,'Index Exchange','indexexchange.com');
INSERT INTO `AdSystem` VALUES (49,'e-Planning',NULL);
INSERT INTO `AdSystem` VALUES (50,'Kiosked',NULL);
INSERT INTO `AdSystem` VALUES (51,'UnrulyX',NULL);
INSERT INTO `AdSystem` VALUES (52,'Brightcom',NULL);
INSERT INTO `AdSystem` VALUES (53,'PowerInbox',NULL);
INSERT INTO `AdSystem` VALUES (54,'Fyber','fyber.com');
INSERT INTO `AdSystem` VALUES (55,'TidalTV',NULL);
INSERT INTO `AdSystem` VALUES (56,'Nativo',NULL);
INSERT INTO `AdSystem` VALUES (57,'Media.net',NULL);
INSERT INTO `AdSystem` VALUES (58,'YuMe',NULL);
INSERT INTO `AdSystem` VALUES (59,'RevContent',NULL);
INSERT INTO `AdSystem` VALUES (60,'Outbrain',NULL);
INSERT INTO `AdSystem` VALUES (61,'Zedo',NULL);
INSERT INTO `AdSystem` VALUES (62,'SlimCut Media',NULL);
INSERT INTO `AdSystem` VALUES (63,'Bidtellect',NULL);
INSERT INTO `AdSystem` VALUES (64,'Smart RTB+',NULL);
INSERT INTO `AdSystem` VALUES (65,'LoopMe',NULL);
INSERT INTO `AdSystem` VALUES (66,'Vidazoo',NULL);
INSERT INTO `AdSystem` VALUES (67,'Videoflare',NULL);
INSERT INTO `AdSystem` VALUES (68,'Yahoo Ad Exchange',NULL);
INSERT INTO `AdSystem` VALUES (69,'PixFuture',NULL);
INSERT INTO `AdSystem` VALUES (77,'Tremor',NULL);
INSERT INTO `AdSystem` VALUES (83,'TripleLift',NULL);
INSERT INTO `AdSystem` VALUES (84,'AppNexus','appnexus.com');
INSERT INTO `AdSystem` VALUES (86,'COMET',NULL);
INSERT INTO `AdSystem` VALUES (88,'One by AOL: Video','advertising.com');
INSERT INTO `AdSystem` VALUES (94,'Teads','teads.tv');
INSERT INTO `AdSystem` VALUES (95,'PulsePoint',NULL);
INSERT INTO `AdSystem` VALUES (96,'District M',NULL);
INSERT INTO `AdSystem` VALUES (97,'Sharethrough',NULL);
COMMIT;

