#!/bin/bash

VENV_BIN_DIR=$(poetry run which python | sed -e 's/\/python$//')
. ${VENV_BIN_DIR}/activate

SCRIPT_DIR=$(cd $(dirname $0); pwd)
PYTHONPATH=${PYTHONPATH}:./tumblr_aggregate

bash ${APPDIR}/migration/migrate.sh

python tumblr_aggregate/app.py
