#
# Cookbook Name:: application
# Recipe:: database
#
# Copyright (C) 2014 Jeremy Olliver
#
# All rights reserved - Do Not Redistribute
#

# node.override['mongodb']['config']['rest'] = true

include_recipe 'mongodb::mongodb_org_repo' # to ensure we get a recent enough version
include_recipe 'mongodb::default' # provides service[mongod]


if Chef::Config[:solo]
  if node['app_uptime']['mongo']['password'] && node['app_uptime']['mongo']['password'] != ''
    Chef::Log.info('Using set mongodb password for uptime db auth')
  else
    fail "You must set a mongodb password in the attribute ['app_uptime']['mongo']['password'] when running in chef solo mode"
  end
else
  include_recipe 'openssl' # random password generation

  ::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
  node.set_unless['app_uptime']['mongo']['password'] = secure_password
end

mongo_user = node['app_uptime']['mongo']['user']
mongo_password = node['app_uptime']['mongo']['password']

execute 'create-mongodb-uptime-user' do
  # TODO: second param is the db_name
  command "/usr/bin/mongo uptime --eval 'db.createUser({user: \"#{mongo_user}\", pwd: \"#{mongo_password}\", roles: [{ role: \"readWrite\", db: \"uptime\" }]})'"
  action  :run
  not_if  "/usr/bin/mongo uptime --eval 'db.auth(\"#{mongo_user}\",\"#{mongo_password}\")' | grep -q ^1$"
end
