#!/bin/bash

path=`pwd`
dir=`basename $path`

docker ps -a -q | xargs docker rm -f
