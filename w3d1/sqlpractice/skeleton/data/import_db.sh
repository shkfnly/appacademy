#!/usr/bin/env sh

dropdb sqlzoo
createdb sqlzoo
psql sqlzoo < create_tables.sql
