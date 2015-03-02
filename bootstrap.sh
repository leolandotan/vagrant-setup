# Variables
USERNAME=root
PASSWORD=password

# Set MySQL root username and password
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password $PASSWORD"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password $PASSWORD"

# Set phpMyAdmin passwords
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"

echo -e "\n--- Updating packages list ---\n"
apt-get -y update

echo -e "\n--- Install debconf-utils for debconf-set-selections command ---\n"
apt-get install debconf-utils

echo -e "\n--- Install LAMP Server ---\n"
apt-get -y install lamp-server^

echo -e "\n--- Install phpMyAdmin ---\n"
apt-get -y install phpmyadmin

# Silence apache
echo "ServerName localhost" >> /etc/apache2/apache2.conf

echo -e "\n--- Enabling mod-rewrite ---\n"
# " > /dev/null 2>&1" is used to silence the output
a2enmod rewrite

echo -e "\n--- Restarting Apache ---\n"
service apache2 restart

echo -e "\n--- Setting document root to public directory ---\n"
rm -rf /var/www
ln -fs /vagrant/public /var/www
