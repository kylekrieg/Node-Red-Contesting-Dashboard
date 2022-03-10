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

```
editorTheme: {
       projects: {
           // To enable the Projects feature, set this value to true
           enabled: true,
```

## Configuration

These flows require sqlite3 to be installed on your system.  At a terminal command prompt issue the command (everything after the $).

```
$sudo apt-get install sqlite3
```

This will install sqlite3 on to your raspberry pi.

Non-Standard nodes to load to the pallet (before you load the .json file)

```
"node-red-contrib-hourglass"
"node-red-contrib-msg-speed"
"node-red-contrib-play-audio"
"node-red-node-geofence"
"node-red-node-ping"
"node-red-node-smooth"
"node-red-node-sqlite"
"node-red-node-ui-table"
"node-red-contrib-web-worldmap"
"node-red-dashboard"
"node-red-contrib-string"
"node-red-contrib-ui-led"
"node-red-contrib-unit-converter"
```

After loading the sqlite node, we need to build the QSO table in the database. 

At the terminal command prompt User (pi) type the following (everything after the $).

```
$sqlite3 qsos
```

This will create a database named "qsos" and drop you into the database.

Now we have to create a table within the qsos database called qsos.

At the sqlite> prompt, copy everything below from & including CREATE INDEX down to the semicolon and paste into the database.  When done, hit <enter>  This will create a table called qsos and a table named spots.

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
  
To verify, type .schema at the carrot (>) prompt to confirm your database structure.  You should see everything above.

```
sqlite>.schema
```
  
Type .exit to exit out of the database and return to the Pi command prompt.

```
sqlite>.exit 
```

Your Node Red local qsos database is now created and ready to go.  
Now configure the properties of the SQLite node (you installed via pallet manager) to create (or confirm) the node is pointing to the qsos database.  
The database name is case sensitive inside the node properties.  

For your contest stations, within the N1MM entry window, click on Config -> Configure Ports, Mode Control, Winkey,etc... -> Broadcast Data.  
Click the Radio, Contacts & Score check boxes.  This enables UDP packets to be sent to the Node Red server.  
Type the following in the correct Radio, Contacts & Score text boxes where the IP of the Node Red server is aaa.bbb.ccc.ddd.  
Place a space after the default IP:Port to start your IP address.

Radio to aaa.bbb.ccc.ddd:12060
Contacts to aaa.bbb.ccc.ddd:12061
Score to aaa.bbb.ccc.ddd:12062

For example, the Radio text box should look like this after your done (with the default values still there).

127.0.0.1:12060 192.168.1.30:12060

IMPORTANT -> Only enable the socre checkbox on the MASTER N!MM STATION!!!!  Only 1 computer should be sending score data to Node Red.

Now click on the Configure & Resets tab and configure the dashboard per your liking.  









## Download the N1MM Dashboard JSON From GitHub

[Github code](https://github.com/kylekrieg/N1MM-Node-Red-Dashboard)

## Configure






