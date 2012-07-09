ALTER TABLE SBI_LOV ADD DATASET_ID INTEGER; 
ALTER TABLE SBI_LOV ADD CONSTRAINT SBI_LOV_2 FOREIGN KEY  (DATASET_ID) REFERENCES SBI_DATA_SET (DS_ID);
	
INSERT INTO SBI_DOMAINS (VALUE_ID, VALUE_CD,VALUE_NM,DOMAIN_CD,DOMAIN_NM,VALUE_DS, USER_IN, TIME_IN)
    VALUES ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_DOMAINS'),
    'DATASET','sbidomains.nm.dataset','INPUT_TYPE','Input mode and values','sbidomains.ds.dataset', 'server', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where  sequence_name = 'SBI_DOMAINS';
commit;

ALTER TABLE SBI_EXT_ROLES ADD EDIT_WORKSHEET BIT DEFAULT 1;
commit;

DELETE FROM SBI_DOMAINS WHERE domain_cd = 'SCRIPT_TYPE' AND value_cd='ejs';
UPDATE SBI_DOMAINS SET value_cd='ECMAScript' WHERE domain_cd = 'SCRIPT_TYPE' AND value_cd='rhino-nonjdk';
commit;
ALTER TABLE SBI_DATA_SET_HISTORY ADD COLUMN QUERY_SCRIPT TEXT DEFAULT NULL;
ALTER TABLE SBI_DATA_SET_HISTORY ADD COLUMN QUERY_SCRIPT_LANGUAGE VARCHAR(100) DEFAULT NULL;
commit;

--ALTER TABLE SBI_DOMAINS ADD CONSTRAINT XAK1SBI_DOMAINS UNIQUE (VALUE_CD, DOMAIN_CD);
ALTER TABLE SBI_DATA_SET_HISTORY ALTER COLUMN PARAMS VARCHAR(4000);

ALTER TABLE SBI_PARUSE ADD COLUMN MAXIMIZER_ENABLED BIT DEFAULT 0;
UPDATE SBI_PARUSE SET MAXIMIZER_ENABLED = 0;
commit;



-- UPDATE FOR MULTITENANT


ALTER TABLE SBI_DATA_SET_HISTORY ADD COLUMN ORGANIZATION VARCHAR(20);
UPDATE SBI_DATA_SET_HISTORY set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_CHECKS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_CHECKS DROP CONSTRAINT XAK1SBI_CHECKS;
ALTER TABLE SBI_CHECKS ADD CONSTRAINT XAK1SBI_CHECKS UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_DOMAINS set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_ENGINES set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_ENGINES DROP CONSTRAINT XAK1SBI_ENGINES;
ALTER TABLE SBI_ENGINES ADD CONSTRAINT XAK1SBI_ENGINES UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_EXT_ROLES set ORGANIZATION = 'SPAGOBI';
commit;


ALTER TABLE SBI_EXT_ROLES DROP CONSTRAINT XAK1SBI_EXT_ROLES;
ALTER TABLE SBI_EXT_ROLES ADD CONSTRAINT XAK1SBI_EXT_ROLES UNIQUE (NAME, ORGANIZATION);



UPDATE SBI_FUNC_ROLE set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_FUNCTIONS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_FUNCTIONS DROP CONSTRAINT XAK1SBI_FUNCTIONS;
ALTER TABLE SBI_FUNCTIONS ADD CONSTRAINT XAK1SBI_FUNCTIONS UNIQUE (CODE, ORGANIZATION);

UPDATE SBI_LOV set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_LOV DROP CONSTRAINT XAK1SBI_LOV;
ALTER TABLE SBI_LOV ADD CONSTRAINT XAK1SBI_LOV UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_OBJ_FUNC set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_OBJ_PAR set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_OBJ_STATE set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_OBJECTS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_OBJECTS DROP CONSTRAINT XAK1SBI_OBJECTS;
ALTER TABLE SBI_OBJECTS ADD CONSTRAINT XAK1SBI_OBJECTS UNIQUE (LABEL, ORGANIZATION); 

UPDATE SBI_OBJECTS_RATING set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_PARAMETERS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_PARAMETERS DROP CONSTRAINT XAK1SBI_PARAMETERS;
ALTER TABLE SBI_PARAMETERS ADD CONSTRAINT XAK1SBI_PARAMETERS UNIQUE(LABEL, ORGANIZATION); 

UPDATE SBI_PARUSE set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_PARUSE_CK set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_PARUSE_DET set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_SUBREPORTS set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_OBJ_PARUSE set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_EVENTS set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_EVENTS_LOG set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_AUDIT set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_GEO_MAPS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_GEO_MAPS DROP CONSTRAINT XAK1SBI_GEO_MAPS;
ALTER TABLE SBI_GEO_MAPS ADD CONSTRAINT XAK1SBI_GEO_MAPS UNIQUE (NAME, ORGANIZATION);

UPDATE SBI_GEO_FEATURES set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_GEO_FEATURES DROP CONSTRAINT XAK1SBI_GEO_FEATURES;
ALTER TABLE SBI_GEO_FEATURES ADD CONSTRAINT XAK1SBI_GEO_FEATURES UNIQUE (NAME, ORGANIZATION);

UPDATE SBI_GEO_MAP_FEATURES set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_VIEWPOINTS set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_DATA_SOURCE set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_DATA_SOURCE DROP CONSTRAINT AK1SBI_DATA_SOURCE;
ALTER TABLE SBI_DATA_SOURCE ADD CONSTRAINT XAK1SBI_DATA_SOURCE UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_BINARY_CONTENTS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_BINARY_CONTENTS DROP CONSTRAINT AK1SBI_BINARY_CONTENTS;

UPDATE SBI_OBJECT_TEMPLATES set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_OBJECT_TEMPLATES DROP CONSTRAINT AK1SBI_OBJECT_TEMPLATES;

UPDATE SBI_OBJECT_NOTES set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_OBJECT_NOTES DROP CONSTRAINT AK1SBI_OBJECT_NOTES;

UPDATE SBI_SUBOBJECTS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_SUBOBJECTS DROP CONSTRAINT AK1SBI_SUBOBJECTS;

UPDATE SBI_SNAPSHOTS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_SNAPSHOTS DROP CONSTRAINT AK1SBI_SNAPSHOTS;

UPDATE SBI_USER_FUNC set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_USER_FUNC DROP CONSTRAINT AK1SBI_USER_FUNC;

ALTER TABLE SBI_ROLE_TYPE_USER_FUNC DROP CONSTRAINT AK1SBI_ROLE_TYPE_USER_FUNC;

UPDATE SBI_DOSSIER_PRES set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_DOSSIER_PRES DROP CONSTRAINT AK1SBI_DOSSIER_PRES;

UPDATE SBI_DOSSIER_TEMP set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_DOSSIER_TEMP DROP CONSTRAINT AK1SBI_DOSSIER_TEMP;

UPDATE SBI_DOSSIER_BIN_TEMP set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_DOSSIER_BIN_TEMP DROP CONSTRAINT AK1SBI_DOSSIER_BIN_TEMP;

UPDATE SBI_DIST_LIST set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_DIST_LIST DROP CONSTRAINT AK1SBI_SBI_DIST_LIST;
ALTER TABLE SBI_DIST_LIST ADD CONSTRAINT XAK1SBI_SBI_DIST_LIST UNIQUE (NAME, ORGANIZATION);

UPDATE SBI_DIST_LIST_USER set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_DIST_LIST_USER DROP CONSTRAINT AK1SBI_DIST_LIST_USER;

UPDATE SBI_DIST_LIST_OBJECTS set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_DIST_LIST_OBJECTS DROP CONSTRAINT AK1SBI_DIST_LIST_OBJECTS;

UPDATE SBI_REMEMBER_ME set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_REMEMBER_ME DROP CONSTRAINT AK1SBI_REMEMBER_ME;

UPDATE SBI_DATA_SET set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_DATA_SET DROP CONSTRAINT AK1SBI_DATA_SET;
ALTER TABLE SBI_DATA_SET ADD CONSTRAINT XAK1SBI_DATA_SET UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_MENU set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_MENU_ROLE set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_KPI_ROLE set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_KPI_ROLE DROP CONSTRAINT AK1SBI_KPI_ROLE;

UPDATE SBI_KPI set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_KPI DROP CONSTRAINT AK1SBI_KPI;
ALTER TABLE SBI_KPI ADD CONSTRAINT XAK1SBI_KPI UNIQUE (CODE, ORGANIZATION);

UPDATE SBI_KPI_DOCUMENTS set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_MEASURE_UNIT set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_THRESHOLD set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_THRESHOLD DROP CONSTRAINT XIF1SBI_THRESHOLD;
ALTER TABLE SBI_THRESHOLD ADD CONSTRAINT XIF1SBI_THRESHOLD UNIQUE (CODE, ORGANIZATION);

UPDATE SBI_THRESHOLD_VALUE set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_KPI_MODEL set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_KPI_MODEL DROP CONSTRAINT XIF1SBI_KPI_MODEL;
ALTER TABLE SBI_KPI_MODEL ADD CONSTRAINT XIF1SBI_KPI_MODEL UNIQUE (KPI_MODEL_LBL, ORGANIZATION);

UPDATE SBI_KPI_PERIODICITY set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_KPI_PERIODICITY DROP CONSTRAINT XIF1SBI_KPI_PERIODICITY;
ALTER TABLE SBI_KPI_PERIODICITY ADD CONSTRAINT XIF1SBI_KPI_PERIODICITY UNIQUE (NAME, ORGANIZATION);

UPDATE SBI_KPI_INSTANCE set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_KPI_INST_PERIOD set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_KPI_INSTANCE_HISTORY set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_KPI_INSTANCE_HISTORY DROP CONSTRAINT XIF1SBI_KPI_INST_HISTORY;

UPDATE SBI_KPI_VALUE set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_KPI_VALUE DROP CONSTRAINT XIF1SBI_KPI_VALUE;

UPDATE SBI_KPI_MODEL_INST set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_KPI_MODEL_INST DROP CONSTRAINT XAK2SBI_KPI_MODEL_INST;
ALTER TABLE SBI_KPI_MODEL_INST ADD CONSTRAINT XAK2SBI_KPI_MODEL_INST UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_RESOURCES set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_RESOURCES DROP CONSTRAINT XIF1SBI_RESOURCES;
ALTER TABLE SBI_RESOURCES ADD CONSTRAINT XIF1SBI_RESOURCES UNIQUE (RESOURCE_CODE, ORGANIZATION);

UPDATE SBI_KPI_MODEL_RESOURCES set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_ALARM set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_ALARM DROP CONSTRAINT XIF1SBI_ALARM;
ALTER TABLE SBI_ALARM ADD CONSTRAINT XIF1SBI_ALARM UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_ALARM_EVENT set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_ALARM_CONTACT set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_ALARM_CONTACT DROP CONSTRAINT XIF1SBI_ALARM_CONTACT;
ALTER TABLE SBI_ALARM_CONTACT ADD CONSTRAINT XIF1SBI_ALARM_CONTACT UNIQUE (NAME, ORGANIZATION);

UPDATE SBI_OBJ_METADATA set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_OBJ_METADATA DROP CONSTRAINT XAK1SBI_OBJ_METADATA;
ALTER TABLE SBI_OBJ_METADATA ADD CONSTRAINT XAK1SBI_OBJ_METADATA UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_OBJ_METACONTENTS set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_CONFIG set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_USER set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_ATTRIBUTE set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_ATTRIBUTE ADD CONSTRAINT XAK1SBI_USER UNIQUE ( ATTRIBUTE_NAME, ORGANIZATION );

UPDATE SBI_USER_ATTRIBUTES set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_EXT_USER_ROLES set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_UDP set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_UDP DROP CONSTRAINT XAK1SBI_UDP;
ALTER TABLE SBI_UDP ADD CONSTRAINT XAK1SBI_UDP UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_UDP_VALUE set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_KPI_REL set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_KPI_ERROR set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_ORG_UNIT set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_ORG_UNIT DROP CONSTRAINT XIF1SBI_ORG_UNIT;
ALTER TABLE SBI_ORG_UNIT ADD CONSTRAINT XIF1SBI_ORG_UNIT UNIQUE(LABEL, NAME, ORGANIZATION);

UPDATE SBI_ORG_UNIT_HIERARCHIES set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_ORG_UNIT_HIERARCHIES DROP CONSTRAINT XIF1SBI_ORG_UNIT_HIERARCHIES;
ALTER TABLE SBI_ORG_UNIT_HIERARCHIES ADD CONSTRAINT XIF1SBI_ORG_UNIT_HIERARCHIES UNIQUE (LABEL, COMPANY, ORGANIZATION);

commit;

UPDATE SBI_ORG_UNIT_NODES set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_ORG_UNIT_GRANT set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_ORG_UNIT_GRANT DROP CONSTRAINT XIF1SBI_ORG_UNIT_GRANT;
ALTER TABLE SBI_ORG_UNIT_GRANT ADD CONSTRAINT XIF1SBI_ORG_UNIT_GRANT UNIQUE (LABEL, ORGANIZATION);

UPDATE SBI_ORG_UNIT_GRANT_NODES set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_GOAL set ORGANIZATION = 'SPAGOBI';
commit;
ALTER TABLE SBI_GOAL ADD CONSTRAINT XIF1SBI_SBI_GOAL UNIQUE (NAME, ORGANIZATION);

UPDATE SBI_GOAL_HIERARCHY set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_GOAL_KPI set ORGANIZATION = 'SPAGOBI';
commit;

UPDATE SBI_OBJ_PARVIEW set ORGANIZATION = 'SPAGOBI';
commit;

ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN USER_IN VARCHAR( 100 ) NOT NULL;
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN USER_UP VARCHAR( 100 );
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN USER_DE VARCHAR( 100 );
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN TIME_IN TIMESTAMP NOT NULL;
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN TIME_UP TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN TIME_DE TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN SBI_VERSION_IN VARCHAR( 10 );
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN SBI_VERSION_UP VARCHAR( 10 );
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN SBI_VERSION_DE VARCHAR( 10 );
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN META_VERSION VARCHAR( 100 );
ALTER TABLE SBI_I18N_MESSAGES ADD COLUMN ORGANIZATION VARCHAR( 20 );

UPDATE SBI_I18N_MESSAGES set ORGANIZATION = 'SPAGOBI';
commit;

ALTER TABLE SBI_I18N_MESSAGES DROP PRIMARY KEY;
ALTER TABLE SBI_I18N_MESSAGES ADD PRIMARY KEY (LANGUAGE_CD, LABEL, ORGANIZATION);

UPDATE SBI_KPI_COMMENTS set ORGANIZATION = 'SPAGOBI';
commit;

CREATE TABLE SBI_ORGANIZATIONS (
       ID     INTEGER NOT NULL,
       NAME   VARCHAR(20),
       UNIQUE XAK1SBI_ORGANIZATIONS (NAME),
       PRIMARY KEY (ID)
)ENGINE=InnoDB;

INSERT INTO SBI_ORGANIZATIONS(ID,NAME) VALUES (1,'SPAGOBI');
INSERT INTO hibernate_sequences(NEXT_VAL,SEQUENCE_NAME) VALUES (2,'SBI_ORGANIZATIONS');
commit;


Alter Table QRTZ_JOB_DETAILS NOCHECK Constraint All;
Alter Table QRTZ_TRIGGERS NOCHECK Constraint All;
Alter Table QRTZ_JOB_LISTENERS NOCHECK Constraint All;
Alter Table QRTZ_FIRED_TRIGGERS NOCHECK Constraint All;

update QRTZ_JOB_DETAILS set JOB_GROUP = CONCAT('SPAGOBI/' , JOB_GROUP);
update QRTZ_TRIGGERS set JOB_GROUP = CONCAT('SPAGOBI/' , JOB_GROUP);
update QRTZ_JOB_LISTENERS set JOB_GROUP = CONCAT('SPAGOBI/' , JOB_GROUP);
update QRTZ_FIRED_TRIGGERS set JOB_GROUP = CONCAT('SPAGOBI/' , JOB_GROUP);

Alter Table QRTZ_JOB_DETAILS CHECK Constraint ALL;
Alter Table QRTZ_TRIGGERS CHECK Constraint ALL;
Alter Table QRTZ_JOB_LISTENERS CHECK Constraint ALL;
Alter Table QRTZ_FIRED_TRIGGERS CHECK Constraint ALL;

commit;
