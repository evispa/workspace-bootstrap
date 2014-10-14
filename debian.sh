sudo apt-get update;

# install latest updates
sudo apt-get -y upgrade;

# google chrome
echo "Checking for google-chrome repository...";

if grep -q 'deb http://dl.google.com/linux/chrome/deb/' '/etc/apt/sources.list.d/google.list';
	then
		echo "Repository found.";
	else
		echo "Repository not found.";
		echo "Add repo key.";
		wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -;
		echo "Add repo to sources list.";
		sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list';
		sudo apt-get update;
fi

sudo apt-get -y install google-chrome-beta; # google-chrome-stable?

# virtual box
echo "Checking for virtualbox repository...";

if grep -q 'deb http://download.virtualbox.org/virtualbox/debian' '/etc/apt/sources.list.d/virtualbox.list';
	then
		echo "Repository found.";
	else
		echo "Repository not found.";
		echo "Add repo key.";
		wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -;
		echo "Add repo to sources list.";
		sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list.d/virtualbox.list';
		sudo apt-get update;
fi

sudo apt-get -y install build-essential linux-headers-`uname -r`;
sudo apt-get -y install virtualbox;
sudo apt-get -y install virtualbox-dkms;

# vagrant
## some boxes use nfsd due to slow shared folders issue
sudo apt-get install -y nfs-kernel-server;
## no newest version vagrant in ppa...
cd /tmp;
sudo wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb;
sudo sh dpkg -i vagrant_1.6.3_x86_64.deb;
sudo rm vagrant_1.6.3_x86_64.deb;
## try to install latest
sudo apt-get -y install vagrant;

# filezilla
sudo apt-get -y install filezilla;

# sun Java
sudo apt-get -y purge openjdk*;
sudo apt-get -y install software-properties-common;
sudo add-apt-repository -y ppa:webupd8team/java;
sudo apt-get update;
sudo apt-get -y install oracle-java8-installer;

# version control
sudo apt-get -y install git
sudo apt-get -y install mercurial;

# meld
sudo apt-get -y install meld;

# skype
sudo apt-get -y install skype;

# mysql utilities
sudo apt-get -y install mysql-client;
sudo apt-get -y install mysql-server;

# php-cli
sudo apt-get -y install php5-cli;

# composer
if [ ! -f /usr/bin/composer ]; then
    cd /tmp;
    sudo curl -sS https://getcomposer.org/installer | php;
    sudo mv composer.phar /usr/bin/composer;
    export PATH=~/.composer/vendor/bin:$PATH;
fi

# phpcs
composer global require squizlabs/php_codesniffer:*;
sudo ln -s ~/.composer/vendor/bin/phpcs /usr/bin/phpcs;

# phpmd
composer global require phpmd/phpmd:*;
sudo ln -s ~/.composer/vendor/bin/phpmd /usr/bin/phpmd;

# increase inotify watches limit
sudo sh -c 'echo "fs.inotify.max_user_watches = 524288" >> "/etc/sysctl.conf"';
sudo sysctl -p;

# mercurial config
printf "Provide some info for mercurial ui.\n";
read -p "Enter your name and surname: " name surname;
read -p "Enter your email: " email;

echo "[ui]
username = $name $surname <$email>

[extensions]
color=
progress=
purge=
hgext.ftp=/home/$USER/www/scripts/ftp.py
" > ~/.hgrc;
