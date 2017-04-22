Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty64'
  config.vm.hostname = 'mysql.loc'
  config.vm.network 'private_network', ip: '192.168.33.10'

  config.vm.provider :virtualbox do |vb|
    vb.name   = 'vMySQL'
    vb.cpus   = 2
    vb.memory = 1024
    vb.customize ['modifyvm', :id, '--ioapic', 'on']
  end

  config.vm.provision :puppet do |puppet|
    puppet.options        = '--verbose --summarize --debug'
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path    = 'puppet/modules'
  end
end
