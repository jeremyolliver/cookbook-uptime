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

include_recipe 'openssl' # random password generation

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['app_uptime']['mongo']['password'] = secure_password

mongo_user = node['app_uptime']['mongo']['user']
mongo_password = node['app_uptime']['mongo']['password']
# mongo_password = if (password_set = node['app_uptime']['mongo']['password'])
#   password_set
# else
#   generated_password = 4 # TODO
#   node.set['app_uptime']['mongo']['password'] = generated_password
#   generated_password
# end

execute 'create-mongodb-uptime-user' do
  # TODO: second param is the db_name
  command "/usr/bin/mongo uptime --eval 'db.createUser({user: \"#{mongo_user}\", pwd: \"#{mongo_password}\", roles: [{ role: \"readWrite\", db: \"uptime\" }]})'"
  action  :run
  not_if  "/usr/bin/mongo uptime --eval 'db.auth(\"#{mongo_user}\",\"#{mongo_password}\")' | grep -q ^1$"
end
