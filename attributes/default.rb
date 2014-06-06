default['uptime']['repo']['url'] = 'git@github.com:fzaninotto/uptime.git'
default['uptime']['repo']['ref'] = 'v3.1'

default['uptime']['url'] = 'http://localhost:8082' # You should override this
default['uptime']['plugins'] = ['console', 'patternMatcher', 'httpOptions', 'email']
default['uptime']['external_plugins'] = []

default['uptime']['monitor']['pollingInterval']         = 10000
default['uptime']['monitor']['timeout']                 = 5000

default['uptime']['analyzer']['updateInterval']         = 60000        # one minute
default['uptime']['analyzer']['qosAggregationInterval'] = 600000       # ten minutes
default['uptime']['analyzer']['pingHistory']            = 8035200000   # three months
