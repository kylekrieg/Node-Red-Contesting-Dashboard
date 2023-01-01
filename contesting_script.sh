#!/bin/bash

## ---- Functions ----- ##
#Create ProgressBar function

function ProgressBar {
    # Process data
        let _progress=(${1}*100/${2}*100)/100
        let _done=(${_progress}*4)/10
        let _left=40-$_done
    # Build progressbar string lengths
        _done=$(printf "%${_done}s")
        _left=$(printf "%${_left}s")
    # Output example:
    # Progress : [########################################] 100%
        printf "\rProgress : [${_done// /#}${_left// /-}] ${_progress}%%"
}

# Variables
_start=1
_end=100
clear

## ---- Initial Questioning ---- ##
printf "Welcome to the NodeRed Dashboards.\nPlease hit enter to continue. "
read
echo "Are you installing via Docker? *Recommended way* (Y/n)"
read docker_value
if  [[ $docker_value == 'n' ]] || [[ $docker_value == 'N' ]]; then
    NR_Path=$HOME/.node-red
    echo "Are you wanting to update Node-Red?"
    echo -n "Only choose no if you have installed Node-red all ready on this machine. Most people will choose Yes."
    read -p "(Y/n) " flag_update

    echo "Are you wanting to update the Dashboard? Note this will not delete your data."
    read -p "(Y/n) " dashboard_update
else
    NR_Path=$HOME/Contest_Dashboard
    flag_update='Y'
    dashboard_update='Y'
fi
# Are you a dev?
read -p "Are you planning to help develop any of the dashboards? (y/N)" flag_dev

if [[ $flag_dev == 'Y' || $flag_dev == 'y' ]] ; then
    read -p "What is your Github Username?" git_username
    read -p "What is your Github Email?" git_email
else
    git_username=nobody
    git_email=example@example.com
fi

## ---- Update RPI ---- ##
if  [[ $flag_update != 'n' ]] && [[ $flag_update != 'N' ]]; then
    echo "Updating and Upgrading your Pi to newest standards"
    for number in $(seq ${_start} ${_end})
        do
            sleep 2
            ProgressBar ${number} ${_end}
        done &
    bgid=$!
    sudo apt-get update -qq > /dev/null && sudo apt-get full-upgrade -qq -y > /dev/null && sudo apt-get clean > /dev/null
    kill $bgid
    wait

    ProgressBar ${_end}  ${_end}


    # -- Install Node-Red -- #
    if  [[ $docker_value == 'n' ]] || [[ $docker_value == 'N' ]]; then
        bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) <<!
        y
        y
!
        wait
        clear
        echo "Install and Update NodeRed  Y"
        sudo systemctl stop nodered.service

    fi
    clear
    echo "Updating and Upgrading your Pi to newest standards  Y"
fi
# -- Install git & Sqlite3 / Docker -- #
if  [[ $docker_value == 'n' ]] || [[ $docker_value == 'N' ]]; then
    sudo apt-get install git sqlite3 -y -qq > /dev/null
    echo "Install Git & Sqlite  Y"
else 
    sudo apt-get install git sqlite3 docker.io docker-compose -y -qq
    echo "Install Git Sqlite & Docker Y"
fi
wait

#configure NodeRed
if [[ ! -d $NR_Path ]] ; then
    mkdir $NR_Path
fi 
cd $NR_Path/
if [[ ! -d projects ]] ; then 
  mkdir projects 
fi 
if  [[ $docker_value == 'n' ]] || [[ $docker_value == 'N' ]]; then
    npm install @node-red-contrib-themes/theme-collection --silent &> /dev/null
    curl -sL -o settings.js https://raw.githubusercontent.com/kd9lsv/Node-Red-AutoScripts/master/settings.js
    cd projects
    echo -n "Cloning the Node-Red Dashboard"
    cat > .config.users.json << EOL
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
        if [[ ! -d Node-Red-Contesting-Dashboard ]] ; then 
            git clone https://github.com/kylekrieg/Node-Red-Contesting-Dashboard.git --quiet
            cd ~/.node-red/projects/Node-Red-Contesting-Dashboard
        else 
            cd ~/.node-red/projects/Node-Red-Contesting-Dashboard
            git config pull.rebase true
            git restore flow.json
            git pull &> /dev/null
        fi
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
        ProgressBar ${_end} ${_end}
        kill $bgid
        wait
        cd ~/.node-red/
        cat > .config.projects.json <<EOL  
        {
            "activeProject": "Node-Red-Contesting-Dashboard",
            "projects": {}
        }
EOL
        echo "  Y"
    fi
    sudo systemctl enable --now nodered.service
    HOSTIP=`hostname -I | cut -d ' ' -f 1`
    if [ "$HOSTIP" = "" ]; then
        HOSTIP="127.0.0.1"
    fi
    # Configure SQLITE
    if  [[ $docker_value == 'n' ]] && [[ $docker_value == 'N' ]]; then
    cd $HOME
    curl -sL -o schema_init https://raw.githubusercontent.com/kylekrieg/Node-Red-Contesting-Dashboard/master/schema.db
    sqlite3 qsos < schema_init
    fi

else
    cd $NR_Path
    curl -L -o ./docker-compose.yml https://github.com/radiosport-live/Node-Red-AutoScripts/docker/docker-compose.yml
    read -p "Are you wanting to config the docker container ? (y/N) " docker_config
    if [[ $docker_config == 'Y' || $docker_config == 'y' ]] ; then
        echo "$(pwd)"
        read -p "Press any key to edit the file. Please close when finished."
        read 
        nano docker-compose.yml
        wait
    fi
    mkdir files
    docker-compose up -d
echo "Node Red has Completed. Head to http://$HOSTIP:1880/ui to access the Contest Dashboard."
fi