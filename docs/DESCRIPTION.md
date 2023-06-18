## Configuration & Resets

General Notes

For any form, make sure to click on submit to save. Each section saves separately.

### Cluster with Dupes
Telnet Host configuration: w3lpl.net:7373

### Cluster without Dupes
Telnet Host configuration: dxc.ve7cc.net:23

### Radio Names
Please fill in the name into the top of the form and then click the dropdown to add the PC to the Dashboard.
Note you must use the NETBIOS name from the computer. If using N1MM, head to network status for mor information.

### Contest Configuration
#### Exchange
Below are the options that display on the main dashboard page. Please click the correct exchange.
(when in doubt use Full Exchange)

![Exchange Category](../pics/config&Reset/Exchange.png)

#### Category
Currently the options are the following.
SO1V - 1 VFO
SO2R - Single Op 2 Radio
Multi-Op

#### Dashboard Rate
You can choose rather if you want the main dashboard to have the radio Qs/Hr vs operator Qs/hr.

### Contest Callsign
You need to use the callsign that is for the contest.

### Online Scoreboard

#### Contest Name
To find the abbreviation for the contest online scoreboard head to https://contestonlinescore.com/settings/

### Announcements

#### Say Multi On/Off

#### Great Circle Lines On/Off

#### Lightning Info Enable

### Dashboard Upgrade

#### Rolling Release

Rolling Release is the dev branch on github.
If there is any issue with changing this, you need to use the follow command in the root folder of the node-red project.

* `git checkout origin/dev`

To change back use 

* `git checkout master`.


### Call Lookup Engine & Login

Options are HamDB, QRZ, and HamQth.
QRZ needs an XML subscription, while HamQth does need a login.
HamDB has limited functionality (USA/VE).

### Measurement Units

Distance is used for mapping functions with either miles or kilometers.

Temperature has options of Celsius or Fahrenheit.

### Backup & Restore

Less of an issue, the files get update automatically by node-red. 

### OP Competition Sort By

The options to control on the Op Competition page in the NR-Contest-Dashboard are as follows:
* by QSOs
* by Score
* by Mults

### Map Configuration

### Radiosport.live Data

### Database Reset
