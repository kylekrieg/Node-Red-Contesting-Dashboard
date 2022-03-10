Install Readme

## Raspberry Pi OS Install

You can install Node Red on almost any Raspberry Pi, including a Pi Zero.  For instructions on how to build a Rasbperry Pi,
there are tons of YouTube videos out there on how to build.  I created a primer on the Node Red for Ham Radio Groups IO page
That you can use along with a video on after you image your Pi.

[Groups IO Raspberry Pi Imager How To](https://groups.io/g/nodered-hamradio/message/5426)

[How to Install the Raspberry Pi OS & Update](https://youtu.be/4jNbmGgvT2g)

## Install Node Red

One script to rule them all.

[Node Red Raspberry Pi Install Script](https://nodered.org/docs/getting-started/raspberrypi)

## Enable Projects within Node Red

Edit the settings.js file within your /pi/.node-red directory.  In the editorTheme section, enable projects (set to true).  

> editorTheme: {
>        projects: {
>            // To enable the Projects feature, set this value to true
>            enabled: true,



