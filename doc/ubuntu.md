# BigClown Alpha - Software Setup for Ubuntu Host Platform

## Prerequisites

- Ubuntu system 16.04, 15.10, 14.04 or 12.04 (minimum kernel version 3.10)
- Administrator rights
- Internet connectivity
- USB cable, Bridge Module and sensors/actuators (Tags, Modules)

## Install Docker

Please follow instructions at [Docker page](https://docs.docker.com/engine/installation/linux/ubuntulinux/)

## Configure Docker

Disconnect Bridge Module from USB.

Connect Bridge Module with USB cable again.

`mkdir -v $HOME/hub`

## Run Clown.Hub software on Ubuntu

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

Set relay to “true” state (this will publish message to MQTT broker
running inside the container):

`docker exec hub mosquitto_pub -t nodes/bridge/0/relay/i2c0-3b/set
 -m '{"state": true}'`

Set relay to “false” state:

`docker exec hub mosquitto_pub -t nodes/bridge/0/relay/i2c0-3b/set
 -m '{"state": false}'`

If you want to see values from a simulator (running as parallel process
inside the container):

`docker exec hub mosquitto_sub -v -t 'nodes/bridge/simulator/#'`
