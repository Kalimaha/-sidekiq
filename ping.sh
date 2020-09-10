#!/bin/bash
echo Wake up the worker
curl -X POST https://kafka-consumer.onrender.com/msg
