#!/bin/bash

DB_PATH=/home/warabanshi/tmp/sqlite/aggregate.db;
SQL_PATH=$(dirname ${BASH_SOURCE[0]})

if [ ! -e $DB_PATH ]; then
    touch $DB_PATH
    sqlite3 $DB_PATH < $SQL_PATH/migrate.sql
fi
