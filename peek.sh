#!/bin/bash

echo $1

head  -n 3 $1
echo ...
tail -n 3 $1
