#!/bin/bash
sudo apt-get --yes install update
sudo apt-get --yes install upgrade
sudo apt-get --yes install git autoconf build-essential gperf bison flex texinfo libtool libncurses5-dev wget gawk libc6-dev-amd64 python-serial libexpat-dev

ESP2866_BIN_ROOT="/opt/Espressif"
ESP2866_SDK_NAME="ESP8266_SDK"
ESP2866_SDK_ROOT="$ESP2866_BIN_ROOT""/""$ESP2866_SDK_NAME"

mkdir "$ESP2866_BIN_ROOT"
chown "$USER" "$ESP2866_BIN_ROOT"/

cd "$ESP2866_BIN_ROOT"
git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git 
cd crosstool-NG
./bootstrap && ./configure --prefix="$PWD" && make && make install
./ct-ng xtensa-lx106-elf
./ct-ng build
PATH_ADDITION="$PWD""/builds/xtensa-lx106-elf/bin"
PATH="$PATH_ADDITION"":""$PATH"

cd "$ESP2866_BIN_ROOT"
SDK_NAME_PREFIX=esp_iot_sdk
SDK_VERSION=1.2.0
SDK_REVISION=15_07_03
SDK_ZIP_FILE="$SDK_NAME_PREFIX""_v""$SDK_VERSION""_""$SDK_REVISION"".zip"

wget -O "$SDK_ZIP_FILE" "https://github.com/esp8266/esp8266-wiki/raw/master/sdk/""$SDK_ZIP_FILE"
unzip "$SDK_ZIP_FILE"
mv "$SDK_NAME_PREFIX""_v""$SDK_VERSION" "$ESP2866_SDK_NAME"
mv License "$ESP2866_SDK_NAME"/


cd "$ESP2866_SDK_ROOT"
sed -i -e 's/xt-ar/xtensa-lx106-elf-ar/' -e 's/xt-xcc/xtensa-lx106-elf-gcc/' -e 's/xt-objcopy/xtensa-lx106-elf-objcopy/' Makefile
mv examples/IoT_Demo .

cd "$ESP2866_SDK_ROOT"
wget -O lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a
wget -O lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a
wget -O include.tgz https://github.com/esp8266/esp8266-wiki/raw/master/include.tgz
tar -xvzf include.tgz
rm -f include.tgz


cd "$ESP2866_BIN_ROOT"
wget -O esptool_0.0.2-1_i386.deb https://github.com/esp8266/esp8266-wiki/raw/master/deb/esptool_0.0.2-1_i386.deb
dpkg -i esptool_0.0.2-1_i386.deb
rm -f esptool_0.0.2-1_i386.deb

cd "$ESP2866_BIN_ROOT"
git clone "https://github.com/themadinventor/esptool esptool-py"
ln -s "$PWD""/esptool-py/esptool.py" "crosstool-NG/builds/xtensa-lx106-elf/bin/"



ENV_FILE="/home/""$USER""/esp2866-env"
echo "#" > "$ENV_FILE"
echo export PATH="$PATH_ADDITION"":\$PATH" >> "$ENV_FILE"
echo export PS1="\"\\[\\e[32;1m\\][ESP2866-dev]\\[\\e[0m\\]:\\w\> \""

