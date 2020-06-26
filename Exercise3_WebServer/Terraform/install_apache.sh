#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo ifconfig | grep "inet" | grep -v inet6 | grep -v 127.0.0.1 | awk '{print $2}' >> ifconfig
sudo rm /var/www/html/index.html
sudo echo "<img src=http://s3-cloudcourse-website.s3.amazonaws.com/Web.png>" >>  /var/www/html/index.html
sudo echo "<p> The IP Address of this Server is <iframe width="120" height="40" src="ifconfig"></iframe></p>" >>  /var/www/html/index.html




