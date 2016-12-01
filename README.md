# esp2866
Some installation script for the esp2866 development, based on 
    *https://github.com/esp8266/esp8266-wiki/wiki/Toolchain*

iot_sdk currently used is
```
    esp_iot_sdk_v1.2.0_15_07_03
```
Change the script if anothe verion is needed.

Mainly to get a single script to install everything needed to develope esp2866 programs.
Some build systems does not come with web browsers and GUI.
 
So all you need is git. Which installs with 
```
      sudo apt-get install git
```
Pull this from the repository with
```
      git clone git://github.com/wmchmx/esp2866
```
Start the install with
```
      esp2866/esp2866.sh
```
After installation source the environment file in the home directory
```
      source /home/$USER/esp2866-env
```

