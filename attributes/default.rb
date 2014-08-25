## WARNING: node['uptime'] attribute is reserved for ohai system information

default['app_uptime']['repo']['url'] = 'https://github.com/fzaninotto/uptime.git'
default['app_uptime']['repo']['ref'] = 'd9cc96cc835b65577e9bc8c94625eb2706a1b923' # Ideally a tag e.g. v3.1 (if it actually worked)

default['app_uptime']['url']              = "http://localhost:8082" # You should override this
default['app_uptime']['plugins']          = ['console', 'patternMatcher', 'httpOptions', 'email']
default['app_uptime']['external_plugins'] = []
default['app_uptime']['config']           = {}

default['app_uptime']['monitor']['pollingInterval']         = 10000
default['app_uptime']['monitor']['timeout']                 = 5000

default['app_uptime']['analyzer']['updateInterval']         = 60000        # one minute
default['app_uptime']['analyzer']['qosAggregationInterval'] = 600000       # ten minutes
default['app_uptime']['analyzer']['pingHistory']            = 8035200000   # three months

default['app_uptime']['mongo']['user'] = 'uptime'
default['app_uptime']['mongo']['password'] = 'thisisnotthepassword'
