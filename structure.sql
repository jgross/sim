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

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


--
-- Name: page_types; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.page_types AS ENUM (
    'blog',
    'case study',
    'forum',
    'social',
    'helpdesk',
    'career',
    'website',
    'product',
    'twitter_mention',
    'promotion',
    'commercial',
    'event',
    'pr',
    '["login", "login"]',
    '["legal", "legal"]',
    '["news", "news"]',
    '["webinar", "webinar"]',
    '["article", "article"]',
    '["image", "image"]',
    '["index_page", "index_page"]',
    '["management", "management"]',
    '["tweet", "tweet"]',
    '["marketing", "marketing"]',
    '["upload", "upload"]',
    '["pdf", "pdf"]',
    '["blog", "blog"]',
    '["case_study", "case study"]',
    '["forum", "forum"]',
    '["social", "social"]',
    '["helpdesk", "helpdesk"]',
    '["career", "career"]',
    '["website", "website"]',
    '["product", "product"]',
    '["twitter_mention", "twitter_mention"]',
    '["promotion", "promotion"]',
    '["commercial", "commercial"]',
    '["event", "event"]',
    '["pr", "pr"]',
    '["company", "company"]',
    'webinar',
    'company',
    'news',
    'tweet',
    'youtube'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: abraham_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.abraham_histories (
    id integer NOT NULL,
    controller_name character varying,
    action_name character varying,
    tour_name character varying,
    creator_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: abraham_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.abraham_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: abraham_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.abraham_histories_id_seq OWNED BY public.abraham_histories.id;


--
-- Name: account_invitations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.account_invitations (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    invited_by_id bigint,
    token character varying,
    name character varying,
    email character varying,
    roles jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: account_invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.account_invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.account_invitations_id_seq OWNED BY public.account_invitations.id;


--
-- Name: account_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.account_users (
    id bigint NOT NULL,
    account_id bigint,
    user_id bigint,
    roles jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: account_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.account_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.account_users_id_seq OWNED BY public.account_users.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts (
    id bigint NOT NULL,
    name character varying NOT NULL,
    owner_id bigint,
    personal boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    domain character varying,
    subdomain character varying,
    extra_billing_info text,
    slack_integration character varying,
    template character varying,
    ms_teams_webhook_url character varying,
    deleted_at timestamp(6) without time zone,
    ads boolean DEFAULT false,
    allow_translations boolean DEFAULT false,
    billing_email character varying,
    organization_id bigint,
    url_counts integer DEFAULT 0,
    account_users_count integer DEFAULT 0,
    word_filter character varying,
    score integer,
    assistant_id character varying,
    abtest character varying,
    auto_watch_threshold integer,
    grade_median integer,
    grade_top_precentile integer,
    openai boolean DEFAULT false,
    template_blurb text,
    template_value_prop_title character varying,
    template_value_prop_details text,
    competitor_mode boolean DEFAULT true,
    main_company_id integer,
    paused boolean DEFAULT false,
    main_company_name character varying,
    main_company_url character varying,
    scrape_screenshots boolean DEFAULT false,
    company_count integer DEFAULT 0,
    industry character varying,
    processing_started boolean DEFAULT false,
    ci_platform boolean DEFAULT false NOT NULL
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: action_mailbox_inbound_emails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.action_mailbox_inbound_emails (
    id bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    message_id character varying NOT NULL,
    message_checksum character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: action_mailbox_inbound_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.action_mailbox_inbound_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_mailbox_inbound_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.action_mailbox_inbound_emails_id_seq OWNED BY public.action_mailbox_inbound_emails.id;


--
-- Name: action_text_rich_texts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.action_text_rich_texts (
    id bigint NOT NULL,
    name character varying NOT NULL,
    body text,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.action_text_rich_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.action_text_rich_texts_id_seq OWNED BY public.action_text_rich_texts.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp without time zone NOT NULL,
    service_name character varying NOT NULL,
    summary text,
    openai_file_id character varying,
    openai_vector_store_id character varying
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    addressable_type character varying NOT NULL,
    addressable_id bigint NOT NULL,
    address_type integer,
    line1 character varying,
    line2 character varying,
    city character varying,
    state character varying,
    country character varying,
    postal_code character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: ads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ads (
    id bigint NOT NULL,
    title character varying,
    visual_url character varying,
    url_id bigint NOT NULL,
    company_id bigint NOT NULL,
    description text,
    postion integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    competitor_id integer
);


--
-- Name: ads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ads_id_seq OWNED BY public.ads.id;


--
-- Name: ahoy_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ahoy_events (
    id bigint NOT NULL,
    visit_id bigint,
    user_id bigint,
    name character varying,
    properties jsonb,
    "time" timestamp(6) without time zone
);


--
-- Name: ahoy_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ahoy_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ahoy_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ahoy_events_id_seq OWNED BY public.ahoy_events.id;


--
-- Name: ahoy_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ahoy_messages (
    id bigint NOT NULL,
    user_type character varying,
    user_id bigint,
    to_ciphertext text,
    to_bidx character varying,
    mailer character varying,
    subject text,
    sent_at timestamp(6) without time zone
);


--
-- Name: ahoy_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ahoy_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ahoy_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ahoy_messages_id_seq OWNED BY public.ahoy_messages.id;


--
-- Name: ahoy_visits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ahoy_visits (
    id bigint NOT NULL,
    visit_token character varying,
    visitor_token character varying,
    user_id bigint,
    ip character varying,
    user_agent text,
    referrer text,
    referring_domain character varying,
    landing_page text,
    browser character varying,
    os character varying,
    device_type character varying,
    country character varying,
    region character varying,
    city character varying,
    latitude double precision,
    longitude double precision,
    utm_source character varying,
    utm_medium character varying,
    utm_term character varying,
    utm_content character varying,
    utm_campaign character varying,
    app_version character varying,
    os_version character varying,
    platform character varying,
    started_at timestamp(6) without time zone
);


--
-- Name: ahoy_visits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ahoy_visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ahoy_visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ahoy_visits_id_seq OWNED BY public.ahoy_visits.id;


--
-- Name: ai_agent_examples; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_agent_examples (
    id bigint NOT NULL,
    prompt character varying,
    agent_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: ai_agent_examples_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ai_agent_examples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ai_agent_examples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ai_agent_examples_id_seq OWNED BY public.ai_agent_examples.id;


--
-- Name: ai_agent_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_agent_messages (
    id bigint NOT NULL,
    agent_task_id bigint NOT NULL,
    role character varying NOT NULL,
    content text,
    tool_calls json,
    tool_call_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    deleted_at timestamp(6) without time zone,
    feedback integer,
    llm character varying,
    url character varying,
    url_verified boolean DEFAULT false,
    streaming boolean DEFAULT false,
    is_streaming boolean,
    meta jsonb
);


--
-- Name: ai_agent_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ai_agent_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ai_agent_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ai_agent_messages_id_seq OWNED BY public.ai_agent_messages.id;


--
-- Name: ai_agent_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_agent_tasks (
    id bigint NOT NULL,
    agent_id bigint NOT NULL,
    user_id bigint,
    account_id bigint,
    parent_task_id bigint,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying,
    project_id integer,
    runs_every character varying,
    next_run timestamp(6) without time zone,
    rerun_instruction character varying,
    deleted_at timestamp(6) without time zone,
    summary text,
    memory_strategy character varying,
    window_size integer,
    summary_updated_at timestamp(6) without time zone,
    tracked_entities jsonb DEFAULT '{}'::jsonb,
    task_type character varying,
    last_run_at timestamp(6) without time zone,
    object_type character varying,
    object_id integer,
    persona_id bigint,
    project_section_id integer,
    llm character varying,
    search_calls_count integer DEFAULT 0 NOT NULL,
    page_fetch_calls_count integer DEFAULT 0 NOT NULL,
    execution_started_at timestamp(6) without time zone,
    fetched_urls text[] DEFAULT '{}'::text[],
    alert_calls_count integer DEFAULT 0 NOT NULL,
    renamed boolean DEFAULT false NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    rename_job_enqueued boolean DEFAULT false
);


--
-- Name: ai_agent_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ai_agent_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ai_agent_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ai_agent_tasks_id_seq OWNED BY public.ai_agent_tasks.id;


--
-- Name: ai_agents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_agents (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text NOT NULL,
    instructions text NOT NULL,
    tools json DEFAULT '[]'::json NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    chat_model character varying DEFAULT 'gpt-4o-mini'::character varying,
    display_in_project boolean DEFAULT false,
    runs_every character varying,
    account_id integer,
    user_id integer,
    deleted_at timestamp(6) without time zone,
    default_memory_strategy character varying DEFAULT 'window'::character varying,
    default_window_size integer DEFAULT 10,
    agent_type character varying DEFAULT 'conversation'::character varying,
    project_template boolean DEFAULT false,
    icon character varying,
    estimated_time character varying,
    auto_start boolean DEFAULT false,
    auto_start_hidden boolean DEFAULT true,
    auto_start_message text,
    split_view boolean DEFAULT false,
    agent_tasks_count integer DEFAULT 0 NOT NULL,
    archived_at timestamp(6) without time zone
);


--
-- Name: ai_agents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ai_agents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ai_agents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ai_agents_id_seq OWNED BY public.ai_agents.id;


--
-- Name: alert_hides; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alert_hides (
    id bigint NOT NULL,
    alert_id bigint NOT NULL,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    hidden_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: alert_hides_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alert_hides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alert_hides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alert_hides_id_seq OWNED BY public.alert_hides.id;


--
-- Name: alert_ratings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alert_ratings (
    id bigint NOT NULL,
    alert_id bigint NOT NULL,
    user_id bigint NOT NULL,
    agent_task_id bigint,
    thumbs_up boolean DEFAULT false,
    thumbs_down boolean DEFAULT false,
    feedback_reason character varying,
    feedback_details text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: alert_ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alert_ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alert_ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alert_ratings_id_seq OWNED BY public.alert_ratings.id;


--
-- Name: alert_views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alert_views (
    id bigint NOT NULL,
    alert_id bigint NOT NULL,
    user_id bigint NOT NULL,
    viewed_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: alert_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alert_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alert_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alert_views_id_seq OWNED BY public.alert_views.id;


--
-- Name: alerts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alerts (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    user_id bigint,
    alert_type character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id bigint,
    alert_class character varying
);


--
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alerts_id_seq OWNED BY public.alerts.id;


--
-- Name: analysis_companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analysis_companies (
    id bigint NOT NULL,
    competitor_analysis_id bigint NOT NULL,
    company_id bigint NOT NULL,
    "position" integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: analysis_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.analysis_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analysis_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.analysis_companies_id_seq OWNED BY public.analysis_companies.id;


--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcements (
    id bigint NOT NULL,
    kind character varying,
    title character varying,
    published_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.announcements_id_seq OWNED BY public.announcements.id;


--
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token character varying,
    name character varying,
    metadata jsonb DEFAULT '{}'::jsonb,
    transient boolean DEFAULT false,
    last_used_at timestamp without time zone,
    expires_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint
);


--
-- Name: api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.api_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.api_tokens_id_seq OWNED BY public.api_tokens.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: artifacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.artifacts (
    id bigint NOT NULL,
    title character varying NOT NULL,
    artifact_type character varying NOT NULL,
    content text,
    metadata jsonb DEFAULT '{}'::jsonb,
    task_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    product_blueprint_id bigint,
    artifactable_type character varying,
    artifactable_id bigint
);


--
-- Name: artifacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.artifacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artifacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.artifacts_id_seq OWNED BY public.artifacts.id;


--
-- Name: blazer_audits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_audits (
    id bigint NOT NULL,
    user_id bigint,
    query_id bigint,
    statement text,
    data_source character varying,
    created_at timestamp without time zone
);


--
-- Name: blazer_audits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_audits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_audits_id_seq OWNED BY public.blazer_audits.id;


--
-- Name: blazer_checks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_checks (
    id bigint NOT NULL,
    creator_id bigint,
    query_id bigint,
    state character varying,
    schedule character varying,
    emails text,
    slack_channels text,
    check_type character varying,
    message text,
    last_run_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_checks_id_seq OWNED BY public.blazer_checks.id;


--
-- Name: blazer_dashboard_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_dashboard_queries (
    id bigint NOT NULL,
    dashboard_id bigint,
    query_id bigint,
    "position" integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_dashboard_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_dashboard_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_dashboard_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_dashboard_queries_id_seq OWNED BY public.blazer_dashboard_queries.id;


--
-- Name: blazer_dashboards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_dashboards (
    id bigint NOT NULL,
    creator_id bigint,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_dashboards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_dashboards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_dashboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_dashboards_id_seq OWNED BY public.blazer_dashboards.id;


--
-- Name: blazer_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blazer_queries (
    id bigint NOT NULL,
    creator_id bigint,
    name character varying,
    description text,
    statement text,
    data_source character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blazer_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blazer_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blazer_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blazer_queries_id_seq OWNED BY public.blazer_queries.id;


--
-- Name: block_ai_agents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.block_ai_agents (
    id bigint NOT NULL,
    blockable_type character varying NOT NULL,
    blockable_id bigint NOT NULL,
    ai_agent_id bigint NOT NULL,
    account_id bigint NOT NULL,
    trigger_type character varying DEFAULT 'manual'::character varying NOT NULL,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    agent_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_run_at timestamp(6) without time zone,
    next_run_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: block_ai_agents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.block_ai_agents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: block_ai_agents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.block_ai_agents_id_seq OWNED BY public.block_ai_agents.id;


--
-- Name: blogs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blogs (
    id bigint NOT NULL,
    title character varying,
    content text,
    author character varying,
    keywords text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    slug character varying,
    meta_description text,
    hero_alt character varying,
    status integer,
    published_at date,
    view_count integer DEFAULT 0,
    excerpt character varying,
    key_takeaways text[] DEFAULT '{}'::text[]
);


--
-- Name: blogs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blogs_id_seq OWNED BY public.blogs.id;


--
-- Name: bookmarks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookmarks (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    bookmarkable_type character varying NOT NULL,
    bookmarkable_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    project_id bigint
);


--
-- Name: bookmarks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookmarks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bookmarks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookmarks_id_seq OWNED BY public.bookmarks.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: chat_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chat_histories (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    prompt text,
    response text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    object_type character varying,
    object_id integer
);


--
-- Name: chat_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chat_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chat_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chat_histories_id_seq OWNED BY public.chat_histories.id;


--
-- Name: chat_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chat_messages (
    id bigint NOT NULL,
    chat_id bigint NOT NULL,
    content text,
    role character varying DEFAULT 'user'::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    message_id character varying,
    json_data text,
    tool_call_id character varying,
    function_name character varying,
    user_id integer,
    token_count integer,
    deleted_at timestamp(6) without time zone
);


--
-- Name: chat_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chat_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chat_messages_id_seq OWNED BY public.chat_messages.id;


--
-- Name: chats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chats (
    id bigint NOT NULL,
    session_id character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    thread_id character varying,
    account_id bigint,
    name character varying,
    name_updated boolean DEFAULT false,
    daily_check boolean DEFAULT false,
    keyword character varying,
    person character varying,
    company_id_to_check integer,
    notify character varying DEFAULT 'chat'::character varying,
    deleted_at timestamp(6) without time zone
);


--
-- Name: chats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chats_id_seq OWNED BY public.chats.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    commentable_id bigint NOT NULL,
    commentable_type character varying NOT NULL,
    content text NOT NULL,
    user_id bigint NOT NULL,
    parent_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint NOT NULL,
    mentioned_user_ids json
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    name character varying,
    url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint,
    scrape_search_engines boolean DEFAULT false,
    twitter character varying,
    scrape_twitter boolean DEFAULT false,
    url_count integer DEFAULT 0,
    rss character varying,
    active_scrape boolean,
    team_id bigint,
    brief_clean_up text,
    check_for_ads boolean DEFAULT false,
    last_content_found timestamp without time zone,
    youtube_url character varying,
    indexed_at timestamp without time zone,
    linked_profile_url character varying,
    allow_translations boolean DEFAULT false,
    display_on_feed_count integer DEFAULT 0,
    crm character varying,
    rest_only boolean DEFAULT false,
    last_url_indexed integer,
    management_url_id integer,
    management_count integer DEFAULT 0,
    people_count integer DEFAULT 0,
    failed_scrape integer DEFAULT 0,
    facebook_url character varying,
    instegram_url character varying,
    last_48h integer DEFAULT 0,
    last_7d integer DEFAULT 0,
    last_14d integer DEFAULT 0,
    last_30d integer DEFAULT 0,
    description text,
    linkedin_employee_count integer DEFAULT 0,
    linkedin_followers_count integer DEFAULT 0,
    news_term character varying,
    linkedin_data text,
    g2_url character varying,
    linkedin_company_id character varying,
    linkedin_updates integer DEFAULT 0,
    linkedin_updates_last_30_days integer DEFAULT 0,
    crunchbase_url character varying,
    import_id integer,
    twitter_id character varying,
    old_twitter character varying,
    scrape_linkedin_employees boolean DEFAULT false,
    scrape_linkedin_updates boolean DEFAULT false,
    score integer,
    g2_grade double precision,
    g2_discussions double precision,
    g2_review_count double precision,
    limit_urls text,
    last_checked_twitter timestamp(6) without time zone,
    last_checked_youtube timestamp(6) without time zone,
    last_checked_linkedin timestamp(6) without time zone,
    parent_id integer,
    linkedin_scrape_every integer DEFAULT 24,
    subdomains text,
    industry character varying,
    ticker_symbol character varying,
    headquarter_location text,
    market_segment_id bigint,
    root_url_count integer DEFAULT 0,
    last_checked_website timestamp(6) without time zone,
    requires_proxy boolean DEFAULT false,
    additional_information text,
    job_service character varying,
    tag_line character varying,
    facebook_id character varying,
    wikipedia_url character varying,
    tweets_count integer DEFAULT 0,
    linkedin_count integer DEFAULT 0,
    youtubes_count integer DEFAULT 0,
    job_count integer DEFAULT 0,
    press_releases_count integer DEFAULT 0,
    events_count integer DEFAULT 0,
    paused_at timestamp(6) without time zone,
    color character varying,
    monthly_limit integer DEFAULT 1000,
    monthly_urls integer DEFAULT 0,
    display_feed boolean DEFAULT true,
    job_site character varying,
    funding_amount character varying,
    funding_stage character varying,
    owner_id bigint,
    sitemap_tested boolean DEFAULT false,
    sitemap_tested_at timestamp(6) without time zone,
    market_position_rank integer,
    market_position_tier character varying,
    market_position_percentage numeric(5,2),
    market_position_score numeric(5,2),
    market_position_total_companies integer,
    market_position_calculated_at timestamp(6) without time zone,
    year_founded integer,
    twitter_check_frequency_hours integer,
    twitter_activity_score numeric,
    twitter_tweets_last_30_days integer,
    last_twitter_activity_at timestamp(6) without time zone,
    youtube_check_frequency_hours integer,
    youtube_activity_score numeric,
    youtube_videos_last_30_days integer,
    last_youtube_activity_at timestamp(6) without time zone,
    linkedin_activity_score numeric(5,2),
    last_linkedin_activity_at timestamp(6) without time zone,
    career_page_url character varying
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: company_blueprint_associations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_blueprint_associations (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    product_blueprint_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_blueprint_associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_blueprint_associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_blueprint_associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_blueprint_associations_id_seq OWNED BY public.company_blueprint_associations.id;


--
-- Name: company_collection_memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_collection_memberships (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    company_collection_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_collection_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_collection_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_collection_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_collection_memberships_id_seq OWNED BY public.company_collection_memberships.id;


--
-- Name: company_competitors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_competitors (
    id bigint NOT NULL,
    company_id bigint,
    competitor_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_competitors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_competitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_competitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_competitors_id_seq OWNED BY public.company_competitors.id;


--
-- Name: company_customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_customers (
    id bigint NOT NULL,
    provider_company_id bigint NOT NULL,
    customer_company_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_customers_id_seq OWNED BY public.company_customers.id;


--
-- Name: company_finances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_finances (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    ticker character varying,
    current_price numeric,
    revenue_5yr_cagr numeric,
    yoy_revenue_growth numeric,
    rd_spend_percentage numeric,
    gross_margin numeric,
    ebitda bigint,
    ebitda_margin numeric,
    ga_revenue_ratio numeric,
    capex bigint,
    net_debt_to_ebitda numeric,
    fcf_to_debt_ratio numeric,
    ev_to_ebitda numeric,
    currency character varying,
    last_updated timestamp(6) without time zone,
    data_points integer,
    raw_data text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    cik character varying,
    exchange character varying
);


--
-- Name: company_finances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_finances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_finances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_finances_id_seq OWNED BY public.company_finances.id;


--
-- Name: company_followers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_followers (
    id bigint NOT NULL,
    company_id bigint,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint,
    team_id bigint,
    importance integer DEFAULT 0,
    relationship_type character varying DEFAULT 'competitor'::character varying,
    priority integer DEFAULT 1,
    notes text
);


--
-- Name: company_followers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_followers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_followers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_followers_id_seq OWNED BY public.company_followers.id;


--
-- Name: company_keyword_counts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_keyword_counts (
    id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    company_id bigint NOT NULL,
    title_count integer,
    body_count integer,
    total_count integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_keyword_counts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_keyword_counts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_keyword_counts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_keyword_counts_id_seq OWNED BY public.company_keyword_counts.id;


--
-- Name: company_managers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_managers (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    role character varying DEFAULT 'manager'::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_managers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_managers_id_seq OWNED BY public.company_managers.id;


--
-- Name: company_news; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_news (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    body text,
    week integer,
    year integer,
    month integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_news_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_news_id_seq OWNED BY public.company_news.id;


--
-- Name: company_owners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_owners (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_owners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_owners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_owners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_owners_id_seq OWNED BY public.company_owners.id;


--
-- Name: company_relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_relationships (
    id bigint NOT NULL,
    primary_company_id bigint NOT NULL,
    related_company_id bigint NOT NULL,
    relationship_type character varying NOT NULL,
    priority integer DEFAULT 1,
    notes text,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_relationships_id_seq OWNED BY public.company_relationships.id;


--
-- Name: company_tweeps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_tweeps (
    id bigint NOT NULL,
    company_id integer,
    tweep_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_tweeps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_tweeps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_tweeps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_tweeps_id_seq OWNED BY public.company_tweeps.id;


--
-- Name: company_url_filters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_url_filters (
    id bigint NOT NULL,
    company_id bigint,
    user_id bigint,
    grade_threshold integer,
    word character varying,
    days integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id integer
);


--
-- Name: company_url_filters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_url_filters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_url_filters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_url_filters_id_seq OWNED BY public.company_url_filters.id;


--
-- Name: company_weekly_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_weekly_reports (
    id bigint NOT NULL,
    cweek integer,
    company_id bigint NOT NULL,
    year integer,
    body text,
    public boolean DEFAULT false,
    title character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_weekly_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_weekly_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_weekly_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_weekly_reports_id_seq OWNED BY public.company_weekly_reports.id;


--
-- Name: comparison_lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comparison_lines (
    id bigint NOT NULL,
    comparison_id bigint NOT NULL,
    feature character varying,
    product_1_value character varying,
    product_2_value character varying,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    product_1_url_count integer,
    product_2_url_count integer,
    product_1_youtube_count integer,
    product_2_youtube_count integer,
    product_1_screenshot_count integer,
    product_2_screenshot_count integer,
    product_1_linkedin_count integer,
    product_2_linkedin_count integer,
    product_1_facebook_count integer,
    product_2_facebook_count integer,
    product_1_twitter_count integer,
    product_2_twitter_count integer,
    product_1_instagram_count integer,
    product_2_instagram_count integer,
    product_1_helpdesk_count integer,
    product_2_helpdesk_count integer,
    product_1_pr_count integer,
    product_2_pr_count integer,
    product_1_news_count integer,
    product_2_news_count integer,
    winnning_product_id integer
);


--
-- Name: comparison_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comparison_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comparison_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comparison_lines_id_seq OWNED BY public.comparison_lines.id;


--
-- Name: comparisons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comparisons (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    title character varying,
    product_1_id bigint NOT NULL,
    product_2_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: comparisons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comparisons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comparisons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comparisons_id_seq OWNED BY public.comparisons.id;


--
-- Name: competitor_analyses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.competitor_analyses (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    description text,
    raw_data text,
    name character varying,
    product_ids json DEFAULT '[]'::json,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint,
    public boolean DEFAULT false,
    public_slug character varying,
    visits_count integer DEFAULT 0 NOT NULL,
    intended_feature_ids text
);


--
-- Name: harvey_ball_competitor_analyses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.harvey_ball_competitor_analyses (
    id bigint NOT NULL,
    feature_analysis_id bigint NOT NULL,
    competitor_analysis_id bigint NOT NULL,
    "position" integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: competitor_analyses_feature_analyses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.competitor_analyses_feature_analyses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: competitor_analyses_feature_analyses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.competitor_analyses_feature_analyses_id_seq OWNED BY public.harvey_ball_competitor_analyses.id;


--
-- Name: competitor_analyses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.competitor_analyses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: competitor_analyses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.competitor_analyses_id_seq OWNED BY public.competitor_analyses.id;


--
-- Name: competitor_priorities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.competitor_priorities (
    id bigint NOT NULL,
    priority character varying,
    company_id bigint NOT NULL,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    "position" integer
);


--
-- Name: competitor_priorities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.competitor_priorities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: competitor_priorities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.competitor_priorities_id_seq OWNED BY public.competitor_priorities.id;


--
-- Name: competitor_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.competitor_reports (
    id bigint NOT NULL,
    company_id bigint,
    week integer,
    week_start_date date,
    week_end_date date,
    year integer,
    datasets text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id integer
);


--
-- Name: competitor_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.competitor_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: competitor_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.competitor_reports_id_seq OWNED BY public.competitor_reports.id;


--
-- Name: competitors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.competitors (
    id bigint NOT NULL,
    name character varying,
    industry character varying,
    location character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: competitors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.competitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: competitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.competitors_id_seq OWNED BY public.competitors.id;


--
-- Name: connected_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.connected_accounts (
    id bigint NOT NULL,
    owner_id bigint,
    provider character varying,
    uid character varying,
    refresh_token character varying,
    expires_at timestamp without time zone,
    auth jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    access_token character varying,
    access_token_secret character varying,
    owner_type character varying
);


--
-- Name: connected_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.connected_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: connected_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.connected_accounts_id_seq OWNED BY public.connected_accounts.id;


--
-- Name: content_blocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_blocks (
    id bigint NOT NULL,
    document_section_id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    block_type character varying NOT NULL,
    "position" integer NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    content_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    layout_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    block_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_modified_at timestamp(6) without time zone,
    last_modified_by_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: content_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.content_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: content_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.content_blocks_id_seq OWNED BY public.content_blocks.id;


--
-- Name: contents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contents (
    id bigint NOT NULL,
    title character varying,
    body text,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    draft boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: contents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contents_id_seq OWNED BY public.contents.id;


--
-- Name: daily_digests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_digests (
    id bigint NOT NULL,
    input text,
    output text,
    prompt character varying,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: daily_digests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_digests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: daily_digests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_digests_id_seq OWNED BY public.daily_digests.id;


--
-- Name: data_quality_companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_quality_companies (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    url_count integer,
    url_last_found integer,
    tweet_count integer,
    tweet_last_found timestamp(6) without time zone,
    career_count integer,
    career_last_found timestamp(6) without time zone,
    linkedin_count integer,
    linkedin_last_found timestamp(6) without time zone,
    blog_count integer,
    blog_last_found timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: data_quality_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.data_quality_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: data_quality_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.data_quality_companies_id_seq OWNED BY public.data_quality_companies.id;


--
-- Name: data_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_sets (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    data text,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    min integer,
    max integer,
    metric character varying,
    timeframe character varying,
    company_id integer,
    raw_data text,
    data_model character varying,
    start_date date,
    end_date date,
    year integer,
    month integer,
    week integer,
    name character varying
);


--
-- Name: data_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.data_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: data_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.data_sets_id_seq OWNED BY public.data_sets.id;


--
-- Name: document_collaborations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_collaborations (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    user_id bigint NOT NULL,
    invited_by_id bigint NOT NULL,
    role character varying DEFAULT 'viewer'::character varying NOT NULL,
    status character varying DEFAULT 'active'::character varying NOT NULL,
    last_accessed_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: document_collaborations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_collaborations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_collaborations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_collaborations_id_seq OWNED BY public.document_collaborations.id;


--
-- Name: document_exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_exports (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    user_id bigint NOT NULL,
    export_format character varying NOT NULL,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    file_path character varying,
    external_url character varying,
    export_options jsonb DEFAULT '{}'::jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    exported_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: document_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_exports_id_seq OWNED BY public.document_exports.id;


--
-- Name: document_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_sections (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    template_section_id bigint,
    name character varying NOT NULL,
    description text,
    section_type character varying DEFAULT 'content'::character varying NOT NULL,
    "position" integer NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    layout_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    content_blocks_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: document_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_sections_id_seq OWNED BY public.document_sections.id;


--
-- Name: document_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_tags (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    name character varying NOT NULL,
    color character varying DEFAULT '#3b82f6'::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: document_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_tags_id_seq OWNED BY public.document_tags.id;


--
-- Name: document_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_templates (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    parent_template_id bigint,
    name character varying NOT NULL,
    description text,
    template_type character varying DEFAULT 'blank'::character varying NOT NULL,
    status character varying DEFAULT 'draft'::character varying NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    layout_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    documents_count integer DEFAULT 0 NOT NULL,
    template_sections_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: document_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_templates_id_seq OWNED BY public.document_templates.id;


--
-- Name: document_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_versions (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    user_id bigint NOT NULL,
    version_number integer NOT NULL,
    comment text,
    document_data jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: document_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_versions_id_seq OWNED BY public.document_versions.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    document_template_id bigint,
    parent_document_id bigint,
    title character varying NOT NULL,
    description text,
    status character varying DEFAULT 'draft'::character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    document_sections_count integer DEFAULT 0 NOT NULL,
    collaborations_count integer DEFAULT 0 NOT NULL,
    versions_count integer DEFAULT 0 NOT NULL,
    last_edited_at timestamp(6) without time zone,
    last_edited_by_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: email_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_templates (
    id bigint NOT NULL,
    subject character varying,
    campaign character varying,
    prompt_body text,
    status integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: email_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_templates_id_seq OWNED BY public.email_templates.id;


--
-- Name: email_trackers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_trackers (
    id bigint NOT NULL,
    trackable_type character varying NOT NULL,
    trackable_id bigint NOT NULL,
    user_id bigint,
    token character varying,
    opened_at timestamp(6) without time zone,
    open_count integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: email_trackers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_trackers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_trackers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_trackers_id_seq OWNED BY public.email_trackers.id;


--
-- Name: email_weekly_digests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_weekly_digests (
    id bigint NOT NULL,
    subject character varying,
    body_html text,
    body_plain character varying,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    week integer,
    year integer,
    month integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: email_weekly_digests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_weekly_digests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_weekly_digests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_weekly_digests_id_seq OWNED BY public.email_weekly_digests.id;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.emails (
    id bigint NOT NULL,
    subject character varying,
    body text,
    prompt_text text,
    person_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    "to" character varying,
    "from" character varying,
    due_date timestamp(6) without time zone,
    sent_at timestamp(6) without time zone,
    status integer,
    error_message character varying
);


--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.emails_id_seq OWNED BY public.emails.id;


--
-- Name: event_attendances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_attendances (
    id bigint NOT NULL,
    event_id bigint NOT NULL,
    company_id bigint NOT NULL,
    urls text,
    booth character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: event_attendances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.event_attendances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_attendances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.event_attendances_id_seq OWNED BY public.event_attendances.id;


--
-- Name: event_followers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_followers (
    id bigint NOT NULL,
    event_id bigint NOT NULL,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: event_followers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.event_followers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_followers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.event_followers_id_seq OWNED BY public.event_followers.id;


--
-- Name: event_speakers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_speakers (
    id bigint NOT NULL,
    event_id bigint NOT NULL,
    person_id bigint NOT NULL,
    url_id bigint,
    talk_title character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: event_speakers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.event_speakers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_speakers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.event_speakers_id_seq OWNED BY public.event_speakers.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    name character varying,
    location character varying,
    date date,
    description text,
    url character varying,
    hashtag character varying,
    event_type integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    year integer,
    quarter integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: evidences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evidences (
    id bigint NOT NULL,
    dataset_id bigint,
    company_id bigint,
    feature_id bigint,
    value integer,
    evidence text,
    confidence integer,
    notes text,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    agent_task_id bigint,
    feature_analysis_id bigint,
    source_url character varying,
    found_keywords text[] DEFAULT '{}'::text[],
    discovered_at timestamp(6) without time zone,
    source_type character varying,
    source_title character varying,
    source_author character varying,
    source_published_at timestamp(6) without time zone
);


--
-- Name: evidences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evidences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evidences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evidences_id_seq OWNED BY public.evidences.id;


--
-- Name: facts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.facts (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    content text,
    company_id bigint NOT NULL,
    location character varying,
    keyword character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    keyword_id integer,
    product_feature_id bigint,
    content_published_at date,
    prominence_score integer DEFAULT 1,
    source_context character varying,
    language_tone character varying
);


--
-- Name: facts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.facts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: facts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.facts_id_seq OWNED BY public.facts.id;


--
-- Name: feature_analyses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_analyses (
    id bigint NOT NULL,
    feature_id bigint NOT NULL,
    account_id bigint NOT NULL,
    harvey_ball_score integer DEFAULT 0 NOT NULL,
    confidence_score integer DEFAULT 0,
    evidence_summary text,
    mention_count integer DEFAULT 0,
    notes text,
    last_evidence_date date,
    manual_override boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    agent_id bigint,
    ai_agent_task bigint,
    company_id bigint NOT NULL,
    CONSTRAINT confidence_score_range CHECK (((confidence_score >= 0) AND (confidence_score <= 100))),
    CONSTRAINT harvey_ball_score_range CHECK (((harvey_ball_score >= 0) AND (harvey_ball_score <= 4)))
);


--
-- Name: feature_analyses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feature_analyses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feature_analyses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feature_analyses_id_seq OWNED BY public.feature_analyses.id;


--
-- Name: feature_analysis_snapshots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_analysis_snapshots (
    id bigint NOT NULL,
    product_feature_id bigint NOT NULL,
    analysis_period_start date NOT NULL,
    analysis_period_end date NOT NULL,
    harvey_ball_score integer NOT NULL,
    fact_count integer DEFAULT 0,
    average_prominence numeric(5,2),
    momentum_score numeric(5,2),
    trend_direction character varying,
    supporting_fact_ids json,
    prominent_language json,
    source_breakdown json,
    analysis_summary text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: feature_analysis_snapshots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feature_analysis_snapshots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feature_analysis_snapshots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feature_analysis_snapshots_id_seq OWNED BY public.feature_analysis_snapshots.id;


--
-- Name: feature_capabilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_capabilities (
    id bigint NOT NULL,
    feature_id bigint NOT NULL,
    product_id bigint,
    company_id bigint,
    url_id bigint,
    capability text NOT NULL,
    grade integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: feature_capabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feature_capabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feature_capabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feature_capabilities_id_seq OWNED BY public.feature_capabilities.id;


--
-- Name: feature_keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_keywords (
    id bigint NOT NULL,
    feature_id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: feature_keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feature_keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feature_keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feature_keywords_id_seq OWNED BY public.feature_keywords.id;


--
-- Name: feature_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_sets (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: feature_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feature_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feature_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feature_sets_id_seq OWNED BY public.feature_sets.id;


--
-- Name: feature_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feature_urls (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    feature_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    extracted_content text,
    cosine_similarity double precision
);


--
-- Name: feature_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feature_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feature_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feature_urls_id_seq OWNED BY public.feature_urls.id;


--
-- Name: features; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.features (
    id bigint NOT NULL,
    name character varying,
    description text,
    parent_id integer,
    "integer" integer,
    lft integer NOT NULL,
    rgt integer NOT NULL,
    depth integer DEFAULT 0 NOT NULL,
    children_count integer DEFAULT 0 NOT NULL,
    product_blueprint_id bigint,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    keywords_tmp text,
    addressed_problem text,
    keyword_id integer,
    product_id integer,
    grade integer DEFAULT 0,
    tmp boolean DEFAULT false,
    account_id bigint NOT NULL,
    product_blueprint_module_id bigint
);


--
-- Name: features_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.features_id_seq OWNED BY public.features.id;


--
-- Name: file_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_questions (
    id bigint NOT NULL,
    question text NOT NULL,
    answer text,
    file_id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: file_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.file_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: file_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.file_questions_id_seq OWNED BY public.file_questions.id;


--
-- Name: flipper_features; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flipper_features (
    id bigint NOT NULL,
    key character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: flipper_features_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.flipper_features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flipper_features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.flipper_features_id_seq OWNED BY public.flipper_features.id;


--
-- Name: flipper_gates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flipper_gates (
    id bigint NOT NULL,
    feature_key character varying NOT NULL,
    key character varying NOT NULL,
    value text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: flipper_gates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.flipper_gates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flipper_gates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.flipper_gates_id_seq OWNED BY public.flipper_gates.id;


--
-- Name: goals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goals (
    id bigint NOT NULL,
    metric character varying,
    value integer,
    month integer,
    year integer,
    week integer,
    description text,
    code text,
    period integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: goals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.goals_id_seq OWNED BY public.goals.id;


--
-- Name: grade_configurations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grade_configurations (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    marketing_enabled boolean DEFAULT true,
    marketing_weight integer DEFAULT 5,
    announcements_enabled boolean DEFAULT true,
    announcements_weight integer DEFAULT 8,
    hiring_enabled boolean DEFAULT true,
    hiring_weight integer DEFAULT 3,
    events_enabled boolean DEFAULT true,
    events_weight integer DEFAULT 4,
    case_studies_enabled boolean DEFAULT true,
    case_studies_weight integer DEFAULT 7,
    pr_enabled boolean DEFAULT true,
    pr_weight integer DEFAULT 6,
    blog_posts_enabled boolean DEFAULT true,
    blog_posts_weight integer DEFAULT 5,
    videos_enabled boolean DEFAULT true,
    videos_weight integer DEFAULT 4,
    help_desk_enabled boolean DEFAULT true,
    help_desk_weight integer DEFAULT 2,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: grade_configurations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grade_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grade_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grade_configurations_id_seq OWNED BY public.grade_configurations.id;


--
-- Name: headers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.headers (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    text character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    header_tag character varying
);


--
-- Name: headers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.headers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: headers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.headers_id_seq OWNED BY public.headers.id;


--
-- Name: ignore_domains; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ignore_domains (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    uri character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: ignore_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ignore_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ignore_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ignore_domains_id_seq OWNED BY public.ignore_domains.id;


--
-- Name: ignore_patterns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ignore_patterns (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    pattern character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: ignore_patterns_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ignore_patterns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ignore_patterns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ignore_patterns_id_seq OWNED BY public.ignore_patterns.id;


--
-- Name: import_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.import_maps (
    id bigint NOT NULL,
    import_id bigint NOT NULL,
    headers json,
    map json,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: import_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.import_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: import_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.import_maps_id_seq OWNED BY public.import_maps.id;


--
-- Name: imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.imports (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    people_list_id bigint,
    user_id bigint NOT NULL,
    records text,
    import_errors text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status integer DEFAULT 0
);


--
-- Name: imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.imports_id_seq OWNED BY public.imports.id;


--
-- Name: inbound_webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inbound_webhooks (
    id bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    body text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: inbound_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inbound_webhooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inbound_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inbound_webhooks_id_seq OWNED BY public.inbound_webhooks.id;


--
-- Name: integrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.integrations (
    id bigint NOT NULL,
    type character varying,
    auth_token character varying,
    last_synced_at timestamp(6) without time zone,
    data jsonb,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: integrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.integrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: integrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.integrations_id_seq OWNED BY public.integrations.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    url_id bigint,
    title character varying NOT NULL,
    description text,
    requirements text,
    responsibilities text,
    benefits text,
    department character varying,
    team character varying,
    job_function character varying,
    employment_type character varying DEFAULT 'full_time'::character varying,
    experience_level character varying,
    remote boolean DEFAULT false,
    location character varying,
    locations json,
    country character varying,
    state_province character varying,
    city character varying,
    relocation_assistance boolean DEFAULT false,
    salary_min_cents integer,
    salary_max_cents integer,
    salary_currency character varying DEFAULT 'USD'::character varying,
    compensation_type character varying,
    equity_details text,
    application_url character varying,
    external_id character varying,
    source_system character varying,
    applicant_count integer,
    application_deadline date,
    status character varying DEFAULT 'active'::character varying,
    discovered_at timestamp(6) without time zone NOT NULL,
    removed_at timestamp(6) without time zone,
    posted_at timestamp(6) without time zone,
    last_seen_at timestamp(6) without time zone,
    closed_at timestamp(6) without time zone,
    filled_at timestamp(6) without time zone,
    required_skills json,
    preferred_skills json,
    technologies json,
    years_experience_min integer,
    years_experience_max integer,
    requires_degree boolean DEFAULT false,
    degree_level character varying,
    urgency_score integer,
    new_role boolean,
    backfill boolean,
    strategic_significance text,
    competitor_similar_roles json,
    ai_summary text,
    keyword_analysis json,
    posting_frequency_score integer,
    market_insights text,
    raw_data json,
    scraping_source character varying,
    view_count integer DEFAULT 0,
    flagged_for_review boolean DEFAULT false,
    internal_notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: journey_emotions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_emotions (
    id bigint NOT NULL,
    score integer NOT NULL,
    description text NOT NULL,
    journey_stage_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    journey_map_id bigint
);


--
-- Name: journey_emotions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_emotions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_emotions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_emotions_id_seq OWNED BY public.journey_emotions.id;


--
-- Name: journey_map_persona_needs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_map_persona_needs (
    id bigint NOT NULL,
    description text NOT NULL,
    journey_map_persona_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: journey_map_persona_needs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_map_persona_needs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_map_persona_needs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_map_persona_needs_id_seq OWNED BY public.journey_map_persona_needs.id;


--
-- Name: journey_map_persona_pain_points; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_map_persona_pain_points (
    id bigint NOT NULL,
    description text NOT NULL,
    journey_map_persona_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: journey_map_persona_pain_points_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_map_persona_pain_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_map_persona_pain_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_map_persona_pain_points_id_seq OWNED BY public.journey_map_persona_pain_points.id;


--
-- Name: journey_map_personas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_map_personas (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    demographics text,
    journey_map_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    persona_id bigint
);


--
-- Name: journey_map_personas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_map_personas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_map_personas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_map_personas_id_seq OWNED BY public.journey_map_personas.id;


--
-- Name: journey_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_maps (
    id bigint NOT NULL,
    title character varying NOT NULL,
    description text,
    goal character varying,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    project_id bigint,
    agent_task_id bigint,
    deleted_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    persona_id bigint
);


--
-- Name: journey_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_maps_id_seq OWNED BY public.journey_maps.id;


--
-- Name: journey_opportunities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_opportunities (
    id bigint NOT NULL,
    description text NOT NULL,
    impact integer DEFAULT 1,
    potential_solution text,
    journey_stage_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: journey_opportunities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_opportunities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_opportunities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_opportunities_id_seq OWNED BY public.journey_opportunities.id;


--
-- Name: journey_stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_stages (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    "position" integer NOT NULL,
    journey_map_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: journey_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_stages_id_seq OWNED BY public.journey_stages.id;


--
-- Name: journey_thoughts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_thoughts (
    id bigint NOT NULL,
    content text NOT NULL,
    sentiment integer DEFAULT 1,
    is_quote boolean DEFAULT false,
    journey_stage_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: journey_thoughts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_thoughts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_thoughts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_thoughts_id_seq OWNED BY public.journey_thoughts.id;


--
-- Name: journey_touchpoints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey_touchpoints (
    id bigint NOT NULL,
    description text NOT NULL,
    channel integer DEFAULT 0,
    screenshot_url character varying,
    journey_stage_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: journey_touchpoints_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_touchpoints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_touchpoints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_touchpoints_id_seq OWNED BY public.journey_touchpoints.id;


--
-- Name: keyword_distances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_distances (
    id bigint NOT NULL,
    wrd_1 character varying,
    wrd_2 character varying,
    avg_distance integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: keyword_distances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_distances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_distances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_distances_id_seq OWNED BY public.keyword_distances.id;


--
-- Name: keyword_embeddings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_embeddings (
    id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    embedding double precision[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: keyword_embeddings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_embeddings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_embeddings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_embeddings_id_seq OWNED BY public.keyword_embeddings.id;


--
-- Name: keyword_followers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_followers (
    id bigint NOT NULL,
    delivery_method character varying,
    keyword_id bigint,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id integer
);


--
-- Name: keyword_followers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_followers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_followers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_followers_id_seq OWNED BY public.keyword_followers.id;


--
-- Name: keyword_group_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_group_items (
    id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    keyword_group_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: keyword_group_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_group_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_group_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_group_items_id_seq OWNED BY public.keyword_group_items.id;


--
-- Name: keyword_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_groups (
    id bigint NOT NULL,
    group_name character varying,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: keyword_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_groups_id_seq OWNED BY public.keyword_groups.id;


--
-- Name: keyword_quarentines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_quarentines (
    id bigint NOT NULL,
    aws_entity_type character varying,
    bare_word character varying,
    ignored boolean,
    language_code character varying,
    language_name character varying,
    rank integer,
    recurrence integer,
    synonyms text,
    used_as_hashtag boolean,
    word character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    ignore boolean DEFAULT false,
    token_count integer,
    person_id integer,
    url_count integer DEFAULT 0,
    last_enriched timestamp(6) without time zone,
    full_word_only boolean DEFAULT true,
    stemmed character varying,
    last_compacted_at timestamp(6) without time zone,
    ai_vetted boolean DEFAULT false
);


--
-- Name: keyword_quarentines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_quarentines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_quarentines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_quarentines_id_seq OWNED BY public.keyword_quarentines.id;


--
-- Name: keyword_recurrences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_recurrences (
    id bigint NOT NULL,
    count integer,
    company_id bigint,
    keyword_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: keyword_recurrences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_recurrences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_recurrences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_recurrences_id_seq OWNED BY public.keyword_recurrences.id;


--
-- Name: keyword_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_stats (
    id bigint NOT NULL,
    word character varying,
    account_id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    urls_count integer DEFAULT 0,
    url_ids text,
    companies_count integer DEFAULT 0,
    company_ids text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: keyword_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_stats_id_seq OWNED BY public.keyword_stats.id;


--
-- Name: keyword_trends; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_trends (
    id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: keyword_trends_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_trends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_trends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_trends_id_seq OWNED BY public.keyword_trends.id;


--
-- Name: keyword_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keyword_urls (
    id bigint NOT NULL,
    keyword_id bigint,
    url_id bigint,
    company_id bigint,
    aws_entity_type character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    keyword_quarentine_id bigint,
    excerpt text,
    cosine_similarity double precision
);


--
-- Name: keyword_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keyword_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keyword_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keyword_urls_id_seq OWNED BY public.keyword_urls.id;


--
-- Name: keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keywords (
    id bigint NOT NULL,
    aws_entity_type character varying,
    bare_word character varying,
    ignored boolean,
    language_code character varying,
    language_name character varying,
    rank integer,
    recurrence integer,
    synonyms text,
    used_as_hashtag boolean,
    word character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    ignore boolean DEFAULT false,
    token_count integer,
    person_id integer,
    url_count integer DEFAULT 0,
    last_enriched timestamp(6) without time zone,
    full_word_only boolean DEFAULT true,
    stemmed character varying,
    last_compacted_at timestamp(6) without time zone,
    ai_vetted boolean DEFAULT false
);


--
-- Name: keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keywords_id_seq OWNED BY public.keywords.id;


--
-- Name: lead_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lead_imports (
    id bigint NOT NULL,
    list_name character varying,
    description text,
    people_list_id integer,
    account_id integer,
    user_id integer,
    split boolean DEFAULT false,
    analyzed boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: lead_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lead_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lead_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lead_imports_id_seq OWNED BY public.lead_imports.id;


--
-- Name: leader_boards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leader_boards (
    id bigint NOT NULL,
    feature_id bigint NOT NULL,
    places json,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: leader_boards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leader_boards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leader_boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leader_boards_id_seq OWNED BY public.leader_boards.id;


--
-- Name: lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lines (
    id bigint NOT NULL,
    text character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    as_number numeric,
    md5 character varying,
    number_of_times_found integer DEFAULT 0,
    company_id integer
);


--
-- Name: lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lines_id_seq OWNED BY public.lines.id;


--
-- Name: link_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.link_maps (
    id bigint NOT NULL,
    company_id integer,
    graph json,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: link_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.link_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: link_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.link_maps_id_seq OWNED BY public.link_maps.id;


--
-- Name: links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.links (
    id bigint NOT NULL,
    source_url_id integer,
    target_url_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    anchor_text character varying,
    entity_type character varying
);


--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.links_id_seq OWNED BY public.links.id;


--
-- Name: login_activities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.login_activities (
    id bigint NOT NULL,
    scope character varying,
    strategy character varying,
    identity_ciphertext text,
    identity_bidx character varying,
    success boolean,
    failure_reason character varying,
    user_type character varying,
    user_id bigint,
    context character varying,
    ip_ciphertext text,
    ip_bidx character varying,
    user_agent text,
    referrer text,
    city character varying,
    region character varying,
    country character varying,
    latitude double precision,
    longitude double precision,
    created_at timestamp without time zone
);


--
-- Name: login_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.login_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: login_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.login_activities_id_seq OWNED BY public.login_activities.id;


--
-- Name: market_segments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.market_segments (
    id bigint NOT NULL,
    name character varying,
    description text,
    active boolean,
    market_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    body text,
    parent_id bigint,
    account_id bigint,
    tam numeric(15,2),
    sam numeric(15,2),
    som numeric(15,2),
    number_of_companies integer,
    average_company_size numeric(10,2),
    average_company_revenue numeric(15,2),
    growth_rate numeric(5,2),
    cagr numeric(5,2),
    market_penetration numeric(5,2),
    currency character varying DEFAULT 'USD'::character varying,
    data_year integer,
    data_source character varying
);


--
-- Name: COLUMN market_segments.tam; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.tam IS 'Total Addressable Market';


--
-- Name: COLUMN market_segments.sam; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.sam IS 'Serviceable Addressable Market';


--
-- Name: COLUMN market_segments.som; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.som IS 'Serviceable Obtainable Market';


--
-- Name: COLUMN market_segments.number_of_companies; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.number_of_companies IS 'Number of companies in this market segment';


--
-- Name: COLUMN market_segments.average_company_size; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.average_company_size IS 'Average company size (employees)';


--
-- Name: COLUMN market_segments.average_company_revenue; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.average_company_revenue IS 'Average company revenue';


--
-- Name: COLUMN market_segments.growth_rate; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.growth_rate IS 'Market growth rate (%)';


--
-- Name: COLUMN market_segments.cagr; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.cagr IS 'Compound Annual Growth Rate (%)';


--
-- Name: COLUMN market_segments.market_penetration; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.market_penetration IS 'Market penetration (%)';


--
-- Name: COLUMN market_segments.currency; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.currency IS 'Currency for financial values';


--
-- Name: COLUMN market_segments.data_year; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.data_year IS 'Year of the financial data';


--
-- Name: COLUMN market_segments.data_source; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.market_segments.data_source IS 'Source of the financial data';


--
-- Name: market_segments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.market_segments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: market_segments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.market_segments_id_seq OWNED BY public.market_segments.id;


--
-- Name: markets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.markets (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint,
    archived_at timestamp(6) without time zone
);


--
-- Name: markets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.markets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: markets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.markets_id_seq OWNED BY public.markets.id;


--
-- Name: meta_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meta_tags (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    tag_type character varying,
    tag_content text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id bigint
);


--
-- Name: meta_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meta_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meta_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meta_tags_id_seq OWNED BY public.meta_tags.id;


--
-- Name: mini_help_views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mini_help_views (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    dismissed boolean,
    mini_help_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: mini_help_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mini_help_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mini_help_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mini_help_views_id_seq OWNED BY public.mini_help_views.id;


--
-- Name: mini_helps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mini_helps (
    id bigint NOT NULL,
    controller character varying,
    action character varying,
    description text,
    title text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: mini_helps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mini_helps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mini_helps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mini_helps_id_seq OWNED BY public.mini_helps.id;


--
-- Name: negative_keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.negative_keywords (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    word character varying
);


--
-- Name: negative_keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.negative_keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: negative_keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.negative_keywords_id_seq OWNED BY public.negative_keywords.id;


--
-- Name: newsletter_issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.newsletter_issues (
    id bigint NOT NULL,
    subject character varying,
    body text,
    status integer,
    delivery_date timestamp(6) without time zone,
    newsletter_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    brief text,
    prompt character varying,
    user_id integer,
    slug character varying
);


--
-- Name: newsletter_issues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.newsletter_issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: newsletter_issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.newsletter_issues_id_seq OWNED BY public.newsletter_issues.id;


--
-- Name: newsletter_subscribers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.newsletter_subscribers (
    id bigint NOT NULL,
    email character varying,
    name character varying,
    newsletter_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: newsletter_subscribers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.newsletter_subscribers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: newsletter_subscribers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.newsletter_subscribers_id_seq OWNED BY public.newsletter_subscribers.id;


--
-- Name: newsletters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.newsletters (
    id bigint NOT NULL,
    name character varying,
    description text,
    status integer,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    public boolean DEFAULT false,
    slug character varying
);


--
-- Name: newsletters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.newsletters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: newsletters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.newsletters_id_seq OWNED BY public.newsletters.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    body text,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    person_id bigint,
    people_list_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: noticed_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.noticed_events (
    id bigint NOT NULL,
    type character varying,
    record_type character varying,
    record_id bigint,
    params jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    notifications_count integer,
    account_id bigint
);


--
-- Name: noticed_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.noticed_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: noticed_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.noticed_events_id_seq OWNED BY public.noticed_events.id;


--
-- Name: noticed_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.noticed_notifications (
    id bigint NOT NULL,
    type character varying,
    event_id bigint NOT NULL,
    recipient_type character varying NOT NULL,
    recipient_id bigint NOT NULL,
    read_at timestamp without time zone,
    seen_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint
);


--
-- Name: noticed_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.noticed_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: noticed_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.noticed_notifications_id_seq OWNED BY public.noticed_notifications.id;


--
-- Name: notification_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_tokens (
    id bigint NOT NULL,
    user_id bigint,
    token character varying NOT NULL,
    platform character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: notification_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notification_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_tokens_id_seq OWNED BY public.notification_tokens.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    recipient_type character varying NOT NULL,
    recipient_id bigint NOT NULL,
    type character varying,
    params jsonb,
    read_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    interacted_at timestamp without time zone
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_access_tokens (
    id bigint NOT NULL,
    resource_owner_id integer,
    application_id integer,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying
);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_access_tokens_id_seq OWNED BY public.oauth_access_tokens.id;


--
-- Name: open_ai_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.open_ai_batches (
    id bigint NOT NULL,
    input_file_id character varying,
    output_file_id character varying,
    user_id integer,
    account_id integer,
    batch_id character varying,
    "for" character varying,
    checked integer,
    processed boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    object_type character varying,
    object_id integer,
    action character varying
);


--
-- Name: open_ai_batches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.open_ai_batches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: open_ai_batches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.open_ai_batches_id_seq OWNED BY public.open_ai_batches.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    name character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    enabled_topic_dashboards character varying,
    domains character varying,
    open_ai_token character varying
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: outgoing_tweets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.outgoing_tweets (
    id bigint NOT NULL,
    tweet character varying,
    status integer,
    publish_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: outgoing_tweets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.outgoing_tweets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: outgoing_tweets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.outgoing_tweets_id_seq OWNED BY public.outgoing_tweets.id;


--
-- Name: page_cleanups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page_cleanups (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    path character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: page_cleanups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_cleanups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_cleanups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_cleanups_id_seq OWNED BY public.page_cleanups.id;


--
-- Name: partial_caches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partial_caches (
    id bigint NOT NULL,
    key character varying,
    data text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: partial_caches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.partial_caches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: partial_caches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.partial_caches_id_seq OWNED BY public.partial_caches.id;


--
-- Name: pay_charges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_charges (
    id bigint NOT NULL,
    processor_id character varying NOT NULL,
    amount integer NOT NULL,
    amount_refunded integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    data jsonb,
    application_fee_amount integer,
    currency character varying,
    metadata jsonb,
    subscription_id integer,
    customer_id bigint,
    stripe_account character varying,
    type character varying
);


--
-- Name: pay_charges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_charges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_charges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_charges_id_seq OWNED BY public.pay_charges.id;


--
-- Name: pay_customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_customers (
    id bigint NOT NULL,
    owner_type character varying,
    owner_id bigint,
    processor character varying,
    processor_id character varying,
    "default" boolean,
    data jsonb,
    deleted_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    stripe_account character varying,
    type character varying
);


--
-- Name: pay_customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_customers_id_seq OWNED BY public.pay_customers.id;


--
-- Name: pay_merchants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_merchants (
    id bigint NOT NULL,
    owner_type character varying,
    owner_id bigint,
    processor character varying,
    processor_id character varying,
    "default" boolean,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    type character varying
);


--
-- Name: pay_merchants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_merchants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_merchants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_merchants_id_seq OWNED BY public.pay_merchants.id;


--
-- Name: pay_payment_methods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_payment_methods (
    id bigint NOT NULL,
    customer_id bigint,
    processor_id character varying,
    "default" boolean,
    payment_method_type character varying,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    stripe_account character varying,
    type character varying
);


--
-- Name: pay_payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_payment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_payment_methods_id_seq OWNED BY public.pay_payment_methods.id;


--
-- Name: pay_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_subscriptions (
    id integer NOT NULL,
    name character varying NOT NULL,
    processor_id character varying NOT NULL,
    processor_plan character varying NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    trial_ends_at timestamp without time zone,
    ends_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    status character varying,
    data jsonb,
    application_fee_percent numeric(8,2),
    metadata jsonb,
    customer_id bigint,
    current_period_start timestamp(6) without time zone,
    current_period_end timestamp(6) without time zone,
    metered boolean,
    pause_behavior character varying,
    pause_starts_at timestamp(6) without time zone,
    pause_resumes_at timestamp(6) without time zone,
    payment_method_id character varying,
    stripe_account character varying,
    type character varying
);


--
-- Name: pay_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_subscriptions_id_seq OWNED BY public.pay_subscriptions.id;


--
-- Name: pay_webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pay_webhooks (
    id bigint NOT NULL,
    processor character varying,
    event_type character varying,
    event jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pay_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pay_webhooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pay_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pay_webhooks_id_seq OWNED BY public.pay_webhooks.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people (
    id bigint NOT NULL,
    name character varying,
    company_id bigint,
    account_id bigint,
    keyword_id bigint,
    linkedin_data character varying,
    headline character varying,
    linkedin_profile_url character varying,
    twitter_handle character varying,
    facebook_profile_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tried_to_get_linkedin_data boolean DEFAULT false,
    searched_for_social_media boolean DEFAULT false,
    management boolean DEFAULT false,
    enriched_at timestamp(6) without time zone,
    url_count integer,
    slug character varying,
    title character varying,
    source character varying,
    intercom_id character varying,
    intercom_workspace character varying,
    email character varying,
    intercom_data text,
    google_scholar_id character varying,
    researchgate_url character varying,
    justia_url character varying,
    country character varying,
    openai_vetted boolean DEFAULT false,
    city character varying,
    address character varying,
    postal_code character varying,
    phone character varying,
    embedding public.vector(1536),
    profile_image_attached boolean DEFAULT false,
    department character varying,
    years_with_the_company integer DEFAULT '-1'::integer,
    degree character varying,
    university character varying
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- Name: people_lists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people_lists (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    name character varying,
    description text,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    titles character varying,
    countries character varying,
    sectors character varying,
    search_keywords text,
    embedding public.vector(1536),
    quality_score double precision DEFAULT 0.0
);


--
-- Name: people_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_lists_id_seq OWNED BY public.people_lists.id;


--
-- Name: person_account_information; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_account_information (
    id bigint NOT NULL,
    data text,
    person_id bigint NOT NULL,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: person_account_information_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_account_information_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_account_information_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_account_information_id_seq OWNED BY public.person_account_information.id;


--
-- Name: person_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_accounts (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: person_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_accounts_id_seq OWNED BY public.person_accounts.id;


--
-- Name: person_followers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_followers (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    person_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: person_followers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_followers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_followers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_followers_id_seq OWNED BY public.person_followers.id;


--
-- Name: person_searches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_searches (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    data text,
    links text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    search_phrase character varying
);


--
-- Name: person_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_searches_id_seq OWNED BY public.person_searches.id;


--
-- Name: person_skills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_skills (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    skill_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: person_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_skills_id_seq OWNED BY public.person_skills.id;


--
-- Name: person_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_subscriptions (
    id bigint NOT NULL,
    people_list_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    person_id integer
);


--
-- Name: person_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_subscriptions_id_seq OWNED BY public.person_subscriptions.id;


--
-- Name: person_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_urls (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    url_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: person_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_urls_id_seq OWNED BY public.person_urls.id;


--
-- Name: persona_group_memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.persona_group_memberships (
    id bigint NOT NULL,
    persona_group_id bigint NOT NULL,
    persona_id bigint NOT NULL,
    role_type character varying NOT NULL,
    influence_level integer,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: persona_group_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.persona_group_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: persona_group_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.persona_group_memberships_id_seq OWNED BY public.persona_group_memberships.id;


--
-- Name: persona_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.persona_groups (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    industry character varying,
    market_segment character varying,
    organization_size character varying,
    additional_attributes jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: persona_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.persona_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: persona_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.persona_groups_id_seq OWNED BY public.persona_groups.id;


--
-- Name: persona_product_blueprint_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.persona_product_blueprint_modules (
    id bigint NOT NULL,
    persona_id bigint NOT NULL,
    product_blueprint_module_id bigint NOT NULL,
    relationship_type character varying DEFAULT 'primary'::character varying,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: persona_product_blueprint_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.persona_product_blueprint_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: persona_product_blueprint_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.persona_product_blueprint_modules_id_seq OWNED BY public.persona_product_blueprint_modules.id;


--
-- Name: persona_user_stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.persona_user_stories (
    id bigint NOT NULL,
    persona_id bigint NOT NULL,
    user_story_id bigint NOT NULL,
    relationship_type character varying DEFAULT 'primary'::character varying,
    relationship_notes text,
    impact_level integer DEFAULT 5,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: persona_user_stories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.persona_user_stories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: persona_user_stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.persona_user_stories_id_seq OWNED BY public.persona_user_stories.id;


--
-- Name: personas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personas (
    id bigint NOT NULL,
    name character varying,
    description text,
    age integer,
    education text,
    title character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    data json,
    account_id bigint NOT NULL,
    gender character varying,
    location character varying,
    income_range character varying,
    goals text[] DEFAULT '{}'::text[],
    pain_points text[] DEFAULT '{}'::text[],
    motivations text[] DEFAULT '{}'::text[],
    frustrations text[] DEFAULT '{}'::text[],
    tech_comfort_level character varying,
    preferred_devices text[] DEFAULT '{}'::text[],
    preferred_channels text[] DEFAULT '{}'::text[],
    usage_frequency character varying,
    user_segment character varying,
    journey_stage character varying,
    influencers text[] DEFAULT '{}'::text[],
    quote text,
    day_in_life text,
    avatar_url character varying,
    scenario_examples text[] DEFAULT '{}'::text[],
    primary_goal text,
    created_by character varying,
    last_updated timestamp without time zone,
    data_sources text[] DEFAULT '{}'::text[],
    validation_method character varying,
    industry character varying,
    information_sources jsonb DEFAULT '{}'::jsonb
);


--
-- Name: personas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personas_id_seq OWNED BY public.personas.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pg_search_documents (
    id bigint NOT NULL,
    content text,
    searchable_type character varying,
    searchable_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pg_search_documents_id_seq OWNED BY public.pg_search_documents.id;


--
-- Name: pghero_query_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pghero_query_stats (
    id bigint NOT NULL,
    database text,
    "user" text,
    query text,
    query_hash bigint,
    total_time double precision,
    calls bigint,
    captured_at timestamp without time zone
);


--
-- Name: pghero_query_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pghero_query_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pghero_query_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pghero_query_stats_id_seq OWNED BY public.pghero_query_stats.id;


--
-- Name: plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plans (
    id bigint NOT NULL,
    name character varying NOT NULL,
    amount integer DEFAULT 0 NOT NULL,
    "interval" character varying NOT NULL,
    details jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    trial_period_days integer DEFAULT 0,
    hidden boolean,
    currency character varying,
    interval_count integer DEFAULT 1,
    description character varying,
    unit_label character varying,
    charge_per_unit boolean,
    stripe_id character varying,
    braintree_id character varying,
    paddle_billing_id character varying,
    paddle_classic_id character varying,
    lemon_squeezy_id character varying,
    fake_processor_id character varying,
    contact_url character varying
);


--
-- Name: plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plans_id_seq OWNED BY public.plans.id;


--
-- Name: pm_roi_calculations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pm_roi_calculations (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    feature_id bigint,
    product_id bigint,
    project_id bigint,
    feature_name character varying NOT NULL,
    segment_size integer NOT NULL,
    expected_lift numeric(8,2) NOT NULL,
    development_cost numeric(12,2) NOT NULL,
    roi_percentage numeric(8,2) NOT NULL,
    confidence_level character varying NOT NULL,
    risk_level character varying,
    business_case text,
    assumptions text,
    risks text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    ai_agent_task_id bigint NOT NULL,
    user_story_id bigint,
    market_segment_id bigint,
    arpu numeric(10,2) DEFAULT 0.0,
    roi_type character varying DEFAULT 'arr'::character varying,
    existing_customers integer DEFAULT 0,
    upgrade_delta numeric(10,2) DEFAULT 0.0,
    churn_reduction numeric(8,2) DEFAULT 0.0,
    incidents_avoided integer DEFAULT 0,
    cost_per_incident numeric(10,2) DEFAULT 0.0,
    engagement_lift numeric(8,2) DEFAULT 0.0,
    arpu_uplift numeric(10,2) DEFAULT 0.0,
    development_days integer DEFAULT 30 NOT NULL,
    cost_per_day numeric(10,2) DEFAULT 1000.0 NOT NULL
);


--
-- Name: pm_roi_calculations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pm_roi_calculations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pm_roi_calculations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pm_roi_calculations_id_seq OWNED BY public.pm_roi_calculations.id;


--
-- Name: product_blueprint_associations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_blueprint_associations (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_blueprint_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: product_blueprint_associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_blueprint_associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_blueprint_associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_blueprint_associations_id_seq OWNED BY public.product_blueprint_associations.id;


--
-- Name: product_blueprint_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_blueprint_modules (
    id bigint NOT NULL,
    name character varying,
    description text,
    product_blueprint_id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: product_blueprint_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_blueprint_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_blueprint_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_blueprint_modules_id_seq OWNED BY public.product_blueprint_modules.id;


--
-- Name: product_blueprints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_blueprints (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint DEFAULT 2,
    manager_id bigint
);


--
-- Name: product_blueprints_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_blueprints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_blueprints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_blueprints_id_seq OWNED BY public.product_blueprints.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_categories (
    id bigint NOT NULL,
    name character varying,
    description text,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_categories_id_seq OWNED BY public.product_categories.id;


--
-- Name: product_features; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_features (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    feature_id bigint NOT NULL,
    score integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    current_harvey_ball_score integer DEFAULT 0,
    last_analyzed_at timestamp(6) without time zone,
    trend_direction character varying,
    momentum_score numeric(5,2)
);


--
-- Name: product_features_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_features_id_seq OWNED BY public.product_features.id;


--
-- Name: product_owners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_owners (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: product_owners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_owners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_owners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_owners_id_seq OWNED BY public.product_owners.id;


--
-- Name: product_personas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_personas (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    persona_id bigint NOT NULL,
    main_persona boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: product_personas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_personas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_personas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_personas_id_seq OWNED BY public.product_personas.id;


--
-- Name: product_screenshots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_screenshots (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    image character varying,
    caption character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    url_id integer,
    filename character varying,
    feature_id integer,
    ai_vetted boolean DEFAULT false,
    ai_checked boolean DEFAULT false,
    deleted_at timestamp(6) without time zone,
    user_story text,
    ux_analysis text,
    url_string character varying
);


--
-- Name: product_screenshots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_screenshots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_screenshots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_screenshots_id_seq OWNED BY public.product_screenshots.id;


--
-- Name: product_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_urls (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    url_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: product_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_urls_id_seq OWNED BY public.product_urls.id;


--
-- Name: product_videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_videos (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    url_id bigint NOT NULL,
    embed_code character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    title character varying,
    description text,
    video_url character varying,
    event_id bigint,
    account_id bigint NOT NULL,
    deleted_at timestamp(6) without time zone
);


--
-- Name: product_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_videos_id_seq OWNED BY public.product_videos.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying,
    user_id bigint NOT NULL,
    company_id bigint NOT NULL,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    url character varying,
    account_id bigint,
    release_notes_url character varying,
    deleted_at timestamp(6) without time zone,
    brief text,
    tagline character varying
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: project_data_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_data_items (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    ai_agent_task_id bigint,
    content text,
    item_type character varying,
    item_id bigint,
    status character varying,
    approved boolean,
    approved_by integer,
    approved_at timestamp(6) without time zone,
    rejection_reason text,
    confidence_score numeric,
    relevance_score numeric,
    metadata jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    uri character varying,
    title character varying
);


--
-- Name: project_data_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_data_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_data_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_data_items_id_seq OWNED BY public.project_data_items.id;


--
-- Name: project_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_sections (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    title character varying,
    body jsonb,
    agent_task_id bigint,
    output jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    output_type character varying DEFAULT 'text'::character varying NOT NULL,
    input_data jsonb
);


--
-- Name: project_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_sections_id_seq OWNED BY public.project_sections.id;


--
-- Name: project_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_sources (
    id bigint NOT NULL,
    name character varying,
    source_type character varying,
    project_id bigint NOT NULL,
    sourceable_type character varying NOT NULL,
    sourceable_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: project_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_sources_id_seq OWNED BY public.project_sources.id;


--
-- Name: project_topic_dashboard_briefs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_topic_dashboard_briefs (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    topic_dashboard_id bigint NOT NULL,
    data_set_id bigint NOT NULL,
    project_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: project_topic_dashboard_briefs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_topic_dashboard_briefs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_topic_dashboard_briefs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_topic_dashboard_briefs_id_seq OWNED BY public.project_topic_dashboard_briefs.id;


--
-- Name: project_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_urls (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    url_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: project_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_urls_id_seq OWNED BY public.project_urls.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    name character varying,
    description text,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    data_set_id integer,
    project_data_items_count integer DEFAULT 0,
    approved_data_items_count integer DEFAULT 0,
    ai_agent_tasks_count integer DEFAULT 0,
    scheduled_agent_tasks_count integer DEFAULT 0,
    pending_data_items_count integer DEFAULT 0,
    rejected_data_items_count integer DEFAULT 0,
    vector_store_id character varying,
    plc_stage character varying,
    launch_date date
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: raw_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.raw_data (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    data text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: raw_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.raw_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: raw_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.raw_data_id_seq OWNED BY public.raw_data.id;


--
-- Name: report_elements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.report_elements (
    id bigint NOT NULL,
    report_id bigint NOT NULL,
    report_template_id bigint NOT NULL,
    header character varying,
    body text,
    type character varying,
    params json,
    data json,
    prompt text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: report_elements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.report_elements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: report_elements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.report_elements_id_seq OWNED BY public.report_elements.id;


--
-- Name: report_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.report_templates (
    id bigint NOT NULL,
    title character varying,
    description text,
    period character varying,
    account_id bigint NOT NULL,
    layout json,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: report_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.report_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: report_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.report_templates_id_seq OWNED BY public.report_templates.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reports (
    id bigint NOT NULL,
    title character varying,
    body text,
    author character varying,
    dataset_id integer,
    account_id integer,
    user_id integer,
    keyword_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer,
    project_id bigint
);


--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: scrape_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scrape_runs (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    urls_count integer,
    scrape_type integer
);


--
-- Name: scrape_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scrape_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scrape_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scrape_runs_id_seq OWNED BY public.scrape_runs.id;


--
-- Name: section_blocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.section_blocks (
    id bigint NOT NULL,
    template_section_id bigint NOT NULL,
    block_type character varying NOT NULL,
    "position" integer NOT NULL,
    content_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    layout_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    ai_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: section_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.section_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: section_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.section_blocks_id_seq OWNED BY public.section_blocks.id;


--
-- Name: service_calls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_calls (
    id bigint NOT NULL,
    service_name character varying,
    call_name character varying,
    account_id integer,
    company_id integer,
    payload text,
    url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: service_calls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.service_calls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: service_calls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.service_calls_id_seq OWNED BY public.service_calls.id;


--
-- Name: similar_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.similar_urls (
    id bigint NOT NULL,
    source_url_id integer,
    target_url_id integer,
    score double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    target_company_id integer
);


--
-- Name: similar_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.similar_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: similar_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.similar_urls_id_seq OWNED BY public.similar_urls.id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skills (
    id bigint NOT NULL,
    name character varying,
    category character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- Name: smart_report_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smart_report_sections (
    id bigint NOT NULL,
    smart_report_version_id bigint NOT NULL,
    company_id bigint NOT NULL,
    content text,
    "position" integer,
    status character varying,
    last_edited_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: smart_report_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.smart_report_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: smart_report_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.smart_report_sections_id_seq OWNED BY public.smart_report_sections.id;


--
-- Name: smart_report_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smart_report_versions (
    id bigint NOT NULL,
    smart_report_id bigint NOT NULL,
    version_number integer NOT NULL,
    changelog text,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: smart_report_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.smart_report_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: smart_report_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.smart_report_versions_id_seq OWNED BY public.smart_report_versions.id;


--
-- Name: smart_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smart_reports (
    id bigint NOT NULL,
    title character varying,
    description text,
    topic_dashboard_id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    timeframe_start date,
    timeframe_end date,
    auto_update boolean DEFAULT false,
    last_auto_update_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: smart_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.smart_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: smart_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.smart_reports_id_seq OWNED BY public.smart_reports.id;


--
-- Name: snapshots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    urls_captured text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status integer
);


--
-- Name: snapshots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.snapshots_id_seq OWNED BY public.snapshots.id;


--
-- Name: suggested_actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggested_actions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    url_id bigint NOT NULL,
    title character varying,
    description text,
    sent_at timestamp(6) without time zone,
    marked_as_done timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    good_suggestion boolean DEFAULT false,
    bad_suggestion boolean DEFAULT false,
    bad_suggestion_feedback character varying,
    account_id integer
);


--
-- Name: suggested_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.suggested_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suggested_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.suggested_actions_id_seq OWNED BY public.suggested_actions.id;


--
-- Name: suggested_companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggested_companies (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    name character varying,
    url character varying,
    description text,
    source character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    following boolean DEFAULT false,
    emailed_at timestamp(6) without time zone,
    deleted_at timestamp(6) without time zone,
    archived boolean DEFAULT false
);


--
-- Name: suggested_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.suggested_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suggested_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.suggested_companies_id_seq OWNED BY public.suggested_companies.id;


--
-- Name: template_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.template_sections (
    id bigint NOT NULL,
    document_template_id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    section_type character varying DEFAULT 'content'::character varying NOT NULL,
    "position" integer NOT NULL,
    required boolean DEFAULT false NOT NULL,
    layout_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    conditional_logic jsonb DEFAULT '{}'::jsonb NOT NULL,
    section_blocks_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: template_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.template_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: template_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.template_sections_id_seq OWNED BY public.template_sections.id;


--
-- Name: template_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.template_versions (
    id bigint NOT NULL,
    template_id bigint NOT NULL,
    version_number integer,
    template_data jsonb,
    comment text,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: template_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.template_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: template_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.template_versions_id_seq OWNED BY public.template_versions.id;


--
-- Name: topic_dashboard_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_dashboard_notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    topic_dashboard_id bigint NOT NULL,
    frequency_in_days integer DEFAULT '-1'::integer,
    notification_channel character varying DEFAULT 'email'::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: topic_dashboard_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topic_dashboard_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_dashboard_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topic_dashboard_notifications_id_seq OWNED BY public.topic_dashboard_notifications.id;


--
-- Name: topic_dashboard_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_dashboard_urls (
    id bigint NOT NULL,
    topic_dashboard_id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    url_id bigint NOT NULL,
    context_check boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: topic_dashboard_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topic_dashboard_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_dashboard_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topic_dashboard_urls_id_seq OWNED BY public.topic_dashboard_urls.id;


--
-- Name: topic_dashboards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_dashboards (
    id bigint NOT NULL,
    name character varying,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    negative_keywords text,
    template_id integer,
    keywords_string character varying,
    paused boolean DEFAULT false
);


--
-- Name: topic_dashboards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topic_dashboards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_dashboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topic_dashboards_id_seq OWNED BY public.topic_dashboards.id;


--
-- Name: topic_followers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_followers (
    id bigint NOT NULL,
    topic_id bigint,
    user_id bigint,
    delivery_method character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: topic_followers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topic_followers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_followers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topic_followers_id_seq OWNED BY public.topic_followers.id;


--
-- Name: topic_keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_keywords (
    id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    topic_dashboard_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: topic_keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topic_keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topic_keywords_id_seq OWNED BY public.topic_keywords.id;


--
-- Name: topic_recurrences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_recurrences (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    topic_id bigint,
    count integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: topic_recurrences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topic_recurrences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_recurrences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topic_recurrences_id_seq OWNED BY public.topic_recurrences.id;


--
-- Name: topic_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_templates (
    id bigint NOT NULL,
    name character varying,
    words character varying,
    organization_id bigint,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: topic_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topic_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topic_templates_id_seq OWNED BY public.topic_templates.id;


--
-- Name: topic_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_urls (
    id bigint NOT NULL,
    topic_id bigint NOT NULL,
    url_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id bigint,
    aws_entity_type character varying
);


--
-- Name: topic_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topic_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topic_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topic_urls_id_seq OWNED BY public.topic_urls.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topics (
    id bigint NOT NULL,
    word character varying,
    recurrence integer,
    rank integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    aws_entity_type character varying,
    ignored boolean DEFAULT false,
    bare_word character varying,
    synonym_id integer,
    language_name character varying,
    language_code character varying,
    used_as_hashtag boolean DEFAULT false,
    used_as_twitter_at boolean DEFAULT false,
    synonyms text
);


--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- Name: transcripts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transcripts (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    transcript text,
    youtube_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: transcripts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transcripts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transcripts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transcripts_id_seq OWNED BY public.transcripts.id;


--
-- Name: tweep_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tweep_urls (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    tweep_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: tweep_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tweep_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tweep_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tweep_urls_id_seq OWNED BY public.tweep_urls.id;


--
-- Name: tweeps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tweeps (
    id bigint NOT NULL,
    handle character varying,
    description text,
    followers_count integer,
    friends_count integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_data text
);


--
-- Name: tweeps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tweeps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tweeps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tweeps_id_seq OWNED BY public.tweeps.id;


--
-- Name: twitter_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.twitter_accounts (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    active_scrape boolean,
    handle character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: twitter_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.twitter_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: twitter_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.twitter_accounts_id_seq OWNED BY public.twitter_accounts.id;


--
-- Name: url_collection_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_collection_items (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    url_collection_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tldr text
);


--
-- Name: url_collection_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_collection_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_collection_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_collection_items_id_seq OWNED BY public.url_collection_items.id;


--
-- Name: url_collections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_collections (
    id bigint NOT NULL,
    name character varying,
    description text,
    user_id bigint,
    account_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: url_collections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_collections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_collections_id_seq OWNED BY public.url_collections.id;


--
-- Name: url_docs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_docs (
    id bigint NOT NULL,
    document text,
    url_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: url_docs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_docs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_docs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_docs_id_seq OWNED BY public.url_docs.id;


--
-- Name: url_embeddings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_embeddings (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    embedding double precision[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: url_embeddings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_embeddings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_embeddings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_embeddings_id_seq OWNED BY public.url_embeddings.id;


--
-- Name: url_fingerprints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_fingerprints (
    id bigint NOT NULL,
    location character varying NOT NULL,
    company_id bigint NOT NULL,
    archived boolean DEFAULT false,
    first_seen_at timestamp(6) without time zone NOT NULL,
    last_seen_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: url_fingerprints_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_fingerprints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_fingerprints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_fingerprints_id_seq OWNED BY public.url_fingerprints.id;


--
-- Name: url_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_images (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    image_url character varying,
    image_alt text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: url_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_images_id_seq OWNED BY public.url_images.id;


--
-- Name: url_searches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_searches (
    id bigint NOT NULL,
    title character varying,
    brief text,
    url_id integer,
    company_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS ((setweight(to_tsvector('english'::regconfig, (COALESCE(title, ''::character varying))::text), 'A'::"char") || setweight(to_tsvector('english'::regconfig, COALESCE(brief, ''::text)), 'B'::"char"))) STORED,
    account_id integer,
    location character varying
);


--
-- Name: url_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_searches_id_seq OWNED BY public.url_searches.id;


--
-- Name: url_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_stats (
    id bigint NOT NULL,
    url_id bigint NOT NULL,
    company_id bigint NOT NULL,
    month integer,
    year integer,
    views integer DEFAULT 0,
    likes integer DEFAULT 0,
    favorites integer DEFAULT 0,
    comments integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: url_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_stats_id_seq OWNED BY public.url_stats.id;


--
-- Name: url_watches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.url_watches (
    id bigint NOT NULL,
    url_id integer,
    account_id integer,
    user_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_id integer,
    thumbs_up boolean,
    thumbs_down boolean
);


--
-- Name: url_watches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.url_watches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: url_watches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.url_watches_id_seq OWNED BY public.url_watches.id;


--
-- Name: urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.urls (
    id bigint NOT NULL,
    location character varying,
    title character varying,
    fetched_at timestamp without time zone,
    document text,
    ignore boolean DEFAULT false,
    company_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    captured_at timestamp without time zone,
    last_modified timestamp without time zone,
    scrape_count integer,
    checksum text,
    body text,
    root boolean,
    relative_path text,
    depth integer,
    scan_frequency integer,
    blog boolean,
    carrer boolean,
    news boolean,
    product boolean,
    company boolean,
    person boolean,
    status integer,
    parent_url character varying,
    meta_author character varying,
    meta_description text,
    meta_keywords character varying,
    meta_robots character varying,
    meta_language character varying,
    meta_date character varying,
    meta_abstract text,
    keywords_count integer,
    redirects character varying,
    page_type public.page_types,
    estimated_published_at date,
    change_count integer,
    external boolean,
    display_on_feed boolean,
    language character varying,
    tweet_id character varying,
    special_words text,
    brief text,
    watch boolean,
    rss boolean,
    scrape_run_id integer,
    career boolean DEFAULT false,
    thumbnail character varying,
    tweet_target_url_id integer,
    brief_with_structure text,
    tldr text,
    grade integer DEFAULT 0,
    qs character varying,
    graded_at timestamp(6) without time zone,
    untranslated_brief text,
    untranslated_language_code character varying,
    translated_at timestamp(6) without time zone,
    ignore_reason character varying,
    sitemap boolean DEFAULT false,
    requires_js_scraping boolean DEFAULT false,
    scraped_at timestamp(6) without time zone,
    keywords_parsed_at timestamp(6) without time zone,
    number_of_times_scraped integer DEFAULT 0,
    pinecone_indexed_at timestamp(6) without time zone,
    bare_brief text,
    anchor_text character varying,
    favorite_count integer DEFAULT 0,
    twitter_retweet_count integer DEFAULT 0,
    twitter_quote_count integer DEFAULT 0,
    view_count integer DEFAULT 0,
    link_count integer DEFAULT 0,
    person_id integer,
    people_captured_at timestamp(6) without time zone,
    people_mentioned integer,
    stemmed text,
    reset_count integer,
    source character varying,
    event_id integer,
    checked_for_events boolean DEFAULT false,
    topic character varying,
    date_checked boolean DEFAULT false,
    product_id bigint,
    requires_proxy boolean DEFAULT false,
    like_count integer,
    comment_count integer,
    openai_processed boolean DEFAULT false,
    normalized_url character varying,
    reviewed character varying,
    relevance_score integer,
    rationale text,
    feature_id integer,
    brief_hash character varying,
    subdomain character varying,
    graded boolean DEFAULT false,
    content_updated_at timestamp(6) without time zone,
    original_publish_date date,
    page_importance integer DEFAULT 1,
    linkedin_update_id character varying
);


--
-- Name: urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.urls_id_seq OWNED BY public.urls.id;


--
-- Name: user_stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_stories (
    id bigint NOT NULL,
    title character varying,
    description text,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    acceptance_criteria json,
    epic character varying,
    user_type character varying,
    functionality text,
    benefit text,
    priority character varying,
    priority_rationale text,
    story_points integer,
    dependencies json,
    definition_of_done json,
    edge_cases json,
    status character varying DEFAULT 'draft'::character varying,
    epic_id bigint,
    "position" integer,
    story_statement text,
    user_type_fallback character varying,
    task_id bigint,
    archived_at timestamp(6) without time zone,
    market_segment_id bigint,
    feature_id bigint,
    implementation_steps jsonb DEFAULT '[]'::jsonb,
    backend_estimate integer DEFAULT 0,
    frontend_estimate integer DEFAULT 0,
    testing_estimate integer DEFAULT 0,
    integration_estimate integer DEFAULT 0,
    total_estimate integer DEFAULT 0,
    risk_level character varying,
    technical_dependencies text,
    implementation_notes text
);


--
-- Name: user_stories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_stories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_stories_id_seq OWNED BY public.user_stories.id;


--
-- Name: user_views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_views (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    company_id bigint NOT NULL,
    view_urls_array text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: user_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_views_id_seq OWNED BY public.user_views.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    first_name character varying,
    last_name character varying,
    time_zone character varying,
    accepted_terms_at timestamp without time zone,
    accepted_privacy_at timestamp without time zone,
    announcements_read_at timestamp without time zone,
    admin boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id bigint,
    invitations_count integer DEFAULT 0,
    preferred_language character varying,
    otp_required_for_login boolean,
    otp_secret character varying,
    last_otp_timestep integer,
    otp_backup_codes text,
    weekly_update_email_subscribed boolean DEFAULT true,
    organization_id integer,
    preferences jsonb,
    name character varying GENERATED ALWAYS AS ((((first_name)::text || ' '::text) || (last_name)::text)) STORED,
    linkedin_profile_url character varying,
    person_id integer,
    job_title character varying,
    current_company_id integer,
    default_account_id integer,
    current_url character varying,
    current_url_title character varying,
    current_url_additional_info character varying,
    onboarded boolean DEFAULT false
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vector_stores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vector_stores (
    id bigint NOT NULL,
    owner_type character varying NOT NULL,
    owner_id bigint NOT NULL,
    openai_id character varying NOT NULL,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: vector_stores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vector_stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vector_stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vector_stores_id_seq OWNED BY public.vector_stores.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id bigint NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object text,
    created_at timestamp without time zone,
    object_changes text
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.videos (
    id bigint NOT NULL,
    title character varying NOT NULL,
    for_page character varying,
    description text,
    status character varying DEFAULT 'pending'::character varying,
    duration integer,
    thumbnail_url character varying,
    is_public boolean DEFAULT true,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- Name: widget_dashboards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.widget_dashboards (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    name character varying,
    "default" boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    layout text
);


--
-- Name: widget_dashboards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.widget_dashboards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: widget_dashboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.widget_dashboards_id_seq OWNED BY public.widget_dashboards.id;


--
-- Name: widgets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.widgets (
    id bigint NOT NULL,
    name character varying,
    graph_type character varying,
    dataset_id integer,
    options character varying,
    width integer,
    height integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint,
    highlights character varying,
    widget_dashboard_id integer,
    x integer DEFAULT 0,
    y integer DEFAULT 0,
    category integer DEFAULT 0
);


--
-- Name: widgets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.widgets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.widgets_id_seq OWNED BY public.widgets.id;


--
-- Name: abraham_histories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abraham_histories ALTER COLUMN id SET DEFAULT nextval('public.abraham_histories_id_seq'::regclass);


--
-- Name: account_invitations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account_invitations ALTER COLUMN id SET DEFAULT nextval('public.account_invitations_id_seq'::regclass);


--
-- Name: account_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account_users ALTER COLUMN id SET DEFAULT nextval('public.account_users_id_seq'::regclass);


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: action_mailbox_inbound_emails id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_mailbox_inbound_emails ALTER COLUMN id SET DEFAULT nextval('public.action_mailbox_inbound_emails_id_seq'::regclass);


--
-- Name: action_text_rich_texts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_text_rich_texts ALTER COLUMN id SET DEFAULT nextval('public.action_text_rich_texts_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: ads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads ALTER COLUMN id SET DEFAULT nextval('public.ads_id_seq'::regclass);


--
-- Name: ahoy_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_events ALTER COLUMN id SET DEFAULT nextval('public.ahoy_events_id_seq'::regclass);


--
-- Name: ahoy_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_messages ALTER COLUMN id SET DEFAULT nextval('public.ahoy_messages_id_seq'::regclass);


--
-- Name: ahoy_visits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_visits ALTER COLUMN id SET DEFAULT nextval('public.ahoy_visits_id_seq'::regclass);


--
-- Name: ai_agent_examples id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_examples ALTER COLUMN id SET DEFAULT nextval('public.ai_agent_examples_id_seq'::regclass);


--
-- Name: ai_agent_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_messages ALTER COLUMN id SET DEFAULT nextval('public.ai_agent_messages_id_seq'::regclass);


--
-- Name: ai_agent_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_tasks ALTER COLUMN id SET DEFAULT nextval('public.ai_agent_tasks_id_seq'::regclass);


--
-- Name: ai_agents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agents ALTER COLUMN id SET DEFAULT nextval('public.ai_agents_id_seq'::regclass);


--
-- Name: alert_hides id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_hides ALTER COLUMN id SET DEFAULT nextval('public.alert_hides_id_seq'::regclass);


--
-- Name: alert_ratings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_ratings ALTER COLUMN id SET DEFAULT nextval('public.alert_ratings_id_seq'::regclass);


--
-- Name: alert_views id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_views ALTER COLUMN id SET DEFAULT nextval('public.alert_views_id_seq'::regclass);


--
-- Name: alerts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerts ALTER COLUMN id SET DEFAULT nextval('public.alerts_id_seq'::regclass);


--
-- Name: analysis_companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analysis_companies ALTER COLUMN id SET DEFAULT nextval('public.analysis_companies_id_seq'::regclass);


--
-- Name: announcements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements ALTER COLUMN id SET DEFAULT nextval('public.announcements_id_seq'::regclass);


--
-- Name: api_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens ALTER COLUMN id SET DEFAULT nextval('public.api_tokens_id_seq'::regclass);


--
-- Name: artifacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artifacts ALTER COLUMN id SET DEFAULT nextval('public.artifacts_id_seq'::regclass);


--
-- Name: blazer_audits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_audits ALTER COLUMN id SET DEFAULT nextval('public.blazer_audits_id_seq'::regclass);


--
-- Name: blazer_checks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_checks ALTER COLUMN id SET DEFAULT nextval('public.blazer_checks_id_seq'::regclass);


--
-- Name: blazer_dashboard_queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_dashboard_queries ALTER COLUMN id SET DEFAULT nextval('public.blazer_dashboard_queries_id_seq'::regclass);


--
-- Name: blazer_dashboards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_dashboards ALTER COLUMN id SET DEFAULT nextval('public.blazer_dashboards_id_seq'::regclass);


--
-- Name: blazer_queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_queries ALTER COLUMN id SET DEFAULT nextval('public.blazer_queries_id_seq'::regclass);


--
-- Name: block_ai_agents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.block_ai_agents ALTER COLUMN id SET DEFAULT nextval('public.block_ai_agents_id_seq'::regclass);


--
-- Name: blogs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blogs ALTER COLUMN id SET DEFAULT nextval('public.blogs_id_seq'::regclass);


--
-- Name: bookmarks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks ALTER COLUMN id SET DEFAULT nextval('public.bookmarks_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: chat_histories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_histories ALTER COLUMN id SET DEFAULT nextval('public.chat_histories_id_seq'::regclass);


--
-- Name: chat_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_messages ALTER COLUMN id SET DEFAULT nextval('public.chat_messages_id_seq'::regclass);


--
-- Name: chats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chats ALTER COLUMN id SET DEFAULT nextval('public.chats_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: company_blueprint_associations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_blueprint_associations ALTER COLUMN id SET DEFAULT nextval('public.company_blueprint_associations_id_seq'::regclass);


--
-- Name: company_collection_memberships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_collection_memberships ALTER COLUMN id SET DEFAULT nextval('public.company_collection_memberships_id_seq'::regclass);


--
-- Name: company_competitors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_competitors ALTER COLUMN id SET DEFAULT nextval('public.company_competitors_id_seq'::regclass);


--
-- Name: company_customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_customers ALTER COLUMN id SET DEFAULT nextval('public.company_customers_id_seq'::regclass);


--
-- Name: company_finances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_finances ALTER COLUMN id SET DEFAULT nextval('public.company_finances_id_seq'::regclass);


--
-- Name: company_followers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_followers ALTER COLUMN id SET DEFAULT nextval('public.company_followers_id_seq'::regclass);


--
-- Name: company_keyword_counts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_keyword_counts ALTER COLUMN id SET DEFAULT nextval('public.company_keyword_counts_id_seq'::regclass);


--
-- Name: company_managers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_managers ALTER COLUMN id SET DEFAULT nextval('public.company_managers_id_seq'::regclass);


--
-- Name: company_news id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_news ALTER COLUMN id SET DEFAULT nextval('public.company_news_id_seq'::regclass);


--
-- Name: company_owners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_owners ALTER COLUMN id SET DEFAULT nextval('public.company_owners_id_seq'::regclass);


--
-- Name: company_relationships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_relationships ALTER COLUMN id SET DEFAULT nextval('public.company_relationships_id_seq'::regclass);


--
-- Name: company_tweeps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_tweeps ALTER COLUMN id SET DEFAULT nextval('public.company_tweeps_id_seq'::regclass);


--
-- Name: company_url_filters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_url_filters ALTER COLUMN id SET DEFAULT nextval('public.company_url_filters_id_seq'::regclass);


--
-- Name: company_weekly_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_weekly_reports ALTER COLUMN id SET DEFAULT nextval('public.company_weekly_reports_id_seq'::regclass);


--
-- Name: comparison_lines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comparison_lines ALTER COLUMN id SET DEFAULT nextval('public.comparison_lines_id_seq'::regclass);


--
-- Name: comparisons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comparisons ALTER COLUMN id SET DEFAULT nextval('public.comparisons_id_seq'::regclass);


--
-- Name: competitor_analyses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_analyses ALTER COLUMN id SET DEFAULT nextval('public.competitor_analyses_id_seq'::regclass);


--
-- Name: competitor_priorities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_priorities ALTER COLUMN id SET DEFAULT nextval('public.competitor_priorities_id_seq'::regclass);


--
-- Name: competitor_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_reports ALTER COLUMN id SET DEFAULT nextval('public.competitor_reports_id_seq'::regclass);


--
-- Name: competitors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitors ALTER COLUMN id SET DEFAULT nextval('public.competitors_id_seq'::regclass);


--
-- Name: connected_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_accounts ALTER COLUMN id SET DEFAULT nextval('public.connected_accounts_id_seq'::regclass);


--
-- Name: content_blocks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_blocks ALTER COLUMN id SET DEFAULT nextval('public.content_blocks_id_seq'::regclass);


--
-- Name: contents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contents ALTER COLUMN id SET DEFAULT nextval('public.contents_id_seq'::regclass);


--
-- Name: daily_digests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_digests ALTER COLUMN id SET DEFAULT nextval('public.daily_digests_id_seq'::regclass);


--
-- Name: data_quality_companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_quality_companies ALTER COLUMN id SET DEFAULT nextval('public.data_quality_companies_id_seq'::regclass);


--
-- Name: data_sets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_sets ALTER COLUMN id SET DEFAULT nextval('public.data_sets_id_seq'::regclass);


--
-- Name: document_collaborations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_collaborations ALTER COLUMN id SET DEFAULT nextval('public.document_collaborations_id_seq'::regclass);


--
-- Name: document_exports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_exports ALTER COLUMN id SET DEFAULT nextval('public.document_exports_id_seq'::regclass);


--
-- Name: document_sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_sections ALTER COLUMN id SET DEFAULT nextval('public.document_sections_id_seq'::regclass);


--
-- Name: document_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_tags ALTER COLUMN id SET DEFAULT nextval('public.document_tags_id_seq'::regclass);


--
-- Name: document_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_templates ALTER COLUMN id SET DEFAULT nextval('public.document_templates_id_seq'::regclass);


--
-- Name: document_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_versions ALTER COLUMN id SET DEFAULT nextval('public.document_versions_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: email_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_templates ALTER COLUMN id SET DEFAULT nextval('public.email_templates_id_seq'::regclass);


--
-- Name: email_trackers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_trackers ALTER COLUMN id SET DEFAULT nextval('public.email_trackers_id_seq'::regclass);


--
-- Name: email_weekly_digests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_weekly_digests ALTER COLUMN id SET DEFAULT nextval('public.email_weekly_digests_id_seq'::regclass);


--
-- Name: emails id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emails ALTER COLUMN id SET DEFAULT nextval('public.emails_id_seq'::regclass);


--
-- Name: event_attendances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_attendances ALTER COLUMN id SET DEFAULT nextval('public.event_attendances_id_seq'::regclass);


--
-- Name: event_followers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_followers ALTER COLUMN id SET DEFAULT nextval('public.event_followers_id_seq'::regclass);


--
-- Name: event_speakers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_speakers ALTER COLUMN id SET DEFAULT nextval('public.event_speakers_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: evidences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidences ALTER COLUMN id SET DEFAULT nextval('public.evidences_id_seq'::regclass);


--
-- Name: facts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facts ALTER COLUMN id SET DEFAULT nextval('public.facts_id_seq'::regclass);


--
-- Name: feature_analyses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analyses ALTER COLUMN id SET DEFAULT nextval('public.feature_analyses_id_seq'::regclass);


--
-- Name: feature_analysis_snapshots id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analysis_snapshots ALTER COLUMN id SET DEFAULT nextval('public.feature_analysis_snapshots_id_seq'::regclass);


--
-- Name: feature_capabilities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_capabilities ALTER COLUMN id SET DEFAULT nextval('public.feature_capabilities_id_seq'::regclass);


--
-- Name: feature_keywords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_keywords ALTER COLUMN id SET DEFAULT nextval('public.feature_keywords_id_seq'::regclass);


--
-- Name: feature_sets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_sets ALTER COLUMN id SET DEFAULT nextval('public.feature_sets_id_seq'::regclass);


--
-- Name: feature_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_urls ALTER COLUMN id SET DEFAULT nextval('public.feature_urls_id_seq'::regclass);


--
-- Name: features id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.features ALTER COLUMN id SET DEFAULT nextval('public.features_id_seq'::regclass);


--
-- Name: file_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_questions ALTER COLUMN id SET DEFAULT nextval('public.file_questions_id_seq'::regclass);


--
-- Name: flipper_features id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flipper_features ALTER COLUMN id SET DEFAULT nextval('public.flipper_features_id_seq'::regclass);


--
-- Name: flipper_gates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flipper_gates ALTER COLUMN id SET DEFAULT nextval('public.flipper_gates_id_seq'::regclass);


--
-- Name: goals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goals ALTER COLUMN id SET DEFAULT nextval('public.goals_id_seq'::regclass);


--
-- Name: grade_configurations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grade_configurations ALTER COLUMN id SET DEFAULT nextval('public.grade_configurations_id_seq'::regclass);


--
-- Name: harvey_ball_competitor_analyses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvey_ball_competitor_analyses ALTER COLUMN id SET DEFAULT nextval('public.competitor_analyses_feature_analyses_id_seq'::regclass);


--
-- Name: headers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.headers ALTER COLUMN id SET DEFAULT nextval('public.headers_id_seq'::regclass);


--
-- Name: ignore_domains id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ignore_domains ALTER COLUMN id SET DEFAULT nextval('public.ignore_domains_id_seq'::regclass);


--
-- Name: ignore_patterns id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ignore_patterns ALTER COLUMN id SET DEFAULT nextval('public.ignore_patterns_id_seq'::regclass);


--
-- Name: import_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_maps ALTER COLUMN id SET DEFAULT nextval('public.import_maps_id_seq'::regclass);


--
-- Name: imports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports ALTER COLUMN id SET DEFAULT nextval('public.imports_id_seq'::regclass);


--
-- Name: inbound_webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbound_webhooks ALTER COLUMN id SET DEFAULT nextval('public.inbound_webhooks_id_seq'::regclass);


--
-- Name: integrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integrations ALTER COLUMN id SET DEFAULT nextval('public.integrations_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: journey_emotions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_emotions ALTER COLUMN id SET DEFAULT nextval('public.journey_emotions_id_seq'::regclass);


--
-- Name: journey_map_persona_needs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_persona_needs ALTER COLUMN id SET DEFAULT nextval('public.journey_map_persona_needs_id_seq'::regclass);


--
-- Name: journey_map_persona_pain_points id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_persona_pain_points ALTER COLUMN id SET DEFAULT nextval('public.journey_map_persona_pain_points_id_seq'::regclass);


--
-- Name: journey_map_personas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_personas ALTER COLUMN id SET DEFAULT nextval('public.journey_map_personas_id_seq'::regclass);


--
-- Name: journey_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_maps ALTER COLUMN id SET DEFAULT nextval('public.journey_maps_id_seq'::regclass);


--
-- Name: journey_opportunities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_opportunities ALTER COLUMN id SET DEFAULT nextval('public.journey_opportunities_id_seq'::regclass);


--
-- Name: journey_stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_stages ALTER COLUMN id SET DEFAULT nextval('public.journey_stages_id_seq'::regclass);


--
-- Name: journey_thoughts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_thoughts ALTER COLUMN id SET DEFAULT nextval('public.journey_thoughts_id_seq'::regclass);


--
-- Name: journey_touchpoints id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_touchpoints ALTER COLUMN id SET DEFAULT nextval('public.journey_touchpoints_id_seq'::regclass);


--
-- Name: keyword_distances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_distances ALTER COLUMN id SET DEFAULT nextval('public.keyword_distances_id_seq'::regclass);


--
-- Name: keyword_embeddings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_embeddings ALTER COLUMN id SET DEFAULT nextval('public.keyword_embeddings_id_seq'::regclass);


--
-- Name: keyword_followers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_followers ALTER COLUMN id SET DEFAULT nextval('public.keyword_followers_id_seq'::regclass);


--
-- Name: keyword_group_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_group_items ALTER COLUMN id SET DEFAULT nextval('public.keyword_group_items_id_seq'::regclass);


--
-- Name: keyword_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_groups ALTER COLUMN id SET DEFAULT nextval('public.keyword_groups_id_seq'::regclass);


--
-- Name: keyword_quarentines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_quarentines ALTER COLUMN id SET DEFAULT nextval('public.keyword_quarentines_id_seq'::regclass);


--
-- Name: keyword_recurrences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_recurrences ALTER COLUMN id SET DEFAULT nextval('public.keyword_recurrences_id_seq'::regclass);


--
-- Name: keyword_stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_stats ALTER COLUMN id SET DEFAULT nextval('public.keyword_stats_id_seq'::regclass);


--
-- Name: keyword_trends id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_trends ALTER COLUMN id SET DEFAULT nextval('public.keyword_trends_id_seq'::regclass);


--
-- Name: keyword_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_urls ALTER COLUMN id SET DEFAULT nextval('public.keyword_urls_id_seq'::regclass);


--
-- Name: keywords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keywords ALTER COLUMN id SET DEFAULT nextval('public.keywords_id_seq'::regclass);


--
-- Name: lead_imports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead_imports ALTER COLUMN id SET DEFAULT nextval('public.lead_imports_id_seq'::regclass);


--
-- Name: leader_boards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leader_boards ALTER COLUMN id SET DEFAULT nextval('public.leader_boards_id_seq'::regclass);


--
-- Name: lines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lines ALTER COLUMN id SET DEFAULT nextval('public.lines_id_seq'::regclass);


--
-- Name: link_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_maps ALTER COLUMN id SET DEFAULT nextval('public.link_maps_id_seq'::regclass);


--
-- Name: links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links ALTER COLUMN id SET DEFAULT nextval('public.links_id_seq'::regclass);


--
-- Name: login_activities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_activities ALTER COLUMN id SET DEFAULT nextval('public.login_activities_id_seq'::regclass);


--
-- Name: market_segments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.market_segments ALTER COLUMN id SET DEFAULT nextval('public.market_segments_id_seq'::regclass);


--
-- Name: markets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.markets ALTER COLUMN id SET DEFAULT nextval('public.markets_id_seq'::regclass);


--
-- Name: meta_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meta_tags ALTER COLUMN id SET DEFAULT nextval('public.meta_tags_id_seq'::regclass);


--
-- Name: mini_help_views id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mini_help_views ALTER COLUMN id SET DEFAULT nextval('public.mini_help_views_id_seq'::regclass);


--
-- Name: mini_helps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mini_helps ALTER COLUMN id SET DEFAULT nextval('public.mini_helps_id_seq'::regclass);


--
-- Name: negative_keywords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.negative_keywords ALTER COLUMN id SET DEFAULT nextval('public.negative_keywords_id_seq'::regclass);


--
-- Name: newsletter_issues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_issues ALTER COLUMN id SET DEFAULT nextval('public.newsletter_issues_id_seq'::regclass);


--
-- Name: newsletter_subscribers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_subscribers ALTER COLUMN id SET DEFAULT nextval('public.newsletter_subscribers_id_seq'::regclass);


--
-- Name: newsletters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletters ALTER COLUMN id SET DEFAULT nextval('public.newsletters_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: noticed_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticed_events ALTER COLUMN id SET DEFAULT nextval('public.noticed_events_id_seq'::regclass);


--
-- Name: noticed_notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticed_notifications ALTER COLUMN id SET DEFAULT nextval('public.noticed_notifications_id_seq'::regclass);


--
-- Name: notification_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_tokens ALTER COLUMN id SET DEFAULT nextval('public.notification_tokens_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: oauth_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_tokens_id_seq'::regclass);


--
-- Name: open_ai_batches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.open_ai_batches ALTER COLUMN id SET DEFAULT nextval('public.open_ai_batches_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: outgoing_tweets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outgoing_tweets ALTER COLUMN id SET DEFAULT nextval('public.outgoing_tweets_id_seq'::regclass);


--
-- Name: page_cleanups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_cleanups ALTER COLUMN id SET DEFAULT nextval('public.page_cleanups_id_seq'::regclass);


--
-- Name: partial_caches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partial_caches ALTER COLUMN id SET DEFAULT nextval('public.partial_caches_id_seq'::regclass);


--
-- Name: pay_charges id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_charges ALTER COLUMN id SET DEFAULT nextval('public.pay_charges_id_seq'::regclass);


--
-- Name: pay_customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_customers ALTER COLUMN id SET DEFAULT nextval('public.pay_customers_id_seq'::regclass);


--
-- Name: pay_merchants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_merchants ALTER COLUMN id SET DEFAULT nextval('public.pay_merchants_id_seq'::regclass);


--
-- Name: pay_payment_methods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_payment_methods ALTER COLUMN id SET DEFAULT nextval('public.pay_payment_methods_id_seq'::regclass);


--
-- Name: pay_subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.pay_subscriptions_id_seq'::regclass);


--
-- Name: pay_webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_webhooks ALTER COLUMN id SET DEFAULT nextval('public.pay_webhooks_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- Name: people_lists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_lists ALTER COLUMN id SET DEFAULT nextval('public.people_lists_id_seq'::regclass);


--
-- Name: person_account_information id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_account_information ALTER COLUMN id SET DEFAULT nextval('public.person_account_information_id_seq'::regclass);


--
-- Name: person_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_accounts ALTER COLUMN id SET DEFAULT nextval('public.person_accounts_id_seq'::regclass);


--
-- Name: person_followers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_followers ALTER COLUMN id SET DEFAULT nextval('public.person_followers_id_seq'::regclass);


--
-- Name: person_searches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_searches ALTER COLUMN id SET DEFAULT nextval('public.person_searches_id_seq'::regclass);


--
-- Name: person_skills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_skills ALTER COLUMN id SET DEFAULT nextval('public.person_skills_id_seq'::regclass);


--
-- Name: person_subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.person_subscriptions_id_seq'::regclass);


--
-- Name: person_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_urls ALTER COLUMN id SET DEFAULT nextval('public.person_urls_id_seq'::regclass);


--
-- Name: persona_group_memberships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_group_memberships ALTER COLUMN id SET DEFAULT nextval('public.persona_group_memberships_id_seq'::regclass);


--
-- Name: persona_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_groups ALTER COLUMN id SET DEFAULT nextval('public.persona_groups_id_seq'::regclass);


--
-- Name: persona_product_blueprint_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_product_blueprint_modules ALTER COLUMN id SET DEFAULT nextval('public.persona_product_blueprint_modules_id_seq'::regclass);


--
-- Name: persona_user_stories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_user_stories ALTER COLUMN id SET DEFAULT nextval('public.persona_user_stories_id_seq'::regclass);


--
-- Name: personas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personas ALTER COLUMN id SET DEFAULT nextval('public.personas_id_seq'::regclass);


--
-- Name: pg_search_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents ALTER COLUMN id SET DEFAULT nextval('public.pg_search_documents_id_seq'::regclass);


--
-- Name: pghero_query_stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pghero_query_stats ALTER COLUMN id SET DEFAULT nextval('public.pghero_query_stats_id_seq'::regclass);


--
-- Name: plans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plans ALTER COLUMN id SET DEFAULT nextval('public.plans_id_seq'::regclass);


--
-- Name: pm_roi_calculations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations ALTER COLUMN id SET DEFAULT nextval('public.pm_roi_calculations_id_seq'::regclass);


--
-- Name: product_blueprint_associations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_associations ALTER COLUMN id SET DEFAULT nextval('public.product_blueprint_associations_id_seq'::regclass);


--
-- Name: product_blueprint_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_modules ALTER COLUMN id SET DEFAULT nextval('public.product_blueprint_modules_id_seq'::regclass);


--
-- Name: product_blueprints id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprints ALTER COLUMN id SET DEFAULT nextval('public.product_blueprints_id_seq'::regclass);


--
-- Name: product_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.product_categories_id_seq'::regclass);


--
-- Name: product_features id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_features ALTER COLUMN id SET DEFAULT nextval('public.product_features_id_seq'::regclass);


--
-- Name: product_owners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_owners ALTER COLUMN id SET DEFAULT nextval('public.product_owners_id_seq'::regclass);


--
-- Name: product_personas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_personas ALTER COLUMN id SET DEFAULT nextval('public.product_personas_id_seq'::regclass);


--
-- Name: product_screenshots id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_screenshots ALTER COLUMN id SET DEFAULT nextval('public.product_screenshots_id_seq'::regclass);


--
-- Name: product_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_urls ALTER COLUMN id SET DEFAULT nextval('public.product_urls_id_seq'::regclass);


--
-- Name: product_videos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_videos ALTER COLUMN id SET DEFAULT nextval('public.product_videos_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: project_data_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_data_items ALTER COLUMN id SET DEFAULT nextval('public.project_data_items_id_seq'::regclass);


--
-- Name: project_sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_sections ALTER COLUMN id SET DEFAULT nextval('public.project_sections_id_seq'::regclass);


--
-- Name: project_sources id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_sources ALTER COLUMN id SET DEFAULT nextval('public.project_sources_id_seq'::regclass);


--
-- Name: project_topic_dashboard_briefs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_topic_dashboard_briefs ALTER COLUMN id SET DEFAULT nextval('public.project_topic_dashboard_briefs_id_seq'::regclass);


--
-- Name: project_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_urls ALTER COLUMN id SET DEFAULT nextval('public.project_urls_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: raw_data id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.raw_data ALTER COLUMN id SET DEFAULT nextval('public.raw_data_id_seq'::regclass);


--
-- Name: report_elements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_elements ALTER COLUMN id SET DEFAULT nextval('public.report_elements_id_seq'::regclass);


--
-- Name: report_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_templates ALTER COLUMN id SET DEFAULT nextval('public.report_templates_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: scrape_runs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scrape_runs ALTER COLUMN id SET DEFAULT nextval('public.scrape_runs_id_seq'::regclass);


--
-- Name: section_blocks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.section_blocks ALTER COLUMN id SET DEFAULT nextval('public.section_blocks_id_seq'::regclass);


--
-- Name: service_calls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_calls ALTER COLUMN id SET DEFAULT nextval('public.service_calls_id_seq'::regclass);


--
-- Name: similar_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.similar_urls ALTER COLUMN id SET DEFAULT nextval('public.similar_urls_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- Name: smart_report_sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_report_sections ALTER COLUMN id SET DEFAULT nextval('public.smart_report_sections_id_seq'::regclass);


--
-- Name: smart_report_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_report_versions ALTER COLUMN id SET DEFAULT nextval('public.smart_report_versions_id_seq'::regclass);


--
-- Name: smart_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_reports ALTER COLUMN id SET DEFAULT nextval('public.smart_reports_id_seq'::regclass);


--
-- Name: snapshots id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots ALTER COLUMN id SET DEFAULT nextval('public.snapshots_id_seq'::regclass);


--
-- Name: suggested_actions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggested_actions ALTER COLUMN id SET DEFAULT nextval('public.suggested_actions_id_seq'::regclass);


--
-- Name: suggested_companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggested_companies ALTER COLUMN id SET DEFAULT nextval('public.suggested_companies_id_seq'::regclass);


--
-- Name: template_sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.template_sections ALTER COLUMN id SET DEFAULT nextval('public.template_sections_id_seq'::regclass);


--
-- Name: template_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.template_versions ALTER COLUMN id SET DEFAULT nextval('public.template_versions_id_seq'::regclass);


--
-- Name: topic_dashboard_notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_notifications ALTER COLUMN id SET DEFAULT nextval('public.topic_dashboard_notifications_id_seq'::regclass);


--
-- Name: topic_dashboard_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_urls ALTER COLUMN id SET DEFAULT nextval('public.topic_dashboard_urls_id_seq'::regclass);


--
-- Name: topic_dashboards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboards ALTER COLUMN id SET DEFAULT nextval('public.topic_dashboards_id_seq'::regclass);


--
-- Name: topic_followers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_followers ALTER COLUMN id SET DEFAULT nextval('public.topic_followers_id_seq'::regclass);


--
-- Name: topic_keywords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_keywords ALTER COLUMN id SET DEFAULT nextval('public.topic_keywords_id_seq'::regclass);


--
-- Name: topic_recurrences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_recurrences ALTER COLUMN id SET DEFAULT nextval('public.topic_recurrences_id_seq'::regclass);


--
-- Name: topic_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_templates ALTER COLUMN id SET DEFAULT nextval('public.topic_templates_id_seq'::regclass);


--
-- Name: topic_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_urls ALTER COLUMN id SET DEFAULT nextval('public.topic_urls_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- Name: transcripts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transcripts ALTER COLUMN id SET DEFAULT nextval('public.transcripts_id_seq'::regclass);


--
-- Name: tweep_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tweep_urls ALTER COLUMN id SET DEFAULT nextval('public.tweep_urls_id_seq'::regclass);


--
-- Name: tweeps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tweeps ALTER COLUMN id SET DEFAULT nextval('public.tweeps_id_seq'::regclass);


--
-- Name: twitter_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.twitter_accounts ALTER COLUMN id SET DEFAULT nextval('public.twitter_accounts_id_seq'::regclass);


--
-- Name: url_collection_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_collection_items ALTER COLUMN id SET DEFAULT nextval('public.url_collection_items_id_seq'::regclass);


--
-- Name: url_collections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_collections ALTER COLUMN id SET DEFAULT nextval('public.url_collections_id_seq'::regclass);


--
-- Name: url_docs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_docs ALTER COLUMN id SET DEFAULT nextval('public.url_docs_id_seq'::regclass);


--
-- Name: url_embeddings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_embeddings ALTER COLUMN id SET DEFAULT nextval('public.url_embeddings_id_seq'::regclass);


--
-- Name: url_fingerprints id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_fingerprints ALTER COLUMN id SET DEFAULT nextval('public.url_fingerprints_id_seq'::regclass);


--
-- Name: url_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_images ALTER COLUMN id SET DEFAULT nextval('public.url_images_id_seq'::regclass);


--
-- Name: url_searches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_searches ALTER COLUMN id SET DEFAULT nextval('public.url_searches_id_seq'::regclass);


--
-- Name: url_stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_stats ALTER COLUMN id SET DEFAULT nextval('public.url_stats_id_seq'::regclass);


--
-- Name: url_watches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_watches ALTER COLUMN id SET DEFAULT nextval('public.url_watches_id_seq'::regclass);


--
-- Name: urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls ALTER COLUMN id SET DEFAULT nextval('public.urls_id_seq'::regclass);


--
-- Name: user_stories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_stories ALTER COLUMN id SET DEFAULT nextval('public.user_stories_id_seq'::regclass);


--
-- Name: user_views id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_views ALTER COLUMN id SET DEFAULT nextval('public.user_views_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vector_stores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vector_stores ALTER COLUMN id SET DEFAULT nextval('public.vector_stores_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- Name: widget_dashboards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.widget_dashboards ALTER COLUMN id SET DEFAULT nextval('public.widget_dashboards_id_seq'::regclass);


--
-- Name: widgets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.widgets ALTER COLUMN id SET DEFAULT nextval('public.widgets_id_seq'::regclass);


--
-- Name: abraham_histories abraham_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abraham_histories
    ADD CONSTRAINT abraham_histories_pkey PRIMARY KEY (id);


--
-- Name: account_invitations account_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account_invitations
    ADD CONSTRAINT account_invitations_pkey PRIMARY KEY (id);


--
-- Name: account_users account_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account_users
    ADD CONSTRAINT account_users_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: action_mailbox_inbound_emails action_mailbox_inbound_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_mailbox_inbound_emails
    ADD CONSTRAINT action_mailbox_inbound_emails_pkey PRIMARY KEY (id);


--
-- Name: action_text_rich_texts action_text_rich_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_text_rich_texts
    ADD CONSTRAINT action_text_rich_texts_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: ads ads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (id);


--
-- Name: ahoy_events ahoy_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_events
    ADD CONSTRAINT ahoy_events_pkey PRIMARY KEY (id);


--
-- Name: ahoy_messages ahoy_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_messages
    ADD CONSTRAINT ahoy_messages_pkey PRIMARY KEY (id);


--
-- Name: ahoy_visits ahoy_visits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ahoy_visits
    ADD CONSTRAINT ahoy_visits_pkey PRIMARY KEY (id);


--
-- Name: ai_agent_examples ai_agent_examples_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_examples
    ADD CONSTRAINT ai_agent_examples_pkey PRIMARY KEY (id);


--
-- Name: ai_agent_messages ai_agent_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_messages
    ADD CONSTRAINT ai_agent_messages_pkey PRIMARY KEY (id);


--
-- Name: ai_agent_tasks ai_agent_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_tasks
    ADD CONSTRAINT ai_agent_tasks_pkey PRIMARY KEY (id);


--
-- Name: ai_agents ai_agents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agents
    ADD CONSTRAINT ai_agents_pkey PRIMARY KEY (id);


--
-- Name: alert_hides alert_hides_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_hides
    ADD CONSTRAINT alert_hides_pkey PRIMARY KEY (id);


--
-- Name: alert_ratings alert_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_ratings
    ADD CONSTRAINT alert_ratings_pkey PRIMARY KEY (id);


--
-- Name: alert_views alert_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_views
    ADD CONSTRAINT alert_views_pkey PRIMARY KEY (id);


--
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: analysis_companies analysis_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analysis_companies
    ADD CONSTRAINT analysis_companies_pkey PRIMARY KEY (id);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: api_tokens api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT api_tokens_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: artifacts artifacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artifacts
    ADD CONSTRAINT artifacts_pkey PRIMARY KEY (id);


--
-- Name: blazer_audits blazer_audits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_audits
    ADD CONSTRAINT blazer_audits_pkey PRIMARY KEY (id);


--
-- Name: blazer_checks blazer_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_checks
    ADD CONSTRAINT blazer_checks_pkey PRIMARY KEY (id);


--
-- Name: blazer_dashboard_queries blazer_dashboard_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_dashboard_queries
    ADD CONSTRAINT blazer_dashboard_queries_pkey PRIMARY KEY (id);


--
-- Name: blazer_dashboards blazer_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_dashboards
    ADD CONSTRAINT blazer_dashboards_pkey PRIMARY KEY (id);


--
-- Name: blazer_queries blazer_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blazer_queries
    ADD CONSTRAINT blazer_queries_pkey PRIMARY KEY (id);


--
-- Name: block_ai_agents block_ai_agents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.block_ai_agents
    ADD CONSTRAINT block_ai_agents_pkey PRIMARY KEY (id);


--
-- Name: blogs blogs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);


--
-- Name: bookmarks bookmarks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT bookmarks_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: chat_histories chat_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_histories
    ADD CONSTRAINT chat_histories_pkey PRIMARY KEY (id);


--
-- Name: chat_messages chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);


--
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_blueprint_associations company_blueprint_associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_blueprint_associations
    ADD CONSTRAINT company_blueprint_associations_pkey PRIMARY KEY (id);


--
-- Name: company_collection_memberships company_collection_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_collection_memberships
    ADD CONSTRAINT company_collection_memberships_pkey PRIMARY KEY (id);


--
-- Name: company_competitors company_competitors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_competitors
    ADD CONSTRAINT company_competitors_pkey PRIMARY KEY (id);


--
-- Name: company_customers company_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_customers
    ADD CONSTRAINT company_customers_pkey PRIMARY KEY (id);


--
-- Name: company_finances company_finances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_finances
    ADD CONSTRAINT company_finances_pkey PRIMARY KEY (id);


--
-- Name: company_followers company_followers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_followers
    ADD CONSTRAINT company_followers_pkey PRIMARY KEY (id);


--
-- Name: company_keyword_counts company_keyword_counts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_keyword_counts
    ADD CONSTRAINT company_keyword_counts_pkey PRIMARY KEY (id);


--
-- Name: company_managers company_managers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_managers
    ADD CONSTRAINT company_managers_pkey PRIMARY KEY (id);


--
-- Name: company_news company_news_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_news
    ADD CONSTRAINT company_news_pkey PRIMARY KEY (id);


--
-- Name: company_owners company_owners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_owners
    ADD CONSTRAINT company_owners_pkey PRIMARY KEY (id);


--
-- Name: company_relationships company_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_relationships
    ADD CONSTRAINT company_relationships_pkey PRIMARY KEY (id);


--
-- Name: company_tweeps company_tweeps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_tweeps
    ADD CONSTRAINT company_tweeps_pkey PRIMARY KEY (id);


--
-- Name: company_url_filters company_url_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_url_filters
    ADD CONSTRAINT company_url_filters_pkey PRIMARY KEY (id);


--
-- Name: company_weekly_reports company_weekly_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_weekly_reports
    ADD CONSTRAINT company_weekly_reports_pkey PRIMARY KEY (id);


--
-- Name: comparison_lines comparison_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comparison_lines
    ADD CONSTRAINT comparison_lines_pkey PRIMARY KEY (id);


--
-- Name: comparisons comparisons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comparisons
    ADD CONSTRAINT comparisons_pkey PRIMARY KEY (id);


--
-- Name: harvey_ball_competitor_analyses competitor_analyses_feature_analyses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvey_ball_competitor_analyses
    ADD CONSTRAINT competitor_analyses_feature_analyses_pkey PRIMARY KEY (id);


--
-- Name: competitor_analyses competitor_analyses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_analyses
    ADD CONSTRAINT competitor_analyses_pkey PRIMARY KEY (id);


--
-- Name: competitor_priorities competitor_priorities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_priorities
    ADD CONSTRAINT competitor_priorities_pkey PRIMARY KEY (id);


--
-- Name: competitor_reports competitor_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_reports
    ADD CONSTRAINT competitor_reports_pkey PRIMARY KEY (id);


--
-- Name: competitors competitors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitors
    ADD CONSTRAINT competitors_pkey PRIMARY KEY (id);


--
-- Name: connected_accounts connected_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_accounts
    ADD CONSTRAINT connected_accounts_pkey PRIMARY KEY (id);


--
-- Name: content_blocks content_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_blocks
    ADD CONSTRAINT content_blocks_pkey PRIMARY KEY (id);


--
-- Name: contents contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT contents_pkey PRIMARY KEY (id);


--
-- Name: daily_digests daily_digests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_digests
    ADD CONSTRAINT daily_digests_pkey PRIMARY KEY (id);


--
-- Name: data_quality_companies data_quality_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_quality_companies
    ADD CONSTRAINT data_quality_companies_pkey PRIMARY KEY (id);


--
-- Name: data_sets data_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_sets
    ADD CONSTRAINT data_sets_pkey PRIMARY KEY (id);


--
-- Name: document_collaborations document_collaborations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_collaborations
    ADD CONSTRAINT document_collaborations_pkey PRIMARY KEY (id);


--
-- Name: document_exports document_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_exports
    ADD CONSTRAINT document_exports_pkey PRIMARY KEY (id);


--
-- Name: document_sections document_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_sections
    ADD CONSTRAINT document_sections_pkey PRIMARY KEY (id);


--
-- Name: document_tags document_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_tags
    ADD CONSTRAINT document_tags_pkey PRIMARY KEY (id);


--
-- Name: document_templates document_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_templates
    ADD CONSTRAINT document_templates_pkey PRIMARY KEY (id);


--
-- Name: document_versions document_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_versions
    ADD CONSTRAINT document_versions_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: email_templates email_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_pkey PRIMARY KEY (id);


--
-- Name: email_trackers email_trackers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_trackers
    ADD CONSTRAINT email_trackers_pkey PRIMARY KEY (id);


--
-- Name: email_weekly_digests email_weekly_digests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_weekly_digests
    ADD CONSTRAINT email_weekly_digests_pkey PRIMARY KEY (id);


--
-- Name: emails emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: event_attendances event_attendances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_attendances
    ADD CONSTRAINT event_attendances_pkey PRIMARY KEY (id);


--
-- Name: event_followers event_followers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_followers
    ADD CONSTRAINT event_followers_pkey PRIMARY KEY (id);


--
-- Name: event_speakers event_speakers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_speakers
    ADD CONSTRAINT event_speakers_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: evidences evidences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidences
    ADD CONSTRAINT evidences_pkey PRIMARY KEY (id);


--
-- Name: facts facts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facts
    ADD CONSTRAINT facts_pkey PRIMARY KEY (id);


--
-- Name: feature_analyses feature_analyses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analyses
    ADD CONSTRAINT feature_analyses_pkey PRIMARY KEY (id);


--
-- Name: feature_analysis_snapshots feature_analysis_snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analysis_snapshots
    ADD CONSTRAINT feature_analysis_snapshots_pkey PRIMARY KEY (id);


--
-- Name: feature_capabilities feature_capabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_capabilities
    ADD CONSTRAINT feature_capabilities_pkey PRIMARY KEY (id);


--
-- Name: feature_keywords feature_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_keywords
    ADD CONSTRAINT feature_keywords_pkey PRIMARY KEY (id);


--
-- Name: feature_sets feature_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_sets
    ADD CONSTRAINT feature_sets_pkey PRIMARY KEY (id);


--
-- Name: feature_urls feature_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_urls
    ADD CONSTRAINT feature_urls_pkey PRIMARY KEY (id);


--
-- Name: features features_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (id);


--
-- Name: file_questions file_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_questions
    ADD CONSTRAINT file_questions_pkey PRIMARY KEY (id);


--
-- Name: flipper_features flipper_features_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flipper_features
    ADD CONSTRAINT flipper_features_pkey PRIMARY KEY (id);


--
-- Name: flipper_gates flipper_gates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flipper_gates
    ADD CONSTRAINT flipper_gates_pkey PRIMARY KEY (id);


--
-- Name: goals goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (id);


--
-- Name: grade_configurations grade_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grade_configurations
    ADD CONSTRAINT grade_configurations_pkey PRIMARY KEY (id);


--
-- Name: headers headers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.headers
    ADD CONSTRAINT headers_pkey PRIMARY KEY (id);


--
-- Name: ignore_domains ignore_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ignore_domains
    ADD CONSTRAINT ignore_domains_pkey PRIMARY KEY (id);


--
-- Name: ignore_patterns ignore_patterns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ignore_patterns
    ADD CONSTRAINT ignore_patterns_pkey PRIMARY KEY (id);


--
-- Name: import_maps import_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_maps
    ADD CONSTRAINT import_maps_pkey PRIMARY KEY (id);


--
-- Name: imports imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT imports_pkey PRIMARY KEY (id);


--
-- Name: inbound_webhooks inbound_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbound_webhooks
    ADD CONSTRAINT inbound_webhooks_pkey PRIMARY KEY (id);


--
-- Name: integrations integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integrations
    ADD CONSTRAINT integrations_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: journey_emotions journey_emotions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_emotions
    ADD CONSTRAINT journey_emotions_pkey PRIMARY KEY (id);


--
-- Name: journey_map_persona_needs journey_map_persona_needs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_persona_needs
    ADD CONSTRAINT journey_map_persona_needs_pkey PRIMARY KEY (id);


--
-- Name: journey_map_persona_pain_points journey_map_persona_pain_points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_persona_pain_points
    ADD CONSTRAINT journey_map_persona_pain_points_pkey PRIMARY KEY (id);


--
-- Name: journey_map_personas journey_map_personas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_personas
    ADD CONSTRAINT journey_map_personas_pkey PRIMARY KEY (id);


--
-- Name: journey_maps journey_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_maps
    ADD CONSTRAINT journey_maps_pkey PRIMARY KEY (id);


--
-- Name: journey_opportunities journey_opportunities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_opportunities
    ADD CONSTRAINT journey_opportunities_pkey PRIMARY KEY (id);


--
-- Name: journey_stages journey_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_stages
    ADD CONSTRAINT journey_stages_pkey PRIMARY KEY (id);


--
-- Name: journey_thoughts journey_thoughts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_thoughts
    ADD CONSTRAINT journey_thoughts_pkey PRIMARY KEY (id);


--
-- Name: journey_touchpoints journey_touchpoints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_touchpoints
    ADD CONSTRAINT journey_touchpoints_pkey PRIMARY KEY (id);


--
-- Name: keyword_distances keyword_distances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_distances
    ADD CONSTRAINT keyword_distances_pkey PRIMARY KEY (id);


--
-- Name: keyword_embeddings keyword_embeddings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_embeddings
    ADD CONSTRAINT keyword_embeddings_pkey PRIMARY KEY (id);


--
-- Name: keyword_followers keyword_followers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_followers
    ADD CONSTRAINT keyword_followers_pkey PRIMARY KEY (id);


--
-- Name: keyword_group_items keyword_group_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_group_items
    ADD CONSTRAINT keyword_group_items_pkey PRIMARY KEY (id);


--
-- Name: keyword_groups keyword_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_groups
    ADD CONSTRAINT keyword_groups_pkey PRIMARY KEY (id);


--
-- Name: keyword_quarentines keyword_quarentines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_quarentines
    ADD CONSTRAINT keyword_quarentines_pkey PRIMARY KEY (id);


--
-- Name: keyword_recurrences keyword_recurrences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_recurrences
    ADD CONSTRAINT keyword_recurrences_pkey PRIMARY KEY (id);


--
-- Name: keyword_stats keyword_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_stats
    ADD CONSTRAINT keyword_stats_pkey PRIMARY KEY (id);


--
-- Name: keyword_trends keyword_trends_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_trends
    ADD CONSTRAINT keyword_trends_pkey PRIMARY KEY (id);


--
-- Name: keyword_urls keyword_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_urls
    ADD CONSTRAINT keyword_urls_pkey PRIMARY KEY (id);


--
-- Name: keywords keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keywords
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (id);


--
-- Name: lead_imports lead_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead_imports
    ADD CONSTRAINT lead_imports_pkey PRIMARY KEY (id);


--
-- Name: leader_boards leader_boards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leader_boards
    ADD CONSTRAINT leader_boards_pkey PRIMARY KEY (id);


--
-- Name: lines lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_pkey PRIMARY KEY (id);


--
-- Name: link_maps link_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_maps
    ADD CONSTRAINT link_maps_pkey PRIMARY KEY (id);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: login_activities login_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_activities
    ADD CONSTRAINT login_activities_pkey PRIMARY KEY (id);


--
-- Name: market_segments market_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.market_segments
    ADD CONSTRAINT market_segments_pkey PRIMARY KEY (id);


--
-- Name: markets markets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.markets
    ADD CONSTRAINT markets_pkey PRIMARY KEY (id);


--
-- Name: meta_tags meta_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meta_tags
    ADD CONSTRAINT meta_tags_pkey PRIMARY KEY (id);


--
-- Name: mini_help_views mini_help_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mini_help_views
    ADD CONSTRAINT mini_help_views_pkey PRIMARY KEY (id);


--
-- Name: mini_helps mini_helps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mini_helps
    ADD CONSTRAINT mini_helps_pkey PRIMARY KEY (id);


--
-- Name: negative_keywords negative_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.negative_keywords
    ADD CONSTRAINT negative_keywords_pkey PRIMARY KEY (id);


--
-- Name: newsletter_issues newsletter_issues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_issues
    ADD CONSTRAINT newsletter_issues_pkey PRIMARY KEY (id);


--
-- Name: newsletter_subscribers newsletter_subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_subscribers
    ADD CONSTRAINT newsletter_subscribers_pkey PRIMARY KEY (id);


--
-- Name: newsletters newsletters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletters
    ADD CONSTRAINT newsletters_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: noticed_events noticed_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticed_events
    ADD CONSTRAINT noticed_events_pkey PRIMARY KEY (id);


--
-- Name: noticed_notifications noticed_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticed_notifications
    ADD CONSTRAINT noticed_notifications_pkey PRIMARY KEY (id);


--
-- Name: notification_tokens notification_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_tokens
    ADD CONSTRAINT notification_tokens_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: open_ai_batches open_ai_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.open_ai_batches
    ADD CONSTRAINT open_ai_batches_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: outgoing_tweets outgoing_tweets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outgoing_tweets
    ADD CONSTRAINT outgoing_tweets_pkey PRIMARY KEY (id);


--
-- Name: page_cleanups page_cleanups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_cleanups
    ADD CONSTRAINT page_cleanups_pkey PRIMARY KEY (id);


--
-- Name: partial_caches partial_caches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partial_caches
    ADD CONSTRAINT partial_caches_pkey PRIMARY KEY (id);


--
-- Name: pay_charges pay_charges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_charges
    ADD CONSTRAINT pay_charges_pkey PRIMARY KEY (id);


--
-- Name: pay_customers pay_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_customers
    ADD CONSTRAINT pay_customers_pkey PRIMARY KEY (id);


--
-- Name: pay_merchants pay_merchants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_merchants
    ADD CONSTRAINT pay_merchants_pkey PRIMARY KEY (id);


--
-- Name: pay_payment_methods pay_payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_payment_methods
    ADD CONSTRAINT pay_payment_methods_pkey PRIMARY KEY (id);


--
-- Name: pay_subscriptions pay_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_subscriptions
    ADD CONSTRAINT pay_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: pay_webhooks pay_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pay_webhooks
    ADD CONSTRAINT pay_webhooks_pkey PRIMARY KEY (id);


--
-- Name: people_lists people_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_lists
    ADD CONSTRAINT people_lists_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: person_account_information person_account_information_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_account_information
    ADD CONSTRAINT person_account_information_pkey PRIMARY KEY (id);


--
-- Name: person_accounts person_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_accounts
    ADD CONSTRAINT person_accounts_pkey PRIMARY KEY (id);


--
-- Name: person_followers person_followers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_followers
    ADD CONSTRAINT person_followers_pkey PRIMARY KEY (id);


--
-- Name: person_searches person_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_searches
    ADD CONSTRAINT person_searches_pkey PRIMARY KEY (id);


--
-- Name: person_skills person_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_skills
    ADD CONSTRAINT person_skills_pkey PRIMARY KEY (id);


--
-- Name: person_subscriptions person_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_subscriptions
    ADD CONSTRAINT person_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: person_urls person_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_urls
    ADD CONSTRAINT person_urls_pkey PRIMARY KEY (id);


--
-- Name: persona_group_memberships persona_group_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_group_memberships
    ADD CONSTRAINT persona_group_memberships_pkey PRIMARY KEY (id);


--
-- Name: persona_groups persona_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_groups
    ADD CONSTRAINT persona_groups_pkey PRIMARY KEY (id);


--
-- Name: persona_product_blueprint_modules persona_product_blueprint_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_product_blueprint_modules
    ADD CONSTRAINT persona_product_blueprint_modules_pkey PRIMARY KEY (id);


--
-- Name: persona_user_stories persona_user_stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_user_stories
    ADD CONSTRAINT persona_user_stories_pkey PRIMARY KEY (id);


--
-- Name: personas personas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: pghero_query_stats pghero_query_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pghero_query_stats
    ADD CONSTRAINT pghero_query_stats_pkey PRIMARY KEY (id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: pm_roi_calculations pm_roi_calculations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT pm_roi_calculations_pkey PRIMARY KEY (id);


--
-- Name: product_blueprint_associations product_blueprint_associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_associations
    ADD CONSTRAINT product_blueprint_associations_pkey PRIMARY KEY (id);


--
-- Name: product_blueprint_modules product_blueprint_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_modules
    ADD CONSTRAINT product_blueprint_modules_pkey PRIMARY KEY (id);


--
-- Name: product_blueprints product_blueprints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprints
    ADD CONSTRAINT product_blueprints_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: product_features product_features_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_features
    ADD CONSTRAINT product_features_pkey PRIMARY KEY (id);


--
-- Name: product_owners product_owners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_owners
    ADD CONSTRAINT product_owners_pkey PRIMARY KEY (id);


--
-- Name: product_personas product_personas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_personas
    ADD CONSTRAINT product_personas_pkey PRIMARY KEY (id);


--
-- Name: product_screenshots product_screenshots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_screenshots
    ADD CONSTRAINT product_screenshots_pkey PRIMARY KEY (id);


--
-- Name: product_urls product_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_urls
    ADD CONSTRAINT product_urls_pkey PRIMARY KEY (id);


--
-- Name: product_videos product_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_videos
    ADD CONSTRAINT product_videos_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: project_data_items project_data_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_data_items
    ADD CONSTRAINT project_data_items_pkey PRIMARY KEY (id);


--
-- Name: project_sections project_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_sections
    ADD CONSTRAINT project_sections_pkey PRIMARY KEY (id);


--
-- Name: project_sources project_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_sources
    ADD CONSTRAINT project_sources_pkey PRIMARY KEY (id);


--
-- Name: project_topic_dashboard_briefs project_topic_dashboard_briefs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_topic_dashboard_briefs
    ADD CONSTRAINT project_topic_dashboard_briefs_pkey PRIMARY KEY (id);


--
-- Name: project_urls project_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_urls
    ADD CONSTRAINT project_urls_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: raw_data raw_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.raw_data
    ADD CONSTRAINT raw_data_pkey PRIMARY KEY (id);


--
-- Name: report_elements report_elements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_elements
    ADD CONSTRAINT report_elements_pkey PRIMARY KEY (id);


--
-- Name: report_templates report_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_templates
    ADD CONSTRAINT report_templates_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: scrape_runs scrape_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scrape_runs
    ADD CONSTRAINT scrape_runs_pkey PRIMARY KEY (id);


--
-- Name: section_blocks section_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.section_blocks
    ADD CONSTRAINT section_blocks_pkey PRIMARY KEY (id);


--
-- Name: service_calls service_calls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_calls
    ADD CONSTRAINT service_calls_pkey PRIMARY KEY (id);


--
-- Name: similar_urls similar_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.similar_urls
    ADD CONSTRAINT similar_urls_pkey PRIMARY KEY (id);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: smart_report_sections smart_report_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_report_sections
    ADD CONSTRAINT smart_report_sections_pkey PRIMARY KEY (id);


--
-- Name: smart_report_versions smart_report_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_report_versions
    ADD CONSTRAINT smart_report_versions_pkey PRIMARY KEY (id);


--
-- Name: smart_reports smart_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_reports
    ADD CONSTRAINT smart_reports_pkey PRIMARY KEY (id);


--
-- Name: snapshots snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots
    ADD CONSTRAINT snapshots_pkey PRIMARY KEY (id);


--
-- Name: suggested_actions suggested_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggested_actions
    ADD CONSTRAINT suggested_actions_pkey PRIMARY KEY (id);


--
-- Name: suggested_companies suggested_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggested_companies
    ADD CONSTRAINT suggested_companies_pkey PRIMARY KEY (id);


--
-- Name: template_sections template_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.template_sections
    ADD CONSTRAINT template_sections_pkey PRIMARY KEY (id);


--
-- Name: template_versions template_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.template_versions
    ADD CONSTRAINT template_versions_pkey PRIMARY KEY (id);


--
-- Name: topic_dashboard_notifications topic_dashboard_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_notifications
    ADD CONSTRAINT topic_dashboard_notifications_pkey PRIMARY KEY (id);


--
-- Name: topic_dashboard_urls topic_dashboard_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_urls
    ADD CONSTRAINT topic_dashboard_urls_pkey PRIMARY KEY (id);


--
-- Name: topic_dashboards topic_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboards
    ADD CONSTRAINT topic_dashboards_pkey PRIMARY KEY (id);


--
-- Name: topic_followers topic_followers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_followers
    ADD CONSTRAINT topic_followers_pkey PRIMARY KEY (id);


--
-- Name: topic_keywords topic_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_keywords
    ADD CONSTRAINT topic_keywords_pkey PRIMARY KEY (id);


--
-- Name: topic_recurrences topic_recurrences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_recurrences
    ADD CONSTRAINT topic_recurrences_pkey PRIMARY KEY (id);


--
-- Name: topic_templates topic_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_templates
    ADD CONSTRAINT topic_templates_pkey PRIMARY KEY (id);


--
-- Name: topic_urls topic_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_urls
    ADD CONSTRAINT topic_urls_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: transcripts transcripts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transcripts
    ADD CONSTRAINT transcripts_pkey PRIMARY KEY (id);


--
-- Name: tweep_urls tweep_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tweep_urls
    ADD CONSTRAINT tweep_urls_pkey PRIMARY KEY (id);


--
-- Name: tweeps tweeps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tweeps
    ADD CONSTRAINT tweeps_pkey PRIMARY KEY (id);


--
-- Name: twitter_accounts twitter_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.twitter_accounts
    ADD CONSTRAINT twitter_accounts_pkey PRIMARY KEY (id);


--
-- Name: url_collection_items url_collection_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_collection_items
    ADD CONSTRAINT url_collection_items_pkey PRIMARY KEY (id);


--
-- Name: url_collections url_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_collections
    ADD CONSTRAINT url_collections_pkey PRIMARY KEY (id);


--
-- Name: url_docs url_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_docs
    ADD CONSTRAINT url_docs_pkey PRIMARY KEY (id);


--
-- Name: url_embeddings url_embeddings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_embeddings
    ADD CONSTRAINT url_embeddings_pkey PRIMARY KEY (id);


--
-- Name: url_fingerprints url_fingerprints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_fingerprints
    ADD CONSTRAINT url_fingerprints_pkey PRIMARY KEY (id);


--
-- Name: url_images url_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_images
    ADD CONSTRAINT url_images_pkey PRIMARY KEY (id);


--
-- Name: url_searches url_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_searches
    ADD CONSTRAINT url_searches_pkey PRIMARY KEY (id);


--
-- Name: url_stats url_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_stats
    ADD CONSTRAINT url_stats_pkey PRIMARY KEY (id);


--
-- Name: url_watches url_watches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_watches
    ADD CONSTRAINT url_watches_pkey PRIMARY KEY (id);


--
-- Name: urls urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls
    ADD CONSTRAINT urls_pkey PRIMARY KEY (id);


--
-- Name: user_stories user_stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_stories
    ADD CONSTRAINT user_stories_pkey PRIMARY KEY (id);


--
-- Name: user_views user_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_views
    ADD CONSTRAINT user_views_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vector_stores vector_stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vector_stores
    ADD CONSTRAINT vector_stores_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: widget_dashboards widget_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.widget_dashboards
    ADD CONSTRAINT widget_dashboards_pkey PRIMARY KEY (id);


--
-- Name: widgets widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.widgets
    ADD CONSTRAINT widgets_pkey PRIMARY KEY (id);


--
-- Name: customer_owner_processor_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customer_owner_processor_index ON public.pay_customers USING btree (owner_type, owner_id, deleted_at);


--
-- Name: idx_alert_hides_user_account_alert; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alert_hides_user_account_alert ON public.alert_hides USING btree (user_id, account_id, alert_id);


--
-- Name: idx_alert_views_user_alert; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alert_views_user_alert ON public.alert_views USING btree (user_id, alert_id);


--
-- Name: idx_alerts_company_type_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alerts_company_type_created ON public.alerts USING btree (company_id, alert_type, created_at DESC);


--
-- Name: idx_alerts_created_at_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alerts_created_at_type ON public.alerts USING btree (created_at DESC, alert_type);


--
-- Name: idx_company_followers_account_relationship; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_company_followers_account_relationship ON public.company_followers USING btree (account_id, relationship_type);


--
-- Name: idx_company_rels_primary_related_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_company_rels_primary_related_type ON public.company_relationships USING btree (primary_company_id, related_company_id, relationship_type);


--
-- Name: idx_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_gin ON public.topics USING gin (word public.gin_trgm_ops);


--
-- Name: idx_on_account_id_priority_position_7765ae2c6a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_account_id_priority_position_7765ae2c6a ON public.competitor_priorities USING btree (account_id, priority, "position");


--
-- Name: idx_on_account_id_relationship_type_9a2347b1ee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_account_id_relationship_type_9a2347b1ee ON public.company_relationships USING btree (account_id, relationship_type);


--
-- Name: idx_on_company_id_page_type_created_at_grade_0d63f81bd1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_company_id_page_type_created_at_grade_0d63f81bd1 ON public.urls USING btree (company_id, page_type, created_at, grade);


--
-- Name: idx_on_competitor_analysis_id_6d657c8aa9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_competitor_analysis_id_6d657c8aa9 ON public.harvey_ball_competitor_analyses USING btree (competitor_analysis_id);


--
-- Name: idx_on_feature_analysis_id_60863b1e9d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_feature_analysis_id_60863b1e9d ON public.harvey_ball_competitor_analyses USING btree (feature_analysis_id);


--
-- Name: idx_on_journey_map_persona_id_b5c0656c19; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_journey_map_persona_id_b5c0656c19 ON public.journey_map_persona_pain_points USING btree (journey_map_persona_id);


--
-- Name: idx_on_primary_company_id_relationship_type_94437fef70; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_primary_company_id_relationship_type_94437fef70 ON public.company_relationships USING btree (primary_company_id, relationship_type);


--
-- Name: idx_on_product_blueprint_module_id_aff60263ae; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_product_blueprint_module_id_aff60263ae ON public.persona_product_blueprint_modules USING btree (product_blueprint_module_id);


--
-- Name: idx_on_related_company_id_relationship_type_1945124adb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_related_company_id_relationship_type_1945124adb ON public.company_relationships USING btree (related_company_id, relationship_type);


--
-- Name: idx_on_user_story_id_relationship_type_7196d50fd4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_user_story_id_relationship_type_7196d50fd4 ON public.persona_user_stories USING btree (user_story_id, relationship_type);


--
-- Name: idx_persona_user_story_relationship_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_persona_user_story_relationship_unique ON public.persona_user_stories USING btree (persona_id, user_story_id, relationship_type);


--
-- Name: idx_unique_location_per_company; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_unique_location_per_company ON public.urls USING btree (location, company_id);


--
-- Name: index_abraham_histories_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_abraham_histories_on_created_at ON public.abraham_histories USING btree (created_at);


--
-- Name: index_abraham_histories_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_abraham_histories_on_creator_id ON public.abraham_histories USING btree (creator_id);


--
-- Name: index_abraham_histories_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_abraham_histories_on_updated_at ON public.abraham_histories USING btree (updated_at);


--
-- Name: index_account_invitations_on_account_id_and_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_account_invitations_on_account_id_and_email ON public.account_invitations USING btree (account_id, email);


--
-- Name: index_account_invitations_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_account_invitations_on_invited_by_id ON public.account_invitations USING btree (invited_by_id);


--
-- Name: index_account_users_on_account_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_account_users_on_account_id_and_user_id ON public.account_users USING btree (account_id, user_id);


--
-- Name: index_accounts_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_organization_id ON public.accounts USING btree (organization_id);


--
-- Name: index_accounts_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_owner_id ON public.accounts USING btree (owner_id);


--
-- Name: index_action_mailbox_inbound_emails_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_action_mailbox_inbound_emails_uniqueness ON public.action_mailbox_inbound_emails USING btree (message_id, message_checksum);


--
-- Name: index_action_text_rich_texts_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_action_text_rich_texts_uniqueness ON public.action_text_rich_texts USING btree (record_type, record_id, name);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_on_record_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_record_id ON public.active_storage_attachments USING btree (record_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_addresses_on_addressable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_on_addressable ON public.addresses USING btree (addressable_type, addressable_id);


--
-- Name: index_ads_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ads_on_company_id ON public.ads USING btree (company_id);


--
-- Name: index_ads_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ads_on_url_id ON public.ads USING btree (url_id);


--
-- Name: index_ahoy_events_on_name_and_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_events_on_name_and_time ON public.ahoy_events USING btree (name, "time");


--
-- Name: index_ahoy_events_on_properties; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_events_on_properties ON public.ahoy_events USING gin (properties jsonb_path_ops);


--
-- Name: index_ahoy_events_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_events_on_user_id ON public.ahoy_events USING btree (user_id);


--
-- Name: index_ahoy_events_on_visit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_events_on_visit_id ON public.ahoy_events USING btree (visit_id);


--
-- Name: index_ahoy_messages_on_to_bidx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_messages_on_to_bidx ON public.ahoy_messages USING btree (to_bidx);


--
-- Name: index_ahoy_messages_on_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_messages_on_user ON public.ahoy_messages USING btree (user_type, user_id);


--
-- Name: index_ahoy_visits_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_visits_on_user_id ON public.ahoy_visits USING btree (user_id);


--
-- Name: index_ahoy_visits_on_visit_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_ahoy_visits_on_visit_token ON public.ahoy_visits USING btree (visit_token);


--
-- Name: index_ahoy_visits_on_visitor_token_and_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ahoy_visits_on_visitor_token_and_started_at ON public.ahoy_visits USING btree (visitor_token, started_at);


--
-- Name: index_ai_agent_examples_on_agent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_examples_on_agent_id ON public.ai_agent_examples USING btree (agent_id);


--
-- Name: index_ai_agent_messages_on_agent_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_messages_on_agent_task_id ON public.ai_agent_messages USING btree (agent_task_id);


--
-- Name: index_ai_agent_messages_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_messages_on_deleted_at ON public.ai_agent_messages USING btree (deleted_at);


--
-- Name: index_ai_agent_messages_on_streaming; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_messages_on_streaming ON public.ai_agent_messages USING btree (streaming);


--
-- Name: index_ai_agent_tasks_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_account_id ON public.ai_agent_tasks USING btree (account_id);


--
-- Name: index_ai_agent_tasks_on_agent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_agent_id ON public.ai_agent_tasks USING btree (agent_id);


--
-- Name: index_ai_agent_tasks_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_deleted_at ON public.ai_agent_tasks USING btree (deleted_at);


--
-- Name: index_ai_agent_tasks_on_execution_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_execution_started_at ON public.ai_agent_tasks USING btree (execution_started_at);


--
-- Name: index_ai_agent_tasks_on_memory_strategy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_memory_strategy ON public.ai_agent_tasks USING btree (memory_strategy);


--
-- Name: index_ai_agent_tasks_on_object_type_and_object_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_object_type_and_object_id ON public.ai_agent_tasks USING btree (object_type, object_id);


--
-- Name: index_ai_agent_tasks_on_parent_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_parent_task_id ON public.ai_agent_tasks USING btree (parent_task_id);


--
-- Name: index_ai_agent_tasks_on_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_persona_id ON public.ai_agent_tasks USING btree (persona_id);


--
-- Name: index_ai_agent_tasks_on_project_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_project_section_id ON public.ai_agent_tasks USING btree (project_section_id);


--
-- Name: index_ai_agent_tasks_on_rename_job_enqueued; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_rename_job_enqueued ON public.ai_agent_tasks USING btree (rename_job_enqueued);


--
-- Name: index_ai_agent_tasks_on_task_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_task_type ON public.ai_agent_tasks USING btree (task_type);


--
-- Name: index_ai_agent_tasks_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agent_tasks_on_user_id ON public.ai_agent_tasks USING btree (user_id);


--
-- Name: index_ai_agents_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agents_on_account_id ON public.ai_agents USING btree (account_id);


--
-- Name: index_ai_agents_on_agent_tasks_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agents_on_agent_tasks_count ON public.ai_agents USING btree (agent_tasks_count);


--
-- Name: index_ai_agents_on_agent_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agents_on_agent_type ON public.ai_agents USING btree (agent_type);


--
-- Name: index_ai_agents_on_auto_start; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agents_on_auto_start ON public.ai_agents USING btree (auto_start);


--
-- Name: index_ai_agents_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agents_on_deleted_at ON public.ai_agents USING btree (deleted_at);


--
-- Name: index_ai_agents_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ai_agents_on_user_id ON public.ai_agents USING btree (user_id);


--
-- Name: index_alert_hides_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_hides_on_account_id ON public.alert_hides USING btree (account_id);


--
-- Name: index_alert_hides_on_alert_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_hides_on_alert_id ON public.alert_hides USING btree (alert_id);


--
-- Name: index_alert_hides_on_alert_user_account_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_alert_hides_on_alert_user_account_unique ON public.alert_hides USING btree (alert_id, user_id, account_id);


--
-- Name: index_alert_hides_on_hidden_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_hides_on_hidden_at ON public.alert_hides USING btree (hidden_at);


--
-- Name: index_alert_hides_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_hides_on_user_id ON public.alert_hides USING btree (user_id);


--
-- Name: index_alert_hides_on_user_id_and_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_hides_on_user_id_and_account_id ON public.alert_hides USING btree (user_id, account_id);


--
-- Name: index_alert_ratings_on_agent_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_ratings_on_agent_task_id ON public.alert_ratings USING btree (agent_task_id);


--
-- Name: index_alert_ratings_on_agent_task_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_ratings_on_agent_task_id_and_user_id ON public.alert_ratings USING btree (agent_task_id, user_id);


--
-- Name: index_alert_ratings_on_alert_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_ratings_on_alert_id ON public.alert_ratings USING btree (alert_id);


--
-- Name: index_alert_ratings_on_alert_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_alert_ratings_on_alert_id_and_user_id ON public.alert_ratings USING btree (alert_id, user_id);


--
-- Name: index_alert_ratings_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_ratings_on_user_id ON public.alert_ratings USING btree (user_id);


--
-- Name: index_alert_views_on_alert_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_views_on_alert_id ON public.alert_views USING btree (alert_id);


--
-- Name: index_alert_views_on_alert_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_alert_views_on_alert_id_and_user_id ON public.alert_views USING btree (alert_id, user_id);


--
-- Name: index_alert_views_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_views_on_user_id ON public.alert_views USING btree (user_id);


--
-- Name: index_alert_views_on_user_id_and_viewed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_views_on_user_id_and_viewed_at ON public.alert_views USING btree (user_id, viewed_at);


--
-- Name: index_alert_views_on_viewed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alert_views_on_viewed_at ON public.alert_views USING btree (viewed_at);


--
-- Name: index_alerts_on_alert_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alerts_on_alert_type ON public.alerts USING btree (alert_type);


--
-- Name: index_alerts_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alerts_on_company_id ON public.alerts USING btree (company_id);


--
-- Name: index_alerts_on_url_alert_type_company_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_alerts_on_url_alert_type_company_unique ON public.alerts USING btree (url_id, alert_type, company_id);


--
-- Name: index_alerts_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alerts_on_url_id ON public.alerts USING btree (url_id);


--
-- Name: index_alerts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_alerts_on_user_id ON public.alerts USING btree (user_id);


--
-- Name: index_analysis_companies_on_analysis_and_company; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_analysis_companies_on_analysis_and_company ON public.analysis_companies USING btree (competitor_analysis_id, company_id);


--
-- Name: index_analysis_companies_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analysis_companies_on_company_id ON public.analysis_companies USING btree (company_id);


--
-- Name: index_analysis_companies_on_competitor_analysis_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analysis_companies_on_competitor_analysis_id ON public.analysis_companies USING btree (competitor_analysis_id);


--
-- Name: index_analysis_companies_on_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analysis_companies_on_position ON public.analysis_companies USING btree ("position");


--
-- Name: index_api_tokens_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_api_tokens_on_token ON public.api_tokens USING btree (token);


--
-- Name: index_api_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_api_tokens_on_user_id ON public.api_tokens USING btree (user_id);


--
-- Name: index_artifacts_on_artifact_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artifacts_on_artifact_type ON public.artifacts USING btree (artifact_type);


--
-- Name: index_artifacts_on_artifactable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artifacts_on_artifactable ON public.artifacts USING btree (artifactable_type, artifactable_id);


--
-- Name: index_artifacts_on_artifactable_and_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artifacts_on_artifactable_and_type ON public.artifacts USING btree (artifactable_type, artifactable_id, artifact_type);


--
-- Name: index_artifacts_on_product_blueprint_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artifacts_on_product_blueprint_id ON public.artifacts USING btree (product_blueprint_id);


--
-- Name: index_artifacts_on_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artifacts_on_task_id ON public.artifacts USING btree (task_id);


--
-- Name: index_blazer_audits_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_audits_on_query_id ON public.blazer_audits USING btree (query_id);


--
-- Name: index_blazer_audits_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_audits_on_user_id ON public.blazer_audits USING btree (user_id);


--
-- Name: index_blazer_checks_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_checks_on_creator_id ON public.blazer_checks USING btree (creator_id);


--
-- Name: index_blazer_checks_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_checks_on_query_id ON public.blazer_checks USING btree (query_id);


--
-- Name: index_blazer_dashboard_queries_on_dashboard_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_dashboard_queries_on_dashboard_id ON public.blazer_dashboard_queries USING btree (dashboard_id);


--
-- Name: index_blazer_dashboard_queries_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_dashboard_queries_on_query_id ON public.blazer_dashboard_queries USING btree (query_id);


--
-- Name: index_blazer_dashboards_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_dashboards_on_creator_id ON public.blazer_dashboards USING btree (creator_id);


--
-- Name: index_blazer_queries_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blazer_queries_on_creator_id ON public.blazer_queries USING btree (creator_id);


--
-- Name: index_block_ai_agents_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_block_ai_agents_on_account_id ON public.block_ai_agents USING btree (account_id);


--
-- Name: index_block_ai_agents_on_agent_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_block_ai_agents_on_agent_config ON public.block_ai_agents USING gin (agent_config);


--
-- Name: index_block_ai_agents_on_ai_agent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_block_ai_agents_on_ai_agent_id ON public.block_ai_agents USING btree (ai_agent_id);


--
-- Name: index_block_ai_agents_on_blockable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_block_ai_agents_on_blockable ON public.block_ai_agents USING btree (blockable_type, blockable_id);


--
-- Name: index_block_ai_agents_on_last_run_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_block_ai_agents_on_last_run_at ON public.block_ai_agents USING btree (last_run_at);


--
-- Name: index_block_ai_agents_on_next_run_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_block_ai_agents_on_next_run_at ON public.block_ai_agents USING btree (next_run_at);


--
-- Name: index_block_ai_agents_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_block_ai_agents_on_status ON public.block_ai_agents USING btree (status);


--
-- Name: index_block_ai_agents_on_trigger_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_block_ai_agents_on_trigger_type ON public.block_ai_agents USING btree (trigger_type);


--
-- Name: index_bookmarks_on_bookmarkable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookmarks_on_bookmarkable ON public.bookmarks USING btree (bookmarkable_type, bookmarkable_id);


--
-- Name: index_bookmarks_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookmarks_on_project_id ON public.bookmarks USING btree (project_id);


--
-- Name: index_bookmarks_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookmarks_on_user_id ON public.bookmarks USING btree (user_id);


--
-- Name: index_chat_histories_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chat_histories_on_user_id ON public.chat_histories USING btree (user_id);


--
-- Name: index_chat_messages_on_chat_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chat_messages_on_chat_id ON public.chat_messages USING btree (chat_id);


--
-- Name: index_chat_messages_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chat_messages_on_deleted_at ON public.chat_messages USING btree (deleted_at);


--
-- Name: index_chats_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chats_on_account_id ON public.chats USING btree (account_id);


--
-- Name: index_chats_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chats_on_deleted_at ON public.chats USING btree (deleted_at);


--
-- Name: index_chats_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chats_on_user_id ON public.chats USING btree (user_id);


--
-- Name: index_comments_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_account_id ON public.comments USING btree (account_id);


--
-- Name: index_comments_on_commentable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_commentable ON public.comments USING btree (commentable_type, commentable_id);


--
-- Name: index_comments_on_commentable_id_and_commentable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_commentable_id_and_commentable_type ON public.comments USING btree (commentable_id, commentable_type);


--
-- Name: index_comments_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_parent_id ON public.comments USING btree (parent_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_companies_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_account_id ON public.companies USING btree (account_id);


--
-- Name: index_companies_on_active_scrape_and_linkedin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_active_scrape_and_linkedin ON public.companies USING btree (active_scrape, linked_profile_url);


--
-- Name: index_companies_on_active_scrape_and_twitter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_active_scrape_and_twitter ON public.companies USING btree (active_scrape, twitter);


--
-- Name: index_companies_on_last_checked_website; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_last_checked_website ON public.companies USING btree (last_checked_website);


--
-- Name: index_companies_on_last_linkedin_activity_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_last_linkedin_activity_at ON public.companies USING btree (last_linkedin_activity_at);


--
-- Name: index_companies_on_market_position_calculated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_market_position_calculated_at ON public.companies USING btree (market_position_calculated_at);


--
-- Name: index_companies_on_market_segment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_market_segment_id ON public.companies USING btree (market_segment_id);


--
-- Name: index_companies_on_market_segment_id_and_market_position_rank; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_market_segment_id_and_market_position_rank ON public.companies USING btree (market_segment_id, market_position_rank);


--
-- Name: index_companies_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_owner_id ON public.companies USING btree (owner_id);


--
-- Name: index_companies_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_team_id ON public.companies USING btree (team_id);


--
-- Name: index_companies_on_year_founded; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_year_founded ON public.companies USING btree (year_founded);


--
-- Name: index_company_blueprint_associations_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_blueprint_associations_on_company_id ON public.company_blueprint_associations USING btree (company_id);


--
-- Name: index_company_blueprint_associations_on_product_blueprint_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_blueprint_associations_on_product_blueprint_id ON public.company_blueprint_associations USING btree (product_blueprint_id);


--
-- Name: index_company_collection_memberships_on_company_collection_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_collection_memberships_on_company_collection_id ON public.company_collection_memberships USING btree (company_collection_id);


--
-- Name: index_company_collection_memberships_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_collection_memberships_on_company_id ON public.company_collection_memberships USING btree (company_id);


--
-- Name: index_company_competitors_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_competitors_on_company_id ON public.company_competitors USING btree (company_id);


--
-- Name: index_company_competitors_on_competitor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_competitors_on_competitor_id ON public.company_competitors USING btree (competitor_id);


--
-- Name: index_company_customers_on_customer_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_customers_on_customer_company_id ON public.company_customers USING btree (customer_company_id);


--
-- Name: index_company_customers_on_provider_and_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_customers_on_provider_and_customer_id ON public.company_customers USING btree (provider_company_id, customer_company_id);


--
-- Name: index_company_finances_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_finances_on_company_id ON public.company_finances USING btree (company_id);


--
-- Name: index_company_followers_on_account_and_relationship_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_account_and_relationship_type ON public.company_followers USING btree (account_id, relationship_type);


--
-- Name: index_company_followers_on_account_company_relationship; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_account_company_relationship ON public.company_followers USING btree (account_id, company_id, relationship_type);


--
-- Name: index_company_followers_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_account_id ON public.company_followers USING btree (account_id);


--
-- Name: index_company_followers_on_account_id_and_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_account_id_and_company_id ON public.company_followers USING btree (account_id, company_id);


--
-- Name: index_company_followers_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_company_id ON public.company_followers USING btree (company_id);


--
-- Name: index_company_followers_on_company_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_company_id_and_user_id ON public.company_followers USING btree (company_id, user_id);


--
-- Name: index_company_followers_on_relationship_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_relationship_type ON public.company_followers USING btree (relationship_type);


--
-- Name: index_company_followers_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_team_id ON public.company_followers USING btree (team_id);


--
-- Name: index_company_followers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_followers_on_user_id ON public.company_followers USING btree (user_id);


--
-- Name: index_company_keyword_counts_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_keyword_counts_on_company_id ON public.company_keyword_counts USING btree (company_id);


--
-- Name: index_company_keyword_counts_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_keyword_counts_on_keyword_id ON public.company_keyword_counts USING btree (keyword_id);


--
-- Name: index_company_managers_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_managers_on_account_id ON public.company_managers USING btree (account_id);


--
-- Name: index_company_managers_on_company_and_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_managers_on_company_and_account ON public.company_managers USING btree (company_id, account_id);


--
-- Name: index_company_managers_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_managers_on_company_id ON public.company_managers USING btree (company_id);


--
-- Name: index_company_managers_on_company_id_and_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_managers_on_company_id_and_account_id ON public.company_managers USING btree (company_id, account_id);


--
-- Name: index_company_managers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_managers_on_user_id ON public.company_managers USING btree (user_id);


--
-- Name: index_company_managers_on_user_id_and_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_managers_on_user_id_and_account_id ON public.company_managers USING btree (user_id, account_id);


--
-- Name: index_company_news_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_news_on_company_id ON public.company_news USING btree (company_id);


--
-- Name: index_company_owners_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_owners_on_account_id ON public.company_owners USING btree (account_id);


--
-- Name: index_company_owners_on_account_id_and_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_owners_on_account_id_and_company_id ON public.company_owners USING btree (account_id, company_id);


--
-- Name: index_company_owners_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_owners_on_company_id ON public.company_owners USING btree (company_id);


--
-- Name: index_company_owners_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_owners_on_user_id ON public.company_owners USING btree (user_id);


--
-- Name: index_company_relationships_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_relationships_on_account_id ON public.company_relationships USING btree (account_id);


--
-- Name: index_company_relationships_on_primary_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_relationships_on_primary_company_id ON public.company_relationships USING btree (primary_company_id);


--
-- Name: index_company_relationships_on_related_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_relationships_on_related_company_id ON public.company_relationships USING btree (related_company_id);


--
-- Name: index_company_url_filters_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_url_filters_on_company_id ON public.company_url_filters USING btree (company_id);


--
-- Name: index_company_url_filters_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_url_filters_on_user_id ON public.company_url_filters USING btree (user_id);


--
-- Name: index_company_weekly_reports_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_company_weekly_reports_on_company_id ON public.company_weekly_reports USING btree (company_id);


--
-- Name: index_comparison_lines_on_comparison_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comparison_lines_on_comparison_id ON public.comparison_lines USING btree (comparison_id);


--
-- Name: index_comparisons_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comparisons_on_account_id ON public.comparisons USING btree (account_id);


--
-- Name: index_comparisons_on_product_1_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comparisons_on_product_1_id ON public.comparisons USING btree (product_1_id);


--
-- Name: index_comparisons_on_product_2_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comparisons_on_product_2_id ON public.comparisons USING btree (product_2_id);


--
-- Name: index_competitor_analyses_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_competitor_analyses_on_account_id ON public.competitor_analyses USING btree (account_id);


--
-- Name: index_competitor_analyses_on_public_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_competitor_analyses_on_public_slug ON public.competitor_analyses USING btree (public_slug);


--
-- Name: index_competitor_analyses_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_competitor_analyses_on_user_id ON public.competitor_analyses USING btree (user_id);


--
-- Name: index_competitor_priorities_on_account_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_competitor_priorities_on_account_and_position ON public.competitor_priorities USING btree (account_id, "position");


--
-- Name: index_competitor_priorities_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_competitor_priorities_on_account_id ON public.competitor_priorities USING btree (account_id);


--
-- Name: index_competitor_priorities_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_competitor_priorities_on_company_id ON public.competitor_priorities USING btree (company_id);


--
-- Name: index_competitor_reports_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_competitor_reports_on_company_id ON public.competitor_reports USING btree (company_id);


--
-- Name: index_connected_accounts_on_owner_id_and_owner_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connected_accounts_on_owner_id_and_owner_type ON public.connected_accounts USING btree (owner_id, owner_type);


--
-- Name: index_content_blocks_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_account_id ON public.content_blocks USING btree (account_id);


--
-- Name: index_content_blocks_on_block_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_block_config ON public.content_blocks USING gin (block_config);


--
-- Name: index_content_blocks_on_block_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_block_type ON public.content_blocks USING btree (block_type);


--
-- Name: index_content_blocks_on_content_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_content_data ON public.content_blocks USING gin (content_data);


--
-- Name: index_content_blocks_on_document_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_document_section_id ON public.content_blocks USING btree (document_section_id);


--
-- Name: index_content_blocks_on_document_section_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_content_blocks_on_document_section_id_and_position ON public.content_blocks USING btree (document_section_id, "position");


--
-- Name: index_content_blocks_on_last_modified_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_last_modified_by_id ON public.content_blocks USING btree (last_modified_by_id);


--
-- Name: index_content_blocks_on_layout_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_layout_config ON public.content_blocks USING gin (layout_config);


--
-- Name: index_content_blocks_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_user_id ON public.content_blocks USING btree (user_id);


--
-- Name: index_content_blocks_on_visible; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_blocks_on_visible ON public.content_blocks USING btree (visible);


--
-- Name: index_contents_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contents_on_account_id ON public.contents USING btree (account_id);


--
-- Name: index_contents_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contents_on_user_id ON public.contents USING btree (user_id);


--
-- Name: index_daily_digests_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_daily_digests_on_account_id ON public.daily_digests USING btree (account_id);


--
-- Name: index_data_quality_companies_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_quality_companies_on_company_id ON public.data_quality_companies USING btree (company_id);


--
-- Name: index_data_sets_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_sets_on_account_id ON public.data_sets USING btree (account_id);


--
-- Name: index_data_sets_on_data_model; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_sets_on_data_model ON public.data_sets USING btree (data_model);


--
-- Name: index_data_sets_on_description_md5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_sets_on_description_md5 ON public.data_sets USING btree (md5(description));


--
-- Name: index_data_sets_on_metric; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_sets_on_metric ON public.data_sets USING btree (metric);


--
-- Name: index_document_collaborations_on_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_collaborations_on_document_id ON public.document_collaborations USING btree (document_id);


--
-- Name: index_document_collaborations_on_document_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_document_collaborations_on_document_id_and_user_id ON public.document_collaborations USING btree (document_id, user_id);


--
-- Name: index_document_collaborations_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_collaborations_on_invited_by_id ON public.document_collaborations USING btree (invited_by_id);


--
-- Name: index_document_collaborations_on_last_accessed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_collaborations_on_last_accessed_at ON public.document_collaborations USING btree (last_accessed_at);


--
-- Name: index_document_collaborations_on_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_collaborations_on_role ON public.document_collaborations USING btree (role);


--
-- Name: index_document_collaborations_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_collaborations_on_status ON public.document_collaborations USING btree (status);


--
-- Name: index_document_collaborations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_collaborations_on_user_id ON public.document_collaborations USING btree (user_id);


--
-- Name: index_document_exports_on_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_exports_on_document_id ON public.document_exports USING btree (document_id);


--
-- Name: index_document_exports_on_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_exports_on_expires_at ON public.document_exports USING btree (expires_at);


--
-- Name: index_document_exports_on_export_format; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_exports_on_export_format ON public.document_exports USING btree (export_format);


--
-- Name: index_document_exports_on_export_options; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_exports_on_export_options ON public.document_exports USING gin (export_options);


--
-- Name: index_document_exports_on_exported_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_exports_on_exported_at ON public.document_exports USING btree (exported_at);


--
-- Name: index_document_exports_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_exports_on_status ON public.document_exports USING btree (status);


--
-- Name: index_document_exports_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_exports_on_user_id ON public.document_exports USING btree (user_id);


--
-- Name: index_document_sections_on_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_sections_on_document_id ON public.document_sections USING btree (document_id);


--
-- Name: index_document_sections_on_document_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_document_sections_on_document_id_and_position ON public.document_sections USING btree (document_id, "position");


--
-- Name: index_document_sections_on_layout_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_sections_on_layout_config ON public.document_sections USING gin (layout_config);


--
-- Name: index_document_sections_on_section_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_sections_on_section_type ON public.document_sections USING btree (section_type);


--
-- Name: index_document_sections_on_template_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_sections_on_template_section_id ON public.document_sections USING btree (template_section_id);


--
-- Name: index_document_sections_on_visible; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_sections_on_visible ON public.document_sections USING btree (visible);


--
-- Name: index_document_tags_on_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_tags_on_document_id ON public.document_tags USING btree (document_id);


--
-- Name: index_document_tags_on_document_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_document_tags_on_document_id_and_name ON public.document_tags USING btree (document_id, name);


--
-- Name: index_document_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_tags_on_name ON public.document_tags USING btree (name);


--
-- Name: index_document_templates_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_templates_on_account_id ON public.document_templates USING btree (account_id);


--
-- Name: index_document_templates_on_account_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_document_templates_on_account_id_and_name ON public.document_templates USING btree (account_id, name);


--
-- Name: index_document_templates_on_is_public; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_templates_on_is_public ON public.document_templates USING btree (is_public);


--
-- Name: index_document_templates_on_layout_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_templates_on_layout_config ON public.document_templates USING gin (layout_config);


--
-- Name: index_document_templates_on_metadata; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_templates_on_metadata ON public.document_templates USING gin (metadata);


--
-- Name: index_document_templates_on_parent_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_templates_on_parent_template_id ON public.document_templates USING btree (parent_template_id);


--
-- Name: index_document_templates_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_templates_on_status ON public.document_templates USING btree (status);


--
-- Name: index_document_templates_on_template_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_templates_on_template_type ON public.document_templates USING btree (template_type);


--
-- Name: index_document_templates_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_templates_on_user_id ON public.document_templates USING btree (user_id);


--
-- Name: index_document_versions_on_document_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_versions_on_document_data ON public.document_versions USING gin (document_data);


--
-- Name: index_document_versions_on_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_versions_on_document_id ON public.document_versions USING btree (document_id);


--
-- Name: index_document_versions_on_document_id_and_version_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_document_versions_on_document_id_and_version_number ON public.document_versions USING btree (document_id, version_number);


--
-- Name: index_document_versions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_document_versions_on_user_id ON public.document_versions USING btree (user_id);


--
-- Name: index_documents_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_account_id ON public.documents USING btree (account_id);


--
-- Name: index_documents_on_account_id_and_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_account_id_and_title ON public.documents USING btree (account_id, title);


--
-- Name: index_documents_on_document_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_document_template_id ON public.documents USING btree (document_template_id);


--
-- Name: index_documents_on_last_edited_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_last_edited_at ON public.documents USING btree (last_edited_at);


--
-- Name: index_documents_on_last_edited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_last_edited_by_id ON public.documents USING btree (last_edited_by_id);


--
-- Name: index_documents_on_metadata; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_metadata ON public.documents USING gin (metadata);


--
-- Name: index_documents_on_parent_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_parent_document_id ON public.documents USING btree (parent_document_id);


--
-- Name: index_documents_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_status ON public.documents USING btree (status);


--
-- Name: index_documents_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_user_id ON public.documents USING btree (user_id);


--
-- Name: index_email_trackers_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_email_trackers_on_token ON public.email_trackers USING btree (token);


--
-- Name: index_email_trackers_on_trackable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_email_trackers_on_trackable ON public.email_trackers USING btree (trackable_type, trackable_id);


--
-- Name: index_email_trackers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_email_trackers_on_user_id ON public.email_trackers USING btree (user_id);


--
-- Name: index_email_weekly_digests_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_email_weekly_digests_on_account_id ON public.email_weekly_digests USING btree (account_id);


--
-- Name: index_email_weekly_digests_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_email_weekly_digests_on_user_id ON public.email_weekly_digests USING btree (user_id);


--
-- Name: index_emails_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emails_on_person_id ON public.emails USING btree (person_id);


--
-- Name: index_event_attendances_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_attendances_on_company_id ON public.event_attendances USING btree (company_id);


--
-- Name: index_event_attendances_on_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_attendances_on_event_id ON public.event_attendances USING btree (event_id);


--
-- Name: index_event_followers_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_followers_on_account_id ON public.event_followers USING btree (account_id);


--
-- Name: index_event_followers_on_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_followers_on_event_id ON public.event_followers USING btree (event_id);


--
-- Name: index_event_speakers_on_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_speakers_on_event_id ON public.event_speakers USING btree (event_id);


--
-- Name: index_event_speakers_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_speakers_on_person_id ON public.event_speakers USING btree (person_id);


--
-- Name: index_event_speakers_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_event_speakers_on_url_id ON public.event_speakers USING btree (url_id);


--
-- Name: index_evidences_on_agent_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_agent_task_id ON public.evidences USING btree (agent_task_id);


--
-- Name: index_evidences_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_company_id ON public.evidences USING btree (company_id);


--
-- Name: index_evidences_on_company_id_and_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_company_id_and_feature_id ON public.evidences USING btree (company_id, feature_id);


--
-- Name: index_evidences_on_company_id_and_feature_id_and_discovered_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_company_id_and_feature_id_and_discovered_at ON public.evidences USING btree (company_id, feature_id, discovered_at);


--
-- Name: index_evidences_on_dataset_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_dataset_id ON public.evidences USING btree (dataset_id);


--
-- Name: index_evidences_on_discovered_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_discovered_at ON public.evidences USING btree (discovered_at);


--
-- Name: index_evidences_on_feature_analysis_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_feature_analysis_id ON public.evidences USING btree (feature_analysis_id);


--
-- Name: index_evidences_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_feature_id ON public.evidences USING btree (feature_id);


--
-- Name: index_evidences_on_source_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_source_published_at ON public.evidences USING btree (source_published_at);


--
-- Name: index_evidences_on_source_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_evidences_on_source_type ON public.evidences USING btree (source_type);


--
-- Name: index_facts_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_facts_on_company_id ON public.facts USING btree (company_id);


--
-- Name: index_facts_on_content; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_facts_on_content ON public.facts USING btree (content);


--
-- Name: index_facts_on_product_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_facts_on_product_feature_id ON public.facts USING btree (product_feature_id);


--
-- Name: index_facts_on_product_feature_id_and_content_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_facts_on_product_feature_id_and_content_published_at ON public.facts USING btree (product_feature_id, content_published_at);


--
-- Name: index_facts_on_prominence_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_facts_on_prominence_score ON public.facts USING btree (prominence_score);


--
-- Name: index_facts_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_facts_on_url_id ON public.facts USING btree (url_id);


--
-- Name: index_feature_analyses_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_account_id ON public.feature_analyses USING btree (account_id);


--
-- Name: index_feature_analyses_on_agent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_agent_id ON public.feature_analyses USING btree (agent_id);


--
-- Name: index_feature_analyses_on_ai_agent_task; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_ai_agent_task ON public.feature_analyses USING btree (ai_agent_task);


--
-- Name: index_feature_analyses_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_company_id ON public.feature_analyses USING btree (company_id);


--
-- Name: index_feature_analyses_on_confidence_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_confidence_score ON public.feature_analyses USING btree (confidence_score);


--
-- Name: index_feature_analyses_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_feature_id ON public.feature_analyses USING btree (feature_id);


--
-- Name: index_feature_analyses_on_harvey_ball_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_harvey_ball_score ON public.feature_analyses USING btree (harvey_ball_score);


--
-- Name: index_feature_analyses_on_manual_override; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_manual_override ON public.feature_analyses USING btree (manual_override);


--
-- Name: index_feature_analyses_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analyses_on_updated_at ON public.feature_analyses USING btree (updated_at);


--
-- Name: index_feature_analysis_snapshots_on_harvey_ball_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analysis_snapshots_on_harvey_ball_score ON public.feature_analysis_snapshots USING btree (harvey_ball_score);


--
-- Name: index_feature_analysis_snapshots_on_product_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analysis_snapshots_on_product_feature_id ON public.feature_analysis_snapshots USING btree (product_feature_id);


--
-- Name: index_feature_analysis_snapshots_on_trend_direction; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_analysis_snapshots_on_trend_direction ON public.feature_analysis_snapshots USING btree (trend_direction);


--
-- Name: index_feature_capabilities_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_capabilities_on_company_id ON public.feature_capabilities USING btree (company_id);


--
-- Name: index_feature_capabilities_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_capabilities_on_feature_id ON public.feature_capabilities USING btree (feature_id);


--
-- Name: index_feature_capabilities_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_capabilities_on_product_id ON public.feature_capabilities USING btree (product_id);


--
-- Name: index_feature_capabilities_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_capabilities_on_url_id ON public.feature_capabilities USING btree (url_id);


--
-- Name: index_feature_keywords_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_keywords_on_feature_id ON public.feature_keywords USING btree (feature_id);


--
-- Name: index_feature_keywords_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_keywords_on_keyword_id ON public.feature_keywords USING btree (keyword_id);


--
-- Name: index_feature_urls_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_urls_on_feature_id ON public.feature_urls USING btree (feature_id);


--
-- Name: index_feature_urls_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feature_urls_on_url_id ON public.feature_urls USING btree (url_id);


--
-- Name: index_features_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_account_id ON public.features USING btree (account_id);


--
-- Name: index_features_on_integer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_integer ON public.features USING btree ("integer");


--
-- Name: index_features_on_lft; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_lft ON public.features USING btree (lft);


--
-- Name: index_features_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_parent_id ON public.features USING btree (parent_id);


--
-- Name: index_features_on_product_blueprint_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_product_blueprint_id ON public.features USING btree (product_blueprint_id);


--
-- Name: index_features_on_product_blueprint_module_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_product_blueprint_module_id ON public.features USING btree (product_blueprint_module_id);


--
-- Name: index_features_on_rgt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_rgt ON public.features USING btree (rgt);


--
-- Name: index_features_on_tmp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_tmp ON public.features USING btree (tmp);


--
-- Name: index_features_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_user_id ON public.features USING btree (user_id);


--
-- Name: index_file_questions_on_file_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_file_questions_on_file_id ON public.file_questions USING btree (file_id);


--
-- Name: index_file_questions_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_file_questions_on_project_id ON public.file_questions USING btree (project_id);


--
-- Name: index_file_questions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_file_questions_on_user_id ON public.file_questions USING btree (user_id);


--
-- Name: index_flipper_features_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_flipper_features_on_key ON public.flipper_features USING btree (key);


--
-- Name: index_flipper_gates_on_feature_key_and_key_and_value; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_flipper_gates_on_feature_key_and_key_and_value ON public.flipper_gates USING btree (feature_key, key, value);


--
-- Name: index_grade_configurations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_grade_configurations_on_user_id ON public.grade_configurations USING btree (user_id);


--
-- Name: index_harvey_ball_analyses_unique_company_feature_account; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_harvey_ball_analyses_unique_company_feature_account ON public.feature_analyses USING btree (company_id, feature_id, account_id);


--
-- Name: index_harvey_ball_competitor_analyses_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_harvey_ball_competitor_analyses_position ON public.harvey_ball_competitor_analyses USING btree (competitor_analysis_id, "position");


--
-- Name: index_harvey_ball_competitor_analyses_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_harvey_ball_competitor_analyses_unique ON public.harvey_ball_competitor_analyses USING btree (feature_analysis_id, competitor_analysis_id);


--
-- Name: index_headers_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_headers_on_url_id ON public.headers USING btree (url_id);


--
-- Name: index_ignore_domains_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ignore_domains_on_company_id ON public.ignore_domains USING btree (company_id);


--
-- Name: index_ignore_patterns_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ignore_patterns_on_company_id ON public.ignore_patterns USING btree (company_id);


--
-- Name: index_import_maps_on_import_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_import_maps_on_import_id ON public.import_maps USING btree (import_id);


--
-- Name: index_imports_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_account_id ON public.imports USING btree (account_id);


--
-- Name: index_imports_on_people_list_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_people_list_id ON public.imports USING btree (people_list_id);


--
-- Name: index_imports_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_imports_on_user_id ON public.imports USING btree (user_id);


--
-- Name: index_integrations_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_integrations_on_account_id ON public.integrations USING btree (account_id);


--
-- Name: index_jobs_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_company_id ON public.jobs USING btree (company_id);


--
-- Name: index_jobs_on_company_id_and_department_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_company_id_and_department_and_status ON public.jobs USING btree (company_id, department, status);


--
-- Name: index_jobs_on_company_id_and_discovered_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_company_id_and_discovered_at ON public.jobs USING btree (company_id, discovered_at);


--
-- Name: index_jobs_on_company_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_company_id_and_status ON public.jobs USING btree (company_id, status);


--
-- Name: index_jobs_on_department; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_department ON public.jobs USING btree (department);


--
-- Name: index_jobs_on_discovered_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_discovered_at ON public.jobs USING btree (discovered_at);


--
-- Name: index_jobs_on_experience_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_experience_level ON public.jobs USING btree (experience_level);


--
-- Name: index_jobs_on_job_function; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_job_function ON public.jobs USING btree (job_function);


--
-- Name: index_jobs_on_remote; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_remote ON public.jobs USING btree (remote);


--
-- Name: index_jobs_on_removed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_removed_at ON public.jobs USING btree (removed_at);


--
-- Name: index_jobs_on_status_and_removed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_status_and_removed_at ON public.jobs USING btree (status, removed_at);


--
-- Name: index_jobs_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_url_id ON public.jobs USING btree (url_id);


--
-- Name: index_journey_emotions_on_journey_map_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_emotions_on_journey_map_id ON public.journey_emotions USING btree (journey_map_id);


--
-- Name: index_journey_emotions_on_journey_stage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_emotions_on_journey_stage_id ON public.journey_emotions USING btree (journey_stage_id);


--
-- Name: index_journey_map_persona_needs_on_journey_map_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_map_persona_needs_on_journey_map_persona_id ON public.journey_map_persona_needs USING btree (journey_map_persona_id);


--
-- Name: index_journey_map_personas_on_journey_map_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_map_personas_on_journey_map_id ON public.journey_map_personas USING btree (journey_map_id);


--
-- Name: index_journey_map_personas_on_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_map_personas_on_persona_id ON public.journey_map_personas USING btree (persona_id);


--
-- Name: index_journey_maps_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_maps_on_account_id ON public.journey_maps USING btree (account_id);


--
-- Name: index_journey_maps_on_agent_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_maps_on_agent_task_id ON public.journey_maps USING btree (agent_task_id);


--
-- Name: index_journey_maps_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_maps_on_deleted_at ON public.journey_maps USING btree (deleted_at);


--
-- Name: index_journey_maps_on_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_maps_on_persona_id ON public.journey_maps USING btree (persona_id);


--
-- Name: index_journey_maps_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_maps_on_project_id ON public.journey_maps USING btree (project_id);


--
-- Name: index_journey_maps_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_maps_on_user_id ON public.journey_maps USING btree (user_id);


--
-- Name: index_journey_opportunities_on_journey_stage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_opportunities_on_journey_stage_id ON public.journey_opportunities USING btree (journey_stage_id);


--
-- Name: index_journey_stages_on_journey_map_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_stages_on_journey_map_id ON public.journey_stages USING btree (journey_map_id);


--
-- Name: index_journey_stages_on_journey_map_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_journey_stages_on_journey_map_id_and_position ON public.journey_stages USING btree (journey_map_id, "position");


--
-- Name: index_journey_thoughts_on_journey_stage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_thoughts_on_journey_stage_id ON public.journey_thoughts USING btree (journey_stage_id);


--
-- Name: index_journey_touchpoints_on_journey_stage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_journey_touchpoints_on_journey_stage_id ON public.journey_touchpoints USING btree (journey_stage_id);


--
-- Name: index_keyword_embeddings_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_embeddings_on_keyword_id ON public.keyword_embeddings USING btree (keyword_id);


--
-- Name: index_keyword_group_items_on_keyword_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_group_items_on_keyword_group_id ON public.keyword_group_items USING btree (keyword_group_id);


--
-- Name: index_keyword_group_items_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_group_items_on_keyword_id ON public.keyword_group_items USING btree (keyword_id);


--
-- Name: index_keyword_groups_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_groups_on_account_id ON public.keyword_groups USING btree (account_id);


--
-- Name: index_keyword_quarentine_on_url_count_and_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_quarentine_on_url_count_and_id ON public.keyword_quarentines USING btree (url_count, id);


--
-- Name: index_keyword_stats_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_stats_on_account_id ON public.keyword_stats USING btree (account_id);


--
-- Name: index_keyword_stats_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_stats_on_keyword_id ON public.keyword_stats USING btree (keyword_id);


--
-- Name: index_keyword_trends_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_trends_on_keyword_id ON public.keyword_trends USING btree (keyword_id);


--
-- Name: index_keyword_urls_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_urls_on_company_id ON public.keyword_urls USING btree (company_id);


--
-- Name: index_keyword_urls_on_keyword_id_and_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_urls_on_keyword_id_and_url_id ON public.keyword_urls USING btree (keyword_id, url_id);


--
-- Name: index_keyword_urls_on_keyword_quarentine_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_urls_on_keyword_quarentine_id ON public.keyword_urls USING btree (keyword_quarentine_id);


--
-- Name: index_keyword_urls_on_url_id_and_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keyword_urls_on_url_id_and_keyword_id ON public.keyword_urls USING btree (url_id, keyword_id);


--
-- Name: index_keywords_on_url_count_and_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_keywords_on_url_count_and_id ON public.keywords USING btree (url_count, id);


--
-- Name: index_leader_boards_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_leader_boards_on_feature_id ON public.leader_boards USING btree (feature_id);


--
-- Name: index_lines_on_as_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lines_on_as_number ON public.lines USING btree (as_number);


--
-- Name: index_lines_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lines_on_company_id ON public.lines USING btree (company_id);


--
-- Name: index_lines_on_md5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lines_on_md5 ON public.lines USING btree (md5);


--
-- Name: index_links_on_source_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_links_on_source_url_id ON public.links USING btree (source_url_id);


--
-- Name: index_links_on_target_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_links_on_target_url_id ON public.links USING btree (target_url_id);


--
-- Name: index_login_activities_on_identity_bidx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_login_activities_on_identity_bidx ON public.login_activities USING btree (identity_bidx);


--
-- Name: index_login_activities_on_ip_bidx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_login_activities_on_ip_bidx ON public.login_activities USING btree (ip_bidx);


--
-- Name: index_login_activities_on_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_login_activities_on_user ON public.login_activities USING btree (user_type, user_id);


--
-- Name: index_market_segments_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_market_segments_on_account_id ON public.market_segments USING btree (account_id);


--
-- Name: index_market_segments_on_market_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_market_segments_on_market_id ON public.market_segments USING btree (market_id);


--
-- Name: index_market_segments_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_market_segments_on_parent_id ON public.market_segments USING btree (parent_id);


--
-- Name: index_markets_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_markets_on_account_id ON public.markets USING btree (account_id);


--
-- Name: index_meta_tags_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meta_tags_on_company_id ON public.meta_tags USING btree (company_id);


--
-- Name: index_meta_tags_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meta_tags_on_url_id ON public.meta_tags USING btree (url_id);


--
-- Name: index_mini_help_views_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mini_help_views_on_account_id ON public.mini_help_views USING btree (account_id);


--
-- Name: index_mini_help_views_on_mini_help_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mini_help_views_on_mini_help_id ON public.mini_help_views USING btree (mini_help_id);


--
-- Name: index_mini_help_views_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mini_help_views_on_user_id ON public.mini_help_views USING btree (user_id);


--
-- Name: index_negative_keywords_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_negative_keywords_on_account_id ON public.negative_keywords USING btree (account_id);


--
-- Name: index_negative_keywords_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_negative_keywords_on_keyword_id ON public.negative_keywords USING btree (keyword_id);


--
-- Name: index_newsletter_issues_on_newsletter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_newsletter_issues_on_newsletter_id ON public.newsletter_issues USING btree (newsletter_id);


--
-- Name: index_newsletter_subscribers_on_newsletter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_newsletter_subscribers_on_newsletter_id ON public.newsletter_subscribers USING btree (newsletter_id);


--
-- Name: index_newsletters_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_newsletters_on_account_id ON public.newsletters USING btree (account_id);


--
-- Name: index_newsletters_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_newsletters_on_user_id ON public.newsletters USING btree (user_id);


--
-- Name: index_notes_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_account_id ON public.notes USING btree (account_id);


--
-- Name: index_notes_on_people_list_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_people_list_id ON public.notes USING btree (people_list_id);


--
-- Name: index_notes_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_person_id ON public.notes USING btree (person_id);


--
-- Name: index_notes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_user_id ON public.notes USING btree (user_id);


--
-- Name: index_noticed_events_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_noticed_events_on_account_id ON public.noticed_events USING btree (account_id);


--
-- Name: index_noticed_events_on_record; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_noticed_events_on_record ON public.noticed_events USING btree (record_type, record_id);


--
-- Name: index_noticed_notifications_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_noticed_notifications_on_account_id ON public.noticed_notifications USING btree (account_id);


--
-- Name: index_noticed_notifications_on_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_noticed_notifications_on_event_id ON public.noticed_notifications USING btree (event_id);


--
-- Name: index_noticed_notifications_on_recipient; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_noticed_notifications_on_recipient ON public.noticed_notifications USING btree (recipient_type, recipient_id);


--
-- Name: index_notification_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_tokens_on_user_id ON public.notification_tokens USING btree (user_id);


--
-- Name: index_notifications_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_account_id ON public.notifications USING btree (account_id);


--
-- Name: index_notifications_on_recipient_type_and_recipient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_recipient_type_and_recipient_id ON public.notifications USING btree (recipient_type, recipient_id);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON public.oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON public.oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON public.oauth_access_tokens USING btree (token);


--
-- Name: index_organizations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organizations_on_user_id ON public.organizations USING btree (user_id);


--
-- Name: index_page_cleanups_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_page_cleanups_on_company_id ON public.page_cleanups USING btree (company_id);


--
-- Name: index_pay_charges_on_customer_id_and_processor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pay_charges_on_customer_id_and_processor_id ON public.pay_charges USING btree (customer_id, processor_id);


--
-- Name: index_pay_customers_on_processor_and_processor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pay_customers_on_processor_and_processor_id ON public.pay_customers USING btree (processor, processor_id);


--
-- Name: index_pay_merchants_on_owner_type_and_owner_id_and_processor; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pay_merchants_on_owner_type_and_owner_id_and_processor ON public.pay_merchants USING btree (owner_type, owner_id, processor);


--
-- Name: index_pay_payment_methods_on_customer_id_and_processor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pay_payment_methods_on_customer_id_and_processor_id ON public.pay_payment_methods USING btree (customer_id, processor_id);


--
-- Name: index_pay_subscriptions_on_customer_id_and_processor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pay_subscriptions_on_customer_id_and_processor_id ON public.pay_subscriptions USING btree (customer_id, processor_id);


--
-- Name: index_pay_subscriptions_on_metered; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pay_subscriptions_on_metered ON public.pay_subscriptions USING btree (metered);


--
-- Name: index_pay_subscriptions_on_pause_starts_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pay_subscriptions_on_pause_starts_at ON public.pay_subscriptions USING btree (pause_starts_at);


--
-- Name: index_people_lists_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_lists_on_account_id ON public.people_lists USING btree (account_id);


--
-- Name: index_people_lists_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_lists_on_user_id ON public.people_lists USING btree (user_id);


--
-- Name: index_people_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_account_id ON public.people USING btree (account_id);


--
-- Name: index_people_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_company_id ON public.people USING btree (company_id);


--
-- Name: index_people_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_keyword_id ON public.people USING btree (keyword_id);


--
-- Name: index_people_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_name ON public.people USING btree (name);


--
-- Name: index_people_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_people_on_slug ON public.people USING btree (slug);


--
-- Name: index_person_account_information_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_account_information_on_account_id ON public.person_account_information USING btree (account_id);


--
-- Name: index_person_account_information_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_account_information_on_person_id ON public.person_account_information USING btree (person_id);


--
-- Name: index_person_accounts_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_accounts_on_account_id ON public.person_accounts USING btree (account_id);


--
-- Name: index_person_accounts_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_accounts_on_person_id ON public.person_accounts USING btree (person_id);


--
-- Name: index_person_followers_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_followers_on_account_id ON public.person_followers USING btree (account_id);


--
-- Name: index_person_followers_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_followers_on_person_id ON public.person_followers USING btree (person_id);


--
-- Name: index_person_followers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_followers_on_user_id ON public.person_followers USING btree (user_id);


--
-- Name: index_person_searches_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_searches_on_person_id ON public.person_searches USING btree (person_id);


--
-- Name: index_person_skills_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_skills_on_person_id ON public.person_skills USING btree (person_id);


--
-- Name: index_person_skills_on_skill_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_skills_on_skill_id ON public.person_skills USING btree (skill_id);


--
-- Name: index_person_subscriptions_on_people_list_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_subscriptions_on_people_list_id ON public.person_subscriptions USING btree (people_list_id);


--
-- Name: index_person_urls_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_urls_on_person_id ON public.person_urls USING btree (person_id);


--
-- Name: index_person_urls_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_urls_on_url_id ON public.person_urls USING btree (url_id);


--
-- Name: index_persona_group_membership_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_persona_group_membership_uniqueness ON public.persona_group_memberships USING btree (persona_group_id, persona_id, role_type);


--
-- Name: index_persona_group_memberships_on_persona_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_persona_group_memberships_on_persona_group_id ON public.persona_group_memberships USING btree (persona_group_id);


--
-- Name: index_persona_group_memberships_on_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_persona_group_memberships_on_persona_id ON public.persona_group_memberships USING btree (persona_id);


--
-- Name: index_persona_groups_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_persona_groups_on_account_id ON public.persona_groups USING btree (account_id);


--
-- Name: index_persona_groups_on_account_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_persona_groups_on_account_id_and_name ON public.persona_groups USING btree (account_id, name);


--
-- Name: index_persona_modules_on_persona_and_module; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_persona_modules_on_persona_and_module ON public.persona_product_blueprint_modules USING btree (persona_id, product_blueprint_module_id);


--
-- Name: index_persona_product_blueprint_modules_on_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_persona_product_blueprint_modules_on_persona_id ON public.persona_product_blueprint_modules USING btree (persona_id);


--
-- Name: index_persona_product_blueprint_modules_on_relationship_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_persona_product_blueprint_modules_on_relationship_type ON public.persona_product_blueprint_modules USING btree (relationship_type);


--
-- Name: index_persona_user_stories_on_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_persona_user_stories_on_persona_id ON public.persona_user_stories USING btree (persona_id);


--
-- Name: index_persona_user_stories_on_user_story_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_persona_user_stories_on_user_story_id ON public.persona_user_stories USING btree (user_story_id);


--
-- Name: index_personas_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_personas_on_account_id ON public.personas USING btree (account_id);


--
-- Name: index_pg_search_documents_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pg_search_documents_on_searchable ON public.pg_search_documents USING btree (searchable_type, searchable_id);


--
-- Name: index_pghero_query_stats_on_database_and_captured_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pghero_query_stats_on_database_and_captured_at ON public.pghero_query_stats USING btree (database, captured_at);


--
-- Name: index_pm_roi_calculations_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_account_id ON public.pm_roi_calculations USING btree (account_id);


--
-- Name: index_pm_roi_calculations_on_account_id_and_confidence_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_account_id_and_confidence_level ON public.pm_roi_calculations USING btree (account_id, confidence_level);


--
-- Name: index_pm_roi_calculations_on_ai_agent_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_ai_agent_task_id ON public.pm_roi_calculations USING btree (ai_agent_task_id);


--
-- Name: index_pm_roi_calculations_on_ai_agent_task_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_ai_agent_task_id_and_created_at ON public.pm_roi_calculations USING btree (ai_agent_task_id, created_at);


--
-- Name: index_pm_roi_calculations_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_feature_id ON public.pm_roi_calculations USING btree (feature_id);


--
-- Name: index_pm_roi_calculations_on_feature_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_feature_name ON public.pm_roi_calculations USING btree (feature_name);


--
-- Name: index_pm_roi_calculations_on_market_segment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_market_segment_id ON public.pm_roi_calculations USING btree (market_segment_id);


--
-- Name: index_pm_roi_calculations_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_product_id ON public.pm_roi_calculations USING btree (product_id);


--
-- Name: index_pm_roi_calculations_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_project_id ON public.pm_roi_calculations USING btree (project_id);


--
-- Name: index_pm_roi_calculations_on_roi_percentage; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_roi_percentage ON public.pm_roi_calculations USING btree (roi_percentage);


--
-- Name: index_pm_roi_calculations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_user_id ON public.pm_roi_calculations USING btree (user_id);


--
-- Name: index_pm_roi_calculations_on_user_story_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pm_roi_calculations_on_user_story_id ON public.pm_roi_calculations USING btree (user_story_id);


--
-- Name: index_product_blueprint_associations_on_product_blueprint_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_blueprint_associations_on_product_blueprint_id ON public.product_blueprint_associations USING btree (product_blueprint_id);


--
-- Name: index_product_blueprint_associations_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_blueprint_associations_on_product_id ON public.product_blueprint_associations USING btree (product_id);


--
-- Name: index_product_blueprint_modules_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_blueprint_modules_on_account_id ON public.product_blueprint_modules USING btree (account_id);


--
-- Name: index_product_blueprint_modules_on_product_blueprint_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_blueprint_modules_on_product_blueprint_id ON public.product_blueprint_modules USING btree (product_blueprint_id);


--
-- Name: index_product_blueprint_modules_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_blueprint_modules_on_user_id ON public.product_blueprint_modules USING btree (user_id);


--
-- Name: index_product_blueprints_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_blueprints_on_account_id ON public.product_blueprints USING btree (account_id);


--
-- Name: index_product_blueprints_on_manager_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_blueprints_on_manager_id ON public.product_blueprints USING btree (manager_id);


--
-- Name: index_product_categories_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_categories_on_account_id ON public.product_categories USING btree (account_id);


--
-- Name: index_product_features_on_current_harvey_ball_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_features_on_current_harvey_ball_score ON public.product_features USING btree (current_harvey_ball_score);


--
-- Name: index_product_features_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_features_on_feature_id ON public.product_features USING btree (feature_id);


--
-- Name: index_product_features_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_features_on_product_id ON public.product_features USING btree (product_id);


--
-- Name: index_product_features_on_trend_direction; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_features_on_trend_direction ON public.product_features USING btree (trend_direction);


--
-- Name: index_product_owners_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_owners_on_account_id ON public.product_owners USING btree (account_id);


--
-- Name: index_product_owners_on_account_id_and_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_owners_on_account_id_and_product_id ON public.product_owners USING btree (account_id, product_id);


--
-- Name: index_product_owners_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_owners_on_product_id ON public.product_owners USING btree (product_id);


--
-- Name: index_product_owners_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_owners_on_user_id ON public.product_owners USING btree (user_id);


--
-- Name: index_product_personas_on_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_personas_on_persona_id ON public.product_personas USING btree (persona_id);


--
-- Name: index_product_personas_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_personas_on_product_id ON public.product_personas USING btree (product_id);


--
-- Name: index_product_personas_on_product_id_and_persona_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_product_personas_on_product_id_and_persona_id ON public.product_personas USING btree (product_id, persona_id);


--
-- Name: index_product_screenshots_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_screenshots_on_deleted_at ON public.product_screenshots USING btree (deleted_at);


--
-- Name: index_product_screenshots_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_screenshots_on_product_id ON public.product_screenshots USING btree (product_id);


--
-- Name: index_product_urls_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_urls_on_product_id ON public.product_urls USING btree (product_id);


--
-- Name: index_product_urls_on_product_id_and_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_product_urls_on_product_id_and_url_id ON public.product_urls USING btree (product_id, url_id);


--
-- Name: index_product_urls_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_urls_on_url_id ON public.product_urls USING btree (url_id);


--
-- Name: index_product_videos_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_videos_on_account_id ON public.product_videos USING btree (account_id);


--
-- Name: index_product_videos_on_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_videos_on_event_id ON public.product_videos USING btree (event_id);


--
-- Name: index_product_videos_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_videos_on_product_id ON public.product_videos USING btree (product_id);


--
-- Name: index_product_videos_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_videos_on_url_id ON public.product_videos USING btree (url_id);


--
-- Name: index_products_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_account_id ON public.products USING btree (account_id);


--
-- Name: index_products_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_company_id ON public.products USING btree (company_id);


--
-- Name: index_products_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_deleted_at ON public.products USING btree (deleted_at);


--
-- Name: index_products_on_deleted_at_and_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_deleted_at_and_company_id ON public.products USING btree (deleted_at, company_id);


--
-- Name: index_products_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_user_id ON public.products USING btree (user_id);


--
-- Name: index_project_data_items_on_ai_agent_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_data_items_on_ai_agent_task_id ON public.project_data_items USING btree (ai_agent_task_id);


--
-- Name: index_project_data_items_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_data_items_on_item_type_and_item_id ON public.project_data_items USING btree (item_type, item_id);


--
-- Name: index_project_data_items_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_data_items_on_project_id ON public.project_data_items USING btree (project_id);


--
-- Name: index_project_sections_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_sections_on_project_id ON public.project_sections USING btree (project_id);


--
-- Name: index_project_sources_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_sources_on_project_id ON public.project_sources USING btree (project_id);


--
-- Name: index_project_sources_on_sourceable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_sources_on_sourceable ON public.project_sources USING btree (sourceable_type, sourceable_id);


--
-- Name: index_project_topic_dashboard_briefs_on_data_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_topic_dashboard_briefs_on_data_set_id ON public.project_topic_dashboard_briefs USING btree (data_set_id);


--
-- Name: index_project_topic_dashboard_briefs_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_topic_dashboard_briefs_on_project_id ON public.project_topic_dashboard_briefs USING btree (project_id);


--
-- Name: index_project_topic_dashboard_briefs_on_topic_dashboard_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_topic_dashboard_briefs_on_topic_dashboard_id ON public.project_topic_dashboard_briefs USING btree (topic_dashboard_id);


--
-- Name: index_project_topic_dashboard_briefs_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_topic_dashboard_briefs_on_user_id ON public.project_topic_dashboard_briefs USING btree (user_id);


--
-- Name: index_project_urls_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_urls_on_project_id ON public.project_urls USING btree (project_id);


--
-- Name: index_project_urls_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_urls_on_url_id ON public.project_urls USING btree (url_id);


--
-- Name: index_projects_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_account_id ON public.projects USING btree (account_id);


--
-- Name: index_projects_on_plc_stage; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_plc_stage ON public.projects USING btree (plc_stage);


--
-- Name: index_projects_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_user_id ON public.projects USING btree (user_id);


--
-- Name: index_projects_on_vector_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_vector_store_id ON public.projects USING btree (vector_store_id);


--
-- Name: index_raw_data_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_raw_data_on_company_id ON public.raw_data USING btree (company_id);


--
-- Name: index_report_elements_on_report_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_report_elements_on_report_id ON public.report_elements USING btree (report_id);


--
-- Name: index_report_elements_on_report_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_report_elements_on_report_template_id ON public.report_elements USING btree (report_template_id);


--
-- Name: index_report_sections_on_version_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_report_sections_on_version_and_position ON public.smart_report_sections USING btree (smart_report_version_id, "position");


--
-- Name: index_report_templates_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_report_templates_on_account_id ON public.report_templates USING btree (account_id);


--
-- Name: index_reports_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reports_on_project_id ON public.reports USING btree (project_id);


--
-- Name: index_scrape_runs_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_scrape_runs_on_company_id ON public.scrape_runs USING btree (company_id);


--
-- Name: index_section_blocks_on_ai_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_section_blocks_on_ai_config ON public.section_blocks USING gin (ai_config);


--
-- Name: index_section_blocks_on_block_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_section_blocks_on_block_type ON public.section_blocks USING btree (block_type);


--
-- Name: index_section_blocks_on_content_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_section_blocks_on_content_config ON public.section_blocks USING gin (content_config);


--
-- Name: index_section_blocks_on_layout_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_section_blocks_on_layout_config ON public.section_blocks USING gin (layout_config);


--
-- Name: index_section_blocks_on_template_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_section_blocks_on_template_section_id ON public.section_blocks USING btree (template_section_id);


--
-- Name: index_section_blocks_on_template_section_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_section_blocks_on_template_section_id_and_position ON public.section_blocks USING btree (template_section_id, "position");


--
-- Name: index_smart_report_sections_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_smart_report_sections_on_company_id ON public.smart_report_sections USING btree (company_id);


--
-- Name: index_smart_report_sections_on_smart_report_version_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_smart_report_sections_on_smart_report_version_id ON public.smart_report_sections USING btree (smart_report_version_id);


--
-- Name: index_smart_report_versions_on_smart_report_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_smart_report_versions_on_smart_report_id ON public.smart_report_versions USING btree (smart_report_id);


--
-- Name: index_smart_report_versions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_smart_report_versions_on_user_id ON public.smart_report_versions USING btree (user_id);


--
-- Name: index_smart_reports_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_smart_reports_on_account_id ON public.smart_reports USING btree (account_id);


--
-- Name: index_smart_reports_on_topic_dashboard_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_smart_reports_on_topic_dashboard_id ON public.smart_reports USING btree (topic_dashboard_id);


--
-- Name: index_smart_reports_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_smart_reports_on_user_id ON public.smart_reports USING btree (user_id);


--
-- Name: index_snapshots_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_snapshots_on_company_id ON public.snapshots USING btree (company_id);


--
-- Name: index_snapshots_on_feature_and_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_snapshots_on_feature_and_period ON public.feature_analysis_snapshots USING btree (product_feature_id, analysis_period_start);


--
-- Name: index_suggested_actions_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_suggested_actions_on_url_id ON public.suggested_actions USING btree (url_id);


--
-- Name: index_suggested_actions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_suggested_actions_on_user_id ON public.suggested_actions USING btree (user_id);


--
-- Name: index_suggested_companies_on_account_and_following; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_suggested_companies_on_account_and_following ON public.suggested_companies USING btree (account_id, following);


--
-- Name: index_suggested_companies_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_suggested_companies_on_account_id ON public.suggested_companies USING btree (account_id);


--
-- Name: index_suggested_companies_on_archived; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_suggested_companies_on_archived ON public.suggested_companies USING btree (archived);


--
-- Name: index_suggested_companies_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_suggested_companies_on_deleted_at ON public.suggested_companies USING btree (deleted_at);


--
-- Name: index_template_sections_on_conditional_logic; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_template_sections_on_conditional_logic ON public.template_sections USING gin (conditional_logic);


--
-- Name: index_template_sections_on_document_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_template_sections_on_document_template_id ON public.template_sections USING btree (document_template_id);


--
-- Name: index_template_sections_on_document_template_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_template_sections_on_document_template_id_and_position ON public.template_sections USING btree (document_template_id, "position");


--
-- Name: index_template_sections_on_layout_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_template_sections_on_layout_config ON public.template_sections USING gin (layout_config);


--
-- Name: index_template_sections_on_required; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_template_sections_on_required ON public.template_sections USING btree (required);


--
-- Name: index_template_sections_on_section_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_template_sections_on_section_type ON public.template_sections USING btree (section_type);


--
-- Name: index_template_versions_on_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_template_versions_on_template_id ON public.template_versions USING btree (template_id);


--
-- Name: index_template_versions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_template_versions_on_user_id ON public.template_versions USING btree (user_id);


--
-- Name: index_topic_dashboard_notifications_on_topic_dashboard_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_dashboard_notifications_on_topic_dashboard_id ON public.topic_dashboard_notifications USING btree (topic_dashboard_id);


--
-- Name: index_topic_dashboard_notifications_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_dashboard_notifications_on_user_id ON public.topic_dashboard_notifications USING btree (user_id);


--
-- Name: index_topic_dashboard_urls_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_dashboard_urls_on_keyword_id ON public.topic_dashboard_urls USING btree (keyword_id);


--
-- Name: index_topic_dashboard_urls_on_topic_dashboard_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_dashboard_urls_on_topic_dashboard_id ON public.topic_dashboard_urls USING btree (topic_dashboard_id);


--
-- Name: index_topic_dashboard_urls_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_dashboard_urls_on_url_id ON public.topic_dashboard_urls USING btree (url_id);


--
-- Name: index_topic_dashboards_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_dashboards_on_account_id ON public.topic_dashboards USING btree (account_id);


--
-- Name: index_topic_followers_on_topic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_followers_on_topic_id ON public.topic_followers USING btree (topic_id);


--
-- Name: index_topic_followers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_followers_on_user_id ON public.topic_followers USING btree (user_id);


--
-- Name: index_topic_keywords_on_keyword_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_keywords_on_keyword_id ON public.topic_keywords USING btree (keyword_id);


--
-- Name: index_topic_keywords_on_topic_dashboard_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_keywords_on_topic_dashboard_id ON public.topic_keywords USING btree (topic_dashboard_id);


--
-- Name: index_topic_recurrences_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_recurrences_on_company_id ON public.topic_recurrences USING btree (company_id);


--
-- Name: index_topic_recurrences_on_topic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_recurrences_on_topic_id ON public.topic_recurrences USING btree (topic_id);


--
-- Name: index_topic_templates_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_templates_on_organization_id ON public.topic_templates USING btree (organization_id);


--
-- Name: index_topic_templates_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_templates_on_user_id ON public.topic_templates USING btree (user_id);


--
-- Name: index_topic_urls_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_urls_on_company_id ON public.topic_urls USING btree (company_id);


--
-- Name: index_topic_urls_on_topic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_urls_on_topic_id ON public.topic_urls USING btree (topic_id);


--
-- Name: index_topic_urls_on_topic_id_and_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_urls_on_topic_id_and_url_id ON public.topic_urls USING btree (topic_id, url_id);


--
-- Name: index_topic_urls_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_urls_on_url_id ON public.topic_urls USING btree (url_id);


--
-- Name: index_topic_urls_on_url_id_and_topic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_topic_urls_on_url_id_and_topic_id ON public.topic_urls USING btree (url_id, topic_id);


--
-- Name: index_topics_on_synonyms; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topics_on_synonyms ON public.topics USING btree (synonyms);


--
-- Name: index_transcripts_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transcripts_on_url_id ON public.transcripts USING btree (url_id);


--
-- Name: index_tweep_urls_on_tweep_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tweep_urls_on_tweep_id ON public.tweep_urls USING btree (tweep_id);


--
-- Name: index_tweep_urls_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tweep_urls_on_url_id ON public.tweep_urls USING btree (url_id);


--
-- Name: index_twitter_accounts_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_twitter_accounts_on_company_id ON public.twitter_accounts USING btree (company_id);


--
-- Name: index_unique_company_manager_per_account; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_unique_company_manager_per_account ON public.company_managers USING btree (user_id, company_id, account_id);


--
-- Name: index_unique_topic_dashboard_keyword_url; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_unique_topic_dashboard_keyword_url ON public.topic_dashboard_urls USING btree (topic_dashboard_id, keyword_id, url_id);


--
-- Name: index_url_collection_items_on_url_collection_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_collection_items_on_url_collection_id ON public.url_collection_items USING btree (url_collection_id);


--
-- Name: index_url_collection_items_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_collection_items_on_url_id ON public.url_collection_items USING btree (url_id);


--
-- Name: index_url_collections_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_collections_on_account_id ON public.url_collections USING btree (account_id);


--
-- Name: index_url_collections_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_collections_on_user_id ON public.url_collections USING btree (user_id);


--
-- Name: index_url_docs_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_docs_on_url_id ON public.url_docs USING btree (url_id);


--
-- Name: index_url_embeddings_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_embeddings_on_url_id ON public.url_embeddings USING btree (url_id);


--
-- Name: index_url_fingerprints_on_archived; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_fingerprints_on_archived ON public.url_fingerprints USING btree (archived);


--
-- Name: index_url_fingerprints_on_company_id_and_location; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_url_fingerprints_on_company_id_and_location ON public.url_fingerprints USING btree (company_id, location);


--
-- Name: index_url_fingerprints_on_last_seen_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_fingerprints_on_last_seen_at ON public.url_fingerprints USING btree (last_seen_at);


--
-- Name: index_url_images_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_images_on_url_id ON public.url_images USING btree (url_id);


--
-- Name: index_url_searches_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_searches_on_searchable ON public.url_searches USING gin (searchable);


--
-- Name: index_url_stats_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_stats_on_company_id ON public.url_stats USING btree (company_id);


--
-- Name: index_url_stats_on_url_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_stats_on_url_id ON public.url_stats USING btree (url_id);


--
-- Name: index_url_watches_on_url_id_and_account_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_watches_on_url_id_and_account_id_and_user_id ON public.url_watches USING btree (url_id, account_id, user_id);


--
-- Name: index_url_watches_on_user_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_url_watches_on_user_id_and_created_at ON public.url_watches USING btree (user_id, created_at);


--
-- Name: index_urls_on_brief_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_brief_hash ON public.urls USING btree (brief_hash);


--
-- Name: index_urls_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_company_id ON public.urls USING btree (company_id);


--
-- Name: index_urls_on_company_id_and_created_at_and_grade; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_company_id_and_created_at_and_grade ON public.urls USING btree (company_id, created_at, grade);


--
-- Name: index_urls_on_company_id_and_page_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_company_id_and_page_type ON public.urls USING btree (company_id, page_type);


--
-- Name: index_urls_on_company_id_and_root; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_company_id_and_root ON public.urls USING btree (company_id, root);


--
-- Name: index_urls_on_company_id_and_source; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_company_id_and_source ON public.urls USING btree (company_id, source);


--
-- Name: index_urls_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_created_at ON public.urls USING btree (created_at);


--
-- Name: index_urls_on_created_at_date_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_created_at_date_status ON public.urls USING btree (date(created_at), status);


--
-- Name: index_urls_on_created_at_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_created_at_status_id ON public.urls USING btree (created_at, status, id);


--
-- Name: index_urls_on_depth; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_depth ON public.urls USING btree (depth);


--
-- Name: index_urls_on_display_on_feed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_display_on_feed ON public.urls USING btree (display_on_feed);


--
-- Name: index_urls_on_graded; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_graded ON public.urls USING btree (graded);


--
-- Name: index_urls_on_ignore; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_ignore ON public.urls USING btree (ignore);


--
-- Name: index_urls_on_language; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_language ON public.urls USING btree (language);


--
-- Name: index_urls_on_linkedin_update_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_linkedin_update_id ON public.urls USING btree (linkedin_update_id);


--
-- Name: index_urls_on_original_publish_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_original_publish_date ON public.urls USING btree (original_publish_date);


--
-- Name: index_urls_on_page_importance; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_page_importance ON public.urls USING btree (page_importance);


--
-- Name: index_urls_on_page_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_page_type ON public.urls USING btree (page_type);


--
-- Name: index_urls_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_product_id ON public.urls USING btree (product_id);


--
-- Name: index_urls_on_reviewed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_reviewed ON public.urls USING btree (reviewed);


--
-- Name: index_urls_on_source; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_source ON public.urls USING btree (source);


--
-- Name: index_urls_on_source_and_brief; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_source_and_brief ON public.urls USING btree (source, brief);


--
-- Name: index_urls_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_status ON public.urls USING btree (status);


--
-- Name: index_urls_on_status_title_null; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_status_title_null ON public.urls USING btree (status) WHERE ((title IS NULL) OR ((title)::text ~~ 'Url %'::text));


--
-- Name: index_urls_on_tweet_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_urls_on_tweet_id ON public.urls USING btree (tweet_id) WHERE (tweet_id IS NOT NULL);


--
-- Name: index_user_company_account_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_company_account_unique ON public.company_followers USING btree (user_id, company_id, account_id);


--
-- Name: index_user_stories_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_account_id ON public.user_stories USING btree (account_id);


--
-- Name: index_user_stories_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_created_at ON public.user_stories USING btree (created_at);


--
-- Name: index_user_stories_on_epic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_epic_id ON public.user_stories USING btree (epic_id);


--
-- Name: index_user_stories_on_feature_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_feature_id ON public.user_stories USING btree (feature_id);


--
-- Name: index_user_stories_on_market_segment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_market_segment_id ON public.user_stories USING btree (market_segment_id);


--
-- Name: index_user_stories_on_risk_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_risk_level ON public.user_stories USING btree (risk_level);


--
-- Name: index_user_stories_on_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_task_id ON public.user_stories USING btree (task_id);


--
-- Name: index_user_stories_on_total_estimate; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_total_estimate ON public.user_stories USING btree (total_estimate);


--
-- Name: index_user_stories_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_stories_on_user_id ON public.user_stories USING btree (user_id);


--
-- Name: index_user_views_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_views_on_company_id ON public.user_views USING btree (company_id);


--
-- Name: index_user_views_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_views_on_user_id ON public.user_views USING btree (user_id);


--
-- Name: index_user_views_on_user_id_and_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_views_on_user_id_and_company_id ON public.user_views USING btree (user_id, company_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON public.users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invitations_count ON public.users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_id ON public.users USING btree (invited_by_id);


--
-- Name: index_users_on_invited_by_type_and_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_type_and_invited_by_id ON public.users USING btree (invited_by_type, invited_by_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_vector_stores_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vector_stores_on_account_id ON public.vector_stores USING btree (account_id);


--
-- Name: index_vector_stores_on_openai_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_vector_stores_on_openai_id ON public.vector_stores USING btree (openai_id);


--
-- Name: index_vector_stores_on_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vector_stores_on_owner ON public.vector_stores USING btree (owner_type, owner_id);


--
-- Name: index_vector_stores_on_owner_type_and_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vector_stores_on_owner_type_and_owner_id ON public.vector_stores USING btree (owner_type, owner_id);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: index_videos_on_is_public; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_videos_on_is_public ON public.videos USING btree (is_public);


--
-- Name: index_videos_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_videos_on_status ON public.videos USING btree (status);


--
-- Name: index_videos_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_videos_on_user_id ON public.videos USING btree (user_id);


--
-- Name: index_widget_dashboards_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_widget_dashboards_on_account_id ON public.widget_dashboards USING btree (account_id);


--
-- Name: index_widgets_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_widgets_on_account_id ON public.widgets USING btree (account_id);


--
-- Name: event_speakers fk_rails_037fda91a5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_speakers
    ADD CONSTRAINT fk_rails_037fda91a5 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: headers fk_rails_039ee876b0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.headers
    ADD CONSTRAINT fk_rails_039ee876b0 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: feature_analyses fk_rails_04231e6a2f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analyses
    ADD CONSTRAINT fk_rails_04231e6a2f FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: report_elements fk_rails_050025324a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_elements
    ADD CONSTRAINT fk_rails_050025324a FOREIGN KEY (report_id) REFERENCES public.reports(id);


--
-- Name: document_collaborations fk_rails_06097f8e08; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_collaborations
    ADD CONSTRAINT fk_rails_06097f8e08 FOREIGN KEY (invited_by_id) REFERENCES public.users(id);


--
-- Name: content_blocks fk_rails_06ae010d5d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_blocks
    ADD CONSTRAINT fk_rails_06ae010d5d FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: jobs fk_rails_078da9e3d3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT fk_rails_078da9e3d3 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: tweep_urls fk_rails_095211fd16; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tweep_urls
    ADD CONSTRAINT fk_rails_095211fd16 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: product_blueprints fk_rails_0b59a4fde3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprints
    ADD CONSTRAINT fk_rails_0b59a4fde3 FOREIGN KEY (manager_id) REFERENCES public.users(id);


--
-- Name: company_owners fk_rails_0de2c4f5b3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_owners
    ADD CONSTRAINT fk_rails_0de2c4f5b3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: topic_dashboard_notifications fk_rails_0e291e8c8b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_notifications
    ADD CONSTRAINT fk_rails_0e291e8c8b FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: journey_map_personas fk_rails_0fc17e99e6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_personas
    ADD CONSTRAINT fk_rails_0fc17e99e6 FOREIGN KEY (journey_map_id) REFERENCES public.journey_maps(id);


--
-- Name: person_account_information fk_rails_0ff37c2e01; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_account_information
    ADD CONSTRAINT fk_rails_0ff37c2e01 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: ai_agent_messages fk_rails_1344aef624; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_messages
    ADD CONSTRAINT fk_rails_1344aef624 FOREIGN KEY (agent_task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: persona_group_memberships fk_rails_143367bc5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_group_memberships
    ADD CONSTRAINT fk_rails_143367bc5c FOREIGN KEY (persona_group_id) REFERENCES public.persona_groups(id);


--
-- Name: feature_capabilities fk_rails_150fd37398; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_capabilities
    ADD CONSTRAINT fk_rails_150fd37398 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: negative_keywords fk_rails_1559ed2673; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.negative_keywords
    ADD CONSTRAINT fk_rails_1559ed2673 FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: product_videos fk_rails_159383f025; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_videos
    ADD CONSTRAINT fk_rails_159383f025 FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- Name: journey_maps fk_rails_15da3355a0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_maps
    ADD CONSTRAINT fk_rails_15da3355a0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: company_blueprint_associations fk_rails_15fabade30; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_blueprint_associations
    ADD CONSTRAINT fk_rails_15fabade30 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: product_videos fk_rails_16d150f621; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_videos
    ADD CONSTRAINT fk_rails_16d150f621 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: person_followers fk_rails_16d38b50fe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_followers
    ADD CONSTRAINT fk_rails_16d38b50fe FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: evidences fk_rails_172b29deb7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidences
    ADD CONSTRAINT fk_rails_172b29deb7 FOREIGN KEY (feature_analysis_id) REFERENCES public.feature_analyses(id);


--
-- Name: keyword_stats fk_rails_1a409c0ff4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_stats
    ADD CONSTRAINT fk_rails_1a409c0ff4 FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: competitor_analyses fk_rails_1a57fd04bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_analyses
    ADD CONSTRAINT fk_rails_1a57fd04bb FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: product_videos fk_rails_1a876518f3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_videos
    ADD CONSTRAINT fk_rails_1a876518f3 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: feature_urls fk_rails_1b96c50b0a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_urls
    ADD CONSTRAINT fk_rails_1b96c50b0a FOREIGN KEY (feature_id) REFERENCES public.features(id);


--
-- Name: product_blueprint_modules fk_rails_1c456709da; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_modules
    ADD CONSTRAINT fk_rails_1c456709da FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: person_accounts fk_rails_1f05e287d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_accounts
    ADD CONSTRAINT fk_rails_1f05e287d2 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: document_exports fk_rails_208ab546fd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_exports
    ADD CONSTRAINT fk_rails_208ab546fd FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- Name: project_topic_dashboard_briefs fk_rails_20a6a92d1a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_topic_dashboard_briefs
    ADD CONSTRAINT fk_rails_20a6a92d1a FOREIGN KEY (data_set_id) REFERENCES public.data_sets(id);


--
-- Name: company_finances fk_rails_20abbc78fb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_finances
    ADD CONSTRAINT fk_rails_20abbc78fb FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: project_data_items fk_rails_21661d57de; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_data_items
    ADD CONSTRAINT fk_rails_21661d57de FOREIGN KEY (approved_by) REFERENCES public.users(id);


--
-- Name: user_views fk_rails_216c29b632; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_views
    ADD CONSTRAINT fk_rails_216c29b632 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: company_managers fk_rails_22dc028cfa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_managers
    ADD CONSTRAINT fk_rails_22dc028cfa FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: suggested_actions fk_rails_240d21d5ad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggested_actions
    ADD CONSTRAINT fk_rails_240d21d5ad FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: topic_dashboard_urls fk_rails_2667383df6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_urls
    ADD CONSTRAINT fk_rails_2667383df6 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: topic_keywords fk_rails_269fa67518; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_keywords
    ADD CONSTRAINT fk_rails_269fa67518 FOREIGN KEY (topic_dashboard_id) REFERENCES public.topic_dashboards(id);


--
-- Name: notes fk_rails_27aea6a7e9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_27aea6a7e9 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: url_images fk_rails_28400a743e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_images
    ADD CONSTRAINT fk_rails_28400a743e FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: smart_report_versions fk_rails_2a612a8623; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_report_versions
    ADD CONSTRAINT fk_rails_2a612a8623 FOREIGN KEY (smart_report_id) REFERENCES public.smart_reports(id);


--
-- Name: documents fk_rails_2be0318c46; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_2be0318c46 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: product_blueprint_modules fk_rails_2cd6002df5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_modules
    ADD CONSTRAINT fk_rails_2cd6002df5 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: company_relationships fk_rails_2ebd9bb749; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_relationships
    ADD CONSTRAINT fk_rails_2ebd9bb749 FOREIGN KEY (related_company_id) REFERENCES public.companies(id);


--
-- Name: person_searches fk_rails_2f1450371a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_searches
    ADD CONSTRAINT fk_rails_2f1450371a FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: feature_capabilities fk_rails_2f4db6e399; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_capabilities
    ADD CONSTRAINT fk_rails_2f4db6e399 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: alerts fk_rails_30d0eb51d9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT fk_rails_30d0eb51d9 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: document_sections fk_rails_3104049632; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_sections
    ADD CONSTRAINT fk_rails_3104049632 FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- Name: comments fk_rails_31554e7034; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_31554e7034 FOREIGN KEY (parent_id) REFERENCES public.comments(id);


--
-- Name: report_elements fk_rails_336d8f6d6b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_elements
    ADD CONSTRAINT fk_rails_336d8f6d6b FOREIGN KEY (report_template_id) REFERENCES public.report_templates(id);


--
-- Name: document_collaborations fk_rails_341e1fdb97; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_collaborations
    ADD CONSTRAINT fk_rails_341e1fdb97 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: competitor_priorities fk_rails_37684b461d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_priorities
    ADD CONSTRAINT fk_rails_37684b461d FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: smart_report_sections fk_rails_378e9819cb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_report_sections
    ADD CONSTRAINT fk_rails_378e9819cb FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: product_personas fk_rails_3b64eb3e12; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_personas
    ADD CONSTRAINT fk_rails_3b64eb3e12 FOREIGN KEY (persona_id) REFERENCES public.personas(id);


--
-- Name: document_templates fk_rails_3dbbab50b1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_templates
    ADD CONSTRAINT fk_rails_3dbbab50b1 FOREIGN KEY (parent_template_id) REFERENCES public.document_templates(id);


--
-- Name: project_data_items fk_rails_3ec2168e4d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_data_items
    ADD CONSTRAINT fk_rails_3ec2168e4d FOREIGN KEY (ai_agent_task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: smart_report_sections fk_rails_408891e0bc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_report_sections
    ADD CONSTRAINT fk_rails_408891e0bc FOREIGN KEY (smart_report_version_id) REFERENCES public.smart_report_versions(id);


--
-- Name: document_collaborations fk_rails_417ed6a49b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_collaborations
    ADD CONSTRAINT fk_rails_417ed6a49b FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- Name: company_relationships fk_rails_447c9028c8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_relationships
    ADD CONSTRAINT fk_rails_447c9028c8 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: product_categories fk_rails_457aab887d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT fk_rails_457aab887d FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: leader_boards fk_rails_4634583ab0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leader_boards
    ADD CONSTRAINT fk_rails_4634583ab0 FOREIGN KEY (feature_id) REFERENCES public.features(id);


--
-- Name: product_videos fk_rails_46bb2f71c3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_videos
    ADD CONSTRAINT fk_rails_46bb2f71c3 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: smart_reports fk_rails_47502c1ecd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_reports
    ADD CONSTRAINT fk_rails_47502c1ecd FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: topic_dashboard_notifications fk_rails_475b073d69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_notifications
    ADD CONSTRAINT fk_rails_475b073d69 FOREIGN KEY (topic_dashboard_id) REFERENCES public.topic_dashboards(id);


--
-- Name: person_urls fk_rails_47b935746a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_urls
    ADD CONSTRAINT fk_rails_47b935746a FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: url_collection_items fk_rails_482b8f1829; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_collection_items
    ADD CONSTRAINT fk_rails_482b8f1829 FOREIGN KEY (url_collection_id) REFERENCES public.url_collections(id);


--
-- Name: product_owners fk_rails_4a4f9bd0b3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_owners
    ADD CONSTRAINT fk_rails_4a4f9bd0b3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: topic_keywords fk_rails_4b3690454d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_keywords
    ADD CONSTRAINT fk_rails_4b3690454d FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: product_personas fk_rails_4e06ad2c2b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_personas
    ADD CONSTRAINT fk_rails_4e06ad2c2b FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: persona_user_stories fk_rails_4f669c9a7b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_user_stories
    ADD CONSTRAINT fk_rails_4f669c9a7b FOREIGN KEY (user_story_id) REFERENCES public.user_stories(id);


--
-- Name: artifacts fk_rails_50d0212f3c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artifacts
    ADD CONSTRAINT fk_rails_50d0212f3c FOREIGN KEY (product_blueprint_id) REFERENCES public.product_blueprints(id);


--
-- Name: mini_help_views fk_rails_51140496e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mini_help_views
    ADD CONSTRAINT fk_rails_51140496e2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: feature_analyses fk_rails_5210b40293; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analyses
    ADD CONSTRAINT fk_rails_5210b40293 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: keyword_group_items fk_rails_52c1079002; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_group_items
    ADD CONSTRAINT fk_rails_52c1079002 FOREIGN KEY (keyword_group_id) REFERENCES public.keyword_groups(id);


--
-- Name: product_blueprint_modules fk_rails_533190ff4f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_modules
    ADD CONSTRAINT fk_rails_533190ff4f FOREIGN KEY (product_blueprint_id) REFERENCES public.product_blueprints(id);


--
-- Name: pm_roi_calculations fk_rails_54114facba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT fk_rails_54114facba FOREIGN KEY (user_story_id) REFERENCES public.user_stories(id);


--
-- Name: content_blocks fk_rails_543ea39a29; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_blocks
    ADD CONSTRAINT fk_rails_543ea39a29 FOREIGN KEY (document_section_id) REFERENCES public.document_sections(id);


--
-- Name: journey_map_personas fk_rails_58c6d5e026; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_personas
    ADD CONSTRAINT fk_rails_58c6d5e026 FOREIGN KEY (persona_id) REFERENCES public.personas(id);


--
-- Name: block_ai_agents fk_rails_5a2f3be2f6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.block_ai_agents
    ADD CONSTRAINT fk_rails_5a2f3be2f6 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: companies fk_rails_5ab5ec3338; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT fk_rails_5ab5ec3338 FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- Name: journey_maps fk_rails_5b7a110f90; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_maps
    ADD CONSTRAINT fk_rails_5b7a110f90 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: person_skills fk_rails_5c28322405; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_skills
    ADD CONSTRAINT fk_rails_5c28322405 FOREIGN KEY (skill_id) REFERENCES public.skills(id);


--
-- Name: product_owners fk_rails_5c5d63b903; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_owners
    ADD CONSTRAINT fk_rails_5c5d63b903 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: url_stats fk_rails_5e50fb607f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_stats
    ADD CONSTRAINT fk_rails_5e50fb607f FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: imports fk_rails_5e7c5ad6db; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT fk_rails_5e7c5ad6db FOREIGN KEY (people_list_id) REFERENCES public.people_lists(id);


--
-- Name: project_topic_dashboard_briefs fk_rails_5f193333bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_topic_dashboard_briefs
    ADD CONSTRAINT fk_rails_5f193333bb FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: feature_keywords fk_rails_5f469afe67; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_keywords
    ADD CONSTRAINT fk_rails_5f469afe67 FOREIGN KEY (feature_id) REFERENCES public.features(id);


--
-- Name: newsletter_subscribers fk_rails_6155e93e14; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_subscribers
    ADD CONSTRAINT fk_rails_6155e93e14 FOREIGN KEY (newsletter_id) REFERENCES public.newsletters(id);


--
-- Name: project_topic_dashboard_briefs fk_rails_62752c02ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_topic_dashboard_briefs
    ADD CONSTRAINT fk_rails_62752c02ca FOREIGN KEY (topic_dashboard_id) REFERENCES public.topic_dashboards(id);


--
-- Name: url_collection_items fk_rails_6302524bdb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_collection_items
    ADD CONSTRAINT fk_rails_6302524bdb FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: document_templates fk_rails_63d4d107ad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_templates
    ADD CONSTRAINT fk_rails_63d4d107ad FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: url_embeddings fk_rails_6727b642e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_embeddings
    ADD CONSTRAINT fk_rails_6727b642e2 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: template_versions fk_rails_6c1f724ea7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.template_versions
    ADD CONSTRAINT fk_rails_6c1f724ea7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: persona_product_blueprint_modules fk_rails_6e8f8d101c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_product_blueprint_modules
    ADD CONSTRAINT fk_rails_6e8f8d101c FOREIGN KEY (product_blueprint_module_id) REFERENCES public.product_blueprint_modules(id);


--
-- Name: feature_keywords fk_rails_6f6d4c67ea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_keywords
    ADD CONSTRAINT fk_rails_6f6d4c67ea FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: grade_configurations fk_rails_70739be28e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grade_configurations
    ADD CONSTRAINT fk_rails_70739be28e FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: project_urls fk_rails_72bbe7a664; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_urls
    ADD CONSTRAINT fk_rails_72bbe7a664 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: persona_user_stories fk_rails_7339d23fbc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_user_stories
    ADD CONSTRAINT fk_rails_7339d23fbc FOREIGN KEY (persona_id) REFERENCES public.personas(id);


--
-- Name: project_sources fk_rails_737f968e94; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_sources
    ADD CONSTRAINT fk_rails_737f968e94 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: journey_touchpoints fk_rails_7664bc9491; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_touchpoints
    ADD CONSTRAINT fk_rails_7664bc9491 FOREIGN KEY (journey_stage_id) REFERENCES public.journey_stages(id);


--
-- Name: pm_roi_calculations fk_rails_77138ebec0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT fk_rails_77138ebec0 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: alert_hides fk_rails_7769997948; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_hides
    ADD CONSTRAINT fk_rails_7769997948 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: alert_ratings fk_rails_7837a7f004; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_ratings
    ADD CONSTRAINT fk_rails_7837a7f004 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: block_ai_agents fk_rails_7886d1bd97; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.block_ai_agents
    ADD CONSTRAINT fk_rails_7886d1bd97 FOREIGN KEY (ai_agent_id) REFERENCES public.ai_agents(id);


--
-- Name: content_blocks fk_rails_78d4d4ce3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_blocks
    ADD CONSTRAINT fk_rails_78d4d4ce3d FOREIGN KEY (last_modified_by_id) REFERENCES public.users(id);


--
-- Name: smart_reports fk_rails_7a04864965; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_reports
    ADD CONSTRAINT fk_rails_7a04864965 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: pm_roi_calculations fk_rails_7ab68134d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT fk_rails_7ab68134d2 FOREIGN KEY (ai_agent_task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: organizations fk_rails_7b93e0061c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT fk_rails_7b93e0061c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: feature_capabilities fk_rails_7c88ea666f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_capabilities
    ADD CONSTRAINT fk_rails_7c88ea666f FOREIGN KEY (feature_id) REFERENCES public.features(id);


--
-- Name: pm_roi_calculations fk_rails_7d32f3c9bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT fk_rails_7d32f3c9bd FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: transcripts fk_rails_7e561c0717; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transcripts
    ADD CONSTRAINT fk_rails_7e561c0717 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: template_versions fk_rails_7eb02752f3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.template_versions
    ADD CONSTRAINT fk_rails_7eb02752f3 FOREIGN KEY (template_id) REFERENCES public.document_templates(id);


--
-- Name: notes fk_rails_7f2323ad43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_7f2323ad43 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: keyword_urls fk_rails_7fca3f6d5d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_urls
    ADD CONSTRAINT fk_rails_7fca3f6d5d FOREIGN KEY (keyword_quarentine_id) REFERENCES public.keyword_quarentines(id);


--
-- Name: meta_tags fk_rails_84d680d82e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meta_tags
    ADD CONSTRAINT fk_rails_84d680d82e FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: ai_agent_tasks fk_rails_877612d92d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_tasks
    ADD CONSTRAINT fk_rails_877612d92d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: document_sections fk_rails_87fa486544; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_sections
    ADD CONSTRAINT fk_rails_87fa486544 FOREIGN KEY (template_section_id) REFERENCES public.template_sections(id);


--
-- Name: persona_group_memberships fk_rails_88316ca6d7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_group_memberships
    ADD CONSTRAINT fk_rails_88316ca6d7 FOREIGN KEY (persona_id) REFERENCES public.personas(id);


--
-- Name: harvey_ball_competitor_analyses fk_rails_887934259e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvey_ball_competitor_analyses
    ADD CONSTRAINT fk_rails_887934259e FOREIGN KEY (feature_analysis_id) REFERENCES public.feature_analyses(id);


--
-- Name: people_lists fk_rails_88c33e745c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_lists
    ADD CONSTRAINT fk_rails_88c33e745c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: people fk_rails_8a5768d3ec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_rails_8a5768d3ec FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: topic_dashboard_urls fk_rails_8e44d8c692; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_urls
    ADD CONSTRAINT fk_rails_8e44d8c692 FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: artifacts fk_rails_8e64ac86df; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artifacts
    ADD CONSTRAINT fk_rails_8e64ac86df FOREIGN KEY (task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: import_maps fk_rails_9094a06ff1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_maps
    ADD CONSTRAINT fk_rails_9094a06ff1 FOREIGN KEY (import_id) REFERENCES public.imports(id);


--
-- Name: newsletter_issues fk_rails_90f2ca2854; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_issues
    ADD CONSTRAINT fk_rails_90f2ca2854 FOREIGN KEY (newsletter_id) REFERENCES public.newsletters(id);


--
-- Name: journey_emotions fk_rails_92a0666c48; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_emotions
    ADD CONSTRAINT fk_rails_92a0666c48 FOREIGN KEY (journey_stage_id) REFERENCES public.journey_stages(id);


--
-- Name: urls fk_rails_93b66a9641; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls
    ADD CONSTRAINT fk_rails_93b66a9641 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_blueprint_associations fk_rails_9472f7aede; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_associations
    ADD CONSTRAINT fk_rails_9472f7aede FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: competitor_analyses fk_rails_9480f23d68; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_analyses
    ADD CONSTRAINT fk_rails_9480f23d68 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: documents fk_rails_95b62e5dfd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_95b62e5dfd FOREIGN KEY (last_edited_by_id) REFERENCES public.users(id);


--
-- Name: feature_analyses fk_rails_98bb215592; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analyses
    ADD CONSTRAINT fk_rails_98bb215592 FOREIGN KEY (feature_id) REFERENCES public.features(id);


--
-- Name: analysis_companies fk_rails_98c2d05c65; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analysis_companies
    ADD CONSTRAINT fk_rails_98c2d05c65 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: reports fk_rails_9a0a9c9bec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_rails_9a0a9c9bec FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: journey_stages fk_rails_9a0c0f5c6e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_stages
    ADD CONSTRAINT fk_rails_9a0c0f5c6e FOREIGN KEY (journey_map_id) REFERENCES public.journey_maps(id);


--
-- Name: ai_agent_tasks fk_rails_9a1f4d4fd7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_tasks
    ADD CONSTRAINT fk_rails_9a1f4d4fd7 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: file_questions fk_rails_9ceec64859; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_questions
    ADD CONSTRAINT fk_rails_9ceec64859 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: product_blueprint_associations fk_rails_9d61685a2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_blueprint_associations
    ADD CONSTRAINT fk_rails_9d61685a2c FOREIGN KEY (product_blueprint_id) REFERENCES public.product_blueprints(id);


--
-- Name: company_owners fk_rails_9e2d3b831a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_owners
    ADD CONSTRAINT fk_rails_9e2d3b831a FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: features fk_rails_9e549256a3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT fk_rails_9e549256a3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: company_blueprint_associations fk_rails_9ea3461458; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_blueprint_associations
    ADD CONSTRAINT fk_rails_9ea3461458 FOREIGN KEY (product_blueprint_id) REFERENCES public.product_blueprints(id);


--
-- Name: documents fk_rails_9eb4fa593a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_9eb4fa593a FOREIGN KEY (document_template_id) REFERENCES public.document_templates(id);


--
-- Name: harvey_ball_competitor_analyses fk_rails_a1369343b0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvey_ball_competitor_analyses
    ADD CONSTRAINT fk_rails_a1369343b0 FOREIGN KEY (competitor_analysis_id) REFERENCES public.competitor_analyses(id);


--
-- Name: feature_urls fk_rails_a16fd77f3a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_urls
    ADD CONSTRAINT fk_rails_a16fd77f3a FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: features fk_rails_a47c8ee44f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT fk_rails_a47c8ee44f FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: features fk_rails_a517dc3224; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT fk_rails_a517dc3224 FOREIGN KEY (product_blueprint_id) REFERENCES public.product_blueprints(id);


--
-- Name: alert_ratings fk_rails_a646d1fa32; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_ratings
    ADD CONSTRAINT fk_rails_a646d1fa32 FOREIGN KEY (agent_task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: market_segments fk_rails_a7578f0f8e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.market_segments
    ADD CONSTRAINT fk_rails_a7578f0f8e FOREIGN KEY (market_id) REFERENCES public.markets(id);


--
-- Name: smart_report_versions fk_rails_a79d33fe28; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_report_versions
    ADD CONSTRAINT fk_rails_a79d33fe28 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: product_screenshots fk_rails_a831ca625e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_screenshots
    ADD CONSTRAINT fk_rails_a831ca625e FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: person_followers fk_rails_a8990c3fbe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_followers
    ADD CONSTRAINT fk_rails_a8990c3fbe FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: company_relationships fk_rails_aec0653f1c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_relationships
    ADD CONSTRAINT fk_rails_aec0653f1c FOREIGN KEY (primary_company_id) REFERENCES public.companies(id);


--
-- Name: url_fingerprints fk_rails_aecf804434; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.url_fingerprints
    ADD CONSTRAINT fk_rails_aecf804434 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: ai_agent_tasks fk_rails_afabb3bfb9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_tasks
    ADD CONSTRAINT fk_rails_afabb3bfb9 FOREIGN KEY (agent_id) REFERENCES public.ai_agents(id);


--
-- Name: file_questions fk_rails_b0052277c4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_questions
    ADD CONSTRAINT fk_rails_b0052277c4 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: event_followers fk_rails_b1a14fe93b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_followers
    ADD CONSTRAINT fk_rails_b1a14fe93b FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- Name: imports fk_rails_b1e2154c26; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT fk_rails_b1e2154c26 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: document_templates fk_rails_b220d88d62; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_templates
    ADD CONSTRAINT fk_rails_b220d88d62 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: facts fk_rails_b2f4d1ea42; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facts
    ADD CONSTRAINT fk_rails_b2f4d1ea42 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: jobs fk_rails_b34da78090; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT fk_rails_b34da78090 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: projects fk_rails_b4884d7210; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_b4884d7210 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: document_exports fk_rails_b6db804ddb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_exports
    ADD CONSTRAINT fk_rails_b6db804ddb FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: event_speakers fk_rails_b6e89b5d68; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_speakers
    ADD CONSTRAINT fk_rails_b6e89b5d68 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: pm_roi_calculations fk_rails_b6f1204470; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT fk_rails_b6f1204470 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: pm_roi_calculations fk_rails_b7313d2a43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT fk_rails_b7313d2a43 FOREIGN KEY (feature_id) REFERENCES public.features(id);


--
-- Name: persona_product_blueprint_modules fk_rails_b756b0e7ac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_product_blueprint_modules
    ADD CONSTRAINT fk_rails_b756b0e7ac FOREIGN KEY (persona_id) REFERENCES public.personas(id);


--
-- Name: company_owners fk_rails_b859fa4e06; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_owners
    ADD CONSTRAINT fk_rails_b859fa4e06 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: projects fk_rails_b872a6760a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_b872a6760a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: project_data_items fk_rails_b89e232d84; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_data_items
    ADD CONSTRAINT fk_rails_b89e232d84 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: documents fk_rails_ba3a155abe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_ba3a155abe FOREIGN KEY (parent_document_id) REFERENCES public.documents(id);


--
-- Name: topic_dashboard_urls fk_rails_ba756f824b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_dashboard_urls
    ADD CONSTRAINT fk_rails_ba756f824b FOREIGN KEY (topic_dashboard_id) REFERENCES public.topic_dashboards(id);


--
-- Name: videos fk_rails_ba925d1105; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT fk_rails_ba925d1105 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: event_speakers fk_rails_bb4ea4c24a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_speakers
    ADD CONSTRAINT fk_rails_bb4ea4c24a FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- Name: document_versions fk_rails_bc4ae66a0a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_versions
    ADD CONSTRAINT fk_rails_bc4ae66a0a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: suggested_actions fk_rails_bdaeeace58; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggested_actions
    ADD CONSTRAINT fk_rails_bdaeeace58 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: evidences fk_rails_bec18ff516; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidences
    ADD CONSTRAINT fk_rails_bec18ff516 FOREIGN KEY (agent_task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: alert_ratings fk_rails_bf7a7c5a29; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_ratings
    ADD CONSTRAINT fk_rails_bf7a7c5a29 FOREIGN KEY (alert_id) REFERENCES public.alerts(id);


--
-- Name: journey_map_persona_pain_points fk_rails_c031e690b4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_persona_pain_points
    ADD CONSTRAINT fk_rails_c031e690b4 FOREIGN KEY (journey_map_persona_id) REFERENCES public.journey_map_personas(id);


--
-- Name: bookmarks fk_rails_c1ff6fa4ac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT fk_rails_c1ff6fa4ac FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: features fk_rails_c29fc272d7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT fk_rails_c29fc272d7 FOREIGN KEY (product_blueprint_module_id) REFERENCES public.product_blueprint_modules(id);


--
-- Name: persona_groups fk_rails_c2a3d6e490; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persona_groups
    ADD CONSTRAINT fk_rails_c2a3d6e490 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: person_skills fk_rails_c2a70b32b9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_skills
    ADD CONSTRAINT fk_rails_c2a70b32b9 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: keyword_group_items fk_rails_c3a07a6de1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_group_items
    ADD CONSTRAINT fk_rails_c3a07a6de1 FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: journey_maps fk_rails_c568c19874; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_maps
    ADD CONSTRAINT fk_rails_c568c19874 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: user_stories fk_rails_c5856684d6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_stories
    ADD CONSTRAINT fk_rails_c5856684d6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: alert_views fk_rails_c7e4ac7bb9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_views
    ADD CONSTRAINT fk_rails_c7e4ac7bb9 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: feature_analyses fk_rails_c80c3aa373; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analyses
    ADD CONSTRAINT fk_rails_c80c3aa373 FOREIGN KEY (agent_id) REFERENCES public.users(id);


--
-- Name: document_versions fk_rails_c81b8ae028; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_versions
    ADD CONSTRAINT fk_rails_c81b8ae028 FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- Name: personas fk_rails_c8f3a50488; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT fk_rails_c8f3a50488 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: alerts fk_rails_ccafb97ab4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT fk_rails_ccafb97ab4 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: user_stories fk_rails_cce66a13cb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_stories
    ADD CONSTRAINT fk_rails_cce66a13cb FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: comments fk_rails_cf9764b6b1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_cf9764b6b1 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: feature_analyses fk_rails_cfb02f0728; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analyses
    ADD CONSTRAINT fk_rails_cfb02f0728 FOREIGN KEY (ai_agent_task) REFERENCES public.ai_agent_tasks(id);


--
-- Name: alert_hides fk_rails_cfccfbf8cf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_hides
    ADD CONSTRAINT fk_rails_cfccfbf8cf FOREIGN KEY (alert_id) REFERENCES public.alerts(id);


--
-- Name: event_attendances fk_rails_d082d0d206; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_attendances
    ADD CONSTRAINT fk_rails_d082d0d206 FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- Name: markets fk_rails_d18d22aa2b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.markets
    ADD CONSTRAINT fk_rails_d18d22aa2b FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: topic_templates fk_rails_d205100298; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_templates
    ADD CONSTRAINT fk_rails_d205100298 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: pm_roi_calculations fk_rails_d2162002d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT fk_rails_d2162002d2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: market_segments fk_rails_d2ff192477; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.market_segments
    ADD CONSTRAINT fk_rails_d2ff192477 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: product_urls fk_rails_d384998c65; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_urls
    ADD CONSTRAINT fk_rails_d384998c65 FOREIGN KEY (url_id) REFERENCES public.urls(id);


--
-- Name: project_topic_dashboard_briefs fk_rails_d3b708adf8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_topic_dashboard_briefs
    ADD CONSTRAINT fk_rails_d3b708adf8 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: alerts fk_rails_d4053234e7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT fk_rails_d4053234e7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: project_urls fk_rails_d438f9fae1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_urls
    ADD CONSTRAINT fk_rails_d438f9fae1 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: company_managers fk_rails_d8ffb172ee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_managers
    ADD CONSTRAINT fk_rails_d8ffb172ee FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: journey_thoughts fk_rails_d91202b42b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_thoughts
    ADD CONSTRAINT fk_rails_d91202b42b FOREIGN KEY (journey_stage_id) REFERENCES public.journey_stages(id);


--
-- Name: analysis_companies fk_rails_d9ff1f4dd6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analysis_companies
    ADD CONSTRAINT fk_rails_d9ff1f4dd6 FOREIGN KEY (competitor_analysis_id) REFERENCES public.competitor_analyses(id);


--
-- Name: alert_views fk_rails_dc56ad24e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_views
    ADD CONSTRAINT fk_rails_dc56ad24e4 FOREIGN KEY (alert_id) REFERENCES public.alerts(id);


--
-- Name: documents fk_rails_dd871098c0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_dd871098c0 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: alert_hides fk_rails_dde9e73cef; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alert_hides
    ADD CONSTRAINT fk_rails_dde9e73cef FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: template_sections fk_rails_ded509d327; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.template_sections
    ADD CONSTRAINT fk_rails_ded509d327 FOREIGN KEY (document_template_id) REFERENCES public.document_templates(id);


--
-- Name: keyword_embeddings fk_rails_e005758f32; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_embeddings
    ADD CONSTRAINT fk_rails_e005758f32 FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: ai_agent_examples fk_rails_e07a2c9ba2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_examples
    ADD CONSTRAINT fk_rails_e07a2c9ba2 FOREIGN KEY (agent_id) REFERENCES public.ai_agents(id);


--
-- Name: person_subscriptions fk_rails_e181921c35; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_subscriptions
    ADD CONSTRAINT fk_rails_e181921c35 FOREIGN KEY (people_list_id) REFERENCES public.people_lists(id);


--
-- Name: pm_roi_calculations fk_rails_e1a93b90f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pm_roi_calculations
    ADD CONSTRAINT fk_rails_e1a93b90f1 FOREIGN KEY (market_segment_id) REFERENCES public.market_segments(id);


--
-- Name: tweep_urls fk_rails_e202776968; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tweep_urls
    ADD CONSTRAINT fk_rails_e202776968 FOREIGN KEY (tweep_id) REFERENCES public.tweeps(id);


--
-- Name: section_blocks fk_rails_e464c71e01; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.section_blocks
    ADD CONSTRAINT fk_rails_e464c71e01 FOREIGN KEY (template_section_id) REFERENCES public.template_sections(id);


--
-- Name: evidences fk_rails_e5c3439024; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidences
    ADD CONSTRAINT fk_rails_e5c3439024 FOREIGN KEY (feature_id) REFERENCES public.features(id) ON DELETE CASCADE;


--
-- Name: user_stories fk_rails_e61770a837; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_stories
    ADD CONSTRAINT fk_rails_e61770a837 FOREIGN KEY (task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: journey_maps fk_rails_e6680531bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_maps
    ADD CONSTRAINT fk_rails_e6680531bd FOREIGN KEY (agent_task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: newsletters fk_rails_e6829818c0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletters
    ADD CONSTRAINT fk_rails_e6829818c0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: journey_map_persona_needs fk_rails_e82d8f1b0f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_map_persona_needs
    ADD CONSTRAINT fk_rails_e82d8f1b0f FOREIGN KEY (journey_map_persona_id) REFERENCES public.journey_map_personas(id);


--
-- Name: evidences fk_rails_e8c61ff878; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidences
    ADD CONSTRAINT fk_rails_e8c61ff878 FOREIGN KEY (dataset_id) REFERENCES public.data_sets(id);


--
-- Name: project_sections fk_rails_e8eb458583; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_sections
    ADD CONSTRAINT fk_rails_e8eb458583 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: user_stories fk_rails_ebecafa05e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_stories
    ADD CONSTRAINT fk_rails_ebecafa05e FOREIGN KEY (market_segment_id) REFERENCES public.market_segments(id);


--
-- Name: person_urls fk_rails_eea3773182; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_urls
    ADD CONSTRAINT fk_rails_eea3773182 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: bookmarks fk_rails_eecf4fc03c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT fk_rails_eecf4fc03c FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: ai_agent_tasks fk_rails_ef229b0f8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_agent_tasks
    ADD CONSTRAINT fk_rails_ef229b0f8d FOREIGN KEY (parent_task_id) REFERENCES public.ai_agent_tasks(id);


--
-- Name: mini_help_views fk_rails_ef4be1a9f6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mini_help_views
    ADD CONSTRAINT fk_rails_ef4be1a9f6 FOREIGN KEY (mini_help_id) REFERENCES public.mini_helps(id);


--
-- Name: market_segments fk_rails_f056775083; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.market_segments
    ADD CONSTRAINT fk_rails_f056775083 FOREIGN KEY (parent_id) REFERENCES public.market_segments(id);


--
-- Name: noticed_events fk_rails_f281f09d8b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticed_events
    ADD CONSTRAINT fk_rails_f281f09d8b FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: notes fk_rails_f32dc9d01b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_f32dc9d01b FOREIGN KEY (people_list_id) REFERENCES public.people_lists(id);


--
-- Name: file_questions fk_rails_f422586e2e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_questions
    ADD CONSTRAINT fk_rails_f422586e2e FOREIGN KEY (file_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: topic_templates fk_rails_f4ac41c0e1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_templates
    ADD CONSTRAINT fk_rails_f4ac41c0e1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: content_blocks fk_rails_f501e2f570; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_blocks
    ADD CONSTRAINT fk_rails_f501e2f570 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: competitor_priorities fk_rails_f6dc3b36de; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitor_priorities
    ADD CONSTRAINT fk_rails_f6dc3b36de FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: journey_opportunities fk_rails_f724660941; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_opportunities
    ADD CONSTRAINT fk_rails_f724660941 FOREIGN KEY (journey_stage_id) REFERENCES public.journey_stages(id);


--
-- Name: keyword_trends fk_rails_f80c8040b3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keyword_trends
    ADD CONSTRAINT fk_rails_f80c8040b3 FOREIGN KEY (keyword_id) REFERENCES public.keywords(id);


--
-- Name: company_managers fk_rails_f9486bfd04; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_managers
    ADD CONSTRAINT fk_rails_f9486bfd04 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: user_stories fk_rails_fa389774f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_stories
    ADD CONSTRAINT fk_rails_fa389774f1 FOREIGN KEY (feature_id) REFERENCES public.features(id) ON DELETE SET NULL;


--
-- Name: smart_reports fk_rails_fb27f6b986; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smart_reports
    ADD CONSTRAINT fk_rails_fb27f6b986 FOREIGN KEY (topic_dashboard_id) REFERENCES public.topic_dashboards(id);


--
-- Name: feature_analysis_snapshots fk_rails_fb752b2229; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feature_analysis_snapshots
    ADD CONSTRAINT fk_rails_fb752b2229 FOREIGN KEY (product_feature_id) REFERENCES public.product_features(id);


--
-- Name: journey_maps fk_rails_fcf3886d39; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey_maps
    ADD CONSTRAINT fk_rails_fcf3886d39 FOREIGN KEY (persona_id) REFERENCES public.personas(id);


--
-- Name: product_urls fk_rails_fd2e19d9c0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_urls
    ADD CONSTRAINT fk_rails_fd2e19d9c0 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: evidences fk_rails_fe1bc4af43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidences
    ADD CONSTRAINT fk_rails_fe1bc4af43 FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: document_tags fk_rails_ff57c99ce6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_tags
    ADD CONSTRAINT fk_rails_ff57c99ce6 FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20250822220132'),
('20250822105230'),
('20250822052341'),
('20250821191320'),
('20250820191015'),
('20250820161557'),
('20250818104132'),
('20250818083251'),
('20250817172417'),
('20250816193934'),
('20250815110326'),
('20250815110313'),
('20250815110301'),
('20250815110248'),
('20250815110037'),
('20250815110024'),
('20250815110012'),
('20250815105959'),
('20250815105946'),
('20250815105907'),
('20250815105827'),
('20250814084842'),
('20250812032820'),
('20250811193124'),
('20250810201546'),
('20250810195218'),
('20250809141910'),
('20250807121355'),
('20250807121240'),
('20250806210739'),
('20250805214105'),
('20250805134747'),
('20250805122925'),
('20250804194150'),
('20250803124006'),
('20250802142656'),
('20250802000000'),
('20250801171527'),
('20250801091021'),
('20250801085937'),
('20250729202227'),
('20250729184029'),
('20250726175645'),
('20250723202116'),
('20250722045713'),
('20250722044412'),
('20250722044332'),
('20250722043855'),
('20250721183429'),
('20250721014240'),
('20250719153229'),
('20250719143140'),
('20250717184131'),
('20250717094350'),
('20250714171455'),
('20250714171332'),
('20250714171252'),
('20250714144417'),
('20250713072305'),
('20250713072304'),
('20250713003506'),
('20250712183308'),
('20250711135747'),
('20250711134918'),
('20250711134533'),
('20250710034333'),
('20250708135228'),
('20250708115845'),
('20250708110123'),
('20250708110058'),
('20250708105751'),
('20250708105639'),
('20250708070000'),
('20250708030615'),
('20250708024746'),
('20250707054917'),
('20250706200000'),
('20250706183506'),
('20250706183309'),
('20250706183253'),
('20250706183239'),
('20250706052433'),
('20250705135557'),
('20250705134914'),
('20250705024526'),
('20250704090207'),
('20250701070500'),
('20250630190000'),
('20250630184034'),
('20250630183948'),
('20250628185548'),
('20250626000000'),
('20250625133935'),
('20250625121626'),
('20250623020000'),
('20250623011009'),
('20250623010031'),
('20250622060700'),
('20250619053046'),
('20250617160000'),
('20250617154640'),
('20250617154639'),
('20250617095000'),
('20250616094000'),
('20250612071328'),
('20250612071123'),
('20250612071112'),
('20250611204454'),
('20250608191800'),
('20250607085029'),
('20250607064901'),
('20250607063750'),
('20250607055032'),
('20250606152557'),
('20250602170000'),
('20250602143359'),
('20250531210543'),
('20250531210104'),
('20250531204930'),
('20250531204426'),
('20250531204140'),
('20250531165443'),
('20250531120101'),
('20250531120000'),
('20250530160154'),
('20250530154922'),
('20250530133053'),
('20250530132716'),
('20250530125753'),
('20250530094550'),
('20250530093313'),
('20250529014727'),
('20250529014647'),
('20250529014027'),
('20250525220000'),
('20250525212440'),
('20250525165657'),
('20250525112618'),
('20250525112511'),
('20250525082609'),
('20250519164700'),
('20250518181522'),
('20250518124207'),
('20250517170000'),
('20250517164351'),
('20250517162529'),
('20250517145527'),
('20250513210908'),
('20250506214752'),
('20250505042359'),
('20250504140408'),
('20250502145615'),
('20250415004907'),
('20250415004654'),
('20250415003406'),
('20250415002429'),
('20250413064307'),
('20250413063813'),
('20250408100209'),
('20250404202910'),
('20250329212348'),
('20250324214005'),
('20250324174649'),
('20250324173640'),
('20250323230813'),
('20250323212922'),
('20250317201452'),
('20250317174242'),
('20250315173146'),
('20250314094807'),
('20250314093406'),
('20250313225818'),
('20250313214722'),
('20250313213850'),
('20250313053137'),
('20250310062337'),
('20250307025209'),
('20250306162035'),
('20250306162004'),
('20250306154100'),
('20250306152049'),
('20250306030839'),
('20250303071825'),
('20250303071756'),
('20250303071716'),
('20250303071641'),
('20250303071601'),
('20250303071523'),
('20250303071439'),
('20250303071306'),
('20250303071050'),
('20250302224408'),
('20250302223538'),
('20250302222810'),
('20250301072714'),
('20250301020029'),
('20250226030000'),
('20250222224938'),
('20250222224846'),
('20250222224236'),
('20250222200018'),
('20250222193004'),
('20250222181953'),
('20250222180555'),
('20250222091832'),
('20250222070125'),
('20250221113920'),
('20250220231822'),
('20250220222145'),
('20250220221630'),
('20250218044749'),
('20250218042221'),
('20250215210552'),
('20250208210435'),
('20250208210244'),
('20250208210030'),
('20250207173055'),
('20250206211550'),
('20250206211533'),
('20250206211339'),
('20250206204401'),
('20250206201720'),
('20250206175607'),
('20250205215518'),
('20250127000001'),
('20250126154637'),
('20250126140202'),
('20250126005700'),
('20250125155348'),
('20250125000001'),
('20250125000000'),
('20250124000001'),
('20250124000000'),
('20250120193913'),
('20250120102545'),
('20250119214234'),
('20250119083237'),
('20250117185808'),
('20250115114024'),
('20250115093636'),
('20250115092629'),
('20250111205935'),
('20250109082228'),
('20250108205229'),
('20250108195443'),
('20250102091129'),
('20250102000001'),
('20250102000000'),
('20250101125432'),
('20250101115450'),
('20250101113406'),
('20250101092440'),
('20250101092251'),
('20250101000003'),
('20250101000002'),
('20250101000001'),
('20241229075951'),
('20241228154154'),
('20241226032636'),
('20241221220157'),
('20241220100959'),
('20241215152032'),
('20241215100032'),
('20241209212429'),
('20241207203204'),
('20241206021504'),
('20241201000001'),
('20241120152606'),
('20241117100552'),
('20241116203636'),
('20241113185613'),
('20241112032928'),
('20241111082606'),
('20241110063221'),
('20241104072624'),
('20241104072623'),
('20241104072445'),
('20241103173610'),
('20241103135022'),
('20241102151827'),
('20241102151741'),
('20241102101914'),
('20241102101232'),
('20241101095815'),
('20241031172038'),
('20241030082345'),
('20241026104959'),
('20241018024737'),
('20241015054036'),
('20241013051255'),
('20241013051254'),
('20241010055815'),
('20241009093637'),
('20241008160641'),
('20241008062451'),
('20241007192930'),
('20241007191725'),
('20241007184546'),
('20241007125845'),
('20241007101548'),
('20241005095909'),
('20241003205207'),
('20241003184215'),
('20241003165626'),
('20241001205105'),
('20240930002208'),
('20240930002123'),
('20240927123758'),
('20240927114817'),
('20240927114732'),
('20240927014213'),
('20240925130917'),
('20240924092614'),
('20240923023008'),
('20240923010910'),
('20240923004026'),
('20240921151740'),
('20240916035203'),
('20240913070001'),
('20240912071701'),
('20240907073510'),
('20240907070205'),
('20240906143309'),
('20240903213733'),
('20240903073542'),
('20240901061051'),
('20240831050818'),
('20240829062732'),
('20240828081108'),
('20240827071615'),
('20240825163026'),
('20240824191718'),
('20240824152037'),
('20240822025805'),
('20240821183620'),
('20240821071446'),
('20240821071059'),
('20240817230736'),
('20240816073804'),
('20240811160531'),
('20240810060827'),
('20240807212943'),
('20240801144449'),
('20240731194331'),
('20240729041632'),
('20240729035005'),
('20240729031554'),
('20240728173607'),
('20240728165503'),
('20240726211849'),
('20240725184953'),
('20240725175737'),
('20240724030339'),
('20240718031736'),
('20240718024326'),
('20240717083649'),
('20240715055629'),
('20240713195323'),
('20240713192903'),
('20240713012618'),
('20240712142050'),
('20240709211129'),
('20240706024957'),
('20240705104148'),
('20240705103950'),
('20240703203632'),
('20240612195255'),
('20240611190326'),
('20240611151848'),
('20240611075541'),
('20240604215720'),
('20240603145125'),
('20240601100746'),
('20240601083916'),
('20240601083644'),
('20240531195353'),
('20240531053308'),
('20240526205810'),
('20240523180649'),
('20240523104351'),
('20240520000000'),
('20240518012513'),
('20240515125102'),
('20240515033334'),
('20240513142034'),
('20240513065447'),
('20240507040328'),
('20240506172047'),
('20240504194004'),
('20240504193437'),
('20240503043029'),
('20240502202908'),
('20240502052747'),
('20240502052409'),
('20240428204549'),
('20240427000927'),
('20240427000846'),
('20240427000740'),
('20240426154408'),
('20240425145355'),
('20240423204013'),
('20240420152026'),
('20240419122623'),
('20240418214547'),
('20240418214445'),
('20240418214316'),
('20240418213224'),
('20240418213223'),
('20240404230851'),
('20240404131148'),
('20240404021720'),
('20240404013022'),
('20240329231132'),
('20240329230943'),
('20240329150424'),
('20240329143432'),
('20240326151658'),
('20240326061409'),
('20240326060354'),
('20240322064819'),
('20240321113458'),
('20240320000000'),
('20240318202053'),
('20240309160849'),
('20240309152434'),
('20240308000001'),
('20240308000000'),
('20240306154645'),
('20240305064751'),
('20240224021434'),
('20240222020825'),
('20240222013808'),
('20240218192235'),
('20240217145330'),
('20240215173200'),
('20240213053723'),
('20240212220816'),
('20240211215656'),
('20240211215624'),
('20240208192152'),
('20240208191456'),
('20240208182350'),
('20240207180153'),
('20240206115816'),
('20240205015653'),
('20240203071156'),
('20240203015222'),
('20240201224933'),
('20240201204806'),
('20240129200820'),
('20240120161829'),
('20240117144542'),
('20240114110220'),
('20240112131918'),
('20240112131813'),
('20240112084119'),
('20240107214203'),
('20240102192139'),
('20240102032821'),
('20231231090211'),
('20231230153500'),
('20231230140826'),
('20231230140738'),
('20231230140629'),
('20231229160200'),
('20231229154446'),
('20231228205318'),
('20231227194356'),
('20231227194147'),
('20231225061847'),
('20231222075827'),
('20231219163933'),
('20231218051457'),
('20231212182719'),
('20231212182502'),
('20231210113513'),
('20231206020145'),
('20231129132324'),
('20231128155334'),
('20231128104745'),
('20231121144739'),
('20231121001721'),
('20231120234532'),
('20231112001744'),
('20231110140743'),
('20231108030612'),
('20231107165123'),
('20231107135316'),
('20231107063925'),
('20231107035059'),
('20231106182501'),
('20231106155826'),
('20231106153853'),
('20231104200658'),
('20231103160833'),
('20231103073245'),
('20231103065059'),
('20231030101454'),
('20231027025018'),
('20231026172217'),
('20231026132045'),
('20231026003348'),
('20231024150632'),
('20231013130639'),
('20231012211725'),
('20231011023056'),
('20231010151212'),
('20231005205819'),
('20231005195742'),
('20231001193558'),
('20230930165604'),
('20230924095442'),
('20230924081434'),
('20230923181730'),
('20230922200826'),
('20230922124530'),
('20230916173950'),
('20230914202659'),
('20230914201748'),
('20230914201714'),
('20230914200545'),
('20230914134247'),
('20230913163314'),
('20230909072241'),
('20230908050947'),
('20230907202725'),
('20230905135307'),
('20230904152545'),
('20230828012322'),
('20230827031241'),
('20230812033919'),
('20230810152614'),
('20230724053416'),
('20230724011650'),
('20230721043050'),
('20230717174558'),
('20230713204709'),
('20230712105650'),
('20230712043044'),
('20230712035057'),
('20230630145214'),
('20230627112610'),
('20230623203639'),
('20230618195231'),
('20230618162127'),
('20230618142554'),
('20230617150332'),
('20230617144621'),
('20230617055938'),
('20230615200041'),
('20230615151308'),
('20230614141141'),
('20230614085423'),
('20230614075627'),
('20230612065321'),
('20230612064540'),
('20230612025520'),
('20230612025330'),
('20230612025204'),
('20230611044158'),
('20230611044059'),
('20230610151239'),
('20230602113056'),
('20230602062659'),
('20230602044400'),
('20230602043907'),
('20230530193641'),
('20230530161012'),
('20230529194108'),
('20230527160552'),
('20230525141512'),
('20230522225843'),
('20230522053510'),
('20230521193840'),
('20230519062015'),
('20230516035210'),
('20230513143739'),
('20230513142732'),
('20230513142211'),
('20230509101314'),
('20230509022612'),
('20230509022156'),
('20230505211339'),
('20230503180159'),
('20230430032335'),
('20230428163958'),
('20230428161206'),
('20230428054318'),
('20230428051614'),
('20230424042612'),
('20230420020807'),
('20230414145257'),
('20230409102732'),
('20230409102219'),
('20230408204004'),
('20230403012356'),
('20230402235917'),
('20230402102008'),
('20230327230627'),
('20230326080246'),
('20230324150210'),
('20230318153012'),
('20230317201456'),
('20230317090033'),
('20230316204609'),
('20230314222836'),
('20230309203925'),
('20230225090937'),
('20230225034214'),
('20230225033853'),
('20230224155158'),
('20230221144253'),
('20230220212525'),
('20230220212442'),
('20230217064013'),
('20230210155944'),
('20230205063653'),
('20230204162609'),
('20230127024904'),
('20230127024802'),
('20230127024701'),
('20230127020758'),
('20230127020227'),
('20230115053551'),
('20230114132615'),
('20230113105231'),
('20230113053112'),
('20230110192107'),
('20230109195026'),
('20230109052708'),
('20230108201246'),
('20230108195741'),
('20230108180243'),
('20221228051150'),
('20221217213633'),
('20221217213016'),
('20221217172154'),
('20221216130900'),
('20221213232437'),
('20221211205533'),
('20221121232410'),
('20221120033043'),
('20221112175036'),
('20221111155204'),
('20221102153738'),
('20221030171718'),
('20221030170543'),
('20221026181744'),
('20221023202745'),
('20221023195733'),
('20221020142956'),
('20221013030332'),
('20221010154532'),
('20221009151242'),
('20221009074509'),
('20221002131415'),
('20220923065550'),
('20220923065413'),
('20220909015021'),
('20220908054602'),
('20220907134652'),
('20220907103551'),
('20220903215006'),
('20220903213859'),
('20220903210318'),
('20220903210059'),
('20220903204148'),
('20220903181936'),
('20220831125119'),
('20220820185351'),
('20220820183528'),
('20220726173750'),
('20220726162552'),
('20220725221511'),
('20220716204024'),
('20220716182458'),
('20220709151020'),
('20220619163110'),
('20220608163727'),
('20220605175149'),
('20220604071517'),
('20220502205110'),
('20220427081919'),
('20220426204424'),
('20220426182322'),
('20220424040615'),
('20220421132540'),
('20220403070328'),
('20220331201915'),
('20220329195242'),
('20220311074749'),
('20220311061851'),
('20220311061721'),
('20220311060618'),
('20220309171010'),
('20220309120907'),
('20220308165833'),
('20220308165716'),
('20220302091056'),
('20220223111438'),
('20220223103828'),
('20220219171155'),
('20220217195048'),
('20220217194753'),
('20220209155401'),
('20220205191611'),
('20220205151404'),
('20220122225111'),
('20220121163730'),
('20220121092303'),
('20220115223744'),
('20220115143725'),
('20220115090548'),
('20220114100621'),
('20220105221527'),
('20220105042958'),
('20220103225528'),
('20211224155949'),
('20211221231835'),
('20211206204750'),
('20211130045658'),
('20211029063416'),
('20211022062858'),
('20211017102000'),
('20211016202151'),
('20211002195137'),
('20211001183460'),
('20211001183459'),
('20210928063825'),
('20210926211745'),
('20210923192359'),
('20210922131252'),
('20210805001857'),
('20210804000959'),
('20210710203922'),
('20210607204123'),
('20210422222152'),
('20210419210614'),
('20210415055323'),
('20210323071428'),
('20210312034326'),
('20210131221118'),
('20210118061751'),
('20210115211740'),
('20210115211641'),
('20210110060242'),
('20210110055230'),
('20210105193521'),
('20210101162347'),
('20201225041825'),
('20201225041720'),
('20201224211327'),
('20201221001330'),
('20201220221642'),
('20201219101802'),
('20201209233134'),
('20201209233133'),
('20201206085920'),
('20201122225835'),
('20201122215714'),
('20201122205823'),
('20201122202616'),
('20201114065222'),
('20201109044536'),
('20201108195845'),
('20201104135906'),
('20201104101827'),
('20201104095148'),
('20201026103532'),
('20201020061417'),
('20201018084333'),
('20201018072310'),
('20201009065501'),
('20201009065402'),
('20201007144518'),
('20200919221443'),
('20200820121859'),
('20200820085746'),
('20200820085400'),
('20200811051531'),
('20200810105540'),
('20200810104211'),
('20200809182512'),
('20200809132120'),
('20200809132005'),
('20200806001403'),
('20200726201932'),
('20200715173316'),
('20200326020204'),
('20200209004223'),
('20200208030344'),
('20200110222159'),
('20200107071919'),
('20200102195022'),
('20191219010439'),
('20191218113802'),
('20191218071859'),
('20191216155245'),
('20191201090142'),
('20191201090050'),
('20191126092001'),
('20191109231827'),
('20191109205958'),
('20191109205905'),
('20191109205434'),
('20191107222103'),
('20191106130332'),
('20191025224530'),
('20190820024249'),
('20190801160834'),
('20190625160454'),
('20190625044813'),
('20190623171724'),
('20190623165151'),
('20190623164316'),
('20190409222127'),
('20190211194309'),
('20190211185458'),
('20190211185457'),
('20190207041139'),
('20190114062651'),
('20190114062649'),
('20180821214213'),
('20180821214212'),
('20180820210659'),
('20180817230558'),
('20180801000001'),
('20180801000000');

