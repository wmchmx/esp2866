#!/bin/bash
sudo apt-get --yes install update
sudo apt-get --yes install upgrade
sudo apt-get --yes install git autoconf build-essential gperf bison flex texinfo libtool libncurses5-dev wget gawk libc6-dev-amd64 python-serial libexpat-dev
mkdir /opt/Espressif
chown "$USER" opt/Espressif/

cd /opt/Espressif
git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git 
cd crosstool-NG
./bootstrap && ./configure --prefix="$PWD" && make && make install
./ct-ng xtensa-lx106-elf
./ct-ng build

PATH="$PWD"/builds/xtensa-lx106-elf/bin:"$PATH"

cd /opt/Espressif
SDK_NAME_PREFIX=esp_iot_sdk
SDK_VERSION=1.2.0
SDK_REVISION=15_07_03
SDK_ZIP_FILE="$SDK_NAME_PREFIX""_v""$SDK_VERSION""_""$SDK_REVISION"".zip"

wget -O "$SDK_ZIP_FILE" "https://github.com/esp8266/esp8266-wiki/raw/master/sdk/""$SDK_ZIP_FILE"
unzip "$SDK_ZIP_FILE"
mv "$SDK_NAME_PREFIX""_v""$SDK_VERSION" ESP8266_SDK
mv License ESP8266_SDK/
