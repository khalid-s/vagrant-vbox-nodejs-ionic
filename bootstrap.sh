#!/usr/bin/env bash

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

#** Fix locale Mac Lion notice
#********************************************************************
sudo locale-gen

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get upgrade -y --fix-missing

sudo apt-get install nginx -y
sudo ufw enable -y
sudo ufw allow 'OpenSSH'
sudo ufw allow 'Nginx HTTP'

echo -e "$Cyan \n Installing MongoDB $Color_Off"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update

Installing ruby for SASS and Compass support
echo -e "$Cyan \n Installing ruby for SASS and Compass support $Color_Off"
sudo apt-get install ruby-full build-essential libssl-dev npm git mongodb-org -y

sudo gem update -f
sudo gem install compass

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh -o install_nvm.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.profile
nvm install 6.10

echo -e "$Cyan \n NodeJS and npm install $Color_Off"
sudo ln -s /usr/bin/nodejs /usr/bin/node

sudo npm install -g typescript gulp-cli concurrently typings grunt-cli bower cordova ionic pm2 forever express-generator nodemon@1.10.1 strongloop
sudo env PATH=$PATH:/home/ubuntu/.nvm/versions/node/v6.10.3/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu

echo -e "$Cyan \n Adding rsa key to ssh agent $Color_Off"
eval "$(ssh-agent -s)"
mkdir -p ~/.ssh
echo -e "$Cyan \n Copy rsa key to ssh folder $Color_Off"
cp /var/www/vagrant-stuffs/id_rsa ~/.ssh
echo -e "$Cyan \n Change rsa key mode to 400 $Color_Off"
chmod 400 ~/.ssh/id_rsa
echo -e "$Cyan \n Add rsa key to ssh agent $Color_Off"
ssh-add ~/.ssh/id_rsa

sudo apt-get install git -y

ssh-keyscan -H github.com >> ~/.ssh/known_hosts && chmod 600 ~/.ssh/known_hosts

sudo mkdir -p /etc/nginx/sites-available
sudo cp /var/www/vagrant-stuffs/nginx-conf /etc/nginx/sites-available/default
sudo cp /var/www/vagrant-stuffs/hosts /etc/hosts

exit;
