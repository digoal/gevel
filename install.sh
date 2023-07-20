#!/bin/bash

set -e

POSTGRESQL_INCLUDE_DIRECTORY="/usr/include/postgresql/14/server"
POSTGRESQL_EXTENSION_DIRECTORY="/usr/share/postgresql/14/extension"
POSTGRESQL_LIBRARY_DIRECTORY="/usr/lib/postgresql/14/lib"

function create_and_copy_so() {
  cp -n "gevel.c" "gevel_tmp.c"
  cc -fPIC -c -I "${POSTGRESQL_INCLUDE_DIRECTORY}" "gevel_tmp.c" -o "gevel.o"
  cc -shared -o "gevel.so" "gevel.o"
  cp -n "gevel.so" "${POSTGRESQL_LIBRARY_DIRECTORY}/gevel.so"
  rm -f "gevel_tmp.c"
  rm -f "gevel.o"
  rm -f "gevel.so"
}

function copy_sql_and_control() {
  cp -n "gevel--1.0.sql" "${POSTGRESQL_EXTENSION_DIRECTORY}/gevel--1.0.sql"
  cp -n "gevel.control" "gevel_tmp.control"
  sed -i 's,%libdir%,'"${POSTGRESQL_LIBRARY_DIRECTORY}"',g' "gevel_tmp.control"
  cp -n "gevel_tmp.control" "${POSTGRESQL_EXTENSION_DIRECTORY}/gevel.control"
  rm -f "gevel_tmp.control"
}

create_and_copy_so
copy_sql_and_control
return 0
