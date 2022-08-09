[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/rogowski-piotr/system-benchmarking-monolith-vs-microservices/blob/piotr-create-documentation-for-application/LICENSE.md)
[![Tests e2e status](https://github.com/rogowski-piotr/system-benchmarking-monolith-vs-microservices/actions/workflows/test.yml/badge.svg)](https://github.com/rogowski-piotr/system-benchmarking-monolith-vs-microservices/actions/workflows/test.yml?query=branch%3Amain)


# Benchmark of software architecture


## Table of content
* [General Information](#general-information)
* [Used Technologies](#used-technologies)
* [Architecture Overview](#architecture-overview)
* [Infrastructure Overview](#infrastructure-overview)
* [Benchmark Overview](#benchmark-overview)
* [Start Guide](#start-guide)
* [About Authors](#about-authors)


## General Information
This is an implementation of a complete benchmarking application. It is adapted to compare the performance and scalability of applications depending on the used technology and software architecture.

Each of the applications being the subject of research offers service for the traveling salesman algorithm implemented in two different versions. Each of them is based on a different computational and memory complexity. The input data for each application are cities in Poland correlated with their coordinates. Currently, the applications have been implemented in several technologies:
 * Java &nbsp; Spring Boot
 * C# &nbsp; .NET
 * Python &nbsp; Flask

Each of the technologies was implemented using two different software architectures - monolith and microservices. During the process of their implementation a big pressure was put to use the same logic for each application. Also, each application was containerized using Docker.

Benchmark generates an even load on the application and collects data about resource consumption and response times. The application has been designed to conduct tests in the cloud environment using the AWS platform. Appropriate tools were used to automate the benchmark launch process and all processes were divided into separate stages:
 * Preparing cloud environment (set type of instance, etc.)
 * Configure environment (install dependent software and tools)
 * Launch benchmark (run application and collect data)

Monitoring of application has been implemented in a way that allows to review dedicated metrics in the form of static charts after the benchmark ends. There is also a possibility to observe metrics in real time using the Graphana tool.

## Used Technologies

### Applications:
 * Python3 and Flask framework
 * Java 17 and Spring Boot framework
 * C# and .NET framework
 * Docker and docker-compose to containerize each applications
 * Nginx as reverse proxy for microservices

### Infrastructure:

### Aplication load:

### Postprocessing:

## Architecture Overview

## Infrastructure Overview

## Benchmark Overview

## Start Guide

## About Authors
This project is a part of the "Projekt Badawczy" program performed by students of Computer Science master degree studies at GUT.