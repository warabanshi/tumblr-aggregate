#!/bin/bash

DB_PATH=${STORE_DIR}/sqlite/aggregate.db;
SQL_PATH=$(dirname ${BASH_SOURCE[0]})

if [ ! -e $DB_PATH ]; then
    mkdir -p ${STORE_DIR}/sqlite
    touch $DB_PATH
    sqlite3 $DB_PATH < $SQL_PATH/migrate.sql
fi
