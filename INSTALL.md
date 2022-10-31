## STOP <- READ THIS SECTION FIRST

Read this full document.  All the way though.  No TL;DR sympathy here.  There are lots of details below that you must follow.  Reading through this document will answer 99% of your questions regarding install as I keep getting asked the same questions over and over.  They are explained in this document!  Just take 10 mins and read the doc. 

## Raspberry Pi OS Install

Node Red can be installed on almost any Raspberry Pi.  Instructions for installing Node Red on other systems can be found on the Node Red website.  For instructions on how to build a Rasbperry Pi, there are tons of YouTube videos out there on how to build from scratch and image.  I created a primer on the Node Red for Ham Radio Groups IO page that you can use, plus a video on how to image your Pi.  See below.  

Be sure to create the ```pi``` username (either at bootup during imaging or later), as the backup and restore functions require the ```/home/pi``` directory to exist.  

[Groups IO Raspberry Pi Imager How To](https://groups.io/g/nodered-hamradio/message/5426)

[How to Install the Raspberry Pi OS & Update](https://youtu.be/4jNbmGgvT2g)

After you build your Pi, it probably has a DHCP address on your network.  If your router is smart enough, you might be able to find it via your local DNS via ```raspberrypi.local```.  

## INSTALL SCRIPT

Below you will find the full install of the contesting dashboard from scrath.  KD9LSV has been kind enough to provide a full install script.  Once you have a imaged a Raspberry Pi, issue the following command at the command prompt to start the install.  This script takes 15 to 20 mins to run on a Pi4.  After this script is completed, the only thing left to complete is the N1MM configuration to point the broadcast data to the Pi.  

```bash <( curl -sL https://contesting.nodered.kd9lsv.me/)```

If you would like to install everything manually, please see this [install document](https://github.com/kylekrieg/Node-Red-Contesting-Dashboard/blob/master/Manual_INSTALL.md)

## Configuration

### N1MM Configuration
On your contest station PCs, within the N1MM entry window, click on ```Config``` then ```Configure Ports, Mode Control, Winkey,etc...``` then ```Broadcast Data``` tab.  
![N1MM Dropdown Menu](https://github.com/kylekrieg/N1MM-Node-Red-Dashboard/blob/master/pics/N1MM_dropdown.jpg)

![N1MM Broadcast Tab Configuration](https://github.com/kylekrieg/N1MM-Node-Red-Dashboard/blob/master/pics/N1MM_broadcast_tab.jpg)

Click the Radio, Contacts, Score & External Callsign Lookup check boxes.  This enables UDP packets to be sent to the Node Red server.  

Type the following in the correct Radio, Contacts, Score & External Callsign Lookup text boxes where the IP of the Node Red server is aaa.bbb.ccc.ddd.  **Place a space after the default 127.0.0.1:12060 to start your IP address.**

```
Radio to aaa.bbb.ccc.ddd:12060
Contacts to aaa.bbb.ccc.ddd:12061
Score to aaa.bbb.ccc.ddd:12062
External Callsign Lookup to aaa.bbb.ccc.ddd:12061
```

**IMPORTANT** when in networking mode:
1) ONLY enable the socre checkbox on the ```MASTER N1MM STATION!!!!```.  Only 1 computer should be sending score data to the Node Red server.  
2) For contacts either do 1 of the following so duplicate QSO's are not logged to the database
    2A) Check the Contacts box to send QSO data to the dashboard from each networked PC or
    2B) Uncheck the Contacts checkbox on all networked computers AND check the Contacts ALL COMPUTERS on the MASTER N1MM station
    
    
### TR4W Configuration
Information on configuring TR4W to send the UDP broadcasts on the correct ports is available on the TR4W GitHub Wiki here: https://github.com/n4af/TR4W/wiki/Configuring-TR4W-for-Node-Red-Contesting-Dashboard

## Finding Errors

Did you find an error or unexpected behavior?  I probably fixed it in the latest version.  Go ahead and upgrade your flow to the latest and see if that fixes the issue.  I update this program daily, so you probably don't have the latest version. 

## General Configuration

The main workspace pallet is located at ```http://ip_address_of_your_rapsberry_pi:1880``` or ```http://hostname_of_your_raspberry_pi.local:1880```

The dashboard website is located at ```http://ip_address_of_your_raspberry_pi:1880/ui``` or ```http://hostname_of_your_raspberry_pi.local:1880/ui```

A few things as we work through the BETA phase of testing.

1) Verify all of the sqlite nodes point to the *qsos* database.  See above for more info. 
2) Configure all the dashboard user settings on the **Configuration & Resets** tab.  Note : If you reboot your Pi or re-start the Node Red server, the configuration settings will be lost so write them down.
3) Before each contest, you must clear the database (big red button) and choose a database lookup server or the dashboard will complain to you.  If using QRZ.com, enter in your username and password if you have XML lookup enabled on your account.  Hamdb is a free lookup but only can lookup a few DXCC entities as of this writing. 

## Dashboard Display Zoom

All of the sections should line up nicely and look uniform except for the Configuration & Resets tab on a 1080p screen.  If your dashboard doesn't look like the [sample screenshots here](https://photos.app.goo.gl/J67xuLADBU3CMHYh7), you might need to adjust the **Zoom** level on your browser to around for the dashboard to look correct on a 1920 x 1080p screen. If you are in full screen mode (hit F11 for full screen mode), 75% might be the right setting.  If your browser is not allowing you to select a custom zoom setting, check the support pages for the broswer as they are usually configurable. Your browswer should ***remember*** this setting next time you pull up the dashboard.  If your browser does not remember the zoom level, there are plug-ins that allow custom zoom and persistence.  

## Known Issues

1) The Spectator Dashboard is still a work in progress.  The vision of this screen is for an operator to be able to use this dashboard to stream to YouTube or Twitch without violating any contest rules.  This dashboard will not give your frequency or band information away but allows the viewer to interact and learn more about contesting and ham radio.
2) The trending arrows on the Operator Competition dashboard need some more work.  I'm not 100% satisified with the way they work.
4) Resize your browser tab (zoom in/out) to get all the dashboard groups to align correctly on the page.  You can hit F11 to go full screen.  We are working on CSS coding to allow the screen to look correct on an HD screen.
5) On the graphical line charts, the most recent data point time is typically in local time with the rest of the data points in UTC.  This is a known bug in the graphing dashboard node.
6) The great circle lines in the Worldmap node currently have an issue with the international date line.  The developers are working on this bug.
7) If you use HamQTH for your Q lookup, not every call in the world is in that database, therefore you might not see it in the latest Q section of the main dashboard screen.  More work to be completed on that.

## Upgrading

See the section above named *Upgrading after 20220319* to create a new *qsos* database.  After the new database is created, you can download the newest version of this project by completing the *Download the N1MM Dashboard JSON From GitHub* above section again and name the new project with a new date.  Follow the steps again from that point on to verify all the configurations are correct.

## To Do

The laundry list is huge.  These are just a few.

1) Setup the dashboard for Field Day and Winter Field Day.
2) Be able to highlight and fill a choropleth map based on Qs worked in each section/zone/state/DXCC.
5) Writelog and N3FJP integration.
6) WAC (Work All Contests) entry window.  This would be a basic entry window to allow an operator to work all the contests happening during the operating time no matter of the exchange and be able to create a Cabrillo file for each contest.

This program is released as-is.  Modify this program as you see fit. 


