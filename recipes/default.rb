#
# Cookbook Name:: application
# Recipe:: default
#
# Copyright (C) 2014 Jeremy Olliver
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'
include_recipe 'nodejs'
include_recipe 'mongodb::mongodb_org_repo' # to ensure we get a recent enough version
include_recipe 'mongodb::default'

group 'uptime'

user 'uptime' do
  gid 'uptime'
  shell '/bin/bash'
  supports manage_home: true
  home '/opt/uptime'
end

app_root = '/opt/uptime/src'

git app_root do
  repository node['app_uptime']['repo']['url']
  revision   node['app_uptime']['repo']['ref']
  action     :sync
  user       'uptime'
  group      'uptime'
  # notifies   :run, 'bash[uptime-npm-install]'
  notifies   :restart, 'service[uptime]'
end

bash 'uptime-npm-install' do
  cwd   app_root
  user  'uptime'
  group 'uptime'
  code  "cd #{app_root} && /usr/bin/npm install"
  action :nothing
end

template "#{app_root}/config/production.yml" do
  source   'config.yml.erb'
  cookbook 'uptime'
  owner    'uptime'
  group    'uptime'
  mode     '0644'
  variables({
    url:              node['app_uptime']['url'],
    plugins:          node['app_uptime']['plugins'],
    external_plugins: node['app_uptime']['external_plugins'],
    monitor_config:   node['app_uptime']['monitor'],
    analyzer_config:  node['app_uptime']['analyzer']
  })
  notifies :restart, 'service[uptime]'
end


package 'build-essential' do
  action :nothing
end.run_action(:install)
chef_gem 'pleaserun'

bash 'generate-service-script' do
  code "#{Gem.default_bindir}/pleaserun --user uptime --description 'Uptime monitor https://github.com/fzaninotto/uptime' --group uptime --name uptime --verbose --chdir #{app_root} --install 'node app'"
  not_if { ::File.exist?('/etc/init/uptime.conf') }
end

service 'uptime' do
  provider Chef::Provider::Service::Upstart
  action [:start, :enable]
end
