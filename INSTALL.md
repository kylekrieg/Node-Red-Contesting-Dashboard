# STOP <- READ THIS SECTION FIRST

Read this full document.  All the way though.  No TL;DR sympathy here.  There are lots of details below that you must follow.  Reading through this document will answer 99% of your questions regarding install as I keep getting asked the same questions over and over.  They are explained in this document!  Just take 10 mins and read the doc.

## Raspberry Pi OS Install

Node Red can be installed on almost any Raspberry Pi.  Instructions for installing Node Red on other systems can be found on the Node Red website.  For instructions on how to build a Rasbperry Pi, there are tons of YouTube videos out there on how to build from scratch and image.  I created a primer on the Node Red for Ham Radio Groups IO page that you can use, plus a video on how to image your Pi.  See below.  

[Groups IO Raspberry Pi Imager How To](https://groups.io/g/nodered-hamradio/message/5426)

[How to Install the Raspberry Pi OS & Update](https://youtu.be/4jNbmGgvT2g)

After you build your Pi, it probably has a DHCP address on your network.  If your router is smart enough, you might be able to find it via your local DNS via ```raspberrypi.local```.  

## INSTALL SCRIPT

Below you will find the full install of the contesting dashboard from scrath.  KD9LSV has been kind enough to provide a full install script.  Once you have a imaged a Raspberry Pi, issue the following command at the command prompt to start the install.  This script takes 15 to 20 mins to run on a Pi4.  After this script is completed, the only thing left to complete is the N1MM configuration to point the broadcast data to the Pi.  

```bash <( curl -sL https://contesting.nodered.kd9lsv.me)```

If you would like to install everything manually, please see this [install document](/Manual_INSTALL.md)

## Configuration

### N1MM Configuration

On your contest station PCs, within the N1MM entry window, click on ```Config``` then ```Configure Ports, Mode Control, Winkey,etc...``` then ```Broadcast Data``` tab.  
![N1MM Dropdown Menu](/pics/N1MM_dropdown.jpg)

![N1MM Broadcast Tab Configuration](/pics/N1MM_broadcast_tab.jpg)

Click the Radio, Contacts, Score & External Callsign Lookup check boxes.  This enables UDP packets to be sent to the Node Red server.  

Type the following in the correct Radio, Contacts, Score & External Callsign Lookup text boxes where the IP of the Node Red server is aaa.bbb.ccc.ddd.  **Place a space after the default 127.0.0.1:12060 to start your IP address.**

```bash
Radio to aaa.bbb.ccc.ddd:12060
Contacts to aaa.bbb.ccc.ddd:12061
Score to aaa.bbb.ccc.ddd:12062
External Callsign Lookup to aaa.bbb.ccc.ddd:12061
```

**IMPORTANT** when in networking mode:

1) ONLY enable the score checkbox on the ```MASTER N1MM STATION!!!!```.  Only 1 computer should be sending score data to the Node Red server.
2) For contacts either do 1 of the following so duplicate QSO's are not logged to the database
    2A) Check the Contacts box to send QSO data to the dashboard from each networked PC or
    2B) Uncheck the Contacts checkbox on all networked computers AND check the Contacts ALL COMPUTERS on the MASTER N1MM station
  
### TR4W Configuration

Information on configuring TR4W to send the UDP broadcasts on the correct ports is available on the TR4W GitHub Wiki here: [https://github.com/n4af/TR4W/wiki/Configuring-TR4W-for-Node-Red-Contesting-Dashboard](https://github.com/n4af/TR4W/wiki/Configuring-TR4W-for-Node-Red-Contesting-Dashboard)

## Finding Errors

Did you find an error or unexpected behavior?  I probably fixed it in the latest version.  Go ahead and upgrade your flow to the latest and see if that fixes the issue.  I update this program regularly, so you probably don't have the latest version. If not, please feel free to head to the [project's issues page](https://github.com/kylekrieg/Node-Red-Contesting-Dashboard/issues) and see if it is already added/needs to be added.

## General Configuration

The main workspace pallet is located at ```http://ip_address_of_your_rapsberry_pi:1880``` or ```http://hostname_of_your_raspberry_pi.local:1880```

The dashboard website is located at ```http://ip_address_of_your_raspberry_pi:1880/ui``` or ```http://hostname_of_your_raspberry_pi.local:1880/ui```

A few things as we work through the BETA phase of testing.

1) Verify all of the sqlite nodes point to the *qsos* database.  See above for more info.
2) Before each contest, you must clear the database (big red button) and choose a database lookup server for maximum utilization.  If using QRZ.com, enter in your username and password if you have XML lookup enabled on your account.  Hamdb is a free lookup but only can lookup a few DXCC entities as of this writing.

## Dashboard Display Zoom

All of the sections should line up nicely and look uniform on a 1920x1080p screen.  If your dashboard doesn't look like the [sample screenshots here](https://photos.app.goo.gl/J67xuLADBU3CMHYh7), you might need to adjust the **Zoom** level on your browser to around for the dashboard to look correct on a alternative size screen. If you are in full screen mode (hit F11 for full screen mode). If your browser is not allowing you to select a custom zoom setting, check the support pages for the broswer as they are usually configurable. Your browswer should ***remember*** this setting next time you pull up the dashboard.  If your browser does not remember the zoom level, there are plug-ins that allow custom zoom and persistence.  

## Known Issues

For more information about the current issues please head to our [Issues on Github](https://github.com/kylekrieg/Node-Red-Contesting-Dashboard/issues)

## Upgrading

See the section above named *Upgrading after 20220319* to create a new *qsos* database.  After the new database is created, you can download the newest version of this project by completing the *Download the N1MM Dashboard JSON From GitHub* above section again and name the new project with a new date.  Follow the steps again from that point on to verify all the configurations are correct.

If upgrading to v1.0.0 or later, please make sure to modifiy the settings.js file to uncomment the contextStorage value.

```json
   contextStorage: {
        default: {
            module:"localfilesystem"
        },
    },
```

## To Do

For more information about the current roadmap please head to our [Timeline on Github](https://github.com/users/kylekrieg/projects/1) to see when features may be added.

This program is released as-is.  Modify this program as you see fit.
