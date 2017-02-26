machines = [
  { hostname: 'vMySQL', ip: '192.168.33.10', memory: '1024', box: 'ubuntu/trusty64' }
]

Vagrant.configure('2') do |config|
  machines.each do |machine|
    config.vm.define machine[:hostname] do |machine_config|
      machine_config.vm.box      = machine[:box]
      machine_config.vm.hostname = machine[:hostname]
      machine_config.vm.network 'private_network', ip: machine[:ip]

      machine_config.vm.provider 'virtualbox' do |vb|
        vb.customize ['modifyvm', :id, '--name', machine[:hostname], '--memory', machine[:memory]]
      end

      machine_config.vm.provision :puppet do |puppet|
        puppet.options        = '--verbose --summarize --debug'
        puppet.manifests_path = 'puppet/manifests'
        puppet.module_path    = 'puppet/modules'
      end
    end
  end
end
