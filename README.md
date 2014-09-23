[![Build Status](https://travis-ci.org/psyreactor/jenkins_kitchen-cookbook.svg?branch=master)](https://travis-ci.org/psyreactor/jenkins_kitchen-cookbook)
jenkins_kitchen Cookbook
===============

This cookbook install jenkins and test-kitchen for chef CI.

####[test-kitchen](https://http://kitchen.ci//)
Test Kitchen is a test harness tool to execute your configured code on one or more platforms in isolation. A driver plugin architecture is used which lets you run your code on various cloud providers and virtualization technologies such as Amazon EC2, Blue Box, CloudStack, Digital Ocean, Rackspace, OpenStack, Vagrant, Docker, LXC containers, and more. Many testing frameworks are already supported out of the box including Bats, shUnit2, RSpec, Serverspec.

Requirements
------------
#### Cookbooks:

- apt - https://github.com/opscode-cookbooks/apt
- yum-epel - https://github.com/opscode-cookbooks/yum-epel
- yum-repoforge - https://github.com/opscode-cookbooks/yum-repoforge
- jenkins - https://github.com/opscode-cookbooks/jenkins
- java - https://github.com/agileorbit-cookbooks/java
- virtualbox - https://github.com/psyreactor/virtualbox-cookbook
- vagrant - https://github.com/psyreactor/vagrant-cookbook
- ruby_build - https://github.com/fnichol/chef-ruby_build
- build-essential - https://github.com/opscode-cookbooks/build-essential
- docker - https://github.com/bflad/chef-docker
- sudo - https://github.com/opscode-cookbooks/sudo
- sysctl - https://github.com/onehealth-cookbooks/sysctl

The following platforms and versions are tested and supported using Opscode's test-kitchen.

- CentOS 5.8, 6.3
- Ubunutu 12.04
- Debian 7.2

The following platform families are supported in the code, and are assumed to work based on the successful testing on CentOS.


- Red Hat (rhel)
- Fedora
- Amazon Linux

Recipes
-------
#### jenkins_kitchen:default
##### Basic Config

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node[:jenkins_kitchen][:kitchen][:driver]</tt></td>
    <td>String</td>
    <td>Driver test-kitchen vagrant or docker are support</td>
    <td><tt>vagrant</tt></td>
  </tr>
  <tr>
    <td><tt>node[:jenkins_kitchen][:proxy][:host]</tt></td>
    <td>String</td>
    <td>proxy for jenkins</td>
    <td><tt>192.168.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>node[:jenkins_kitchen][:proxy][:port]</tt></td>
    <td>String</td>
    <td>proxy port for jenkins</td>
    <td><tt>3128</tt></td>
  </tr>
</table>
## Usage

### jenkins_kitchen::default

Include `jenkins_kitchen` in your node's `run_list`:

```json
"default_attributes": {
  "jenkins_kitchen": {
    "driver": "docker"
    }
  }
```


Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

[More details](https://github.com/psyreactor/wordpress-cookbook/blob/master/CONTRIBUTING.md)

License and Authors
-------------------

Authors:
Lucas Mariani (Psyreactor)
- [marianiluca@gmail.com](mailto:marianiluca@gmail.com)
- [https://github.com/psyreactor](https://github.com/psyreactor)
