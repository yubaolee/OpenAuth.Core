--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Ubuntu 14.6-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public."WmsInboundOrderTbl" DROP CONSTRAINT "WmsInboundOrderTbl_pkey";
ALTER TABLE ONLY public."WmsInboundOrderDtbl" DROP CONSTRAINT "WmsInboundOrderDtbl_pkey";
ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
ALTER TABLE ONLY public."UploadFile" DROP CONSTRAINT "UploadFile_pkey";
ALTER TABLE ONLY public."SysMessage" DROP CONSTRAINT "SysMessage_pkey";
ALTER TABLE ONLY public."SysLog" DROP CONSTRAINT "SysLog_pkey";
ALTER TABLE ONLY public."Stock" DROP CONSTRAINT "Stock_pkey";
ALTER TABLE ONLY public."Role" DROP CONSTRAINT "Role_pkey";
ALTER TABLE ONLY public."Resource" DROP CONSTRAINT "Resource_pkey";
ALTER TABLE ONLY public."Relevance" DROP CONSTRAINT "Relevance_pkey";
ALTER TABLE ONLY public."Org" DROP CONSTRAINT "Org_pkey";
ALTER TABLE ONLY public."OpenJob" DROP CONSTRAINT "OpenJob_pkey";
ALTER TABLE ONLY public."Module" DROP CONSTRAINT "Module_pkey";
ALTER TABLE ONLY public."ModuleElement" DROP CONSTRAINT "ModuleElement_pkey";
ALTER TABLE ONLY public."FrmLeaveReq" DROP CONSTRAINT "FrmLeaveReq_pkey";
ALTER TABLE ONLY public."Form" DROP CONSTRAINT "Form_pkey";
ALTER TABLE ONLY public."FlowScheme" DROP CONSTRAINT "FlowScheme_pkey";
ALTER TABLE ONLY public."FlowInstance" DROP CONSTRAINT "FlowInstance_pkey";
ALTER TABLE ONLY public."FlowInstanceTransitionHistory" DROP CONSTRAINT "FlowInstanceTransitionHistory_pkey";
ALTER TABLE ONLY public."FlowInstanceOperationHistory" DROP CONSTRAINT "FlowInstanceOperationHistory_pkey";
ALTER TABLE ONLY public."DataPrivilegeRule" DROP CONSTRAINT "DataPrivilegeRule_pkey";
ALTER TABLE ONLY public."Category" DROP CONSTRAINT "Category_pkey";
ALTER TABLE ONLY public."CategoryType" DROP CONSTRAINT "CategoryType_pkey";
ALTER TABLE ONLY public."BuilderTable" DROP CONSTRAINT "BuilderTable_pkey";
ALTER TABLE ONLY public."BuilderTableColumn" DROP CONSTRAINT "BuilderTableColumn_pkey";
ALTER TABLE ONLY public."Application" DROP CONSTRAINT "Application_pkey";
DROP TABLE public."WmsInboundOrderTbl";
DROP TABLE public."WmsInboundOrderDtbl";
DROP TABLE public."User";
DROP TABLE public."UploadFile";
DROP TABLE public."SysMessage";
DROP TABLE public."SysLog";
DROP TABLE public."Stock";
DROP TABLE public."Role";
DROP TABLE public."Resource";
DROP TABLE public."Relevance";
DROP TABLE public."Org";
DROP TABLE public."OpenJob";
DROP TABLE public."ModuleElement";
DROP TABLE public."Module";
DROP TABLE public."FrmLeaveReq";
DROP TABLE public."Form";
DROP TABLE public."FlowScheme";
DROP TABLE public."FlowInstanceTransitionHistory";
DROP TABLE public."FlowInstanceOperationHistory";
DROP TABLE public."FlowInstance";
DROP TABLE public."DataPrivilegeRule";
DROP TABLE public."CategoryType";
DROP TABLE public."Category";
DROP TABLE public."BuilderTableColumn";
DROP TABLE public."BuilderTable";
DROP TABLE public."Application";
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Application" (
    "Id" character varying(50) NOT NULL,
    "Name" text DEFAULT ' '::text NOT NULL,
    "AppSecret" character varying(255),
    "Description" character varying(255),
    "Icon" character varying(255),
    "Disable" boolean DEFAULT false NOT NULL,
    "CreateTime" date DEFAULT now() NOT NULL,
    "CreateUser" character varying(50)
);


ALTER TABLE public."Application" OWNER TO postgres;

--
-- Name: BuilderTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BuilderTable" (
    "Id" character varying(50) NOT NULL,
    "TableName" character varying(200) NOT NULL,
    "Comment" character varying(500),
    "DetailTableName" character varying(255),
    "DetailComment" character varying(500),
    "ClassName" character varying(100) NOT NULL,
    "Namespace" character varying(100),
    "ModuleCode" character varying(255),
    "ModuleName" character varying(300),
    "Folder" character varying(300),
    "Options" character varying(1000),
    "TypeId" character varying(50),
    "TypeName" character varying(20),
    "CreateTime" timestamp without time zone NOT NULL,
    "CreateUserId" character varying(50),
    "UpdateTime" timestamp without time zone,
    "UpdateUserId" character varying(50),
    "UpdateUserName" character varying(50),
    "CreateUserName" character varying(50),
    "ForeignKey" character varying(50),
    "IsDynamicHeader" boolean DEFAULT false,
    "ParentTableId" character varying(50)
);


ALTER TABLE public."BuilderTable" OWNER TO postgres;

--
-- Name: BuilderTableColumn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BuilderTableColumn" (
    "Id" character varying(50) NOT NULL,
    "TableId" character varying(50) NOT NULL,
    "TableName" character varying(255),
    "ColumnName" character varying(200),
    "Comment" character varying(500),
    "ColumnType" character varying(100),
    "EntityType" character varying(500),
    "EntityName" character varying(200),
    "IsKey" boolean DEFAULT false NOT NULL,
    "IsIncrement" boolean DEFAULT false NOT NULL,
    "IsRequired" boolean DEFAULT false NOT NULL,
    "IsInsert" boolean DEFAULT false NOT NULL,
    "IsEdit" boolean DEFAULT false NOT NULL,
    "IsList" boolean DEFAULT false NOT NULL,
    "IsQuery" boolean DEFAULT false NOT NULL,
    "QueryType" character varying(200),
    "HtmlType" character varying(200),
    "EditType" character varying(200),
    "Sort" integer NOT NULL,
    "CreateTime" timestamp without time zone NOT NULL,
    "CreateUserId" character varying(50),
    "UpdateTime" timestamp without time zone,
    "UpdateUserId" character varying(50),
    "EditRow" integer,
    "EditCol" integer,
    "UpdateUserName" character varying(50),
    "CreateUserName" character varying(50),
    "MaxLength" integer,
    "DataSource" character varying(200)
);


ALTER TABLE public."BuilderTableColumn" OWNER TO postgres;

--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    "Id" character varying(50) NOT NULL,
    "Name" character varying(255) NOT NULL,
    "DtCode" character varying(50) NOT NULL,
    "DtValue" character varying(50),
    "Enable" boolean NOT NULL,
    "SortNo" integer NOT NULL,
    "Description" character varying(500),
    "TypeId" character varying(50),
    "CreateTime" timestamp without time zone NOT NULL,
    "CreateUserId" character varying(50) NOT NULL,
    "CreateUserName" character varying(200) NOT NULL,
    "UpdateTime" timestamp without time zone,
    "UpdateUserId" character varying(50),
    "UpdateUserName" character varying(200)
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: CategoryType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CategoryType" (
    "Id" character varying(50) NOT NULL,
    "Name" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "CreateTime" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."CategoryType" OWNER TO postgres;

--
-- Name: DataPrivilegeRule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DataPrivilegeRule" (
    "Id" character varying(50) NOT NULL,
    "SourceCode" character varying(50) NOT NULL,
    "SubSourceCode" character varying(50),
    "Description" character varying(255) NOT NULL,
    "SortNo" integer NOT NULL,
    "PrivilegeRules" character varying(1000) NOT NULL,
    "Enable" boolean NOT NULL,
    "CreateTime" timestamp without time zone NOT NULL,
    "CreateUserId" character varying(50) NOT NULL,
    "CreateUserName" character varying(200) NOT NULL,
    "UpdateTime" timestamp without time zone,
    "UpdateUserId" character varying(50),
    "UpdateUserName" character varying(200)
);


ALTER TABLE public."DataPrivilegeRule" OWNER TO postgres;

--
-- Name: FlowInstance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FlowInstance" (
    "Id" character varying(50) NOT NULL,
    "InstanceSchemeId" character varying(50) NOT NULL,
    "Code" character varying(200),
    "CustomName" character varying(200),
    "ActivityId" character varying(50),
    "ActivityType" integer,
    "ActivityName" character varying(200),
    "PreviousId" character varying(50),
    "SchemeContent" character varying,
    "SchemeId" character varying(50),
    "DbName" character varying(50),
    "FrmData" text,
    "FrmType" integer DEFAULT 0 NOT NULL,
    "FrmContentData" text,
    "FrmContentParse" text,
    "FrmId" character varying(50),
    "SchemeType" character varying(50),
    "Disabled" integer DEFAULT 0 NOT NULL,
    "CreateDate" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateUserId" character varying(50),
    "CreateUserName" character varying(50),
    "FlowLevel" integer DEFAULT 0 NOT NULL,
    "Description" character varying(200),
    "IsFinish" integer DEFAULT 0 NOT NULL,
    "MakerList" character varying(1000),
    "OrgId" character varying(50)
);


ALTER TABLE public."FlowInstance" OWNER TO postgres;

--
-- Name: FlowInstanceOperationHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FlowInstanceOperationHistory" (
    "Id" character varying(50) NOT NULL,
    "InstanceId" character varying(50) NOT NULL,
    "Content" character varying(200),
    "CreateDate" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateUserId" character varying(50),
    "CreateUserName" character varying(50)
);


ALTER TABLE public."FlowInstanceOperationHistory" OWNER TO postgres;

--
-- Name: FlowInstanceTransitionHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FlowInstanceTransitionHistory" (
    "Id" character varying(50) NOT NULL,
    "InstanceId" character varying(50) NOT NULL,
    "FromNodeId" character varying(50),
    "FromNodeType" integer,
    "FromNodeName" character varying(200),
    "ToNodeId" character varying(50),
    "ToNodeType" integer,
    "ToNodeName" character varying(200),
    "TransitionSate" integer DEFAULT 0 NOT NULL,
    "IsFinish" integer DEFAULT 0 NOT NULL,
    "CreateDate" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateUserId" character varying(50),
    "CreateUserName" character varying(50)
);


ALTER TABLE public."FlowInstanceTransitionHistory" OWNER TO postgres;

--
-- Name: FlowScheme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FlowScheme" (
    "Id" character varying(50) NOT NULL,
    "SchemeCode" character varying(50),
    "SchemeName" character varying(200),
    "SchemeType" character varying(50),
    "SchemeVersion" character varying(50),
    "SchemeCanUser" character varying,
    "SchemeContent" character varying,
    "FrmId" character varying(50),
    "FrmType" integer DEFAULT 0 NOT NULL,
    "AuthorizeType" integer DEFAULT 0 NOT NULL,
    "SortCode" integer DEFAULT 0 NOT NULL,
    "DeleteMark" integer DEFAULT 0 NOT NULL,
    "Disabled" integer DEFAULT 0 NOT NULL,
    "Description" character varying(200),
    "CreateDate" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateUserId" character varying(50),
    "CreateUserName" character varying(50),
    "ModifyDate" timestamp without time zone,
    "ModifyUserId" character varying(50),
    "ModifyUserName" character varying(50),
    "OrgId" character varying(50)
);


ALTER TABLE public."FlowScheme" OWNER TO postgres;

--
-- Name: Form; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Form" (
    "Id" character varying(50) NOT NULL,
    "Name" character varying(200),
    "FrmType" integer DEFAULT 0 NOT NULL,
    "WebId" character varying(200),
    "Fields" integer DEFAULT 0 NOT NULL,
    "ContentData" text,
    "ContentParse" text,
    "Content" text,
    "SortCode" integer DEFAULT 0 NOT NULL,
    "DeleteMark" integer DEFAULT 0 NOT NULL,
    "DbName" character varying(50),
    "Disabled" integer DEFAULT 0 NOT NULL,
    "Description" character varying(200),
    "CreateDate" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateUserId" character varying(50),
    "CreateUserName" character varying(50),
    "ModifyDate" timestamp without time zone,
    "ModifyUserId" character varying(50),
    "ModifyUserName" character varying(50),
    "OrgId" character varying(50)
);


ALTER TABLE public."Form" OWNER TO postgres;

--
-- Name: FrmLeaveReq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FrmLeaveReq" (
    "Id" character varying(50) NOT NULL,
    "UserName" character varying(10) NOT NULL,
    "RequestType" character varying(20) NOT NULL,
    "StartDate" date NOT NULL,
    "StartTime" timestamp without time zone,
    "EndDate" date NOT NULL,
    "EndTime" timestamp without time zone,
    "RequestComment" character varying(500),
    "Attachment" character varying(500),
    "CreateDate" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateUserId" character varying(50),
    "CreateUserName" character varying(50),
    "FlowInstanceId" character varying(50)
);


ALTER TABLE public."FrmLeaveReq" OWNER TO postgres;

--
-- Name: Module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Module" (
    "Id" character varying(50) NOT NULL,
    "CascadeId" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Name" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Url" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "HotKey" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "IsLeaf" boolean DEFAULT true NOT NULL,
    "IsAutoExpand" boolean DEFAULT false NOT NULL,
    "IconName" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Status" integer DEFAULT 1 NOT NULL,
    "ParentName" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Vector" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "SortNo" integer DEFAULT 0 NOT NULL,
    "ParentId" character varying(50),
    "Code" character varying(50),
    "IsSys" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Module" OWNER TO postgres;

--
-- Name: ModuleElement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ModuleElement" (
    "Id" character varying(50) NOT NULL,
    "DomId" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Name" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Attr" character varying(500) DEFAULT ' '::character varying NOT NULL,
    "Script" character varying(500) DEFAULT ' '::character varying NOT NULL,
    "Icon" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Class" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Remark" character varying(200) DEFAULT ' '::character varying NOT NULL,
    "Sort" integer DEFAULT 0 NOT NULL,
    "ModuleId" character varying(50) NOT NULL,
    "TypeName" character varying(20),
    "TypeId" character varying(50)
);


ALTER TABLE public."ModuleElement" OWNER TO postgres;

--
-- Name: OpenJob; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OpenJob" (
    "Id" character varying(50) NOT NULL,
    "JobName" character varying(200) NOT NULL,
    "RunCount" integer DEFAULT 0 NOT NULL,
    "ErrorCount" integer DEFAULT 0 NOT NULL,
    "NextRunTime" timestamp without time zone,
    "LastRunTime" timestamp without time zone,
    "LastErrorTime" timestamp without time zone,
    "JobType" integer DEFAULT 0 NOT NULL,
    "JobCall" character varying(500) NOT NULL,
    "JobCallParams" character varying(500),
    "Cron" character varying(50) NOT NULL,
    "Status" integer DEFAULT 0 NOT NULL,
    "Remark" character varying(128),
    "CreateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateUserId" character varying(50) NOT NULL,
    "CreateUserName" character varying(200) NOT NULL,
    "UpdateTime" timestamp without time zone,
    "UpdateUserId" character varying(50),
    "UpdateUserName" character varying(200),
    "OrgId" character varying(50)
);


ALTER TABLE public."OpenJob" OWNER TO postgres;

--
-- Name: Org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Org" (
    "Id" character varying(50) NOT NULL,
    "CascadeId" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Name" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "HotKey" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "ParentName" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "IsLeaf" boolean DEFAULT true NOT NULL,
    "IsAutoExpand" boolean DEFAULT false NOT NULL,
    "IconName" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Status" integer DEFAULT 1 NOT NULL,
    "BizCode" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "CustomCode" character varying(4000) DEFAULT ' '::character varying NOT NULL,
    "CreateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateId" integer DEFAULT 0 NOT NULL,
    "SortNo" integer DEFAULT 0 NOT NULL,
    "ParentId" character varying(50),
    "TypeName" character varying(20),
    "TypeId" character varying(50)
);


ALTER TABLE public."Org" OWNER TO postgres;

--
-- Name: Relevance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Relevance" (
    "Id" character varying(50) NOT NULL,
    "Description" character varying(100) DEFAULT ' '::character varying NOT NULL,
    "Key" character varying(100) DEFAULT ' '::character varying NOT NULL,
    "Status" integer DEFAULT 0 NOT NULL,
    "OperateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "OperatorId" character varying(50),
    "FirstId" character varying(50) NOT NULL,
    "SecondId" character varying(50) NOT NULL,
    "ThirdId" character varying(50),
    "ExtendInfo" character varying(100)
);


ALTER TABLE public."Relevance" OWNER TO postgres;

--
-- Name: Resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Resource" (
    "Id" character varying(50) NOT NULL,
    "CascadeId" character varying(255) NOT NULL,
    "Name" character varying(255) NOT NULL,
    "SortNo" integer NOT NULL,
    "Description" character varying(500) NOT NULL,
    "ParentName" character varying(50),
    "ParentId" character varying(50),
    "AppId" character varying(50),
    "AppName" character varying(50),
    "TypeName" character varying(20),
    "TypeId" character varying(50),
    "Disable" boolean NOT NULL,
    "CreateTime" timestamp without time zone NOT NULL,
    "CreateUserId" character varying(50) NOT NULL,
    "CreateUserName" character varying(200) NOT NULL,
    "UpdateTime" timestamp without time zone,
    "UpdateUserId" character varying(50),
    "UpdateUserName" character varying(200)
);


ALTER TABLE public."Resource" OWNER TO postgres;

--
-- Name: Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Role" (
    "Id" character varying(50) NOT NULL,
    "Name" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Status" integer DEFAULT 1 NOT NULL,
    "CreateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateId" character varying(50),
    "TypeName" character varying(20),
    "TypeId" character varying(50)
);


ALTER TABLE public."Role" OWNER TO postgres;

--
-- Name: Stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Stock" (
    "Id" character varying(50) NOT NULL,
    "Name" character varying(500) DEFAULT ' '::character varying NOT NULL,
    "Number" integer DEFAULT 0 NOT NULL,
    "Price" numeric DEFAULT '0'::numeric NOT NULL,
    "Status" integer DEFAULT 0 NOT NULL,
    "Viewable" character varying(50) DEFAULT ' '::character varying NOT NULL,
    "User" character varying(50) DEFAULT ' '::character varying NOT NULL,
    "Time" timestamp without time zone DEFAULT now() NOT NULL,
    "OrgId" character varying(50)
);


ALTER TABLE public."Stock" OWNER TO postgres;

--
-- Name: SysLog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SysLog" (
    "Id" character varying(50) NOT NULL,
    "Content" character varying(1000),
    "TypeName" character varying(20),
    "TypeId" character varying(50),
    "Href" character varying(200),
    "CreateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateId" character varying(50) NOT NULL,
    "CreateName" character varying(200),
    "Ip" character varying(20),
    "Result" integer DEFAULT 0 NOT NULL,
    "Application" character varying(50)
);


ALTER TABLE public."SysLog" OWNER TO postgres;

--
-- Name: SysMessage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SysMessage" (
    "Id" character varying(50) NOT NULL,
    "TypeName" character varying(20),
    "TypeId" character varying(50),
    "FromId" character varying(50),
    "ToId" character varying(50) NOT NULL,
    "FromName" character varying(50),
    "ToName" character varying(50),
    "FromStatus" integer DEFAULT 0 NOT NULL,
    "ToStatus" integer DEFAULT 0 NOT NULL,
    "Href" character varying(200),
    "Title" character varying(200),
    "Content" character varying(1000),
    "CreateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateId" character varying(50)
);


ALTER TABLE public."SysMessage" OWNER TO postgres;

--
-- Name: UploadFile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UploadFile" (
    "Id" character varying(50) NOT NULL,
    "FileName" character varying(200) NOT NULL,
    "FilePath" character varying(500) NOT NULL,
    "Description" character varying(200),
    "FileType" character varying(20),
    "FileSize" integer,
    "Extension" character varying(20),
    "Enable" boolean DEFAULT true NOT NULL,
    "SortCode" integer DEFAULT 0 NOT NULL,
    "DeleteMark" boolean DEFAULT false NOT NULL,
    "CreateUserId" uuid,
    "CreateUserName" character varying(50),
    "CreateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "Thumbnail" character varying(500),
    "BelongApp" character varying(200),
    "BelongAppId" character varying(50)
);


ALTER TABLE public."UploadFile" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "Id" character varying(50) NOT NULL,
    "Account" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Password" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Name" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "Sex" integer DEFAULT 0 NOT NULL,
    "Status" integer DEFAULT 0 NOT NULL,
    "BizCode" character varying(255) DEFAULT ' '::character varying NOT NULL,
    "CreateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "CreateId" character varying(50),
    "TypeName" character varying(20),
    "TypeId" character varying(50)
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: WmsInboundOrderDtbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."WmsInboundOrderDtbl" (
    "Id" character varying(50) NOT NULL,
    "OrderId" character varying(50) NOT NULL,
    "Price" numeric,
    "PriceNoTax" numeric,
    "InStockStatus" boolean NOT NULL,
    "AsnStatus" integer NOT NULL,
    "GoodsId" character varying(50) NOT NULL,
    "GoodsBatch" character varying(50) NOT NULL,
    "QualityFlg" character varying(50) NOT NULL,
    "OrderNum" numeric NOT NULL,
    "InNum" numeric NOT NULL,
    "LeaveNum" numeric NOT NULL,
    "HoldNum" numeric NOT NULL,
    "ProdDate" character varying(30),
    "ExpireDate" character varying(30),
    "TaxRate" numeric,
    "OwnerId" character varying(32) NOT NULL,
    "Remark" character varying(128),
    "CreateTime" timestamp without time zone NOT NULL,
    "CreateUserId" character varying(50) NOT NULL,
    "CreateUserName" character varying(200) NOT NULL,
    "UpdateTime" timestamp without time zone,
    "UpdateUserId" character varying(50),
    "UpdateUserName" character varying(200)
);


ALTER TABLE public."WmsInboundOrderDtbl" OWNER TO postgres;

--
-- Name: WmsInboundOrderTbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."WmsInboundOrderTbl" (
    "Id" character varying(50) NOT NULL,
    "ExternalNo" character varying(50),
    "ExternalType" character varying(50),
    "Status" integer NOT NULL,
    "OrderType" character varying(50) NOT NULL,
    "GoodsType" character varying(50),
    "PurchaseNo" character varying(30),
    "StockId" character varying(12) NOT NULL,
    "OwnerId" character varying(50),
    "ShipperId" character varying(50),
    "SupplierId" character varying(50),
    "ScheduledInboundTime" timestamp without time zone,
    "Remark" character varying(256),
    "Enable" boolean NOT NULL,
    "TransferType" character varying(50),
    "InBondedArea" boolean NOT NULL,
    "ReturnBoxNum" numeric NOT NULL,
    "CreateTime" timestamp without time zone NOT NULL,
    "CreateUserId" character varying(50) NOT NULL,
    "CreateUserName" character varying(200) NOT NULL,
    "UpdateTime" timestamp without time zone,
    "UpdateUserId" character varying(50),
    "UpdateUserName" character varying(200),
    "OrgId" character varying(50)
);


ALTER TABLE public."WmsInboundOrderTbl" OWNER TO postgres;

--
-- Data for Name: Application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Application" ("Id", "Name", "AppSecret", "Description", "Icon", "Disable", "CreateTime", "CreateUser") FROM stdin;
\.


--
-- Data for Name: BuilderTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."BuilderTable" ("Id", "TableName", "Comment", "DetailTableName", "DetailComment", "ClassName", "Namespace", "ModuleCode", "ModuleName", "Folder", "Options", "TypeId", "TypeName", "CreateTime", "CreateUserId", "UpdateTime", "UpdateUserId", "UpdateUserName", "CreateUserName", "ForeignKey", "IsDynamicHeader", "ParentTableId") FROM stdin;
\.


--
-- Data for Name: BuilderTableColumn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."BuilderTableColumn" ("Id", "TableId", "TableName", "ColumnName", "Comment", "ColumnType", "EntityType", "EntityName", "IsKey", "IsIncrement", "IsRequired", "IsInsert", "IsEdit", "IsList", "IsQuery", "QueryType", "HtmlType", "EditType", "Sort", "CreateTime", "CreateUserId", "UpdateTime", "UpdateUserId", "EditRow", "EditCol", "UpdateUserName", "CreateUserName", "MaxLength", "DataSource") FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" ("Id", "Name", "DtCode", "DtValue", "Enable", "SortNo", "Description", "TypeId", "CreateTime", "CreateUserId", "CreateUserName", "UpdateTime", "UpdateUserId", "UpdateUserName") FROM stdin;
\.


--
-- Data for Name: CategoryType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CategoryType" ("Id", "Name", "CreateTime") FROM stdin;
\.


--
-- Data for Name: DataPrivilegeRule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DataPrivilegeRule" ("Id", "SourceCode", "SubSourceCode", "Description", "SortNo", "PrivilegeRules", "Enable", "CreateTime", "CreateUserId", "CreateUserName", "UpdateTime", "UpdateUserId", "UpdateUserName") FROM stdin;
\.


--
-- Data for Name: FlowInstance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FlowInstance" ("Id", "InstanceSchemeId", "Code", "CustomName", "ActivityId", "ActivityType", "ActivityName", "PreviousId", "SchemeContent", "SchemeId", "DbName", "FrmData", "FrmType", "FrmContentData", "FrmContentParse", "FrmId", "SchemeType", "Disabled", "CreateDate", "CreateUserId", "CreateUserName", "FlowLevel", "Description", "IsFinish", "MakerList", "OrgId") FROM stdin;
\.


--
-- Data for Name: FlowInstanceOperationHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FlowInstanceOperationHistory" ("Id", "InstanceId", "Content", "CreateDate", "CreateUserId", "CreateUserName") FROM stdin;
\.


--
-- Data for Name: FlowInstanceTransitionHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FlowInstanceTransitionHistory" ("Id", "InstanceId", "FromNodeId", "FromNodeType", "FromNodeName", "ToNodeId", "ToNodeType", "ToNodeName", "TransitionSate", "IsFinish", "CreateDate", "CreateUserId", "CreateUserName") FROM stdin;
\.


--
-- Data for Name: FlowScheme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FlowScheme" ("Id", "SchemeCode", "SchemeName", "SchemeType", "SchemeVersion", "SchemeCanUser", "SchemeContent", "FrmId", "FrmType", "AuthorizeType", "SortCode", "DeleteMark", "Disabled", "Description", "CreateDate", "CreateUserId", "CreateUserName", "ModifyDate", "ModifyUserId", "ModifyUserName", "OrgId") FROM stdin;
\.


--
-- Data for Name: Form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Form" ("Id", "Name", "FrmType", "WebId", "Fields", "ContentData", "ContentParse", "Content", "SortCode", "DeleteMark", "DbName", "Disabled", "Description", "CreateDate", "CreateUserId", "CreateUserName", "ModifyDate", "ModifyUserId", "ModifyUserName", "OrgId") FROM stdin;
\.


--
-- Data for Name: FrmLeaveReq; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FrmLeaveReq" ("Id", "UserName", "RequestType", "StartDate", "StartTime", "EndDate", "EndTime", "RequestComment", "Attachment", "CreateDate", "CreateUserId", "CreateUserName", "FlowInstanceId") FROM stdin;
\.


--
-- Data for Name: Module; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Module" ("Id", "CascadeId", "Name", "Url", "HotKey", "IsLeaf", "IsAutoExpand", "IconName", "Status", "ParentName", "Vector", "SortNo", "ParentId", "Code", "IsSys") FROM stdin;
7580672f-a390-4bb6-982d-9a4570cb5199	.0.1.	基础配置	 /		f	f	layui-icon-set-fill	0	根节点		1	\N	\N	t
15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9	.0.4.	仓储中心	/		f	f		0	根节点		2	\N		f
069475e3-c997-487a-9f29-e6a864c5c1d4	.0.2.	流程中心	/		f	f	layui-icon-senior	0	根节点		3	\N	\N	t
b19bce90-5508-43b6-93ed-cd9ff9e356a9	.0.3.	消息日志	 /		f	f	layui-icon-set-fill	0	根节点		4	\N	\N	t
92b00259-2d15-43e7-9321-adffb29e8bf2	.0.1.11.	表单设计	/forms/index		f	f	layui-icon-theme	0	基础配置		5	7580672f-a390-4bb6-982d-9a4570cb5199	Form	t
7bc7e527-478d-49fd-868d-5f31951586f5	.0.3.1.	系统日志	/SysLogs/Index		f	f	layui-icon-theme	0	消息日志		1	b19bce90-5508-43b6-93ed-cd9ff9e356a9	SysLog	t
7bc7e527-478d-49fd-868d-5f31951586f6	.0.3.2.	我的消息	/SysMessages/Index		f	f	layui-icon-theme	0	消息日志		2	b19bce90-5508-43b6-93ed-cd9ff9e356a9	SysMessage	t
e8dc5db6-4fc4-4795-a1cc-681cbcceec91	.0.1.3.	资源管理	/Resources/Index		f	f	layui-icon-cellphone	0	基础配置		8	7580672f-a390-4bb6-982d-9a4570cb5199	Resource	f
0031262c-689c-4b96-bae2-2c9d67076ade	.0.1.9.	流程设计	/flowSchemes/index		f	f	layui-icon-engine	0	基础配置		6	7580672f-a390-4bb6-982d-9a4570cb5199	FlowScheme	t
bedb41a2-f310-4775-af99-01be08adda93	.0.1.14.	角色管理	/RoleManager/Index		f	f	layui-icon-user	0	基础配置		2	7580672f-a390-4bb6-982d-9a4570cb5199	Role	t
907a24c6-3c95-4073-8f90-ea7ec42c63f7	.0.1.19.	定时任务	/OpenJobs/Index		f	f	layui-icon-time	0	基础配置		2	7580672f-a390-4bb6-982d-9a4570cb5199	OpenJob	t
37bb9414-19a0-4223-9056-71f8c758a930	.0.2.5.	已处理流程	/flowinstances/disposed		f	f	layui-icon-ok-circle	0	流程中心		3	069475e3-c997-487a-9f29-e6a864c5c1d4	FlowInstanceDisposed	t
4abafc83-c8f5-452f-9882-e113a86e7a3e	.0.2.6.	待处理流程	/flowinstances/wait		f	f	layui-icon-help	0	流程中心		1	069475e3-c997-487a-9f29-e6a864c5c1d4	FlowInstanceWait	t
a94d5648-c2a9-405e-ba6f-f1602ec9b807	.0.1.17.	字典分类	/Categories/Index		f	f		0	基础配置		7	7580672f-a390-4bb6-982d-9a4570cb5199	Category	f
9a87c0fa-9172-42a1-9505-7492433dcb8e	.0.1.16.	数据权限	/dataprivilegerules/index		f	f	layui-icon-auz	0	基础配置		1	7580672f-a390-4bb6-982d-9a4570cb5199	DataPrivilegeRule	f
98a949e8-8704-40a7-b9a1-c0e8801e4057	.0.4.1.	入库订单	/wmsinboundordertbls/index		f	f		0	仓储中心		1	15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9	WmsInboundOrderTbl	f
bc80478d-0547-4437-9cff-be4b40144bdf	.0.1.13.	模块管理	/ModuleManager/Index		f	f	layui-icon-tabs	0	基础配置		1	7580672f-a390-4bb6-982d-9a4570cb5199	Module	t
9486ff22-b696-4d7f-8093-8a3e53c45453	.0.2.7.	我的流程	/flowInstances/Index		f	f	layui-icon-share	0	流程中心		2	069475e3-c997-487a-9f29-e6a864c5c1d4	FlowInstance	t
ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c	.0.1.15.	用户管理	/UserManager/Index		f	f	layui-icon-friends	0	基础配置		3	7580672f-a390-4bb6-982d-9a4570cb5199	User	t
6a9e1346-0c01-44d2-8eb1-f929fdab542a	.0.1.10.	部门管理	/OrgManager/Index		f	f	layui-icon-group	0	基础配置		4	7580672f-a390-4bb6-982d-9a4570cb5199	Org	t
\.


--
-- Data for Name: ModuleElement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ModuleElement" ("Id", "DomId", "Name", "Attr", "Script", "Icon", "Class", "Remark", "Sort", "ModuleId", "TypeName", "TypeId") FROM stdin;
1c870438-4260-43a5-8996-a6e1dc8bbf6a	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加部门	0	6a9e1346-0c01-44d2-8eb1-f929fdab542a	\N	\N
1c870438-4260-43a5-8996-a6e1dc8bbf6b	btnAssignOrgUser	分配用户		assignOrgUser(this)	layui-icon-add-1	layui-btn-normal	分配用户	0	6a9e1346-0c01-44d2-8eb1-f929fdab542a	\N	\N
daddf3b9-71b5-45ac-b85d-5a11c522f2f4	btnDel	删除	 	del()	layui-icon-delete	layui-btn-danger	删除模块	3	bc80478d-0547-4437-9cff-be4b40144bdf	\N	\N
84e38920-f6e5-499c-bf52-a3c6f8499ff7	btnDel	删除	 	del()	layui-icon-delete	layui-btn-danger	删除分类	3	a94d5648-c2a9-405e-ba6f-f1602ec9b807	\N	\N
4bfa8ea0-6b0d-426f-8687-b654575ca780	btnEdit	编辑		edit()	layui-icon-edit	layui-btn-normal	编辑资源	2	e8dc5db6-4fc4-4795-a1cc-681cbcceec91	\N	\N
ef42721f-d223-4a00-a1d9-80b81121f21a	btnEdit	编辑	 	edit()	layui-icon-edit	layui-btn-normal	编辑部门	1	6a9e1346-0c01-44d2-8eb1-f929fdab542a	\N	\N
6c814946-db5c-48bd-84dd-b1c38196ad74	btnAdd	添加模版		add()	layui-icon-add-1	layui-btn-normal		0	0031262c-689c-4b96-bae2-2c9d67076ade	\N	\N
5ed1681c-13d2-4c87-8676-a8d95c0b40ae	btnEditMenu	编辑菜单			layui-icon-add-1	layui-btn-normal	编辑菜单	5	bc80478d-0547-4437-9cff-be4b40144bdf	\N	\N
c3d7b478-21e9-4c1e-b866-a3c80be7909b	btnRefresh	刷新		refresh()	layui-icon-refresh	layui-btn-normal	刷新分类	0	a94d5648-c2a9-405e-ba6f-f1602ec9b807	\N	\N
9c96e485-84a6-45f0-b6a7-f01dab94b0c6	btnPreview	预览		preview()	layui-icon-search	layui-btn-normal		4	92b00259-2d15-43e7-9321-adffb29e8bf2	\N	\N
18cc3217-28a6-49b2-9a20-080230065984	btnEdit	编辑		edit()	layui-icon-edit	layui-btn-normal		1	0031262c-689c-4b96-bae2-2c9d67076ade	\N	\N
38109ca0-32ec-44bd-a243-017e591b532b	btnEditStock	编辑	 	edit()	layui-icon-edit	layui-btn-normal	编辑进出库	0	89c3bfbe-246f-4112-8eb1-b6789da54202	\N	\N
34730f5a-d307-457b-9041-5f7de30abfaa	btnEdit	编辑		edit()	layui-icon-edit	layui-btn-normal	编辑定时任务	2	907a24c6-3c95-4073-8f90-ea7ec42c63f7	\N	\N
8966b04f-8e26-4046-8b03-0c64f9f833dd	btnDel	删除		del()	layui-icon-delete	layui-btn-danger		3	92b00259-2d15-43e7-9321-adffb29e8bf2	\N	\N
6db928fe-93df-460f-9472-8bb0b6cae52c	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加进出库	0	89c3bfbe-246f-4112-8eb1-b6789da54202	\N	\N
362d1eda-c85e-4b14-a80a-b923291e08de	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加	0	f0f06b8f-0a86-487c-8b0e-0a12573ccd46	\N	\N
c35d8f5b-0d38-4f31-84f9-39e476eeab08	btnAdd	新订单			layui-icon-add-1	layui-btn-normal		1	98a949e8-8704-40a7-b9a1-c0e8801e4057		
84694ea5-d6e1-4a65-8a59-7b5b779688d4	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加模块	1	bc80478d-0547-4437-9cff-be4b40144bdf	\N	\N
826b12b3-e916-446d-a2fa-329cfd13c831	btnDetail	进度详情			layui-icon-search	layui-btn-normal		2	4abafc83-c8f5-452f-9882-e113a86e7a3e	\N	\N
5ed1681c-13d2-4c87-8675-a8d95c0b40ae	btnAddMenu	添加菜单		assignButton()	layui-icon-add-1	layui-btn-normal	为模块分配按钮	4	bc80478d-0547-4437-9cff-be4b40144bdf	\N	\N
1a473afd-cbd4-41e9-9471-81f9435aaabe	btnEdit	编辑	 	edit()	layui-icon-edit	layui-btn-normal	编辑分类	2	a94d5648-c2a9-405e-ba6f-f1602ec9b807	\N	\N
c7d7daf0-3669-4a22-8bed-b092617deb9c	btnDel	删除		del()	layui-icon-delete	layui-btn-danger	删除资源	3	e8dc5db6-4fc4-4795-a1cc-681cbcceec91	\N	\N
81ce1abe-209d-4e4c-a8d2-efbc6a3b45ba	btnAdd	添加			layui-icon-add-1	layui-btn-normal		1	9a87c0fa-9172-42a1-9505-7492433dcb8e		
17ae4fd4-ab4e-439e-ba1d-2a53b46d112b	btnDel	删除		del()	layui-icon-delete	layui-btn-danger		2	0031262c-689c-4b96-bae2-2c9d67076ade	\N	\N
1c9acc3e-a40d-4d07-b495-6e60eb9b71b9	btnEdit	编辑		edit()	layui-icon-edit	layui-btn-normal	编辑角色	1	bedb41a2-f310-4775-af99-01be08adda93	\N	\N
5ed1681c-13d2-4c87-8677-a8d95c0b40ae	btnDelMenu	删除菜单			layui-icon-delete	layui-btn-danger		6	bc80478d-0547-4437-9cff-be4b40144bdf		
b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a	btnDetail	查看详情			layui-icon-search	layui-btn-normal		0	37bb9414-19a0-4223-9056-71f8c758a930		
0d25438e-1436-48e0-aedf-0f1690693282	btnAccessModule	为角色分配模块		assignRoleModule(this)	layui-icon-search	layui-btn-normal	为角色分配模块	4	bedb41a2-f310-4775-af99-01be08adda93	\N	\N
2d595a2a-5de5-479e-a331-b53c799a6b11	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加定时任务	1	907a24c6-3c95-4073-8f90-ea7ec42c63f7	\N	\N
34730f5a-d307-457b-9041-5f7de30abfa9	btnEdit	编辑		edit()	layui-icon-edit	layui-btn-normal	编辑用户	1	ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c	\N	\N
79dcd3eb-3aaf-4e08-83c9-713d8ff446fe	btnVerification	处理		verificationForm()	layui-icon-triangle-r	layui-btn-normal		1	4abafc83-c8f5-452f-9882-e113a86e7a3e	\N	\N
816b12b3-e916-446d-a2fa-329cfd13c831	btnDetail	进度详情			layui-icon-search	layui-btn-normal		4	9486ff22-b696-4d7f-8093-8a3e53c45453	\N	\N
9e2c6754-f258-4b14-96a0-b9d981196a65	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加资源	0	e8dc5db6-4fc4-4795-a1cc-681cbcceec91	\N	\N
06fe4738-b4f4-4ecf-b9da-07dd3bb26cb3	btnDel	撤销订单			layui-icon-delete	layui-btn-danger		3	98a949e8-8704-40a7-b9a1-c0e8801e4057		
7f071c63-1620-4486-9264-5806b2e63218	btnAccessRole	为用户分配角色		openUserRoleAccess(this)	layui-icon-search	layui-btn-normal	为用户分配角色	5	ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c	\N	\N
68484265-7802-4f06-b024-33e8b2f2edcf	btnAdd	新的申请		add()	layui-icon-add-1	layui-btn-normal	申请物品	0	9486ff22-b696-4d7f-8093-8a3e53c45453	\N	\N
3dc0ec4d-bf86-4bae-9ec0-1d6c2403fb99	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal		1	92b00259-2d15-43e7-9321-adffb29e8bf2	\N	\N
4f2737db-633f-4946-8a71-b08b9885f151	btnEdit	编辑		edit()	layui-icon-edit	layui-btn-normal		2	92b00259-2d15-43e7-9321-adffb29e8bf2	\N	\N
68fc793f-069f-43e1-a012-42ac2d7c585c	btnDel	删除		del()	layui-icon-delete	layui-btn-danger	删除角色	2	bedb41a2-f310-4775-af99-01be08adda93	\N	\N
2d595a2a-5de5-479e-a331-b53c799a6b10	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加分类	1	a94d5648-c2a9-405e-ba6f-f1602ec9b807	\N	\N
0d25438e-1436-48e0-aedf-0f1690693281	btnRoleAccessUser	添加角色用户		assignRoleUser(this)	layui-icon-search	layui-btn-normal	添加角色用户	4	bedb41a2-f310-4775-af99-01be08adda93	\N	\N
50c9df24-b233-42cb-9a0d-4ce158c75f86	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加用戶	0	ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c	\N	\N
d352c8ee-3dff-4d28-a0de-903ae68f2533	btnPreview	预览		preview()	layui-icon-cellphone	layui-btn-normal		3	0031262c-689c-4b96-bae2-2c9d67076ade	\N	\N
44075557-496e-4dde-bb75-7b69f51ab4fe	btnEdit	编辑		edit()	layui-icon-edit	layui-btn-normal	编辑模块	2	bc80478d-0547-4437-9cff-be4b40144bdf	\N	\N
7b2b1ffb-398b-4f7b-83da-8f484e1bcea0	btnDel	删除		del()	layui-icon-delete	layui-btn-danger	删除部门	2	6a9e1346-0c01-44d2-8eb1-f929fdab542a	\N	\N
d1ba6a72-ba14-44c0-baba-46d0ad96fe8a	btnRefresh	刷新		refresh()	layui-icon-refresh	layui-btn-normal	刷新用户	3	ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c	\N	\N
645b40ac-4223-44a7-aab4-66eb56cf9864	btnAdd	添加		add()	layui-icon-add-1	layui-btn-normal	添加角色	0	bedb41a2-f310-4775-af99-01be08adda93	\N	\N
2feefce1-e3d8-42ac-b811-2352679628da	btnDel	删除		del()	layui-icon-delete	layui-btn-danger	刪除用戶	2	ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c	\N	\N
584c7a3b-d28a-47b4-8648-7797d05d83d1	btnDel	删除		del()	layui-icon-delete	layui-btn-danger		3	9486ff22-b696-4d7f-8093-8a3e53c45453	\N	\N
2feefce1-e3d8-42ac-b811-2352679628dd	btnDel	删除		del()	layui-icon-delete	layui-btn-danger	刪除定时任务	3	907a24c6-3c95-4073-8f90-ea7ec42c63f7	\N	\N
054e9699-7828-4b8b-a28b-d7ae45ed3306	btnEdit	编辑			layui-icon-edit	layui-btn-normal		2	98a949e8-8704-40a7-b9a1-c0e8801e4057		
15a4f88c-4fae-4cab-ba2f-0cbd2cca8736	btnAssignReource	为角色分配资源		openRoleReourceAccess(this)	layui-icon-search	layui-btn-normal	为角色分配资源	3	bedb41a2-f310-4775-af99-01be08adda93	\N	\N
95c2dde0-f2a7-4474-8aa7-c7eaa7c4c87f	btnDel	删除			layui-icon-delete	layui-btn-danger		1	9a87c0fa-9172-42a1-9505-7492433dcb8e		
a7eea5dc-3b10-4550-9cf3-0dba9b9fc32c	btnAddCategory	添加分类			layui-icon-add-1	layui-btn-normal		0	a94d5648-c2a9-405e-ba6f-f1602ec9b807		
c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2	btnDel	删除		del()	layui-icon-delete	layui-btn-danger	删除进出库	0	89c3bfbe-246f-4112-8eb1-b6789da54202	\N	\N
13617796-049c-4ae4-a62b-1ca84002b273	btnDelCategory	删除分类			layui-icon-delete	layui-btn-danger		0	a94d5648-c2a9-405e-ba6f-f1602ec9b807		
f8dde22a-2a37-47c4-8e67-70fb3af5303e	btnRefresh	刷新		refresh()	layui-icon-refresh	layui-btn-normal	刷新部门	3	6a9e1346-0c01-44d2-8eb1-f929fdab542a	\N	\N
\.


--
-- Data for Name: OpenJob; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OpenJob" ("Id", "JobName", "RunCount", "ErrorCount", "NextRunTime", "LastRunTime", "LastErrorTime", "JobType", "JobCall", "JobCallParams", "Cron", "Status", "Remark", "CreateTime", "CreateUserId", "CreateUserName", "UpdateTime", "UpdateUserId", "UpdateUserName", "OrgId") FROM stdin;
\.


--
-- Data for Name: Org; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Org" ("Id", "CascadeId", "Name", "HotKey", "ParentName", "IsLeaf", "IsAutoExpand", "IconName", "Status", "BizCode", "CustomCode", "CreateTime", "CreateId", "SortNo", "ParentId", "TypeName", "TypeId") FROM stdin;
\.


--
-- Data for Name: Relevance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Relevance" ("Id", "Description", "Key", "Status", "OperateTime", "OperatorId", "FirstId", "SecondId", "ThirdId", "ExtendInfo") FROM stdin;
2a36a2b7-41aa-4190-b88c-75d44a56ad6e		UserModule	0	2017-02-06 00:14:18	0	3a95e392-07d4-4af3-b30d-140ca93340f5	92b00259-2d15-43e7-9321-adffb29e8bf2	\N	\N
2a818d22-1ca8-48e2-a2ed-3dbc3d05cc8b		RoleElement	0	2020-04-25 11:49:11.127		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	5fba6316-5599-4245-822c-48ff33299868		
2a8a790f-0b9a-4ab3-8e4f-aae4bfddc609		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	PurchaseNo	
2bb3fddb-0f51-442e-8dbf-236beb47d8a6		RoleOrg	0	2018-04-14 13:16:45		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
2c67ac44-5b67-4942-b457-2212e9a5dbf9		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	e8dc5db6-4fc4-4795-a1cc-681cbcceec91		
2ca288a6-d222-4328-951e-c01c3e77a0c7		RoleElement	0	2016-09-04 23:21:00	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	7f071c63-1620-4486-9264-5806b2e63218	\N	\N
2d0fcc88-a7c0-4d33-8a08-1d688e9dde83		RoleModule	0	2016-09-02 17:03:39	0	211e12c7-e466-496e-8d26-0660a38e24cc	a94d5648-c2a9-405e-ba6f-f1602ec9b807	\N	\N
2d15e438-cc3a-41e9-9b13-325bfd5c804a		RoleElement	0	2016-09-04 23:21:09	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	84e38920-f6e5-499c-bf52-a3c6f8499ff7	\N	\N
2e1d286c-b771-43b0-947e-eeab185cc014		RoleModule	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	4abafc83-c8f5-452f-9882-e113a86e7a3e		
2ebff9a4-b2d5-4a35-a7dd-2cfa2f5b0522		ProcessUser	0	2016-09-07 17:33:39	0	52cc7933-a045-4dcc-8c17-1b618bfa772b	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	\N	\N
30c82d18-7892-4e5f-9aee-e4f483a858c2		UserModule	0	2016-09-05 16:24:55	0	ea25646b-964b-4d41-ab03-d8964e1494fb	9486ff22-b696-4d7f-8093-8a3e53c45453	\N	\N
3225a4dc-c988-410c-8bcd-9afbccbafc09		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	584c7a3b-d28a-47b4-8648-7797d05d83d1		
332a373c-f485-4f85-9af9-7792f7462bf1		RoleModule	0	2016-09-02 17:03:47	0	648b04c4-4ac2-4d69-bef6-07081ef27871	89c3bfbe-246f-4112-8eb1-b6789da54202	\N	\N
333771cf-7eab-4d57-988a-8bd934575558		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	OwnerId	
336b16ba-8313-4cb3-87d7-4370ff175c14		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	Resource	Id	
33fa12d8-8e48-4d1c-9c84-50f533b682ec		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	CreateTime	
340c60fe-8b95-474c-aa04-9197903998d2		RoleModule	0	2016-09-04 23:20:34	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	7580672f-a390-4bb6-982d-9a4570cb5199	\N	\N
361feb63-bde2-49c7-86ec-6df3ec6f0fe3		RoleElement	0	2016-09-04 23:21:13	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	1c870438-4260-43a5-8996-a6e1dc8bbf6a	\N	\N
388f792e-dbd1-40a1-8374-9339e7e60d9e		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	UpdateTime	
3905b8a3-ed7e-4fe0-9e6d-747f6bc79235		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	TypeName	
392dc41e-7186-4efb-a8e5-b5317e4122fb		RoleResource	0	2018-09-10 12:54:14		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	OPENAUTH_DELETEACCOUNT	\N	\N
3931d5b7-dde2-4530-bb2d-79b73f76e19b		RoleDataProperty	0	2019-11-23 00:19:30		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	Category	Name	
3aa0cdcb-ec57-420e-b1b0-eb4d77b8a8d5		UserOrg	0	2020-03-19 21:20:04.11		49df1602-f5f3-4d52-afb7-3802da619558	86449128-d5ac-44bf-b999-f7735b7458fd		
3b4845a5-d7a2-4da7-b95c-43ad03980fda		UserOrg	0	2020-03-19 21:20:04.11		49df1602-f5f3-4d52-afb7-3802da619558	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b		
3bcaab20-e096-480e-a9bb-0fdb70686714		RoleElement	0	2016-09-04 23:21:00	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	cf7388be-2677-427c-ad78-8f00f1062b96	\N	\N
3de0359b-6331-4dc7-a00e-751f71dbadb5		ProcessUser	0	2016-09-28 09:23:30	0	68295d2a-4dfd-4c5e-81e3-9c787e2603bc	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	\N	\N
4190f00a-11a0-4814-849b-cc5232fa4dd4		RoleResource	0	2018-09-12 00:15:54		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	OPENAUTH_DELETEACCOUNT	\N	\N
42ba8a59-5493-4e11-b61b-d87000092767		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	4abafc83-c8f5-452f-9882-e113a86e7a3e		
4459ffd7-446b-456b-aee5-48e67ca000f8		UserOrg	0	2019-10-31 21:51:45		6ba79766-faa0-4259-8139-a4a6d35784e0	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b		
456ddfed-6607-41e9-9c46-0d4c7c9c38d4		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	Status	
45744773-1b85-4913-bc1b-2f00b95a8198		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	9e2c6754-f258-4b14-96a0-b9d981196a65		
45dee058-6b62-4005-a134-dcf7c2781851		RoleElement	0	2020-04-25 11:50:18.427		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	a6b61073-9e76-40ef-88ad-15c8789e2033		
45e97612-46d8-4c36-b89e-ce6572ed7988		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	Id	
460d1c98-2a68-43cf-8d38-d40ceb89916f		UserOrg	0	2017-10-12 09:13:38		3eacdedd-e93a-4816-b49c-99ba3d5323c2	86449128-d5ac-44bf-b999-f7735b7458fd	\N	\N
465b8bc0-b817-410d-849e-55f66b2a3211		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	98a949e8-8704-40a7-b9a1-c0e8801e4057		
471e98ee-9cc5-4dc7-8762-a452e855dbd5		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	CreateTime	
4757bb30-e4bc-4c2d-a824-947ef151d341		UserRole	0	2016-09-07 20:21:16	0	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	4980a85b-e3db-4607-bc2c-0baf0140d7df	\N	\N
4ba3982b-f0ae-4f9a-980e-1eaedc3b5f2e		UserElement	0	2016-09-07 17:48:34	0	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	584c7a3b-d28a-47b4-8648-7797d05d83d1	\N	\N
4c2fb006-53d6-4041-8cf6-e5d74d788897		UserModule	0	2018-04-06 09:48:19		6ba79766-faa0-4259-8139-a4a6d35784e0	9486ff22-b696-4d7f-8093-8a3e53c45453	\N	\N
4c69794b-9957-4f6b-b0fb-6455fe643565		UserElement	0	2018-04-06 14:50:41		49df1602-f5f3-4d52-afb7-3802da619558	826b12b3-e916-446d-a2fa-329cfd13c831	\N	\N
4daccce5-cb7b-46aa-8bed-3c85c72436be		RoleOrg	0	2018-09-12 00:08:37		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
4e613188-0387-4d17-a60d-703b4a606d75		RoleModule	0	2016-09-04 23:20:34	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	bc80478d-0547-4437-9cff-be4b40144bdf	\N	\N
4e665304-9f05-410e-b68f-44d45281b788		RoleOrg	0	2018-09-12 00:08:47		3e761e88-ddf7-4a62-b219-9a315b4564f2	c36e43df-3a99-45da-80d9-3ac5d24f4014	\N	\N
4e693bbd-8ddb-42af-b888-30885612c154		UserOrg	0	2019-10-31 21:58:43		96f63f9d-e8c8-4258-963e-3327ed7d6f56	3d2ad14c-2c56-4a90-a2db-6bde26b0b8b3		
4ec39ee9-9ee9-4aa9-a0db-eb0fdf8d2f00		UserElement	0	2018-04-06 09:48:27		6ba79766-faa0-4259-8139-a4a6d35784e0	b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a	\N	\N
4ee89c07-55e2-4ca6-9ef1-449cfe0a2c3c		RoleResource	0	2018-09-12 00:15:54		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	OPENAUTH_LOGIN	\N	\N
4fde1dc6-9d73-4c7c-9238-28981858c5a6		RoleModule	0	2016-09-05 09:21:56	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	89c3bfbe-246f-4112-8eb1-b6789da54202	\N	\N
5167dbcd-3a32-4ae8-827e-6f381cc58fa2		RoleElement	0	2016-09-04 23:21:00	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	fa816af1-a28d-47b5-9b8b-c46e18f902e9	\N	\N
51c56567-bbf8-466e-8678-9b6bfb38c493		RoleElement	0	2020-04-25 11:49:11.13		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	5fba6316-5599-4245-822c-48ff33299868		
526d6f39-e75a-402b-8ba6-9bb08731da1e		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	CreateTime	
53a4be87-4fa8-415b-97b5-2298ce8b17c8		UserResource	0	2018-04-14 14:38:04		49df1602-f5f3-4d52-afb7-3802da619558	XXX_LOGIN	\N	\N
54b2e9b6-1f7c-4a39-92c9-98f58429c1fc		RoleModule	0	2016-09-02 17:03:39	0	211e12c7-e466-496e-8d26-0660a38e24cc	bc80478d-0547-4437-9cff-be4b40144bdf	\N	\N
54eadc62-a77e-4baa-aa6d-34f5af2d6774		RoleElement	0	2020-04-25 11:49:36.49		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	4770af29-1375-4d27-ab0c-fdbeab87b710		
55b10ecc-3fb3-4127-b69e-e7a3467d7a1a		RoleElement	0	2016-09-05 09:22:11	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	6db928fe-93df-460f-9472-8bb0b6cae52c	\N	\N
5725ff79-43c6-4778-bbff-131cf364dab6		UserElement	0	2016-10-20 17:01:01	0	3a95e392-07d4-4af3-b30d-140ca93340f5	cf7388be-2677-427c-ad78-8f00f1062b96	\N	\N
575221eb-0e4d-4cfa-9cd8-59607784d43d		UserRole	0	2019-10-31 21:59:41		6ba79766-faa0-4259-8139-a4a6d35784e0	3e761e88-ddf7-4a62-b219-9a315b4564f2		
5965ae4d-c718-421f-9895-fdf6255a002e		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	ReturnBoxNum	
59c8b633-167e-47c1-bb63-837780ea93dc		RoleModule	0	2020-04-25 11:48:19.567		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	5c55f7eb-4552-4610-a584-d72685f8d064		
5a20d59c-6ee6-4fe2-98fe-7b35b11026ae		UserElement	0	2016-09-07 15:30:20	0	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	68484265-7802-4f06-b024-33e8b2f2edcf	\N	\N
5aa8ae27-e5b1-4f46-9342-73f1ba11c14c		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	826b12b3-e916-446d-a2fa-329cfd13c831		
5b2d5db8-d603-4be3-add2-c85ef3c53ddc		UserResource	0	2018-04-14 14:38:05		49df1602-f5f3-4d52-afb7-3802da619558	OPENAUTH_LOGIN	\N	\N
5ccce632-f8f0-452b-8faf-4a5372004e85		RoleResource	0	2018-09-12 00:15:54		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	XXX_CHECKUSER	\N	\N
5f616264-84f0-42de-a84a-61d11f2f4786		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	4bfa8ea0-6b0d-426f-8687-b654575ca780		
5f8ac964-c87d-44c0-b780-c4c1382800ea		RoleElement	0	2020-03-19 22:31:02.46		d27ae3cf-135f-4d57-93a6-2120ddf98650	6c814946-db5c-48bd-84dd-b1c38196ad74		
620b368a-7b56-4c74-ab85-8bc91d08ddc9		RoleElement	0	2016-09-04 23:20:42	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	1c9acc3e-a40d-4d07-b495-6e60eb9b71b9	\N	\N
635779b1-f223-41f2-b9a4-7f35633008d7		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	18cc3217-28a6-49b2-9a20-080230065984		
6431a464-6f1f-4ffc-8157-89212b70f09a		RoleOrg	0	2016-09-05 00:00:00	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
64e4f5aa-28ef-4690-9b20-5f0b543964f6		UserElement	0	2016-09-07 15:30:20	0	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	816b12b3-e916-446d-a2fa-329cfd13c831	\N	\N
6532f9c1-3067-4952-b008-e766f833050e		UserRole	0	2019-11-23 00:48:41		96f63f9d-e8c8-4258-963e-3327ed7d6f56	77e6d0c3-f9e1-4933-92c3-c1c6eef75593		
6552d053-69b3-4ae9-b1f2-497582dcb8aa		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	c7d7daf0-3669-4a22-8bed-b092617deb9c		
6645b6fb-efcf-4e48-9c13-84f79bc5be34		RoleOrg	0	2018-04-14 13:16:45		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	86449128-d5ac-44bf-b999-f7735b7458fd	\N	\N
66e25fc5-093d-42ab-85dc-a38f6600889b		UserOrg	0	2016-09-02 13:57:32	0	ea25646b-964b-4d41-ab03-d8964e1494fb	c36e43df-3a99-45da-80d9-3ac5d24f4014	\N	\N
67c502cf-c9bf-4ad3-b749-eda1c7f388e7		RoleElement	0	2020-04-25 11:50:18.43		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	a6b61073-9e76-40ef-88ad-15c8789e2033		
68912e65-256e-45b6-b48e-036382598d32		RoleOrg	0	2016-10-17 10:03:49	0	2eb423d6-6ad9-4efe-b423-872478a2a434	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
68984a83-ce96-4144-9e23-0e0f2249fb45		UserOrg	0	2019-10-31 21:51:30		de8be521-f1ec-4483-b124-0be342890507	c36e43df-3a99-45da-80d9-3ac5d24f4014		
6a0d3b61-67d0-4090-a622-08d5643e1af8		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	Name	
6a427baa-c54c-4830-a2fe-34e206f471c5		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	2d595a2a-5de5-479e-a331-b53c799a6b10		
6b9c4789-042c-4f6f-a749-ee68ee87462d		ProcessUser	0	2016-10-27 16:47:52	0	054ff054-d8ae-4911-a596-8fb1f66b348f	3a95e392-07d4-4af3-b30d-140ca93340f5	\N	\N
6d6eb70e-0caf-485f-943c-671be021a588		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	AppName	
6da6d662-8cef-47cd-80b3-fa885b2dca7a		RoleOrg	0	2018-04-14 13:16:45		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
6db5666b-6f8c-4e83-bada-0b45054bd9a4		RoleElement	0	2016-09-04 23:20:42	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	0d25438e-1436-48e0-aedf-0f1690693282	\N	\N
6fe52499-f800-47ce-96fc-a2b5b43505d5		UserElement	0	2018-04-06 09:48:22		6ba79766-faa0-4259-8139-a4a6d35784e0	584c7a3b-d28a-47b4-8648-7797d05d83d1	\N	\N
7024c6fa-28d2-494f-93af-0651c690e063		RoleModule	0	2020-04-25 11:48:19.567		d27ae3cf-135f-4d57-93a6-2120ddf98650	5c55f7eb-4552-4610-a584-d72685f8d064		
7082bc48-535e-4b92-9dc0-c58340a8239d		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	Resource	Name	
715d017a-68b6-468d-aa3f-32ca4cfd4b9e		RoleModule	0	2016-09-04 23:20:34	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	bedb41a2-f310-4775-af99-01be08adda93	\N	\N
71fa1d0c-1928-4a16-aa94-c92e6f671581		RoleDataProperty	0	2019-11-23 00:51:40		d27ae3cf-135f-4d57-93a6-2120ddf98650	Resource	AppName	
72bf4729-af60-42f5-b0d7-717362ffad7f		RoleElement	0	2016-09-04 23:21:00	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	2feefce1-e3d8-42ac-b811-2352679628da	\N	\N
736141c8-330b-4600-a781-8d0e7cdc01e5		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	SupplierId	
736e90f7-3747-472e-816d-dbb7fdf3b0bb		RoleOrg	0	2018-09-12 00:08:42		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
744da0ee-6c57-4bfc-9937-5ab799112996		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	7bc7e527-478d-49fd-868d-5f31951586f5		
7475b0c3-f204-4f95-a22f-80591fe76bc7		ProcessUser	0	2016-10-31 11:52:39	0	b8bcdf59-1e29-4d97-a364-12ac8e8c5c61	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	\N	\N
75340ad3-fb80-4646-b1de-ba801688ddc2		RoleElement	0	2016-09-04 23:21:04	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	5ed1681c-13d2-4c87-8675-a8d95c0b40ae	\N	\N
759c09ce-f93a-4de7-96fc-cffabc1cd1ac		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	Resource	AppName	
76a5b31b-f855-416c-b7ce-4b9ff1cdb4bc		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	CreateUserName	
76e6629f-764f-4761-afd3-c41e0e9e4310		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	6c814946-db5c-48bd-84dd-b1c38196ad74		
77824f78-792b-4661-b7d9-653f6e0a443c		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	9c96e485-84a6-45f0-b6a7-f01dab94b0c6		
77ac794c-9142-443f-b19c-3b9d960c8ba4		UserOrg	0	2019-10-31 21:51:45		6ba79766-faa0-4259-8139-a4a6d35784e0	86449128-d5ac-44bf-b999-f7735b7458fd		
77bd93da-2c2b-4ba8-bf05-3a1382811a6a		RoleModule	0	2016-09-02 17:03:39	0	211e12c7-e466-496e-8d26-0660a38e24cc	e8dc5db6-4fc4-4795-a1cc-681cbcceec91	\N	\N
77d25c9e-4773-4f95-8048-8d59398835f6		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	3dc0ec4d-bf86-4bae-9ec0-1d6c2403fb99		
77eec82a-f713-4584-872c-761fdbcdb456		UserElement	0	2018-04-06 14:50:37		49df1602-f5f3-4d52-afb7-3802da619558	68484265-7802-4f06-b024-33e8b2f2edcf	\N	\N
77fc08e6-98ae-4d33-b294-bd9fed5b14ed		UserElement	0	2018-04-06 14:50:36		49df1602-f5f3-4d52-afb7-3802da619558	816b12b3-e916-446d-a2fa-329cfd13c831	\N	\N
797c6e5f-7f3c-4891-89b9-a054e10f6c00		UserModule	0	2018-04-06 09:48:01		49df1602-f5f3-4d52-afb7-3802da619558	37bb9414-19a0-4223-9056-71f8c758a930	\N	\N
7a22ccfc-5f4a-472b-850b-61b9552d7e67		UserRole	0	2019-11-23 00:48:10		229f3a49-ab27-49ce-b383-9f10ca23a9d5	d27ae3cf-135f-4d57-93a6-2120ddf98650		
7ab6db05-1098-4134-b228-3329792dc6db		RoleDataProperty	0	2019-11-23 00:51:40		d27ae3cf-135f-4d57-93a6-2120ddf98650	Resource	UpdateUserName	
7b177a26-efdd-406b-8873-24f6565b121f		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	054e9699-7828-4b8b-a28b-d7ae45ed3306		
7c0e613e-2e8e-43e2-93af-cf38bfd56dcb		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	StockId	
7d929ccc-4185-41d0-a81f-42fc0f27a85c		RoleModule	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9		
7d995d7b-5967-4bd0-a601-180925fe4a77		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	7580672f-a390-4bb6-982d-9a4570cb5199		
7dcc9577-f27b-429f-8552-d223d4b48617		UserRole	0	2019-10-31 21:59:41		6ba79766-faa0-4259-8139-a4a6d35784e0	0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d		
7e54557a-5f1d-494c-90c1-509525dd5c08		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	9486ff22-b696-4d7f-8093-8a3e53c45453		
7e8ce905-fa6e-490d-9d33-bde6b6529804		RoleDataProperty	0	2019-11-23 00:19:30		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	Category	Description	
7f25286f-246b-4143-98eb-c3e574fe7455		ProcessUser	0	2016-09-07 17:33:39	0	52cc7933-a045-4dcc-8c17-1b618bfa772b	3a95e392-07d4-4af3-b30d-140ca93340f5	\N	\N
7faeac11-cf1f-40aa-a6ad-2c7768106b9a		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	4f2737db-633f-4946-8a71-b08b9885f151		
7fd7f976-f10e-44aa-a7ba-7ca40d2e8f90		RoleOrg	0	2016-10-17 10:03:30	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
80310629-5e52-482c-9a0f-5c5bdfabcd9e		RoleOrg	0	2016-09-05 00:00:00	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
832f4a8f-7791-4aa6-bcd2-20dcb6f5ef37		UserElement	0	2016-09-02 14:53:04	0	3a95e392-07d4-4af3-b30d-140ca93340f5	15a4f88c-4fae-4cab-ba2f-0cbd2cca8736	\N	\N
84a52091-08a0-4a46-b661-3cd206771c29		RoleModule	0	2016-09-04 23:20:34	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	0031262c-689c-4b96-bae2-2c9d67076ade	\N	\N
854e0658-ab8a-4869-b157-9941955acdc6		RoleElement	0	2016-09-04 23:21:09	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	1a473afd-cbd4-41e9-9471-81f9435aaabe	\N	\N
85b5f9e0-a4d2-4224-9488-c0fb98149f0b		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	c3d7b478-21e9-4c1e-b866-a3c80be7909b		
88a4c966-d042-4a2e-b133-ff7eded1c5de		RoleElement	0	2016-09-04 23:21:13	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	7b2b1ffb-398b-4f7b-83da-8f484e1bcea0	\N	\N
89ea1898-7649-4c3d-ae68-ace9bd9a316b		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	a94d5648-c2a9-405e-ba6f-f1602ec9b807		
8adae84f-6516-4d87-a476-353bc48ae597		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Category	Description	
8af3581e-257f-4655-bac2-5b5afb85ef88		UserOrg	0	2019-10-31 21:59:08		758a34c7-5a31-438c-bdf7-02fdd846b901	b2083488-64e5-44cc-b8f4-929ffa6f2f72		
8b633f3c-965b-4e35-8496-c364890d7760		RoleElement	0	2016-09-04 23:21:09	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	c3d7b478-21e9-4c1e-b866-a3c80be7909b	\N	\N
8c93cb3c-b535-4ab1-af9e-b3ad50847423		RoleDataProperty	0	2019-11-23 00:51:40		d27ae3cf-135f-4d57-93a6-2120ddf98650	Resource	Id	
8e229d71-3b25-4efe-a2fe-829be732a1c6		RoleElement	0	2020-04-25 11:49:11.133		d27ae3cf-135f-4d57-93a6-2120ddf98650	5fba6316-5599-4245-822c-48ff33299868		
8f741d9e-e7f5-4b73-95f4-4b55e0cf6605		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	UpdateUserId	
8fa4a52f-9c0a-43c9-9b7e-b378efb4e1df		RoleResource	0	2018-09-10 12:54:14		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	OPENAUTH_LOGIN	\N	\N
90f19c4e-609f-4dc6-84f7-8b936be05568		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Category	Name	
928e8ddd-b990-471e-983d-f2dac77428d7		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	68484265-7802-4f06-b024-33e8b2f2edcf		
92b2d699-9875-4978-af79-24c83ff4e212		UserOrg	0	2019-10-31 21:58:43		96f63f9d-e8c8-4258-963e-3327ed7d6f56	df442c27-68a0-428e-a309-cba23a994a9d		
92f0b297-96c1-47d4-84dd-571374431bc0		RoleElement	0	2016-09-04 23:21:04	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	84694ea5-d6e1-4a65-8a59-7b5b779688d4	\N	\N
93bcac7a-0ff1-488c-8d1c-3da7e44cbefc		RoleElement	0	2016-09-04 23:21:00	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	d1ba6a72-ba14-44c0-baba-46d0ad96fe8a	\N	\N
95b51b38-177e-4e69-9265-d2c9fcd8b09a		RoleElement	0	2020-04-25 11:50:18.433		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	a6b61073-9e76-40ef-88ad-15c8789e2033		
960224e6-5910-472b-a5ef-b2aa9a8b106f		UserRole	0	2016-09-06 17:06:15	0	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	db309d88-fd21-4b81-a4d9-ae6276a1d813	\N	\N
962b278b-0894-4b36-b1a0-6c5c3d11d4c3		UserElement	0	2018-04-06 14:50:17		49df1602-f5f3-4d52-afb7-3802da619558	b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a	\N	\N
965f010b-2fd6-4b34-ba23-3e44c1af2877		RoleOrg	0	2016-09-08 16:19:18	0	36094f5d-07e7-40d5-91dc-ff60f98b496a	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
98136fef-6d02-4823-bc12-6e5e619e1275		UserRole	0	2019-10-31 21:59:25		758a34c7-5a31-438c-bdf7-02fdd846b901	77e6d0c3-f9e1-4933-92c3-c1c6eef75593		
9a6850d8-fc90-45fe-ab34-cfe0aa1b80ee		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	79dcd3eb-3aaf-4e08-83c9-713d8ff446fe		
9a7648a6-12ac-4473-82ec-c2c845d9047e		RoleElement	0	2019-11-06 10:31:03		3e761e88-ddf7-4a62-b219-9a315b4564f2	054e9699-7828-4b8b-a28b-d7ae45ed3306		
9ad706e3-8e6b-4bc7-a502-371b298ef062		RoleElement	0	2016-09-04 23:21:13	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	ef42721f-d223-4a00-a1d9-80b81121f21a	\N	\N
9ba32bd8-4406-43bf-aac5-0bb0dbd6d228		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	c35d8f5b-0d38-4f31-84f9-39e476eeab08		
9bff1b59-f0fd-41db-9c55-e3275eccfc88		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	Description	
9d568d6d-d78d-47d6-8fb6-b1327cdbe83a		RoleModule	0	2016-09-04 23:20:34	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	a94d5648-c2a9-405e-ba6f-f1602ec9b807	\N	\N
9ded6370-099c-4691-aecd-1ee09542c9d5		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	Disable	
9e46a946-6e81-4f61-bcba-21e4f7fac3df		RoleModule	0	2016-09-02 17:03:39	0	211e12c7-e466-496e-8d26-0660a38e24cc	ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c	\N	\N
9e57e1ff-e9cf-4600-a872-ac85f7845bb0		RoleOrg	0	2018-04-14 13:16:45		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	c36e43df-3a99-45da-80d9-3ac5d24f4014	\N	\N
9edc7b81-2b51-4193-8805-6062e596ccdc		UserOrg	0	2016-09-02 13:57:32	0	ea25646b-964b-4d41-ab03-d8964e1494fb	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
9fa50449-5d87-4579-9f1f-9cdcd876976b		RoleElement	0	2016-09-04 23:21:00	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	6839a297-350b-4215-b680-4e5dfdae5615	\N	\N
a051aa08-38da-4b6d-8d90-10b3c2485e4b		RoleOrg	0	2016-09-05 00:00:00	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	543a9fcf-4770-4fd9-865f-030e562be238	\N	\N
a06fe8c6-3f5e-4085-9bbf-e366571a356c		RoleElement	0	2016-09-04 23:21:04	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	daddf3b9-71b5-45ac-b85d-5a11c522f2f4	\N	\N
a0904102-e26a-4bc5-9c95-ed5ef977586b		RoleModule	0	2016-09-02 17:03:39	0	211e12c7-e466-496e-8d26-0660a38e24cc	6a9e1346-0c01-44d2-8eb1-f929fdab542a	\N	\N
a314a714-95f0-46e2-8341-5a29b9b4f321		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	ShipperId	
a3876834-411d-4228-b7ba-230c29b76295		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	d352c8ee-3dff-4d28-a0de-903ae68f2533		
a3c0d154-4bcc-47a4-9c0e-c0a406686167		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	9e2c6754-f258-4b14-96a0-b9d981196a65		
a5bef7bf-ecdb-4480-ad64-b39a02269607		UserModule	0	2018-04-06 09:48:37		49df1602-f5f3-4d52-afb7-3802da619558	069475e3-c997-487a-9f29-e6a864c5c1d4	\N	\N
a6c7d18e-129f-4922-94bd-8306d1004480		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	Enable	
a8094b46-de5a-40ea-a8ee-69ea905480ef		RoleModule	0	2016-09-05 09:21:56	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	069475e3-c997-487a-9f29-e6a864c5c1d4	\N	\N
a8123b37-ba70-4aab-aef6-1938733b5210		RoleElement	0	2016-09-04 23:20:42	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	c0d8505c-061a-467d-862a-c94f27caa208	\N	\N
a84c4bee-4bf6-4dd7-a0a4-3da64d366535		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	Remark	
a9821db0-49bd-49be-a554-afa811c99760		RoleResource	0	2016-09-04 23:20:22	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	ec99f670-0eca-465c-9f64-d4d5dc510b83	\N	\N
aa051096-a23a-431d-9053-bb954f9453a7		RoleElement	0	2016-09-04 23:20:54	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	4bfa8ea0-6b0d-426f-8687-b654575ca780	\N	\N
aac9206e-a77b-421c-9c85-5f202fddeb31		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	TransferType	
ab84b111-fb5d-4ddd-99d5-479954d9d521		RoleOrg	0	2016-09-08 16:19:18	0	36094f5d-07e7-40d5-91dc-ff60f98b496a	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
ab924ba7-8a74-4804-82b0-ecbbedf4c13e		RoleElement	0	2016-09-05 09:22:11	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	38109ca0-32ec-44bd-a243-017e591b532b	\N	\N
abbf150f-907d-450c-836c-6ad3d6885549		RoleModule	0	2020-04-25 11:48:19.563		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	5c55f7eb-4552-4610-a584-d72685f8d064		
ac184827-9899-4b40-8939-61fe9d2b187c		UserElement	0	2016-09-07 17:48:49	0	3a95e392-07d4-4af3-b30d-140ca93340f5	584c7a3b-d28a-47b4-8648-7797d05d83d1	\N	\N
acb4d37f-8b45-4a99-b364-99f3881dfcda		RoleElement	0	2016-09-04 23:21:13	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	f8dde22a-2a37-47c4-8e67-70fb3af5303e	\N	\N
acc51898-5335-4903-83b9-4701a782bc4d		UserElement	0	2016-10-20 17:01:02	0	3a95e392-07d4-4af3-b30d-140ca93340f5	fa816af1-a28d-47b5-9b8b-c46e18f902e9	\N	\N
ad267296-5eba-4d59-b821-8148d8cfb3c6		RoleModule	0	2016-09-04 23:20:34	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	e8dc5db6-4fc4-4795-a1cc-681cbcceec91	\N	\N
ad29467e-eeee-494c-ab82-f6be5d2619d5		RoleElement	0	2016-09-04 23:21:00	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	50c9df24-b233-42cb-9a0d-4ce158c75f86	\N	\N
ad30e13e-6b75-48f9-97e3-c723d3e36a28		RoleResource	0	2018-09-12 00:15:54		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	OPENAUTH_MODIFYACCOUNT	\N	\N
ad5bc7a6-e307-4fa8-a4ef-ce9e09f7e21b		RoleModule	0	2016-09-05 09:21:56	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	9486ff22-b696-4d7f-8093-8a3e53c45453	\N	\N
ad905aa6-d3d8-4fe9-99b4-5f8be7891d1e		RoleResource	0	2018-09-12 00:15:54		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	XXX_ADMIN	\N	\N
ae131c5a-084b-4932-9215-cf0f739ee969		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	GoodsType	
ae619801-1959-44fd-a75b-a8cca4d559b4		RoleOrg	0	2018-09-12 00:08:37		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	543a9fcf-4770-4fd9-865f-030e562be238	\N	\N
ae95e6e1-ae92-4c2e-b8d8-c32031f35805		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	79dcd3eb-3aaf-4e08-83c9-713d8ff446fe		
af263192-daa8-4f29-99b9-1efb96e31627		RoleElement	0	2016-09-04 23:20:42	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	645b40ac-4223-44a7-aab4-66eb56cf9864	\N	\N
af47386e-142b-4afc-a42a-1ff138ac377c		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	CreateUserName	
b0174f58-3f6c-431a-8bd8-0caba54fd848		RoleElement	0	2019-11-06 10:31:03		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	054e9699-7828-4b8b-a28b-d7ae45ed3306		
b08d7763-a725-406f-a7d5-d144f00d716e		UserOrg	0	2016-09-02 13:56:41	0	3a95e392-07d4-4af3-b30d-140ca93340f5	543a9fcf-4770-4fd9-865f-030e562be238	\N	\N
b241dd3d-2965-44e4-929d-9dacb6444e09		RoleOrg	0	2018-04-14 13:16:45		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	543a9fcf-4770-4fd9-865f-030e562be238	\N	\N
b246cd89-548c-4471-a43b-6f10b40c26b1		RoleOrg	0	2018-09-12 00:08:42		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
00ae6b5c-21fa-4dc9-8ca4-7df669253255		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	c3d7b478-21e9-4c1e-b866-a3c80be7909b		
01ba383d-fe81-473a-84a1-f64ce8a5aae5		UserOrg	0	2019-10-31 21:50:42		229f3a49-ab27-49ce-b383-9f10ca23a9d5	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b		
026ffa48-8cdf-4452-9ac7-b1b55e58e02a		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	c35d8f5b-0d38-4f31-84f9-39e476eeab08		
032e20b6-7273-49f9-9b84-0040323114c0		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	CreateUserId	
03b55a9e-a44f-44fa-9383-4117bf8aba60		RoleResource	0	2018-09-12 00:15:54		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	XXX_DELETEACCOUNT	\N	\N
03be9b5e-38b0-4525-8431-b26d35ce6ce3		UserElement	0	2016-09-07 15:30:43	0	3a95e392-07d4-4af3-b30d-140ca93340f5	816b12b3-e916-446d-a2fa-329cfd13c831	\N	\N
054a8347-a62c-4e62-b9b2-0b2d14e9ff94		RoleModule	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	7580672f-a390-4bb6-982d-9a4570cb5199		
06dfd97d-17e0-42b8-bde7-40006d8c8eb2		UserElement	0	2018-04-06 14:50:37		49df1602-f5f3-4d52-afb7-3802da619558	584c7a3b-d28a-47b4-8648-7797d05d83d1	\N	\N
06f4c4a2-faa8-4bad-9184-50ceb517f30b		ProcessUser	0	2016-09-08 16:48:14	0	10cc09fb-d469-41e5-ae3f-fdd805a4bd4c	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	\N	\N
077e24ab-4c48-4a5e-bfa9-90ea00449136		RoleOrg	0	2018-09-12 00:08:47		3e761e88-ddf7-4a62-b219-9a315b4564f2	86449128-d5ac-44bf-b999-f7735b7458fd	\N	\N
08ff97f7-17fc-4072-b29a-287135898ece		RoleResource	0	2016-09-04 23:20:22	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	fdf3aac3-4507-40ad-aa2f-d7f0459de252	\N	\N
0b3d3a9b-8a96-43d4-918c-fa7e3ea5f5ca		RoleOrg	0	2018-09-12 00:08:37		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
0fd5b371-b010-4846-8833-95cc1e813a32		UserElement	0	2016-09-07 15:31:16	0	ea25646b-964b-4d41-ab03-d8964e1494fb	68484265-7802-4f06-b024-33e8b2f2edcf	\N	\N
10669494-70e2-4583-b5fd-191d7219b792		RoleDataProperty	0	2019-11-23 00:51:40		d27ae3cf-135f-4d57-93a6-2120ddf98650	Resource	AppId	
109dcd85-9f50-4b7b-8615-c107496986ba		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a		
10a76196-ba0c-4294-bb8f-dcd063eb4aab		UserOrg	0	2017-10-12 09:13:38		3eacdedd-e93a-4816-b49c-99ba3d5323c2	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
10e58d75-dec1-4b85-882f-9dac79ad1210		RoleResource	0	2016-10-21 18:08:13	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	ec99f670-0eca-465c-9f64-d4d5dc510b83	\N	\N
120d7a5d-203c-4261-95f5-0125757fb386		UserElement	0	2016-10-20 17:01:01	0	3a95e392-07d4-4af3-b30d-140ca93340f5	7f071c63-1620-4486-9264-5806b2e63218	\N	\N
12f282b5-e87f-416e-8a7c-f9830d115b9a		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	UpdateUserId	
13433400-a32c-4539-b988-8b417c09bc0e		UserModule	0	2016-09-07 15:30:07	0	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	9486ff22-b696-4d7f-8093-8a3e53c45453	\N	\N
13612a4c-b20c-4bd0-a2cd-0ae47576364d		UserElement	0	2016-10-20 16:34:12	0	3a95e392-07d4-4af3-b30d-140ca93340f5	c7d7daf0-3669-4a22-8bed-b092617deb9c	\N	\N
148e317e-dacf-44b4-b3b8-7f68af74acdd		RoleModule	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	069475e3-c997-487a-9f29-e6a864c5c1d4		
1490edd4-9bd3-4e71-bfa4-56f6558c1d3f		UserElement	0	2018-04-06 09:48:24		6ba79766-faa0-4259-8139-a4a6d35784e0	79dcd3eb-3aaf-4e08-83c9-713d8ff446fe	\N	\N
15705855-3e8d-4404-98f4-59af683f20ce		RoleModule	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	98a949e8-8704-40a7-b9a1-c0e8801e4057		
15e66b55-cdce-47a1-9c08-21d5525524e8		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	0031262c-689c-4b96-bae2-2c9d67076ade		
16154fc4-d18e-44a3-bcf2-5539b168aba7		RoleElement	0	2016-10-24 17:25:15	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	18cc3217-28a6-49b2-9a20-080230065984	\N	\N
1740ff26-a4d0-44cc-9fab-a0105c2c60b6		UserOrg	0	2017-10-12 13:59:49		63c9c82a-e0d3-4bde-bbd2-057cda2f5283	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
18389d29-c82d-4181-8ea0-1440ca1c2093		RoleElement	0	2020-03-19 22:31:02.46		d27ae3cf-135f-4d57-93a6-2120ddf98650	9e2c6754-f258-4b14-96a0-b9d981196a65		
183905f3-620c-4995-aead-1e80c5899517		RoleDataProperty	0	2019-11-23 00:19:30		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	Category	Id	
1873ed85-a88a-4236-bd40-2c416aa2576c		RoleModule	0	2016-09-02 17:03:39	0	211e12c7-e466-496e-8d26-0660a38e24cc	7580672f-a390-4bb6-982d-9a4570cb5199	\N	\N
18aa904d-6625-430d-9475-ec84d8c8e605		RoleModule	0	2020-03-19 22:31:02.443		d27ae3cf-135f-4d57-93a6-2120ddf98650	e8dc5db6-4fc4-4795-a1cc-681cbcceec91		
19c9621c-3d23-46b7-a841-54d5c82ec8e8		UserOrg	0	2016-09-02 13:56:53	0	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
1aaa04f0-bd9f-44a0-8bc2-3f7a74684c42		RoleDataProperty	0	2019-11-23 00:19:30		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	Category	DtCode	
1acec4c4-0136-4e2b-a839-8676dbd6594a		ProcessUser	0	2016-09-14 11:38:23	0	6c6afe3c-349c-4198-8710-cf19c90f3afd	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	\N	\N
1ced1564-2fea-4c04-8aea-f071fa5bb293		UserModule	0	2016-09-05 16:24:55	0	ea25646b-964b-4d41-ab03-d8964e1494fb	069475e3-c997-487a-9f29-e6a864c5c1d4	\N	\N
1cf19b35-e2c2-436f-99b9-03ac2b232cc6		RoleElement	0	2016-09-04 23:21:04	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	44075557-496e-4dde-bb75-7b69f51ab4fe	\N	\N
1dca9a35-06e8-4275-8902-13c619880357		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	ScheduledInboundTime	
1e84dafd-3f4d-4b13-a738-2cf0c98e2351		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	AppId	
1fb6b802-2a1f-49a8-b2fa-c5d223a8538c		RoleDataProperty	0	2019-11-23 00:51:40		d27ae3cf-135f-4d57-93a6-2120ddf98650	Resource	UpdateTime	
2014027e-0cff-41cf-974b-56126d6eaa9a		RoleElement	0	2016-09-05 09:22:11	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2	\N	\N
224fa0b0-cdd6-47cf-89c5-45ad2a64bfd5		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	OrderType	
23339fa0-94f4-4d35-a775-bda84d152841		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	069475e3-c997-487a-9f29-e6a864c5c1d4		
242e9543-3343-41d4-8816-15ffeeaef551		UserElement	0	2016-09-07 15:31:16	0	ea25646b-964b-4d41-ab03-d8964e1494fb	584c7a3b-d28a-47b4-8648-7797d05d83d1	\N	\N
24dbc2ce-8474-463f-871b-96cb5edb9800		RoleElement	0	2020-04-25 11:49:36.49		d27ae3cf-135f-4d57-93a6-2120ddf98650	4770af29-1375-4d27-ab0c-fdbeab87b710		
27c4d50c-32da-4dbc-88a1-84b343cdd649		UserElement	0	2016-10-20 17:01:00	0	3a95e392-07d4-4af3-b30d-140ca93340f5	6839a297-350b-4215-b680-4e5dfdae5615	\N	\N
29b06cd6-af0c-4c63-9aba-e5431c5d62ec		UserOrg	0	2017-10-12 09:13:38		3eacdedd-e93a-4816-b49c-99ba3d5323c2	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
b2490ac0-ba16-48a2-b39d-49f6b87f9387		UserModule	0	2018-04-06 09:48:17		6ba79766-faa0-4259-8139-a4a6d35784e0	069475e3-c997-487a-9f29-e6a864c5c1d4	\N	\N
b2edfee4-f980-4aa5-b547-492d677e0674		RoleModule	0	2016-09-04 23:20:34	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c	\N	\N
b2f1a511-26ac-4b5b-bc3a-b7fc52297b41		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	UpdateUserName	
b3245529-7cad-4130-bd2d-ac1129deb2f0		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	UpdateTime	
b3b8f695-a179-489b-90b4-7814ab048a69		UserElement	0	2018-04-06 09:48:21		6ba79766-faa0-4259-8139-a4a6d35784e0	816b12b3-e916-446d-a2fa-329cfd13c831	\N	\N
b3cb3391-4ff4-4071-910e-18c46362ab5d		RoleElement	0	2020-03-19 22:31:02.46		d27ae3cf-135f-4d57-93a6-2120ddf98650	18cc3217-28a6-49b2-9a20-080230065984		
b4c2a294-125c-4768-9214-cea3ccf39a1c		RoleOrg	0	2018-09-12 00:08:42		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	543a9fcf-4770-4fd9-865f-030e562be238	\N	\N
b51345b9-325c-4a30-b147-5562c93c3ed3		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	816b12b3-e916-446d-a2fa-329cfd13c831		
b55798b2-6768-4051-8cdc-9da72c73718d		RoleDataProperty	0	2019-11-23 00:51:40		d27ae3cf-135f-4d57-93a6-2120ddf98650	Resource	Name	
b5c0e181-5f32-4a92-846c-24ff6253b6df		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	054e9699-7828-4b8b-a28b-d7ae45ed3306		
b647148b-21be-42b8-8811-1cb03a6fc349		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	ExternalType	
b6712915-5fc8-4271-b651-6b467ec1d8a8		RoleModule	0	2020-03-19 22:31:02.443		d27ae3cf-135f-4d57-93a6-2120ddf98650	0031262c-689c-4b96-bae2-2c9d67076ade		
b672a830-c3a5-408b-a746-65608534b24c		UserModule	0	2017-12-15 17:07:05		49df1602-f5f3-4d52-afb7-3802da619558	9486ff22-b696-4d7f-8093-8a3e53c45453	\N	\N
b918e504-ba39-4be7-8452-76cef09191d3		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	826b12b3-e916-446d-a2fa-329cfd13c831		
b9e63d17-35c8-4456-abab-8f43a1c99adc		UserModule	0	2018-04-06 09:47:59		49df1602-f5f3-4d52-afb7-3802da619558	4abafc83-c8f5-452f-9882-e113a86e7a3e	\N	\N
ba5f4663-04e1-4b09-8e84-459507df2aeb		UserOrg	0	2019-10-31 21:50:51		1df68dfd-3b6d-4491-872f-00a0fc6c5a64	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b		
bbca349a-5d29-4cce-9f7e-0d5d4ce65a54		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	OwnerId	
bbdc3ea9-3f21-48b0-9d7a-39545d6183d0		UserElement	0	2018-04-06 09:48:25		6ba79766-faa0-4259-8139-a4a6d35784e0	826b12b3-e916-446d-a2fa-329cfd13c831	\N	\N
bc39df48-cbcf-4757-af8c-b023ad195721		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	816b12b3-e916-446d-a2fa-329cfd13c831		
bc63b763-cdb8-4516-a3c4-fabe74d7dc56		RoleDataProperty	0	2019-11-23 00:19:30		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	Category	DtValue	
bd783f53-23fa-41f4-8cec-7c61fab52072		UserOrg	0	2018-03-15 09:19:06		0ceff0f8-f848-440c-bc26-d8605ac858cd	86449128-d5ac-44bf-b999-f7735b7458fd	\N	\N
bd82fa18-2500-4e6b-920d-dc235b57f788		RoleModule	0	2020-04-25 11:48:19.553		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	5c55f7eb-4552-4610-a584-d72685f8d064		
bda5f089-64d6-4fb8-9012-d7f3ff36902a		UserOrg	0	2017-10-12 13:59:09		ffd92ed2-5330-4ec2-a42d-6e0e9005db3b	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
be17df2b-a4bb-4080-9d3f-465875a0bd52		RoleModule	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	9486ff22-b696-4d7f-8093-8a3e53c45453		
bee6572d-8fb8-4e0e-af15-93aafc989717		RoleElement	0	2016-09-04 23:20:42	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	68fc793f-069f-43e1-a012-42ac2d7c585c	\N	\N
bef744ab-2323-4552-9a09-f529911f8c59		UserOrg	0	2019-10-31 21:58:43		96f63f9d-e8c8-4258-963e-3327ed7d6f56	60620558-89a2-4b28-8637-52f514773725		
bfe7d15c-9b35-4735-b9a6-38ee8869b5ec		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	CreateUserId	
c14addeb-1812-4a78-9152-1f7115b22d89		UserRole	0	2016-09-05 00:00:47	0	3a95e392-07d4-4af3-b30d-140ca93340f5	db309d88-fd21-4b81-a4d9-ae6276a1d813	\N	\N
c16e961d-e3b9-4b89-8cd4-de6fd23e4709		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	Status	
c25f0741-47bc-48a5-801c-902de87b7ab6		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	CreateUserName	
c2d3b7d6-b47d-4bd8-9dc6-d9134d86713f		RoleOrg	0	2016-10-17 10:03:30	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	86449128-d5ac-44bf-b999-f7735b7458fd	\N	\N
c3050d65-d26b-4e46-bece-a212b0cc00ec		RoleElement	0	2016-09-04 23:20:42	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	15a4f88c-4fae-4cab-ba2f-0cbd2cca8736	\N	\N
c3227c77-d60e-4157-9dd3-a8bcdb3af52b		RoleModule	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	e8dc5db6-4fc4-4795-a1cc-681cbcceec91		
c4771ac5-3375-4de9-adb8-a603398f0d62		RoleElement	0	2016-09-04 23:21:09	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	2d595a2a-5de5-479e-a331-b53c799a6b10	\N	\N
c50fae2a-b36f-486f-9d53-e58406590101		ProcessUser	0	2016-10-27 16:47:52	0	054ff054-d8ae-4911-a596-8fb1f66b348f	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	\N	\N
c58cb482-6ab7-49eb-b5b0-e45424b6e502		RoleElement	0	2016-09-04 23:21:00	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	34730f5a-d307-457b-9041-5f7de30abfa9	\N	\N
c733cfbe-2f71-41e4-92a6-4ff97cf88dc4		UserModule	0	2018-04-06 09:48:19		6ba79766-faa0-4259-8139-a4a6d35784e0	4abafc83-c8f5-452f-9882-e113a86e7a3e	\N	\N
c9099371-8d4e-4f5b-9686-2c60a2c1c641		ProcessUser	0	2016-09-08 16:48:14	0	10cc09fb-d469-41e5-ae3f-fdd805a4bd4c	3a95e392-07d4-4af3-b30d-140ca93340f5	\N	\N
c98b3d02-a76b-4ecc-94a5-cfeffd5e29fb		RoleModule	0	2016-09-02 17:03:39	0	211e12c7-e466-496e-8d26-0660a38e24cc	bedb41a2-f310-4775-af99-01be08adda93	\N	\N
cd500e9c-7599-42d5-94d8-0234369efd41		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	37bb9414-19a0-4223-9056-71f8c758a930		
ce7a6891-361e-44a0-b543-e2a7d8ca0fc0		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	GoodsType	
d060436e-4eac-4109-a4f2-9e5ffb3f843e		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	PurchaseNo	
d1f194c3-3b20-41ee-805b-77c94ee40785		UserOrg	0	2020-03-19 21:20:04.11		49df1602-f5f3-4d52-afb7-3802da619558	543a9fcf-4770-4fd9-865f-030e562be238		
d65f9601-b07e-4c89-8c35-ddc6c3edf3b1		UserRole	0	2019-11-23 00:48:02		1df68dfd-3b6d-4491-872f-00a0fc6c5a64	d27ae3cf-135f-4d57-93a6-2120ddf98650		
d72b9de9-998b-432c-9ccf-d961d386d778		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	b19bce90-5508-43b6-93ed-cd9ff9e356a9		
d892294d-2a2f-410e-bae9-86be3f6e3674		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	StockId	
d967ed9b-a083-4398-954b-ea73edcefa32		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	ExternalNo	
da6c0645-0bf9-4ade-9dd3-1b09e91e504c		RoleElement	0	2016-09-05 09:22:07	0	4980a85b-e3db-4607-bc2c-0baf0140d7df	816b12b3-e916-446d-a2fa-329cfd13c831	\N	\N
db621de5-12e0-4ff1-9532-4cd7a696cf65		RoleElement	0	2020-04-25 11:50:18.433		d27ae3cf-135f-4d57-93a6-2120ddf98650	a6b61073-9e76-40ef-88ad-15c8789e2033		
dbdd5bf2-5910-4644-b087-2f50711840df		UserRole	0	2019-11-23 00:48:35		49df1602-f5f3-4d52-afb7-3802da619558	09ee2ffa-7463-4938-ae0b-1cb4e80c7c13		
dc7dd8ef-c8e6-414f-8e97-31774718654c		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	Id	
de4205b7-4832-40d4-b6ae-956f7b4997ba		RoleModule	0	2020-03-19 22:31:02.443		d27ae3cf-135f-4d57-93a6-2120ddf98650	7580672f-a390-4bb6-982d-9a4570cb5199		
df2d90b3-4e2e-40e9-b406-220009726460		RoleModule	0	2016-09-04 23:20:34	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	6a9e1346-0c01-44d2-8eb1-f929fdab542a	\N	\N
dfd5430b-3422-465a-be79-05a1e06deed2		RoleElement	0	2016-09-04 23:20:54	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	c7d7daf0-3669-4a22-8bed-b092617deb9c	\N	\N
e12b77de-b7ce-4f38-b7a3-f3b2d285f33b		RoleOrg	0	2016-10-17 10:03:49	0	2eb423d6-6ad9-4efe-b423-872478a2a434	08f41bf6-4388-4b1e-bd3e-2ff538b44b1b	\N	\N
e28c0dcd-168a-4b60-a514-7b6eb8026709		RoleOrg	0	2016-10-17 10:03:30	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
e4ccd68d-b31b-4d2d-b591-665818a7bd9f		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Category	Id	
e50d78ae-004d-4f89-95a2-bd5c6327d16c		RoleModule	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	0031262c-689c-4b96-bae2-2c9d67076ade		
e5aa43b8-86df-43be-b5f1-9edd13dc07f8		RoleElement	0	2020-04-25 11:49:36.487		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	4770af29-1375-4d27-ab0c-fdbeab87b710		
e619a82e-edfb-4542-94df-0b92850667ad		RoleResource	0	2018-04-14 14:39:56		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	OPENAUTH_MODIFYACCOUNT	\N	\N
e6bd480f-592a-46e0-9f83-2adefb12dca0		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	8966b04f-8e26-4046-8b03-0c64f9f833dd		
e785147c-f46b-474f-8fad-73b14fa69822		UserRole	0	2016-09-06 17:06:29	0	3a95e392-07d4-4af3-b30d-140ca93340f5	4980a85b-e3db-4607-bc2c-0baf0140d7df	\N	\N
e84f6b9c-716d-4e94-a1aa-7fd0d1a2e23e		RoleModule	0	2016-09-02 17:03:47	0	648b04c4-4ac2-4d69-bef6-07081ef27871	069475e3-c997-487a-9f29-e6a864c5c1d4	\N	\N
e9cf3d63-6305-46c7-93b4-14053387c62c		UserModule	0	2018-04-06 09:48:18		6ba79766-faa0-4259-8139-a4a6d35784e0	37bb9414-19a0-4223-9056-71f8c758a930	\N	\N
ec72f6ae-09ee-4db9-99a1-bf15c8e35dda		ProcessUser	0	2016-09-14 11:38:23	0	6c6afe3c-349c-4198-8710-cf19c90f3afd	3a95e392-07d4-4af3-b30d-140ca93340f5	\N	\N
ec9c80ce-dbdf-4ba5-9091-82f75392c3b0		UserElement	0	2016-09-07 15:30:43	0	3a95e392-07d4-4af3-b30d-140ca93340f5	68484265-7802-4f06-b024-33e8b2f2edcf	\N	\N
ee1986a0-24cc-4dec-b5f5-68ef959ab650		UserElement	0	2018-04-06 14:50:40		49df1602-f5f3-4d52-afb7-3802da619558	79dcd3eb-3aaf-4e08-83c9-713d8ff446fe	\N	\N
ee4f39fd-4fbf-4f68-9a70-d6c7d7db9723		ProcessUser	0	2016-10-31 11:52:39	0	b8bcdf59-1e29-4d97-a364-12ac8e8c5c61	3a95e392-07d4-4af3-b30d-140ca93340f5	\N	\N
eec41fcb-61c0-4e56-a5c0-a9f8be6e6fdc		UserModule	0	2016-09-07 15:30:06	0	3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7	069475e3-c997-487a-9f29-e6a864c5c1d4	\N	\N
ef43a7a6-4a4c-46fe-82d4-1e1055fdac6d		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	17ae4fd4-ab4e-439e-ba1d-2a53b46d112b		
ef8024e8-dab3-4b85-9952-821a005c1f2b		RoleDataProperty	0	2019-11-23 00:51:40		d27ae3cf-135f-4d57-93a6-2120ddf98650	Resource	CascadeId	
f012d886-f204-4599-a00d-7b9847cc0bb7		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	92b00259-2d15-43e7-9321-adffb29e8bf2		
f125441c-f28c-4ffa-9183-c8168ab09afb		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Category	TypeId	
f163873c-2b44-4279-8b2c-498bcd01f05b		RoleElement	0	2020-04-25 11:49:36.49		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	4770af29-1375-4d27-ab0c-fdbeab87b710		
f25d98ff-46bc-48e7-86a0-5eca5e6d98c2		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	UpdateUserName	
f3671c95-a33f-4a11-89dd-00d734d4a230		RoleModule	0	2020-03-19 00:16:54.723		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	15a3a401-e8eb-4d8b-9035-ecd5f53ed0c9		
f4ba636a-9002-43e6-93eb-95132a3e68c5		ProcessUser	0	2016-09-28 09:23:30	0	68295d2a-4dfd-4c5e-81e3-9c787e2603bc	3a95e392-07d4-4af3-b30d-140ca93340f5	\N	\N
f579a427-a9ed-4ebe-8411-72e8e6abd01d		UserElement	0	2016-09-05 16:25:26	0	ea25646b-964b-4d41-ab03-d8964e1494fb	816b12b3-e916-446d-a2fa-329cfd13c831	\N	\N
f61ee29b-7988-404d-b692-5a8f667684be		UserElement	0	2018-04-06 09:48:23		6ba79766-faa0-4259-8139-a4a6d35784e0	68484265-7802-4f06-b024-33e8b2f2edcf	\N	\N
f6367ca1-0486-46a4-b9c6-65c00936a516		RoleElement	0	2016-09-04 23:20:54	0	db309d88-fd21-4b81-a4d9-ae6276a1d813	9e2c6754-f258-4b14-96a0-b9d981196a65	\N	\N
f671f582-9111-4000-aadd-660449d0d4b0		RoleResource	0	2018-09-12 00:15:54		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	XXX_LOGIN	\N	\N
f714b860-447e-4d22-a206-1b545cc98fbb		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	InBondedArea	
f8d157b4-12e3-4488-9e4c-b9670e11b4c6		RoleDataProperty	0	2019-11-23 01:05:44		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	WmsInboundOrderTbl	UpdateUserName	
f8e65a18-a86a-47b1-be87-c437ba5e5fd9		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	Id	
fa52d20f-204d-4cdd-a1e5-5b7faaac4cd7		RoleDataProperty	0	2019-11-23 00:51:40		d27ae3cf-135f-4d57-93a6-2120ddf98650	Resource	CreateUserName	
fa7c4d39-b31a-4668-8716-d40a62aa722b		UserOrg	0	2017-10-12 13:59:49		63c9c82a-e0d3-4bde-bbd2-057cda2f5283	990cb229-cc18-41f3-8e2b-13f0f0110798	\N	\N
fa955d08-fe15-42d2-ae39-98e22e4f9b50		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	WmsInboundOrderTbl	OrderType	
fa9ce486-4b1f-4630-bad3-7625744cb8e8		RoleDataProperty	0	2020-03-19 00:17:01.923		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	Resource	CascadeId	
faf837f2-8ac3-4269-8a1c-b2af432bf7b5		RoleElement	0	2020-03-19 21:23:18.73		0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	a7eea5dc-3b10-4550-9cf3-0dba9b9fc32c		
fafcaba7-57fe-44dd-9343-6112db385dce		RoleElement	0	2020-04-25 11:49:11.133		77e6d0c3-f9e1-4933-92c3-c1c6eef75593	5fba6316-5599-4245-822c-48ff33299868		
fdc16578-e4eb-474d-8cc8-4188693a7c12		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	6c814946-db5c-48bd-84dd-b1c38196ad74		
feec44e3-3f88-4ac2-a4ad-a5bd3161f1bb		UserOrg	0	2019-10-31 21:59:08		758a34c7-5a31-438c-bdf7-02fdd846b901	66386671-0494-4e83-8346-fbcf73283f7b		
fef68b50-ef7f-45a4-8f0e-38e8d8ecaaea		RoleElement	0	2020-03-19 00:16:54.797		09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	68484265-7802-4f06-b024-33e8b2f2edcf		
\.


--
-- Data for Name: Resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Resource" ("Id", "CascadeId", "Name", "SortNo", "Description", "ParentName", "ParentId", "AppId", "AppName", "TypeName", "TypeId", "Disable", "CreateTime", "CreateUserId", "CreateUserName", "UpdateTime", "UpdateUserId", "UpdateUserName") FROM stdin;
SYS_DEL_USER	.0.2.	é?3yó?	0	óμóDé?3yOpenAuth.Net?μí3ó??§D?	?ù?ú	\N	110	OpenAuth.Net	\N	\N	f	2019-11-23 00:27:58	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 00:27:58		
SYS_UPDATE_USER	.0.1.	?üD?ó??§D	0	óμóD?üD?OpenAuth.Net?μí3ó??§D?	?ù?ú	\N	110	OpenAuth.Net	\N	\N	f	2019-11-23 00:27:17	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 00:27:12		
SYS_VIEW_USER	.0.3.	2é?′ó??§	0	2é?′OpenAuth.Netó??§	?ù?ú	\N	110	OpenAuth.Net	\N	\N	f	2019-11-23 00:44:39	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 00:44:39		
XXX_ADDORDER	.0.6.	′′?¨?	0	?úXXX??ì¨′′?	?ù?ú	\N	119	XXX1üàí?	\N	\N	f	2019-11-23 00:53:24	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 00:53:24		
XXX_DEL_LOG	.0.4.	é?3yXXX??ì¨?	0	é?3yXXX??ì¨?	?ù?ú	\N	119	XXX1üàí?	\N	\N	f	2019-11-23 00:45:02	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 00:45:02		
XXX_LOGIN	.0.7.	μ??	0	μ???XXX???	?ù?ú	\N	119	XXX1üàí?	\N	\N	f	2019-11-23 00:55:20	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 00:55:20		
XXX_VIEW_USER	.0.5.	2é?′ó	0	2é?′XXX??ì¨ó??	?ù?ú	\N	119	XXX1üàí?	\N	\N	f	2019-11-23 00:53:01	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 00:53:01		
\.


--
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Role" ("Id", "Name", "Status", "CreateTime", "CreateId", "TypeName", "TypeId") FROM stdin;
09ee2ffa-7463-4938-ae0b-1cb4e80c7c13	1üà?	0	2018-04-09 22:48:24			
0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d	2aê	0	2018-04-09 22:48:29			
77e6d0c3-f9e1-4933-92c3-c1c6eef75593	é	0	2018-04-14 13:16:45			
d27ae3cf-135f-4d57-93a6-2120ddf98650	2aê??t?	0	2019-11-23 00:46:31			
\.


--
-- Data for Name: Stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Stock" ("Id", "Name", "Number", "Price", "Status", "Viewable", "User", "Time", "OrgId") FROM stdin;
\.


--
-- Data for Name: SysLog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SysLog" ("Id", "Content", "TypeName", "TypeId", "Href", "CreateTime", "CreateId", "CreateName", "Ip", "Result", "Application") FROM stdin;
1c6185a2-b36f-4392-b209-1b0f728d8a43	用户访问	访问日志		forms/index	2023-02-10 16:09:49.073293	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
abef6df4-a078-4b4b-a67c-459275a798c7	用户访问	访问日志		resources/index	2023-02-10 16:09:51.86679	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
d3eb22cc-7be5-4fa7-b88f-ff89ccbf6389	用户访问	访问日志		flowschemes/index	2023-02-10 16:09:56.124803	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
b492be59-6a28-41c8-bdb6-37987d941d56	用户访问	访问日志		rolemanager/index	2023-02-10 16:09:57.117345	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
17c70504-3ab2-4ee5-8ca3-ed023faf986e	用户访问	访问日志		dataprivilegerules/index	2023-02-10 16:10:03.5501	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
ee0a273e-1555-42eb-966f-4d1982ff812e	用户访问	访问日志		categories/index	2023-02-10 16:10:04.656383	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
662688be-fd5b-4612-bda7-dc6e9ae84d71	用户访问	访问日志		modulemanager/index	2023-02-10 16:10:06.386048	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
b1a0469c-56ac-4aba-b87d-14c3ff694238	用户访问	访问日志		usermanager/index	2023-02-10 16:10:36.135723	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
8407605b-6dcb-44ae-8b6b-bed8af76534e	用户访问	访问日志		flowinstances/index	2023-02-10 16:10:42.10442	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
08dc939e-97d2-4396-a6c3-d34486cea401	用户访问	访问日志		flowinstances/wait	2023-02-10 16:10:44.228473	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
857415a7-98f7-4431-9210-3212e397b25f	用户访问	访问日志		flowinstances/disposed	2023-02-10 16:10:45.29009	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
3b26611e-c6a4-4b97-9bd9-de31250039ff	用户访问	访问日志		syslogs/index	2023-02-10 16:10:48.307255	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
fcfe3772-da45-427f-bed9-53c29fa00243	用户访问	访问日志		sysmessages/index	2023-02-10 16:10:59.54687	00000000-0000-0000-0000-000000000000	System		0	OpenAuth.Mvc
\.


--
-- Data for Name: SysMessage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SysMessage" ("Id", "TypeName", "TypeId", "FromId", "ToId", "FromName", "ToName", "FromStatus", "ToStatus", "Href", "Title", "Content", "CreateTime", "CreateId") FROM stdin;
\.


--
-- Data for Name: UploadFile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UploadFile" ("Id", "FileName", "FilePath", "Description", "FileType", "FileSize", "Extension", "Enable", "SortCode", "DeleteMark", "CreateUserId", "CreateUserName", "CreateTime", "Thumbnail", "BelongApp", "BelongAppId") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("Id", "Account", "Password", "Name", "Sex", "Status", "BizCode", "CreateTime", "CreateId", "TypeName", "TypeId") FROM stdin;
0ceff0f8-f848-440c-bc26-d8605ac858cd	test5	test5	test5	1	1		2018-03-15 09:19:05			
1df68dfd-3b6d-4491-872f-00a0fc6c5a64	test4	test4	test4	1	1		2017-12-12 14:07:11			
229f3a49-ab27-49ce-b383-9f10ca23a9d5	test3	test3	test3	1	1		2017-12-12 14:07:05			
49df1602-f5f3-4d52-afb7-3802da619558	admin	admin	admin	0	0		2017-12-11 16:18:54			
6ba79766-faa0-4259-8139-a4a6d35784e0	test	test	test	1	0		2017-12-11 16:19:00			
758a34c7-5a31-438c-bdf7-02fdd846b901	test77	test77	test77	0	0		2019-10-31 21:59:08	00000000-0000-0000-0000-000000000000		
96f63f9d-e8c8-4258-963e-3327ed7d6f56	test66	test66	test66	0	0		2019-10-31 21:58:43	00000000-0000-0000-0000-000000000000		
de8be521-f1ec-4483-b124-0be342890507	test2	test2	test2	1	0		2017-12-11 16:19:06			
\.


--
-- Data for Name: WmsInboundOrderDtbl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."WmsInboundOrderDtbl" ("Id", "OrderId", "Price", "PriceNoTax", "InStockStatus", "AsnStatus", "GoodsId", "GoodsBatch", "QualityFlg", "OrderNum", "InNum", "LeaveNum", "HoldNum", "ProdDate", "ExpireDate", "TaxRate", "OwnerId", "Remark", "CreateTime", "CreateUserId", "CreateUserName", "UpdateTime", "UpdateUserId", "UpdateUserName") FROM stdin;
09a939ad-7e40-42f2-b0b3-fa9b74f94897	20190035RK0001	77	73.21	f	0		10045		32	0	0	0			0			2019-11-06 10:37:38	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:59	00000000-0000-0000-0000-000000000000	3???1üà?
1e547556-9549-44d5-9da3-c07d98b5943e	2019102203RK0003	10	6	f	0				0	0	0	0			0			2019-11-07 01:00:35	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:00	00000000-0000-0000-0000-000000000000	3???1üà?
2ae93007-1490-4e81-b410-957fc08e2371	2019102203RK0001	25	22.5	f	0		100011		0	0	0	0			0			2019-11-06 10:32:10	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:28:47	00000000-0000-0000-0000-000000000000	3???1üà?
30eb475b-ed86-4106-88f0-47a5a32ec8aa	TEST_002	10	10	f	1		CJ-334		10	8	2	0	2019-11-22		0			2019-11-23 01:26:54	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 01:26:54		
56b5612c-e048-4650-9710-4b235731d548	20190035RK0001	62	60.23	f	0		133521		10	0	0	0			0			2019-11-06 10:37:38	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:59	00000000-0000-0000-0000-000000000000	3???1üà?
5e7d6ef8-351a-4600-849e-3958588161a7	20190035RK0001	55	54.23	f	0		FK85122		14	0	0	0			0			2019-11-06 10:37:38	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:59	00000000-0000-0000-0000-000000000000	3???1üà?
78c0a896-8341-47d4-b6d2-f241cec9fb58	TEST_001	998.5	985	f	1		CJ-P-4446		500	500	0	0	2019-11-22	2020-11-12	6			2019-11-23 01:27:49	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 01:29:38	00000000-0000-0000-0000-000000000000	3???1üà?
95d6d2a8-0e17-426b-97f3-3c8a82bca313	20190035RK0001	15	13.22	f	0		10052		52	0	0	0			0			2019-11-06 10:37:38	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:59	00000000-0000-0000-0000-000000000000	3???1üà?
b195386a-4f09-4e31-9d72-8e94526f9419	2019102203RK0133	200	199	f	0				0	0	0	0			0			2019-11-07 01:24:11	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-07 01:24:11		
ca470c60-9231-4c13-b51b-ad90c39633ae	2019102203RK0187	22.22	20	f	0				0	0	0	0			0			2019-11-07 01:03:27	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:48	00000000-0000-0000-0000-000000000000	3???1üà?
d19df810-5c47-4a32-a3a5-c908da60bf8b	TEST_002	6.67	6	f	1		CJ-335		54	54	0	0			0			2019-11-23 01:26:54	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 01:26:54		
dc0f9da2-0e0e-4dc3-9e59-2b0d51e53211	2019102203RK0001	10	8	f	1		100010		0	0	0	0			0			2019-11-06 10:32:10	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:28:47	00000000-0000-0000-0000-000000000000	3???1üà?
fcf051d3-5c00-4617-895f-e45891d975df	2019102203RK0002	22.52	18.99	f	1		100020		10	0	0	0			0			2019-11-06 10:32:45	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:28:53	00000000-0000-0000-0000-000000000000	3???1üà?
\.


--
-- Data for Name: WmsInboundOrderTbl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."WmsInboundOrderTbl" ("Id", "ExternalNo", "ExternalType", "Status", "OrderType", "GoodsType", "PurchaseNo", "StockId", "OwnerId", "ShipperId", "SupplierId", "ScheduledInboundTime", "Remark", "Enable", "TransferType", "InBondedArea", "ReturnBoxNum", "CreateTime", "CreateUserId", "CreateUserName", "UpdateTime", "UpdateUserId", "UpdateUserName", "OrgId") FROM stdin;
20190035RK0001	20190035RK0001		1	SYS_INBOUNDTYPE_SAMPLE	2?o???	20190035RK0001					2019-11-20 00:00:00		t	SYS_SHIPTYPE_FREIGHT	t	0	2019-11-06 10:33:17	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:59	00000000-0000-0000-0000-000000000000	3???1üà?	\N
20190035RK0002	20190035RK0002		0	?ù?·è	ì?êaò	20190035RK0002					2019-11-14 00:00:00		t	SYS_SHIPTYPE_FREIGHT	t	0	2019-11-06 10:34:58	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:30:07	00000000-0000-0000-0000-000000000000	3???1üà?	\N
2019102203RK0001	2019102203RK0001	1	1	??í¨è	??í¨é	2019102203RK0001	BJ003	CDC001	SF	SF	2019-10-10 00:00:00		t	SYS_SHIPTYPE_FREIGHT	f	1	2019-10-31 21:27:14	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:28:47	00000000-0000-0000-0000-000000000000	3???1üà?	\N
2019102203RK0002	2019102203RK0002	1	1	??í¨è	??í¨é	2019102203RK0002	BJ003	CDC001	SF	SF	2019-10-10 00:00:00		t	SYS_SHIPTYPE_NORMAL	t	20	2019-10-31 21:27:14	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:28:53	00000000-0000-0000-0000-000000000000	3???1üà?	\N
2019102203RK0003	2019102203RK0003	1	1	SYS_INBOUNDTYPE_RETURN	??í¨é	2019102203RK0003	BJ003	CDC001	SF	SF	2019-10-10 00:00:00		t	SYS_SHIPTYPE_EMS	f	1	2019-10-31 21:27:14	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:00	00000000-0000-0000-0000-000000000000	3???1üà?	\N
2019102203RK0133	2019102203RK0133		0	SYS_INBOUNDTYPE_SAMPLE	SYS_GOODSTYPE_COMMON	2019102203RK0133			001		2019-11-26 00:00:00		t	SYS_SHIPTYPE_EMS	t	0	2019-11-07 01:24:11	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-07 01:24:11			\N
2019102203RK0187	2019102203RK0187		1	SYS_INBOUNDTYPE_PURCHASE	SYS_GOODSTYPE_MEDINSTR	2019102203RK0187					\N		t	SYS_SHIPTYPE_NORMAL	t	0	2019-11-07 01:03:27	00000000-0000-0000-0000-000000000000	3???1üà?	2019-11-23 01:29:48	00000000-0000-0000-0000-000000000000	3???1üà?	\N
TEST_001	TEST_001	\N	0	SYS_INBOUNDTYPE_PURCHASE	SYS_GOODSTYPE_BIOLPROD	TEST_001	001	BJ02	\N	\N	\N	\N	f	SYS_SHIPTYPE_NORMAL	f	0	2019-11-23 01:25:08	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 01:29:38	00000000-0000-0000-0000-000000000000	3???1üà?	\N
TEST_002	TEST_002		0	SYS_INBOUNDTYPE_PURCHASE	SYS_GOODSTYPE_COMMON	TEST_002	002				2019-11-12 00:00:00		f	SYS_SHIPTYPE_EMS	t	0	2019-11-23 01:26:54	6ba79766-faa0-4259-8139-a4a6d35784e0	test	2019-11-23 01:26:54			\N
\.


--
-- Name: Application Application_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Application"
    ADD CONSTRAINT "Application_pkey" PRIMARY KEY ("Id");


--
-- Name: BuilderTableColumn BuilderTableColumn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BuilderTableColumn"
    ADD CONSTRAINT "BuilderTableColumn_pkey" PRIMARY KEY ("Id");


--
-- Name: BuilderTable BuilderTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BuilderTable"
    ADD CONSTRAINT "BuilderTable_pkey" PRIMARY KEY ("Id");


--
-- Name: CategoryType CategoryType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CategoryType"
    ADD CONSTRAINT "CategoryType_pkey" PRIMARY KEY ("Id");


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY ("Id");


--
-- Name: DataPrivilegeRule DataPrivilegeRule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DataPrivilegeRule"
    ADD CONSTRAINT "DataPrivilegeRule_pkey" PRIMARY KEY ("Id");


--
-- Name: FlowInstanceOperationHistory FlowInstanceOperationHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlowInstanceOperationHistory"
    ADD CONSTRAINT "FlowInstanceOperationHistory_pkey" PRIMARY KEY ("Id");


--
-- Name: FlowInstanceTransitionHistory FlowInstanceTransitionHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlowInstanceTransitionHistory"
    ADD CONSTRAINT "FlowInstanceTransitionHistory_pkey" PRIMARY KEY ("Id");


--
-- Name: FlowInstance FlowInstance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlowInstance"
    ADD CONSTRAINT "FlowInstance_pkey" PRIMARY KEY ("Id");


--
-- Name: FlowScheme FlowScheme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlowScheme"
    ADD CONSTRAINT "FlowScheme_pkey" PRIMARY KEY ("Id");


--
-- Name: Form Form_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Form"
    ADD CONSTRAINT "Form_pkey" PRIMARY KEY ("Id");


--
-- Name: FrmLeaveReq FrmLeaveReq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FrmLeaveReq"
    ADD CONSTRAINT "FrmLeaveReq_pkey" PRIMARY KEY ("Id");


--
-- Name: ModuleElement ModuleElement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ModuleElement"
    ADD CONSTRAINT "ModuleElement_pkey" PRIMARY KEY ("Id");


--
-- Name: Module Module_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Module"
    ADD CONSTRAINT "Module_pkey" PRIMARY KEY ("Id");


--
-- Name: OpenJob OpenJob_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenJob"
    ADD CONSTRAINT "OpenJob_pkey" PRIMARY KEY ("Id");


--
-- Name: Org Org_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Org"
    ADD CONSTRAINT "Org_pkey" PRIMARY KEY ("Id");


--
-- Name: Relevance Relevance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relevance"
    ADD CONSTRAINT "Relevance_pkey" PRIMARY KEY ("Id");


--
-- Name: Resource Resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Resource"
    ADD CONSTRAINT "Resource_pkey" PRIMARY KEY ("Id");


--
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY ("Id");


--
-- Name: Stock Stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stock"
    ADD CONSTRAINT "Stock_pkey" PRIMARY KEY ("Id");


--
-- Name: SysLog SysLog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SysLog"
    ADD CONSTRAINT "SysLog_pkey" PRIMARY KEY ("Id");


--
-- Name: SysMessage SysMessage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SysMessage"
    ADD CONSTRAINT "SysMessage_pkey" PRIMARY KEY ("Id");


--
-- Name: UploadFile UploadFile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UploadFile"
    ADD CONSTRAINT "UploadFile_pkey" PRIMARY KEY ("Id");


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("Id");


--
-- Name: WmsInboundOrderDtbl WmsInboundOrderDtbl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WmsInboundOrderDtbl"
    ADD CONSTRAINT "WmsInboundOrderDtbl_pkey" PRIMARY KEY ("Id", "OrderId");


--
-- Name: WmsInboundOrderTbl WmsInboundOrderTbl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WmsInboundOrderTbl"
    ADD CONSTRAINT "WmsInboundOrderTbl_pkey" PRIMARY KEY ("Id");


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

