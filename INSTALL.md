## STOP <- READ THIS SECTION FIRST

Read this full document.  All the way though.  No TL;DR sympathy here.  There are lots of details below that reading through this document will answer 99% of your questions regarding install.  I keep getting asked the same questions over and over and they are explained in this document.  Just take 10 mins and read the doc. 

## Raspberry Pi OS Install

Node Red can be installed on almost any Raspberry Pi.  Instructions for installing Node Red on other systems can be found on the Node Red website.  For instructions on how to build a Rasbperry Pi, there are tons of YouTube videos out there on how to build from scratch and image.  I created a primer on the Node Red for Ham Radio Groups IO page that you can use, plus a video on how to image your Pi.  See below.

[Groups IO Raspberry Pi Imager How To](https://groups.io/g/nodered-hamradio/message/5426)

[How to Install the Raspberry Pi OS & Update](https://youtu.be/4jNbmGgvT2g)

## Install Node Red

One script to rule them all.  Follow the instructions on this website on how to install Node Red on your Pi.
Be sure to start the Node Red service per the instructions and you can get into the Node Red web interface for the first time.

[Node Red Raspberry Pi Install Script](https://nodered.org/docs/getting-started/raspberrypi)

## Enable Projects within Node Red

First we need to install git.  Enter in the below command at a terminal.

```
sudo apt-get install git
```

Edit the settings.js file within your /home/pi/.node-red directory.  In the editorTheme section, enable projects (set to true).  It's probably currently set to false.  Save the file and restart Node Red.

```
editorTheme: {
       projects: {
           // To enable the Projects feature, set this value to true
           enabled: true,
```

Restart Node Red from the command prompt

~~~
sudo systemctl restart nodered.service
~~~

## Pi SQLITE Configuration

This flow require sqlite3 to be installed on your system.  At a terminal command prompt issue the command.  This will load sqlite3 on your Pi.

```
sudo apt-get install sqlite3
```

At the terminal command prompt User (pi) type the following to create a database named qsos and drop you into the database server.

```
sqlite3 qsos
```

Now we have to create tables calles qsos within the qsos database.

At the sqlite prompt, copy everything below and paste into the database.  When done, hit *enter*.  This will create a table named qsos and a table named spots.  It will also create an index on the table qsos.

```
CREATE TABLE qsos(
  "app" TEXT,
  "contestname" TEXT,
  "contestnr" TEXT,
  "timestamp" TEXT,
  "mycall" TEXT,
  "band" TEXT,
  "rxfreq" TEXT,
  "txfreq" TEXT,
  "operator" TEXT,
  "mode" TEXT,
  "call" TEXT,
  "countryprefix" TEXT,
  "wpxprefix" TEXT,
  "stationprefix" TEXT,
  "continent" TEXT,
  "snt" TEXT,
  "sntnr" TEXT,
  "rcv" TEXT,
  "rcvnr" TEXT,
  "gridsquare" TEXT,
  "exchange1" TEXT,
  "section" TEXT,
  "comment" TEXT,
  "qth" TEXT,
  "name" TEXT,
  "power" TEXT,
  "misctext" TEXT,
  "zone" TEXT,
  "prec" TEXT,
  "ck" TEXT,
  "ismultiplier1" TEXT,
  "ismultiplier2" TEXT,
  "ismultiplier3" TEXT,
  "points" TEXT,
  "radionr" TEXT,
  "run1run2" TEXT,
  "RoverLocation" TEXT,
  "RadioInterfaced" TEXT,
  "NetworkedCompNr" TEXT,
  "IsOriginal" TEXT,
  "NetBiosName" TEXT,
  "IsRunQSO" TEXT,
  "StationName" TEXT,
  "ID" TEXT,
  "IsClaimedQso" TEXT,
  "lat" TEXT,
  "lon" TEXT,
  "isbusted" TEXT,
  "distance" TEXT
);
CREATE TABLE spots(
  "call" TEXT type UNIQUE,
  "lat" TEXT,
  "lon" TEXT,
  "grid" TEXT
);
CREATE INDEX call_idx on spots(call);
```
  
To verify, type .schema at the database carrot prompt to confirm your database structure.  You should see everything above.

```
.schema
```
  
Type .exit to exit out of the database and return to the Pi terminal command prompt.

```
.exit 
```

Your Node Red local qsos database is now created and ready to go.

Now configure the properties of the SQLite node (you installed via pallet manager) to create (or confirm) the nodes (should be many of them) are pointing to the qsos database.  
The database name is case sensitive inside the sqlite node properties.  

## N1MM Configuration

On your contest station PCs, within the N1MM entry window, click on **Config** then **Configure Ports, Mode Control, Winkey,etc...** then **Broadcast Data** tab.  

![N1MM Dropdown Menu](https://github.com/kylekrieg/N1MM-Node-Red-Dashboard/blob/master/N1MM_dropdown.jpg)

![N1MM Broadcast Tab Configuration](https://github.com/kylekrieg/N1MM-Node-Red-Dashboard/blob/master/N1MM_broadcast_tab.jpg)

Click the Radio, Contacts & Score check boxes.  This enables UDP packets to be sent to the Node Red server.  

Type the following in the correct Radio, Contacts & Score text boxes where the IP of the Node Red server is aaa.bbb.ccc.ddd.  
Place a space after the default IP:Port to start your IP address.

```
Radio to aaa.bbb.ccc.ddd:12060
Contacts to aaa.bbb.ccc.ddd:12061
Score to aaa.bbb.ccc.ddd:12062
```

**IMPORTANT** only enable the socre checkbox on the **MASTER N1MM STATION!!!!**  Only 1 computer should be sending score data to Node Red server.

## Download the N1MM Dashboard JSON From GitHub & Load

[Github code](https://github.com/kylekrieg/N1MM-Node-Red-Dashboard)

I would highly suggest you clone the dashboard from the github page and run this on a separate dedicated Pi.  Learn how to clone a respository from the [Node Red Projects](https://youtu.be/Bto2rz7bY3g?t=625) video.  A few items to note.  Use https for your clone transport, **DO NOT USE SSH** if you haven't set up github SSH keys.  If you use the https method, you do not need a username or password for github to clone.  Leave those fields blank if asked.

## Loading Node Dependencies

As of March 2022 the following node dependencies are needed.  Be sure to read the **Configuration** section below to delete the ***test data*** tab.

```
node-red-contrib-hourglass
node-red-contrib-msg-speed
node-red-contrib-play-audio
node-red-node-ping
node-red-node-smooth
node-red-node-sqlite
node-red-node-ui-table
node-red-contrib-web-worldmap
node-red-dashboard
node-red-contrib-string
node-red-contrib-ui-led
node-red-contrib-unit-converter
```

## Configuration

A few things as we work through the BETA phase of testing.

1) Delete the **Test Data** tab (the first tab) before your first deploy as those flows are only used for testing.
2) Verify all of the sqlite nodes point to the *qsos* database.
3) Configure all the dashboard user settings on the **Configuration & Resets** tab.  Note : If you reboot your Pi or re-start the Node Red server, the configuration settings will be lost so right them down.
4) Before each contest, you must clear the database (big red button) and choose a database lookup server or the dashboard will complain.  If using QRZ.com, enter in your username and password if you have XML lookup enabled on your account.  

## Dashboard Display Zoom

All of the sections should line up nicely and look uniform except for the Configuration & Resets tab.  If they don't you might need to adjust the **Zoom** level on your browser to around 70% for the dashboard to look correct.  Your browswer should ***remember*** this setting next time you pull up the dashboard.

## Known Issues

1) The Spectator Dashboard is still a work in progress.  The vision of this dashboard is for a screen you can stream to YouTube or Twitch without violating any contest rules with giving your frequency or band information away but allows the viewer to interact and learn more about contesting and ham radio.
2) The trending arrows on the Operator Competition dashboard need some more work.  I'm not 100% satisified with the way they work.
3) Configuration parameters get erased when re-starting the Pi or Node Red server.
4) Resize your browser tab (zoom in/out) to get all the dashboard groups to align correctly on the page.  You can hit F11 to go full screen.

## To Do

The laundry list is huge.  These are just a few.

1) Setup the dashboard for Field Day with every little effort.
2) The great circle lines in the Worldmap node currently have an issue with the international date line.  The developers are working on this bug.
3) Be able to highlight and fill a choropleth map based on Qs worked in each section/zone/state/DXCC.
4) Use hamdb.org lookup for RBN spots.
5) Online Scoreboard integration.  Be able chase your friends or a few stations in real time directly from the dashboard.
6) DXLog and N3FJP integration.

More to come on the configuration of each setting as we work through the BETA.
