name             'uptime'
maintainer       'Jeremy Olliver'
maintainer_email 'jeremy.olliver@gmail.com'
license          'apachev2'
description      'Installs/Configures fzaninotto/uptime'
long_description 'Installs/Configures fzaninotto/uptime'
version          '0.1.0'

depends 'git'
depends 'nodejs' # https://github.com/redguide/nodejs/
depends 'mongodb'

supports 'ubuntu' # So far, only an upstart service script is provided

provides 'uptime::default'
provides 'service[uptime]'
provides 'service[mongod]'
