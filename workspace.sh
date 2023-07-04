#!/bin/bash
docker build -t local-jenkins:latest .
docker-compose up -d local-jenkins