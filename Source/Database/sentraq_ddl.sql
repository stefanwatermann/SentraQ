-- #################################################################################
-- SentraQ database structures (PostgreSQL)
-- v1.0 - 2026-02-10
-- Copyright (c) 2026 Stefan Watermann, www.watermann-it.de
-- #################################################################################

-- drop tables / views
--DROP VIEW public."vComponentLast";
--DROP VIEW public."vStation";
--DROP TABLE public."Setting";
--DROP TABLE public."EventData";
--DROP TABLE public."Alert";
--DROP TABLE public."Component";
--DROP TABLE public."Station";
--DROP TABLE IF EXISTS public."User";
--DROP TABLE IF EXISTS public."Log";

-- Table: public.Log
CREATE TABLE IF NOT EXISTS public."Log"
(
    "Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "LogTs" timestamp without time zone NOT NULL,
    "Event" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "Severity" character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'I'::character varying,
    "Message" character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT "Log_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT "Log_CK_Severity" CHECK ("Severity"::text = ANY (ARRAY['I'::character varying, 'E'::character varying, 'W'::character varying]::text[]))
)

-- Table: public.User
CREATE TABLE IF NOT EXISTS public."User"
(
    "Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Login" character varying(10) COLLATE pg_catalog."default" NOT NULL,
    "Name" character varying(200) COLLATE pg_catalog."default" NOT NULL,
    "Email" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    "Hash" character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    "Role" character varying(3) COLLATE pg_catalog."default" NOT NULL DEFAULT 'USR'::character varying,
    "PasswordResetCode" character varying(100) COLLATE pg_catalog."default",
    "PasswordResetTs" timestamp without time zone,
    CONSTRAINT "User_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT "User_UK_Login" UNIQUE ("Login"),
    CONSTRAINT "User_CK_Role" CHECK ("Role"::text = ANY (ARRAY['USR'::character varying, 'ADM'::character varying, 'RPT'::character varying]::text[]))
)

-- public."EventData" definition
CREATE TABLE IF NOT EXISTS public."EventData"
(
    "Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "HardwareId" character varying(36) COLLATE pg_catalog."default" NOT NULL,
    "CreateTs" timestamp without time zone NOT NULL,
    "Payload" character varying(1000) COLLATE pg_catalog."default",
    "ReceivedTs" timestamp without time zone,
    CONSTRAINT "Data_pkey" PRIMARY KEY ("Id")
);


-- public."Setting" definition
CREATE TABLE IF NOT EXISTS public."Setting"
(
    "Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Key" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    "Value" character varying(2000) COLLATE pg_catalog."default",
    CONSTRAINT "Settings_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT settings_uk_key UNIQUE ("Key")
);


-- public."Station" definition
CREATE TABLE IF NOT EXISTS public."Station"
(
    "Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "DisplayName" character varying(250) COLLATE pg_catalog."default" NOT NULL,
    "ShortName" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "Latitude" numeric NOT NULL,
    "Longitude" numeric NOT NULL,
    "Type" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "Uid" character varying(36) COLLATE pg_catalog."default" NOT NULL,
    "DisplayOrder" integer,
    "AlertReceiverEmailAddresses" character varying(2000) COLLATE pg_catalog."default",
    "WatchdogHardwareId" character varying(36) COLLATE pg_catalog."default",
    "DisplayColor" character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT "Station_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT "UK_Uid" UNIQUE ("Uid")
);


-- public."Alert" definition
CREATE TABLE IF NOT EXISTS public."Alert"
(
    "Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "ConfirmedAt" timestamp without time zone,
    "ConfirmedBy" character varying(100) COLLATE pg_catalog."default",
    "MailSendAt" timestamp without time zone,
    "FirstEventTs" timestamp without time zone,
    "LastEventTs" timestamp without time zone,
    "IsActive" character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::character varying,
    "StationUid" character varying(36) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Alert_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT "Alert_FK_Station" FOREIGN KEY ("StationUid")
        REFERENCES public."Station" ("Uid") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "Alert_CK_IsActive" CHECK ("IsActive"::text = ANY (ARRAY['Y'::character varying, 'N'::character varying]::text[])) NOT VALID
);


-- public."Component" definition
CREATE TABLE IF NOT EXISTS public."Component"
(
    "Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "DisplayName" character varying(250) COLLATE pg_catalog."default" NOT NULL,
    "ShortName" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "HardwareId" character varying(36) COLLATE pg_catalog."default" NOT NULL,
    "Type" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "StationId" bigint NOT NULL,
    "MinValue" integer NOT NULL DEFAULT 0,
    "MaxValue" integer NOT NULL DEFAULT 100,
    "DisplayUnit" character varying(50) COLLATE pg_catalog."default",
    "DisplayOrder" integer,
    CONSTRAINT "Component_pkey" PRIMARY KEY ("Id"),
    CONSTRAINT "UK_HardwareId" UNIQUE ("HardwareId"),
    CONSTRAINT "FK_STATION" FOREIGN KEY ("StationId")
        REFERENCES public."Station" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "Component_CK_Type" CHECK ("Type"::text = ANY (ARRAY['FI'::character varying, 'FL'::character varying, 'AC'::character varying, 'CO'::character varying, 'SE'::character varying, 'DI'::character varying]::text[])) NOT VALID
);


-- public."vComponentLast" source
CREATE OR REPLACE VIEW public."vComponentLast"
 AS
 SELECT c."DisplayName",
    c."ShortName",
    c."HardwareId",
    c."Type",
    c."StationId",
    s."Uid" AS "StationUid",
    c."MinValue",
    c."MaxValue",
    c."DisplayUnit",
    c."DisplayOrder",
    ( SELECT "EventData"."Payload"
           FROM "EventData"
          WHERE "EventData"."Id" = (( SELECT max(e."Id") AS max
                   FROM "EventData" e
                  WHERE e."HardwareId"::text = c."HardwareId"::text))) AS "LastPayload",
    ( SELECT "EventData"."ReceivedTs"
           FROM "EventData"
          WHERE "EventData"."Id" = (( SELECT max(e."Id") AS max
                   FROM "EventData" e
                  WHERE e."HardwareId"::text = c."HardwareId"::text))) AS "LastReceivedTs",
    ( SELECT "EventData"."ReceivedTs"
           FROM "EventData"
          WHERE "EventData"."Id" = (( SELECT min(e."Id") AS min
                   FROM "EventData" e
                  WHERE e."HardwareId"::text = c."HardwareId"::text))) AS "FirstReceivedTs"
   FROM "Component" c
   JOIN "Station" s ON c."StationId" = s."Id"
 UNION
	 SELECT cn."DisplayName"
      ,cn."ShortName"
	  ,cast(concat(cn."HardwareId", '#') as varchar(36))
	  ,'CO'
	  ,cm."StationId"
	  ,(SELECT s1."Uid" FROM public."Station" s1 WHERE s1."Id" = cm."StationId")
	  ,0
	  ,999999999
	  ,cn."DisplayUnit"
	  ,cn."DisplayOrder"
	  ,cast(round(cast(cn."Count" as numeric) / cn."Divisor", 1) as varchar(10))
	  ,cn."LastTs"
	  ,NULL
from   "Counter" cn join "Component" cm on cn."HardwareId" = cm."HardwareId";


-- public."vStation" source
CREATE OR REPLACE VIEW public."vStation"
AS SELECT "Id",
    "DisplayName",
    "ShortName",
    "Latitude",
    "Longitude",
    "Type",
    "DisplayColor",
    "Uid",
    "DisplayOrder",
    "AlertReceiverEmailAddresses",
    "WatchdogHardwareId",
    COALESCE(( SELECT true
           FROM "Alert" a_1
          WHERE a_1."StationUid"::text = s."Uid"::text AND a_1."ConfirmedAt"::text IS NULL AND a_1."IsActive"::text = 'Y'::text), false) AS "HasActiveAlert"
   FROM "Station" s;