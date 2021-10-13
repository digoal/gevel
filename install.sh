#!/bin/bash

set -e

readonly POSTGRESQL_INCLUDE_DIRECTORY="/usr/include/postgresql/server"
readonly POSTGRESQL_EXTENSION_DIRECTORY="/usr/share/postgresql/extension"
readonly POSTGRESQL_LIBRARY_DIRECTORY="/usr/lib/postgresql"

function create_and_copy_so() {
  cp "gevel.c" "gevel_tmp.c"
  cc -fPIC -c -I "${POSTGRESQL_INCLUDE_DIRECTORY}" "gevel_tmp.c" -o "gevel.o"
  cc -shared -o "gevel.so" "gevel.o"
  cp "gevel.so" "${POSTGRESQL_LIBRARY_DIRECTORY}/gevel.so"
  rm "gevel_tmp.c"
  rm "gevel.o"
  rm "gevel.so"
}

function copy_sql_and_control() {
  cp "gevel--1.0.sql" "${POSTGRESQL_EXTENSION_DIRECTORY}/gevel--1.0.sql"
  cp "gevel.control" "gevel_tmp.control"
  sed -i 's,%libdir%,'"${POSTGRESQL_LIBRARY_DIRECTORY}"',g' "gevel_tmp.control"
  cp "gevel_tmp.control" "${POSTGRESQL_EXTENSION_DIRECTORY}/gevel.control"
  rm "gevel_tmp.control"
}

create_and_copy_so
copy_sql_and_control
