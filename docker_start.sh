#!/bin/bash

path=`pwd`
dir=`basename $path`

docker start $dir

