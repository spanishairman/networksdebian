# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "Debian12-inetRouter" do |inetrouter|
  inetrouter.vm.box = "/home/max/vagrant/images/debian12"
  inetrouter.vm.network :private_network,
      # :type => 'dhcp',
      # :libvirt__network_address => '192.168.4.0',
       :type => 'ip',
       :ip => '192.168.1.1',
       :libvirt__netmask => '255.255.255.252',
       :libvirt__network_name => 'vagrant-libvirt-inet1',
       :libvirt__always_destroy => 'false'
      # :libvirt__mac => '52:54:00:33:c6:0b'
  inetrouter.vm.provider "libvirt" do |lvirt|
      lvirt.memory = "1024"
      lvirt.cpus = "1"
      lvirt.title = "Debian12-inetRouter"
      lvirt.description = "Виртуальная машина на базе дистрибутива Debian Linux. inetRouter"
      lvirt.management_network_name = "vagrant-libvirt-mgmt"
      lvirt.management_network_address = "192.168.121.0/24"
      lvirt.management_network_keep = "true"
      lvirt.management_network_mac = "52:54:00:27:28:83"
   #  lv.storage :file, :size => '1G', :device => 'vdb', :allow_existing => false
  end
  inetrouter.vm.provision "shell", inline: <<-SHELL
      brd='*************************************************************'
      echo "$brd"
      echo 'Set Hostname'
      hostnamectl set-hostname inetrouter
      echo "$brd"
      sed -i 's/debian12/inetrouter/' /etc/hosts
      sed -i 's/debian12/inetrouter/' /etc/hosts
      echo "$brd"
      echo 'Изменим ttl для работы через раздающий телефон'
      echo "$brd"
      sysctl -w net.ipv4.ip_default_ttl=66
      echo "$brd"
      echo 'Если ранее не были установлены, то установим необходимые  пакеты'
      echo "$brd"
      apt update
      export DEBIAN_FRONTEND=noninteractive
      apt install -y iptables
      iptables -t nat -A POSTROUTING ! -d 192.168.0.0/16 -o ens5 -j MASQUERADE
      echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
      sysctl -p
      SHELL
  end

  config.vm.define "Debian12-centralRouter" do |centralrouter|
  centralrouter.vm.box = "/home/max/vagrant/images/debian12"
  centralrouter.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.2.1',
       :libvirt__netmask => '255.255.255.224',
       :libvirt__network_name => 'vagrant-libvirt-central1',
       :libvirt__always_destroy => 'false'
  centralrouter.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.2.33',
       :libvirt__netmask => '255.255.255.224',
       :libvirt__network_name => 'vagrant-libvirt-central2',
       :libvirt__always_destroy => 'false'
  centralrouter.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.2.65',
       :libvirt__netmask => '255.255.255.192',
       :libvirt__network_name => 'vagrant-libvirt-central3',
       :libvirt__always_destroy => 'false'
  centralrouter.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.1.2',
       :libvirt__netmask => '255.255.255.252',
       :libvirt__network_name => 'vagrant-libvirt-inet1',
       :libvirt__always_destroy => 'false'
  centralrouter.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.1.5',
       :libvirt__netmask => '255.255.255.252',
       :libvirt__network_name => 'vagrant-libvirt-inet2',
       :libvirt__always_destroy => 'false'  
  centralrouter.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.1.9',
       :libvirt__netmask => '255.255.255.252',
       :libvirt__network_name => 'vagrant-libvirt-inet3',
       :libvirt__always_destroy => 'false'  
  centralrouter.vm.provider "libvirt" do |lvirt|
      lvirt.memory = "1024"
      lvirt.cpus = "1"
      lvirt.title = "Debian12-centralRouter"
      lvirt.description = "Виртуальная машина на базе дистрибутива Debian Linux. centralRouter"
      lvirt.management_network_name = "vagrant-libvirt-mgmt"
      lvirt.management_network_address = "192.168.121.0/24"
      lvirt.management_network_keep = "true"
      lvirt.management_network_mac = "52:54:00:27:28:84"
  #   lv.storage :file, :size => '1G', :device => 'vdb', :allow_existing => false
  end
  centralrouter.vm.provision "shell", inline: <<-SHELL
      brd='*************************************************************'
      echo "$brd"
      echo 'Set Hostname'
      hostnamectl set-hostname centralrouter
      echo "$brd"
      sed -i 's/debian12/centralrouter/' /etc/hosts
      sed -i 's/debian12/centralrouter/' /etc/hosts
      echo "$brd"
      echo 'Изменим ttl для работы через раздающий телефон'
      echo "$brd"
      sysctl -w net.ipv4.ip_default_ttl=66
      echo "$brd"
      echo 'Если ранее не были установлены, то установим необходимые  пакеты'
      echo "$brd"
      apt update
      export DEBIAN_FRONTEND=noninteractive
      apt install -y iptables
      ip route del 0.0.0.0/0
      ip route add 0.0.0.0/0 via 192.168.1.1
      echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
      sysctl -p
      SHELL
  end
  config.vm.define "Debian12-centralServer" do |centralserver|
  centralserver.vm.box = "/home/max/vagrant/images/debian12"
  centralserver.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.0.2',
       :libvirt__netmask => '255.255.255.224',
       :libvirt__network_name => 'vagrant-libvirt-main1',
       :libvirt__always_destroy => 'false'
  centralserver.vm.provider "libvirt" do |lvirt|
      lvirt.memory = "1024"
      lvirt.cpus = "1"
      lvirt.title = "Debian12-centralServer"
      lvirt.description = "Виртуальная машина на базе дистрибутива Debian Linux. centralServer"
      lvirt.management_network_name = "vagrant-libvirt-mgmt"
      lvirt.management_network_address = "192.168.121.0/24"
      lvirt.management_network_keep = "true"
      lvirt.management_network_mac = "52:54:00:27:28:89"
  #   lv.storage :file, :size => '1G', :device => 'vdb', :allow_existing => false
  end
  centralserver.vm.provision "shell", inline: <<-SHELL
      brd='*************************************************************'
      echo "$brd"
      echo 'Set Hostname'
      hostnamectl set-hostname centralserver
      echo "$brd"
      sed -i 's/debian12/centralserver/' /etc/hosts
      sed -i 's/debian12/centralserver/' /etc/hosts
      echo "$brd"
      echo 'Изменим ttl для работы через раздающий телефон'
      echo "$brd"
      sysctl -w net.ipv4.ip_default_ttl=66
      echo "$brd"
      echo 'Если ранее не были установлены, то установим необходимые  пакеты'
      echo "$brd"
      apt update
      export DEBIAN_FRONTEND=noninteractive
      ip route del 0.0.0.0/0
      ip route add 0.0.0.0/0 via 192.168.0.1
      SHELL
  end
  config.vm.define "Debian12-office1Router" do |office1router|
  office1router.vm.box = "/home/max/vagrant/images/debian12"
  office1router.vm.network :private_network,
       :type => 'ip',   
       :ip => '192.168.2.6',
       :libvirt__netmask => '255.255.255.252',
       :libvirt__network_name => 'vagrant-libvirt-central1',
       :libvirt__always_destroy => 'false'  
  office1router.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.3.1',
       :libvirt__netmask => '255.255.255.192',
       :libvirt__network_name => 'vagrant-libvirt-office1-1',
       :libvirt__always_destroy => 'false'
  office1router.vm.network :private_network,
       :type => 'ip', 
       :ip => '192.168.3.65',
       :libvirt__netmask => '255.255.255.192',
       :libvirt__network_name => 'vagrant-libvirt-office1-2',
       :libvirt__always_destroy => 'false'
  office1router.vm.network :private_network,
       :type => 'ip', 
       :ip => '192.168.3.129',
       :libvirt__netmask => '255.255.255.192',
       :libvirt__network_name => 'vagrant-libvirt-office1-3',
       :libvirt__always_destroy => 'false'
  office1router.vm.network :private_network,
       :type => 'ip', 
       :ip => '192.168.3.193',
       :libvirt__netmask => '255.255.255.192',
       :libvirt__network_name => 'vagrant-libvirt-office1-4',
       :libvirt__always_destroy => 'false'
  office1router.vm.provider "libvirt" do |lvirt|
      lvirt.memory = "1024"
      lvirt.cpus = "1"  
      lvirt.title = "Debian12-office1Router"
      lvirt.description = "Виртуальная машина на базе дистрибутива Debian Linux. office1Router"
      lvirt.management_network_name = "vagrant-libvirt-mgmt"
      lvirt.management_network_address = "192.168.121.0/24"
      lvirt.management_network_keep = "true"
      lvirt.management_network_mac = "52:54:00:27:28:85"
  #   lv.storage :file, :size => '1G', :device => 'vdb', :allow_existing => false
  end
  office1router.vm.provision "shell", inline: <<-SHELL
      brd='*************************************************************'
      echo "$brd"
      echo 'Set Hostname'
      hostnamectl set-hostname office1router
      echo "$brd"
      sed -i 's/debian12/office1router/' /etc/hosts
      sed -i 's/debian12/office1router/' /etc/hosts
      echo "$brd"
      echo 'Изменим ttl для работы через раздающий телефон'
      echo "$brd"
      sysctl -w net.ipv4.ip_default_ttl=66
      echo "$brd"
      echo 'Если ранее не были установлены, то установим необходимые  пакеты'
      echo "$brd"
      apt update
      export DEBIAN_FRONTEND=noninteractive
      echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
      sysctl -p
      ip route del 0.0.0.0/0
      ip route add 0.0.0.0/0 via 192.168.2.5
      SHELL
  end
  config.vm.define "Debian12-office2Router" do |office2router|
  office2router.vm.box = "/home/max/vagrant/images/debian12"
  office2router.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.2.10',
       :libvirt__netmask => '255.255.255.252',
       :libvirt__network_name => 'vagrant-libvirt-central2',
       :libvirt__always_destroy => 'false'
  office2router.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.4.1',
       :libvirt__netmask => '255.255.255.128',
       :libvirt__network_name => 'vagrant-libvirt-office2-1',
       :libvirt__always_destroy => 'false'
  office2router.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.4.129',
       :libvirt__netmask => '255.255.255.192',
       :libvirt__network_name => 'vagrant-libvirt-office2-2',
       :libvirt__always_destroy => 'false'
  office2router.vm.network :private_network,
       :type => 'ip',
       :ip => '192.168.4.193',
       :libvirt__netmask => '255.255.255.192',
       :libvirt__network_name => 'vagrant-libvirt-office2-3',
       :libvirt__always_destroy => 'false'
  office2router.vm.provider "libvirt" do |lvirt|
      lvirt.memory = "1024"
      lvirt.cpus = "1"
      lvirt.title = "Debian12-office2Router"
      lvirt.description = "Виртуальная машина на базе дистрибутива Debian Linux. office2Router"
      lvirt.management_network_name = "vagrant-libvirt-mgmt"
      lvirt.management_network_address = "192.168.121.0/24"
      lvirt.management_network_keep = "true"
      lvirt.management_network_mac = "52:54:00:27:28:86"
  #   lv.storage :file, :size => '1G', :device => 'vdb', :allow_existing => false
  end
  office2router.vm.provision "shell", inline: <<-SHELL
      brd='*************************************************************'
      echo "$brd"
      echo 'Set Hostname'
      hostnamectl set-hostname office2router
      echo "$brd"
      sed -i 's/debian12/office2router/' /etc/hosts
      sed -i 's/debian12/office2router/' /etc/hosts
      echo "$brd"
      echo 'Изменим ttl для работы через раздающий телефон'
      echo "$brd"
      sysctl -w net.ipv4.ip_default_ttl=66
      echo "$brd"
      echo 'Если ранее не были установлены, то установим необходимые  пакеты'
      echo "$brd"
      apt update
      export DEBIAN_FRONTEND=noninteractive
      echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
      sysctl -p
      ip route del 0.0.0.0/0
      ip route add 0.0.0.0/0 via 192.168.2.9
      SHELL
  end
  config.vm.define "Debian12-office1Server" do |office1server|
  office1server.vm.box = "/home/max/vagrant/images/debian12"
  office1server.vm.network :private_network,
      # :type => 'dhcp',
      # :libvirt__network_address => '192.168.1.0',
       :type => 'ip',
       :ip => '192.168.3.130',
       :libvirt__netmask => '255.255.255.192',
       :libvirt__network_name => 'vagrant-libvirt-office1-3',
       :libvirt__always_destroy => 'false'
      # :libvirt__mac => '52:54:00:33:c6:0b'
  office1server.vm.provider "libvirt" do |lvirt|
      lvirt.memory = "1024"
      lvirt.cpus = "1"  
      lvirt.title = "Debian12-office1Server"
      lvirt.description = "Виртуальная машина на базе дистрибутива Debian Linux. office1Server"
      lvirt.management_network_name = "vagrant-libvirt-mgmt"
      lvirt.management_network_address = "192.168.121.0/24"
      lvirt.management_network_keep = "true"
      lvirt.management_network_mac = "52:54:00:27:28:87"
  #   lv.storage :file, :size => '1G', :device => 'vdb', :allow_existing => false
  end
  office1server.vm.provision "shell", inline: <<-SHELL
      brd='*************************************************************'
      echo "$brd"
      echo 'Set Hostname'
      hostnamectl set-hostname office1server
      echo "$brd"
      sed -i 's/debian12/office1server/' /etc/hosts
      sed -i 's/debian12/office1server/' /etc/hosts
      echo "$brd"
      echo 'Изменим ttl для работы через раздающий телефон'
      echo "$brd"
      sysctl -w net.ipv4.ip_default_ttl=66
      echo "$brd"
      echo 'Если ранее не были установлены, то установим необходимые  пакеты'
      echo "$brd"
      apt update
      export DEBIAN_FRONTEND=noninteractive
      ip route del 0.0.0.0/0
      ip route add 0.0.0.0/0 via 192.168.3.129
      SHELL
  end
  config.vm.define "Debian12-office2Server" do |office2server|
  office2server.vm.box = "/home/max/vagrant/images/debian12"
  office2server.vm.network :private_network,
      # :type => 'dhcp',
      # :libvirt__network_address => '192.168.1.0',
       :type => 'ip',
       :ip => '192.168.4.2',
       :libvirt__netmask => '255.255.255.128',
       :libvirt__network_name => 'vagrant-libvirt-office2-1',
       :libvirt__always_destroy => 'false'
      # :libvirt__mac => '52:54:00:33:c6:0b'
  office2server.vm.provider "libvirt" do |lvirt|
      lvirt.memory = "1024"
      lvirt.cpus = "1"
      lvirt.title = "Debian12-office2Server"
      lvirt.description = "Виртуальная машина на базе дистрибутива Debian Linux. office2Server"
      lvirt.management_network_name = "vagrant-libvirt-mgmt"
      lvirt.management_network_address = "192.168.121.0/24" 
      lvirt.management_network_keep = "true"
      lvirt.management_network_mac = "52:54:00:27:28:88"
  #   lv.storage :file, :size => '1G', :device => 'vdb', :allow_existing => false
  end
  office2server.vm.provision "shell", inline: <<-SHELL
      brd='*************************************************************'
      echo "$brd"
      echo 'Set Hostname'
      hostnamectl set-hostname office2server
      echo "$brd"
      sed -i 's/debian12/office2server/' /etc/hosts
      sed -i 's/debian12/office2server/' /etc/hosts
      echo "$brd"
      echo 'Изменим ttl для работы через раздающий телефон'
      echo "$brd"
      sysctl -w net.ipv4.ip_default_ttl=66
      echo "$brd"
      echo 'Если ранее не были установлены, то установим необходимые  пакеты'
      echo "$brd"
      apt update
      export DEBIAN_FRONTEND=noninteractive
      ip route del 0.0.0.0/0
      ip route add 0.0.0.0/0 via 192.168.4.1
      SHELL
  end
end
