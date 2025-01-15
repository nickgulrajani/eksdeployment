#!/bin/bash

aws ecr create-repository \
    --repository-name website \
    --image-scanning-configuration scanOnPush=true \
    --region your-region
