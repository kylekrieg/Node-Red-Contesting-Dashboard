After installing the OS be sure to issue this command at a terminal (SSH) window to bring your system up to date. 

```
sudo apt update && sudo apt full-upgrade -y && sudo apt clean
```

## Install Node Red

One script to rule them all.  Copy and run at the command prompt.  No sudo access needed.  Putty is a good SSH client for this.

```
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
```

After the install script is finished, make sure you start the service and enable on boot.
```
sudo systemctl start nodered.service
sudo systemctl enable nodered.service
```
Now try and get into the Node Red web workspace interface for the first time to verify Node Red is running correctly.  

Type the following into a web browser; ```http://ip_address_of_your_raspberry_pi:1880```.  You can also try ```http://hostname_of_raspberry_ip.local:1880```.  Complete the initial tutorial if it runs.  It will only run once. 

[Official Node Red Raspberry Pi Documentation](https://nodered.org/docs/getting-started/raspberrypi)

## Enable Projects within Node Red

First, go and watch this 12 min YouTube video on Node Red projects.  [Node Red Projects Overview](https://youtu.be/Bto2rz7bY3g).  

Second, we need to install git.  On your Pi, enter in the below command at a terminal.

```
sudo apt-get install git
```

Edit the settings.js file within your /home/pi/.node-red directory.  Issue the following commands below.

```
sudo nano /home/pi/.node-red/settings.js
```
In the editorTheme section, enable projects (set to true).  It's probably currently set to false.  Save the settings.js file and restart Node Red.  

***CTRL+X*** to exit nano.

The editor will ask you if you want to save the file.  Type ***Y*** for yes to save the file.  Write the file to settings.js.

```
editorTheme: {
       projects: {
           // To enable the Projects feature, set this value to true
           enabled: true,
```

Restart Node Red from the command prompt.

~~~
sudo systemctl restart nodered.service
~~~

After restarting the Node Red server with projects enabled, go back into the web workspace interface of Node Red.  You will be asked to setup a default project.  Your existing flows will be put into this default project.  If asked to setup a Github account, just choose a username and enter your email address.  You can change these values later if you want to actually create a Github account.  Choose no encryption if prompted.

[Node Red Project Documentation](https://nodered.org/docs/user-guide/projects/)

## Pi SQLITE Configuration

This flow requires sqlite3 to be installed on your system.  At a terminal command prompt issue the command.  This will load sqlite3 on your Pi.

```
sudo apt-get install sqlite3
```
### Upgrading After 20220319

We are going to archive the old qsos database and create a new one.  As of 20220319 I have a new database schema to use. Type the following two commands below to copy the qsos database to qsos_old and then remove the existing database.  Resume by creating the qsos database below. 

```
cp /home/pi/qsos qsos_old
rm /home/pi/qsos
```

At the terminal command prompt User (pi) type the following to create a database named qsos and drop you into the database server.

```
sqlite3 qsos
```

Now we need to create some tables within the qsos database.

At the database prompt, copy everything below and paste it into the database.  When done, hit *enter*.  This will create a table named qsos and a table named spots.  It will also create an index on the table qsos.

```
CREATE TABLE IF NOT EXISTS qsos(
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
CREATE TABLE IF NOT EXISTS radio(
  "timestamp" TEXT,
  "app" TEXT,
  "StationName" TEXT,
  "RadioNr" TEXT,
  "Freq" TEXT,
  "TXFreq" TEXT,
  "Mode" TEXT,
  "OpCall" TEXT,
  "IsRunning" TEXT,
  "FocusEntry" TEXT,
  "EntryWindowHwnd" TEXT,
  "antenna" TEXT,
  "Rotors" TEXT,
  "FocusRadioNr" TEXT,
  "IsStereo" TEXT,
  "IsSplit" TEXT,
  "ActiveRadioNr" TEXT,
  "IsTransmitting" TEXT,
  "FunctionKeyCaption" TEXT,
  "RadioName" TEXT,
  "AuxAntSelected" TEXT,
  "AuxAntSelectedName" TEXT
);
CREATE TABLE IF NOT EXISTS spots(
  "timestamp" TEXT,
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

**IMPORTANT** only enable the socre checkbox on the ```MASTER N1MM STATION!!!!```.  Only 1 computer should be sending score data to the Node Red server.

### TR4W Configuration
Information on configuring TR4W to send the UDP broadcasts on the correct ports is available on the TR4W GitHub Wiki here: https://github.com/n4af/TR4W/wiki/Configuring-TR4W-for-Node-Red-Contesting-Dashboard

## Loading Node Dependencies

As of March 2022 the following node dependencies are needed.  Be sure to read the **Configuration** section below.

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
node-red-contrib-moment
```

After installing these node dependencies (which you should receive a pop up message asking you to resolve node dependencies after you clone the project), you'll need to restart Node Red for the nodes to work properly.  From a command prompt, issue the following command.  Note : some dashboard nodes will only populate in your node palette after a restart. 

```sudo systemctl restart nodered.service```

## Download the Dashboard JSON From GitHub

[Github code](https://github.com/kylekrieg/N1MM-Node-Red-Dashboard)

I would highly suggest you clone the flows from the github page and run this on a separate dedicated Pi.  Learn how to clone a respository from the [Node Red Projects](https://youtu.be/Bto2rz7bY3g?t=625) video.  A few items to note before cloning.  Use https for your clone transport, ```DO NOT USE SSH``` if you haven't set up github SSH keys before.  If you use the https method, you do not need a username or password for github to clone.  Leave those fields blank if asked.

Name your project ```Contest_Dashboard_<DATE>```.  Naming your project with the current date will help when upgrading to the latest version later. 

```
https://github.com/kylekrieg/N1MM-Node-Red-Dashboard.git
```

![Node Red Clone Window](https://github.com/kylekrieg/N1MM-Node-Red-Dashboard/blob/master/pics/NodeRed_Clone_Screen.jpg)

## SQLITE Node Configuration

If you follow the instructions for creating the *qsos* database in the pi home directory, you shouldn't need to re-configure any SQLite nodes.  If you are installing this flow on a non-Raspberry Pi environment, you'll need to make sure all SQLite nodes point to the location of the database on the Node Red computer.  To change the default location;

1) Double click each SQLite node (there are quite a few) to bring up the properties of the node.
2) Click on the pencil icon to the right of the database name.
3) Enter in the full path on your computer to where the *qsos* database is located.  Windows users, spaces and long directories are not allowed.  Do a Google search on how to shorten file paths and how to deal with spaces in your file path. 

## General Configuration

The main workspace pallet is located at ```http://ip_address_of_your_rapsberry_pi:1880``` or ```http://hostname_of_your_raspberry_pi.local:1880```

The dashboard website is located at ```http://ip_address_of_your_raspberry_pi:1880/ui``` or ```http://hostname_of_your_raspberry_pi.local:1880/ui```

A few things as we work through the BETA phase of testing.

1) Verify all of the sqlite nodes point to the *qsos* database.  See above for more info. 
2) Configure all the dashboard user settings on the **Configuration & Resets** tab.  Note : If you reboot your Pi or re-start the Node Red server, the configuration settings will be lost so write them down.
3) Before each contest, you must clear the database (big red button) and choose a database lookup server or the dashboard will complain to you.  If using QRZ.com, enter in your username and password if you have XML lookup enabled on your account.  Hamdb is a free lookup but only can lookup a few DXCC entities as of this writing. 

## Dashboard Display Zoom

All of the sections should line up nicely and look uniform except for the Configuration & Resets tab.  If your dashboard doesn't look like the sample screenshots, you might need to adjust the **Zoom** level on your browser to around 70% for the dashboard to look correct on a 1920 x 1080 screen. If you are in full screen mode, 75% might be the right setting.  If your browser is not allowing you to select a custom zoom setting, check the support pages for the broswer as they are usually configurable. Your browswer should ***remember*** this setting next time you pull up the dashboard.

