# src/test/modules/Makefile

subdir = src/test/modules
top_builddir = ../../..
include $(top_builddir)/src/Makefile.global

SUBDIRS = \
		  brin \
		  commit_ts \
		  delay_execution \
		  dummy_index_am \
		  dummy_seclabel \
		  libpq_pipeline \
		  plsample \
		  snapshot_too_old \
		  spgist_name_ops \
		  test_bloomfilter \
		  test_ddl_deparse \
		  test_escape \
		  test_extensions \
		  test_ginpostinglist \
		  test_integerset \
		  test_misc \
		  test_oat_hooks \
		  test_parser \
		  test_pg_dump \
		  test_predtest \
		  test_rbtree \
		  test_regex \
		  test_rls_hooks \
		  test_shm_mq \
		  unsafe_tests \
		  worker_spi

ifeq ($(with_ssl),openssl)
SUBDIRS += ssl_passphrase_callback
else
ALWAYS_SUBDIRS += ssl_passphrase_callback
endif

$(recurse)
$(recurse_always)
