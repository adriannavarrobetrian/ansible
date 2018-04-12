#!/bin/bash

VERSION=$(date +"%Y%m%d01")
cd /root/backup/$VERSION/cfg

printf "Untarring backups... "
for file in *.tgz; do tar xzf $file; done
echo "done."

