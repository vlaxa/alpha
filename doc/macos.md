# BigClown Alpha - Software Setup for macOS Host Platform

## Prerequisites

- macOS 10.10.3 Yosemite or newer
- Mac must be a 2010 or newer model, with Intel’s hardware support for memory management unit (MMU) virtualization; i.e., Extended Page Tables (EPT)
- At least 4 GiB of RAM
- VirtualBox prior to version 4.3.30 must NOT be installed (it is incompatible with Docker for Mac)
- Internet connectivity
- USB cable, Bridge Module and sensors/actuators (Tags, Modules)

## Download and install DockerToolbox

Download [DockerToolbox-1.12.2.pkg](https://github.com/docker/toolbox/releases/download/v1.12.2/DockerToolbox-1.12.2.pkg), open it and follow installation instructions (you may use Docker’s [installation manual](https://docs.docker.com/toolbox/toolbox_install_mac/#/step-2-install-docker-toolbox)).

![docker](resources/docker-toolbox-mac.png)

Start **Docker Quickstart Terminal**.

Run `docker-machine stop` and then `exit`.

Download [VirtualBox 5.1.8 Oracle VM VirtualBox Extension Pack](http://download.virtualbox.org/virtualbox/5.1.8/Oracle_VM_VirtualBox_Extension_Pack-5.1.8.vbox-extpack) and install it; copy and paste to your terminal:

```sh
cd ~/Downloads
wget -O VirtualBox-5.1.8.vbox-extpack http://download.virtualbox.org/virtualbox/5.1.8/Oracle_VM_VirtualBox_Extension_Pack-5.1.8.vbox-extpack
# If checksum did not match, then do not continue!
echo '2c1e2f5564e9ea5c704021630c87cb70a7bf38e5  VirtualBox-5.1.8.vbox-extpack' | shasum -c
open VirtualBox-5.1.8.vbox-extpack
```

## Configure VirtualBox USB and Network

Connect Bridge Module with USB cable.

Start **Oracle VM VirtualBox**

Add USB config for FT260 of default virtual machine

![usb](resources/vbox-usb-mac.png)

Add Network Port Forwarding in Adapter 1 (NAT) of **default** virtual machine for HTTP and MQTT.

![tcp](resources/vbox-tcp-mac.png)

## Configure Docker

Start **Docker Quickstart Terminal**

Disconnect Bridge Module from USB.

Connect Bridge Module with USB cable.

`mkdir -v $HOME/hub`

Note created directory (looks like /Documents/hub) - "host directory" in references below.

## Run Clown.Hub software on macOS

BigClown uses Docker container technology for seamless software delivery.

Pull Docker image from Docker Hub and run the container in one command:

`docker run -d -p 8080:8080 -p 1883:1883 --privileged -v /dev:/dev -v $HOME/hub:/var/hub -h hub-container --name hub clown/hub`

You can stop container by: 

`docker stop hub`

And start it again by: 

`docker start hub`

## Open the browser and play with the gadgets

Navigate to URL:

<https://hub.local:8080/dashboard> or <https://localhost:8080/dashboard>

Be aware that the connection is not encrypted, so it’s not safe to access it over public internet.

## MQTT playground

Look at measured values (this will subscribe to messages from MQTT broker
running inside the container):

`docker exec hub mosquitto_sub -v -t 'nodes/bridge/0/#'`

Set relay to "true" state (this will publish message to MQTT broker
running inside the container):

`docker exec hub mosquitto_pub -t nodes/bridge/0/relay/i2c0-3b/set
 -m '{"state": true}'`

Set relay to "false" state:

`docker exec hub mosquitto_pub -t nodes/bridge/0/relay/i2c0-3b/set
 -m '{"state": false}'`

If you want to see values from a simulator (running as parallel process
inside the container):

`docker exec hub mosquitto_sub -v -t 'nodes/bridge/simulator/#'`
