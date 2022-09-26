#!/bin/bash
# 1. Create ProgressBar function
# 1.1 Input is currentState($1) and totalState($2)
function ProgressBar {
# Process data
	let _progress=(${1}*100/${2}*100)/100
	let _done=(${_progress}*4)/10
	let _left=40-$_done
# Build progressbar string lengths
	_done=$(printf "%${_done}s")
	_left=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_done// /#}${_left// /-}] ${_progress}%%"

}
# Variables
_start=1

# This accounts as the "totalState" variable for the ProgressBar function
_end=100
clear
printf "Welcome to the NodeRed Dashboards.\nPlease hit enter to continue. "
read
echo "Are you wanting to update Node-Red?"
echo -n "Only choose no if you have installed Node-red all ready on this machine. Most people will choose Yes."
read -p "(Y/n) " flag_update

echo "Are you wanting to update the Dashboard? Note this will not delete your data."
read -p "(Y/n) " dashboard_update
# Are you a dev?
read -p "Are you planning to help develop any of the dashboards? (y/N)" flag_dev
if [[ $flag_dev == 'Y' || $flag_dev == 'y' ]] ; then
read -p "What is your Github Username?" git_username
read -p "What is your Github Email?" git_email
else
git_username=nobody
git_email=example@example.com
fi
# Ask which Dashboard are you looking for?

# Update RPI
if  [[ $flag_update != 'n' ]] && [[ $flag_update != 'N' ]]; then
echo "Updating and Upgrading your Pi to newest standards"
for number in $(seq ${_start} ${_end})
do
	sleep 2
	ProgressBar ${number} ${_end}
done &
bgid=$!
sudo apt-get update -qq > /dev/null && sudo apt-get full-upgrade -qq -y > /dev/null && sudo apt-get clean > /dev/null
wait

ProgressBar ${_end} ${_end}

#Install Node-Red
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) <<!
y
y
!
wait
clear
echo "**NodeRed Dashboard Status**"
echo "Updating and Upgrading your Pi to newest standards  Y"
echo "Install and Update NodeRed  Y"
# Start NodeRed
sudo systemctl start nodered.service
sudo systemctl enable nodered.service
# Install git & Sqlite3
sudo apt-get install gityy sqlite3 -qq > /dev/null
echo "Install Git & Sqlite  Y"
fi
wait
# Configure SQLITE
cd $HOME
sqlite3 qsos<<!
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
.exit
!
#configure NodeRed
sudo systemctl stop nodered.service
wait
cd $HOME/.node-red
npm install @node-red-contrib-themes/theme-collection --silent &> /dev/null
curl -sL -o settings.js https://settings.nodered.kd9lsv.me
if [[ ! -d projects ]] ; then 
  mkdir projects 
fi 
cd projects
echo -n "Cloning the Node-Red Dashboard"
cat > .config.users.json <<EOL
{
     "_": {
        "editor": {
            "view": {
                "view-store-zoom": false,
                "view-store-position": false,
                "view-show-grid": true,
                "view-snap-grid": true,
                "view-grid-size": "20",
                "view-node-status": true,
                "view-node-show-label": true,
                "view-show-tips": true,
                "view-show-welcome-tours": true
            },
            "tours": {
                "welcome": "3.0.0"
            }
        },
        "git": {
            "user": {
                "name": "$git_username",
                "email": "$git_email"
            },
            "workflow": {
                "mode": "manual"
            }
        },
        "debug": {
            "filter": "filterAll",
            "filteredNodes": []
        }
    }
}
EOL
if [[ $dashboard_update != 'n' ]] && [[ $dashboard_update != 'N' ]]; then
git clone https://github.com/kylekrieg/Node-Red-Contesting-Dashboard.git --quiet
cd Node-Red-Contesting-Dashboard
echo "  Y" 
echo "**The next step will take around 10 minutes. Please be patient.**"
echo  -n "Install modules for Contesting Dashboard."
npm config set jobs 4

for number in $(seq ${_start} ${_end})
do
	sleep 5
	ProgressBar ${number} ${_end}
done &
bgid=$!

npm --prefix ~/.node-red/ install ~/.node-red/projects/Node-Red-Contesting-Dashboard/ --silent &> /dev/null
cd ~/.node-red/
cat > .config.projects.json <<EOL  
{
    "activeProject": "Node-Red-Contesting-Dashboard",
    "projects": {}
}
EOL

echo "  Y"
fi
sudo systemctl restart nodered.service
HOSTIP=`hostname -I | cut -d ' ' -f 1`
    if [ "$HOSTIP" = "" ]; then
        HOSTIP="127.0.0.1"
    fi
echo "Node Red has Completed. Head to http://$HOSTIP:1880/ui to access the Contest Dashboard."
