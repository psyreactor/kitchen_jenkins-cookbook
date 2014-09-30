name             'kitchen_jenkins'
maintainer       'Mariani Lucas'
maintainer_email 'marianilucas@gmail.com'
license          'Apache 2.0'
description      'Configures Jenkins for chef recipes CI'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue "0.1.0"

depends 'apt'
depends 'yum-epel'
depends 'yum-repoforge'
depends 'jenkins'
depends 'java'
depends 'virtualbox'
depends 'vagrant'
depends 'ruby_build'
depends 'docker'
depends 'sudo'
depends 'sysctl'