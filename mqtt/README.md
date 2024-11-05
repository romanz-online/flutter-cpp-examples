# flutter-mqtt



## Getting started

Install mosquitto (Linux) with:
```
sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

sudo apt-get install \
      clang cmake git \
      ninja-build pkg-config \
      libgtk-3-dev liblzma-dev \
      libstdc++-12-dev

sudo apt install mosquitto mosquitto-clients
```

Check that mosquitto is installed:
```
mosquitto -version
```

Then run an instance of mosquitto with (default port in project is 1883):
```
mosquitto -p <port_number>
```

If you run mosquitto in the background with `-d`, run this command to kill the process when needed:
```
sudo pkill mosquitto
```
