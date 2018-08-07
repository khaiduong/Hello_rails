#!/bin/bash
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --rails

#curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
#sudo apt-get install -y nodejs

#sudo apt-get install -y build-essential
source /home/ubuntu/.rvm/scripts/rvm

[[ -d "/data/app" ]] || rm -rf /data/app
cd /data && rails new app 

cd /data/app && rails generate controller pages

[[ -d "/data/app/app/controllers/" ]] || mkdir -p /data/app/app/controllers/
cp /data/src/app/controllers/pages_controller.rb /data/app/app/controllers/pages_controller.rb


[[ -d "/data/app/app/views/pages" ]] || mkdir -p /data/app/app/views/pages/
cp /data/src/app/views/pages/home.html.erb /data/app/app/views/pages/home.html.erb

[[ -d "/data/app/config" ]] || mkdir -p /data/app/config
cp /data/src/config/routes.rb /data/app/config/routes.rb

cd /data/app && nohup rails server -b 0.0.0.0 -d &

sleep 10

echo "Rails's listening on port 3000"
echo ""

exit
exit
