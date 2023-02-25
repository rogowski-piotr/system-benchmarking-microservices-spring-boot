FROM postgres:latest

EXPOSE 5432

ENV POSTGRES_ROOT_PASSWORD postgres
ENV POSTGRES_USER root
ENV POSTGRES_PASSWORD postgres

COPY *.sql /docker-entrypoint-initdb.d/