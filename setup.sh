#!/bin/bash
git clone https://github.com/kaperrine-dog/react-chatapp.git ./node/react-chatapp && \
docker-compose build --no-cache && \
docker-compose up -d