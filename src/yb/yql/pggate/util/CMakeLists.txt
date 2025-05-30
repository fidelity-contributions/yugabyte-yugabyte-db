# Copyright (c) YugaByte, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied.  See the License for the specific language governing permissions and limitations
# under the License.
#

set(YB_PCH_PATH ../)

# We need access to the generated pg_type_d.h header from this directory.
include_directories("${YB_BUILD_ROOT}/postgres_build/src/backend")

set(PGGATE_UTIL_SRCS
    pg_wire.cc
    pg_doc_data.cc
    pg_tuple.cc
    ybc_guc.cc
    ybc_util.cc
    ybc-internal.cc
    )

set(PGGATE_UTIL_LIBS
    yb_util
    yb_common)

ADD_YB_LIBRARY(yb_pggate_util
               SRCS ${PGGATE_UTIL_SRCS}
               DEPS ${PGGATE_UTIL_LIBS})

add_dependencies(yb_pggate_util postgres_genbki)
