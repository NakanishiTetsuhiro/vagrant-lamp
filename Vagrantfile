# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-6.8"

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.33.11"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 4096, "--cpus", 2, "--ioapic", "on"]
  end

  config.vm.provision :file, source: "vagrant/apache/httpd.conf", destination: "httpd.conf"
  config.vm.provision :file, source: "vagrant/mysql/my.cnf", destination: "my.cnf"
  config.vm.provision :shell, path: "vagrant/bootstrap.sh"

  # ここにプロジェクトのドキュメントルートのパスを設定してください
  # ex.) config.vm.synced_folder "../my_project", "/vagrant/www", mount_options: ['dmode=777', 'fmode=777']
  config.vm.synced_folder "../blog", "/var/www/html", mount_options: ['dmode=777', 'fmode=777']
end
