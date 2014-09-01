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
sudo apt-get -y install build-essential linux-headers-`uname -r`;
sudo apt-get -y install vagrant virtualbox virtualbox-dkms;

# filezilla
sudo apt-get -y install filezilla;

# sun Java
sudo apt-get -y purge openjdk*;
sudo apt-get -y install software-properties-common;
sudo add-apt-repository -y ppa:webupd8team/java;
sudo apt-get update;
sudo apt-get -y install oracle-java8-installer;

# version control
sudo apt-get -y install git mercurial;

# meld
sudo apt-get -y install meld;

# pear
sudo apt-get -y install php-pear;

# phpmd
sudo pear config-set auto_discover 1;
sudo pear channel-discover pear.phpmd.org;
sudo pear install phpmd/PHP_PMD;

# phpcs
sudo pear install PHP_CodeSniffer;

# skype
sudo apt-get install -y skype;

# composer
curl -sS https://getcomposer.org/installer | php;
sudo mv composer.phar /usr/bin/composer;
