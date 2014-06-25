# uptime cookbook

[![Build Status](https://travis-ci.org/jeremyolliver/cookbook-uptime.svg?branch=master)](https://travis-ci.org/jeremyolliver/cookbook-uptime) Linting test status

This cookbook installs and runs the [uptime](https://github.com/fzaninotto/uptime) http service monitoring application and runs it as a non-privileged user.

## Supported Platforms

ubuntu - see TODO for notes on running with other platforms

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['app_uptime']['repo']['url']</tt></td>
    <td>String</td>
    <td>Git URL for cloning the application source from</td>
    <td><tt>"https://github.com/fzaninotto/uptime.git"</tt></td>
  </tr>
  <tr>
    <td><tt>['app_uptime']['repo']['ref']</tt></td>
    <td>String</td>
    <td>Git Ref (branch/tag/commit sha) to be checked out</td>
    <td><tt>"d9cc96cc835b65577e9bc8c94625eb2706a1b923"</tt></td>
  </tr>
  <tr>
    <td><tt>['app_uptime']['url']</tt></td>
    <td>String</td>
    <td>URL (with optional port) to bind to - should be 1024 or higher as runs unprivileged</td>
    <td><tt>"http://#{node['fqdn']}:3000"</tt></td>
  </tr>
  <tr>
    <td><tt>['app_uptime']['plugins']</tt></td>
    <td>Array</td>
    <td>An array of bundled plugin names to load</td>
    <td><tt>['console', 'patternMatcher', 'httpOptions', 'email']</tt></td>
  </tr>
  <tr>
    <td><tt>['app_uptime']['monitor']</tt></td>
    <td>Hash</td>
    <td>Keys for any option under the 'monitor' section of config.yml may be set</td>
    <td><tt>{"pollingInterval": 10000, "timeout": 5000}</tt></td>
  </tr>
  <tr>
    <td><tt>['app_uptime']['analyzer']</tt></td>
    <td>Hash</td>
    <td>Keys for any option under the 'analyzer' section of config.yml may be set</td>
    <td><tt>{"updateInterval": 60000, "qosAggregationInterval": 600000, "pingHistory": 8035200000}</tt></td>
  </tr>
  <tr>
    <td><tt>['app_uptime']['mongo']['user']</tt></td>
    <td>String</td>
    <td>MongoDB username</td>
    <td><tt>"uptime"</tt></td>
  </tr>
  <tr>
    <td><tt>['app_uptime']['mongo']['password']</tt></td>
    <td>String</td>
    <td>MongoDB password</td>
    <td><tt>A secure randomly generated value by openssl</tt></td>
  </tr>
</table>

## Usage

### uptime::default

Include `uptime::default` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[uptime::default]"
  ]
}
```

## TODO

* Support service configurations for running the uptime process on other platforms
* Add an optional nginx proxy recipe

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

License: Apachev2

Author:: Jeremy Olliver (<jeremy.olliver@gmail.com>)
