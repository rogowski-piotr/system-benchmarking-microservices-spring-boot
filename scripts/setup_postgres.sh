#!/bin/bash

docker build --tag postgres Postgres/

docker run -d -p 5432:5432 --name postgres postgres