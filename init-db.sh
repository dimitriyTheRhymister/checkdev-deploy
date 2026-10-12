#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE cd_auth;
    CREATE DATABASE cd_desc;
    CREATE DATABASE cd_generator;
    CREATE DATABASE mock;
    CREATE DATABASE cd_notification;
EOSQL
