FROM postgres:18

COPY 01_schema.sql /docker-entrypoint-initdb.d/01_schema.sql
COPY 02_seed.sql /docker-entrypoint-initdb.d/02_seed.sql
