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
include_recipe 'mongodb'

user 'uptime' do
  gid 'uptime'
  supports manage_home: true
  home '/opt/uptime'
end

app_root = '/opt/uptime/src'

git app_root do
  repository node['app_uptime']['repo']['url']
  revision   node['app_uptime']['repo']['ref']
  action     :sync
  user       'uptime'
  notifies   :run, 'execute[uptime-install]'
end

execute 'uptime-install' do
  cwd     app_root
  user    'uptime'
  command 'npm install'
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
end
