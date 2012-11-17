#
# Cookbook Name:: kibana
# Recipe:: default
#

include_recipe "runit" unless node["platform_version"] == "12.04"

case node['platform']
when "debian", "ubuntu"
  include_recipe 'apt'
  packages = %w{libcurl4-openssl-dev}
    packages.each do |pkg|
    package pkg do
      action :install
    end
  end
when "redhat", "centos", "amazon", "fedora", "scientific"
  include_recipe 'yum'
  include_recipe "yum::epel"
  packages = %w{curl-devel}
    packages.each do |pkg|
    package pkg do
      action :install
    end
  end
end

group node['kibana']['group'] do
  system true
end

user node['kibana']['user'] do
  home node['kibana']['home']
  gid node['kibana']['group']
  comment "Service user for Kibana web interface"
  supports :manage_home => true
  shell "/bin/bash"
end

unless FileTest.exists?("#{node['kibana']['home']}/kibana-#{node['kibana']['version']}")
  remote_file "#{Chef::Config[:file_cache_path]}/#{node['kibana']['file']}" do
    source node['kibana']['download_url']
    checksum node['kibana']['checksum']
    action :create_if_missing
  end

  bash "Installing Kibana sources #{node['kibana']['file']}" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      tar -zxf #{node['kibana']['file']} -C #{node['kibana']['home']}
    EOH
  end

  link "#{node['kibana']['home']}/current" do
    to "#{node['kibana']['home']}/Kibana-#{node['kibana']['version']}"
    notifies :restart, "service[kibana]"
  end
end

template "Create Kibana config" do
  path "#{node['kibana']['home']}/current/KibanaConfig.rb"
  source "KibanaConfig.rb.erb"
  owner node['kibana']['user']
  group node['kibana']['group']
  mode 0644
  notifies :restart, "service[kibana]"
end

node['rvm']['user_installs'] = [
  { 'user' => node['kibana']['user'] }
]

include_recipe "rvm::user_install"

rvm_ruby node['kibana']['ruby_version'] do
  user node['kibana']['user']
end

rvm_gem "bundler" do
  user node['kibana']['user']
end

execute "kibana owner-change" do
    command "chown -Rf #{node['kibana']['user']}:#{node['kibana']['group']} #{node['kibana']['home']}"
end

rvm_shell "Run bundler install" do
  user node['kibana']['user']
  group node['kibana']['group']
  cwd "#{node['kibana']['home']}/current"
  code %{bundle install}
end

if platform?  "debian", "ubuntu"
  if node["platform_version"] == "12.04"
    template "/etc/init/kibana.conf" do
      mode "0644"
      source "kibana.conf.erb"
    end

    service "kibana" do
      provider Chef::Provider::Service::Upstart
      action [ :enable, :start ]
    end
  else
    runit_service "kibana"
  end
elsif platform? "redhat", "centos", "amazon", "fedora", "scientific"
  template "/etc/init.d/kibana" do
    source "init.erb"
    owner "root"
    group "root"
    mode "0774"
    variables(:basedir => "#{node['logstash']['home']}/current")
  end

  service "logstash_server" do
    supports :restart => true, :reload => true, :status => true
    action :enable
  end
end
