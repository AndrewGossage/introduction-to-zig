#!/bin/sh
cp ./static/* server/static
odin run . > server/static/index.html
echo "slides compiled"

