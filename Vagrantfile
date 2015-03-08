# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise32"
  config.vm.network "private_network", ip: "192.168.55.55"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080, protocol: "tcp", auto_correct: true
  config.vm.network "forwarded_port", guest: 35729, host: 35729, protocol: "tcp", auto_correct: true

  config.vm.synced_folder "public", "/var/www" #, id: "vagrant-root", :nfs => true
  #config.nfs.map_uid = Process.uid
  #config.nfs.map_gid = Process.gid

  # ===================================== 
  # My provisioning
  # ===================================== 

  # setup basic lamp stack and configurations
  config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.provision "shell", path: "install-composer.sh"

  # use non priviliged user to avoid command urls to user /root/...
  config.vm.provision "shell", path: "install-drush.sh", privileged: false

  # http://rvm.io/integration/vagrant - edited to install for "vagrant" user only
  config.vm.provision :shell, path: 'install-rvm.sh',  args: 'stable', privileged: false # changed
  config.vm.provision :shell, path: 'install-ruby.sh', args: '1.9.3',  privileged: false # changed

  # TODO
  # 1. sudo vim /etc/apache2/sites-available/default 
  #   This is to make clean urls work (https://www.drupal.org/node/134439)
  #   1.1. Inside <Directory /var/www> change AllowOverride None to AllowOverride All
  #
  # 2. VirtualHost
  #    <VirtualHost *:80>
  #      ServerAdmin webmaster@drupal.loc
  #      ServerName drupal.loc
  #      ServerAlias www.drupal.loc
  #
  #      DocumentRoot /var/www/drupal
  #      <Directory /var/www/drupal>
  #              Options Indexes FollowSymLinks MultiViews
  #              AllowOverride All
  #              Order allow,deny
  #              allow from all
  #      </Directory>
  #    </VirtualHost>
  # 3. Make livereload work
  #   3.1. http://www.ravisagar.in/blog/how-get-livereload-working-vagrant-and-auto-compile-scss-files-shared-folder
  #   3.2. http://www.ravisagar.in/blog/how-speed-drupal-running-vagrant-windows-host
  #   3.3. Run using bundle exec guard -p -l 10
end
