SET client_min_messages = warning;
DROP DATABASE if exists test_yb_extensions;
CREATE DATABASE test_yb_extensions;
\c test_yb_extensions

-- Testing pgcrypto.
create extension pgcrypto;

select digest('xyz', 'sha1');

-- Using fixed salt to make test repeatable.
select crypt('new password', '$1$7kF93Vc4');

-- Using count to make test repeatable.
select count(gen_random_uuid());

-- Testing fuzzystrmatch.
create extension fuzzystrmatch;

select levenshtein('YugaByte', 'yugabyte');

select metaphone('yugabyte', 8);

-- Clean up.
drop extension pgcrypto;

-- Expect failure since function should be removed.
select digest('xyz', 'sha1');

drop extension fuzzystrmatch;

-- Expect failure since function should be removed.
select levenshtein('YugaByte', 'yugabyte');

-- Testing pg_stat_statements;
select pg_stat_statements_reset();
select pg_get_userbyid(userid),datname,query,calls,rows,shared_blks_hit,shared_blks_read,shared_blks_dirtied,shared_blks_written,local_blks_hit,local_blks_read,local_blks_dirtied,local_blks_written,temp_blks_read,temp_blks_written,blk_read_time
    from pg_stat_statements join pg_database on dbid = oid order by query;

create table test(a int, b float);
insert into test(a,b) values (5,10);
select pg_get_userbyid(userid),datname,query,calls,rows,shared_blks_hit,shared_blks_read,shared_blks_dirtied,shared_blks_written,local_blks_hit,local_blks_read,local_blks_dirtied,local_blks_written,temp_blks_read,temp_blks_written,blk_read_time
    from pg_stat_statements join pg_database on dbid = oid order by query;
insert into test(a,b) values (15,20);
select pg_get_userbyid(userid),datname,query,calls,rows,shared_blks_hit,shared_blks_read,shared_blks_dirtied,shared_blks_written,local_blks_hit,local_blks_read,local_blks_dirtied,local_blks_written,temp_blks_read,temp_blks_written,blk_read_time
    from pg_stat_statements join pg_database on dbid = oid order by query;
-- SeqScan forces YbSeqScan node with NodeTag near the end of the list in nodes.h
explain (analyze, costs off, summary off, timing off) /*+SeqScan(test)*/ select a, b from test;
-- GHI 14498: different queryid may indicate NodeTag added to the middle of the list
-- Please make sure it is appended
select queryid, query from pg_stat_statements where query like 'explain %';
drop table test;

-- Testing uuid-ossp
create extension "uuid-ossp";

select uuid_generate_v5('00000000-0000-0000-0000-000000000000', 'yugabyte');

-- generated values are random, so to ensure deterministic output ignore the actual values.
select uuid_generate_v1() != uuid_generate_v4();

-- Testing CVE-2023-39417
CREATE SCHEMA "has space";
CREATE SCHEMA has$dollar;

CREATE EXTENSION yb_test_extension SCHEMA has$dollar;
CREATE EXTENSION yb_test_extension SCHEMA "has space";

\c yugabyte

DROP DATABASE test_yb_extensions WITH (FORCE);

--
-- GH-26857 - Validate that the yb_extension role has the necessary privileges
-- to create/alter/delete extensions.
--
CREATE USER non_db_admin_user INHERIT CREATEROLE CREATEDB BYPASSRLS LOGIN;
GRANT pg_read_all_stats, pg_signal_backend, yb_extension, yb_fdw, yb_db_admin TO non_db_admin_user;
GRANT CREATE ON SCHEMA public to non_db_admin_user WITH GRANT OPTION;

-- Set up objects required to alter the extension.
CREATE SCHEMA test_schema;
GRANT CREATE ON SCHEMA test_schema to non_db_admin_user WITH GRANT OPTION;

CREATE FUNCTION test_func (a INT) RETURNS INT
LANGUAGE PLPGSQL AS $$
BEGIN
	RETURN a;
END;
$$;

ALTER FUNCTION test_func (a INT) OWNER TO non_db_admin_user;
CREATE ACCESS METHOD dummy_am_yb_user TYPE INDEX HANDLER bthandler;

\c yugabyte non_db_admin_user
-- A non-admin user is not allowed to create/drop access methods unless it is a
-- part of an extension script. Postgres does not have a command to alter an
-- access method.
CREATE ACCESS METHOD dummy_am_non_db_admin_user TYPE INDEX HANDLER bthandler;
DROP ACCESS METHOD dummy_am_non_db_admin_user;

CREATE EXTENSION vector;
ALTER EXTENSION vector SET SCHEMA test_schema;
-- A non-admin user is not allowed to create/drop access methods as part of
-- altering an extension.
ALTER EXTENSION vector ADD ACCESS METHOD dummy_am_yb_user;
ALTER EXTENSION vector ADD ACCESS METHOD am_not_found;
ALTER EXTENSION vector DROP ACCESS METHOD dummy_am_yb_user;
ALTER EXTENSION vector ADD FUNCTION test_func(INT);
ALTER EXTENSION vector DROP FUNCTION func_not_found(TEXT);
ALTER EXTENSION vector DROP FUNCTION test_func(INT);
DROP EXTENSION vector CASCADE;
\c yugabyte
