Vagrant::Config.run do |config|
  config.vm.box = "lucid64"
  config.vm.box_url = 'http://files.vagrantup.com/lucid64.box'

  # Forward Kibana web interface
  config.vm.forward_port 5601, 5601

  # Forward logstash server
  config.vm.forward_port 5959, 5959

  # Forward elasticsearch-head
  config.vm.forward_port 9200, 9200

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    # chef.add_recipe "elasticsearch"
    chef.add_recipe "apt"
    chef.add_recipe "logstash::server"
    chef.add_recipe "kibana"

    # Specify chef attributes
    chef.json.merge!({
      # :elasticsearch => {
      #   :cluster_name => "logstash_vagrant"
      # },
      logstash: {
        server: {
          xms: '128M',
          xmx: '128M',
          install_rabbitmq: false,
          inputs: [{
            file: {
              type: "sample-logs",
              path: ["/var/log/*.log"],
              exclude: ["*.gz"],
              debug: true
            }
          }, {
            tcp: {
              type: "tcp-input",
              port: "5959",
              format: "json_event"
            }
          }]
        }
      }
    })
  end

  config.vm.customize ["modifyvm", :id, "--memory", 512]
end
