#!/bin/bash

p=$(ps -ef | grep "python ./nsca-helper-daemon.py" | awk "NR==1" | awk '{print $3}' | tail -n 1)

echo $p

kill -9 $p
