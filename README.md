# uptime cookbook

[![Build Status](https://travis-ci.org/jeremyolliver/cookbook-uptime.svg?branch=master)](https://travis-ci.org/jeremyolliver/cookbook-uptime) Linting test status

This cookbook installs and runs the [uptime](https://github.com/fzaninotto/uptime) http service monitoring application and runs it as a non-privileged user.

## Supported Platforms

So far Ubuntu 12.04, and 14.04 are is the only fully supported platform - due to use of an Upstart service script. If you are using another platform, using the `upstart::install` and `upstart::database` recipes and your own service provider should work for you.

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
    <td><tt>"http://#{node['fqdn']}:8082"</tt></td>
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

If you are using chef-solo, then you will need to manually set a password for the mongodb instance `['app_uptime']['mongo']['password'] = 'pleasepickyourownpassword'`. chef-client when used with a server (either open source or enterprise) - will automatically generate and store a password in the same attribute.

It is also recommended to put a web server such as apache or nginx in front of this as a proxy, as this application is intentionally run as a non-privileged user, which means it cannot be run on port 80 or 443 directly.

## TODO

* Support service configurations for running the uptime process on other platforms
* Add an optional nginx proxy recipe

## Testing

This cookbook is tested on ubuntu 12.04 and 14.04
This cookbook has a test kitchen setup to converge the recipes on those platforms locally.

To run those tests:

Setup:

* Install the ruby development dependencies: `gem install bundler && bundle install`
* Install [vagrant](https://www.vagrantup.com/)
* Install [VirtualBox](https://www.virtualbox.org/)
* `vagrant plugin install vagrant-omnibus`
* `vagrant plugin install vagrant-berkshelf`

Run:

    # Code linting (also run on CI)
    rake style
    # Integration tests (Not currently run on CI)
    kitchen verify all

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
