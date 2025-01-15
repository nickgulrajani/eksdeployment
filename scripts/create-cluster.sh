#!/bin/bash

eksctl create cluster \
    --name my-cluster \
    --region your-region \
    --nodegroup-name standard-workers \
    --node-type t3.medium \
    --nodes 2 \
    --nodes-min 1 \
    --nodes-max 4 \
    --managed
