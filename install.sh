#!/bin/bash

# this is where Cypht will be installed
DESTINATION="/usr/local/share/cypht-1.4.x"

# validate the destination directory
sudo test -r $DESTINATION -a -x $DESTINATION
if [ $? -ne 0 ]; then
    sudo mkdir $DESTINATION
fi

# create working directory
mkdir cypht-temp
cd cypht-temp

# grab latest code
wget https://github.com/cypht-org/cypht/archive/1.4.x.zip

# unpack the archive
unzip 1.4.x.zip

# run composer
cd cypht-1.4.x && composer install && cd ..

# create a vanilla ini file
cp cypht-1.4.x/hm3.sample.ini cypht-1.4.x/hm3.ini

# fix permissions and ownership
find cypht-1.4.x -type d -print | xargs chmod 755
find cypht-1.4.x -type f -print | xargs chmod 644
sudo chown -R root:root cypht-1.4.x

# copy to destination folder
sudo mv cypht-1.4.x/* $DESTINATION

# remove working directory
cd ..
sudo rm -rf cypht-temp