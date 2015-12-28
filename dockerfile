# Usage: FROM [image name]
FROM debian:wheezy

# Usage: MAINTAINER [name]
MAINTAINER weezhard

ENV PUPPET_VERSION 3.8.4

RUN apt-get update && \
    apt-get install -y wget ca-certificates lsb-release

RUN wget -q https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb -O /tmp/puppetlabs-release-wheezy.deb && \
    dpkg -i /tmp/puppetlabs-release-wheezy.deb

RUN apt-get update && \
    apt-get install -y ruby-dev make puppetmaster=$PUPPET_VERSION-1puppetlabs1 hiera

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install --no-ri --no-rdoc librarian-puppet puppet-lint

COPY conf/puppet.conf /etc/puppet/puppet.conf
COPY conf/fileserver.conf /etc/puppet/fileserver.conf
COPY conf/autosign.conf /etc/puppet/autosign.conf
COPY conf/hiera.yaml /etc/hiera.yaml

RUN mkdir -p /etc/puppet/environments

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/puppet/environments", "/var/lib/puppet", "/opt/puppet-files"]

EXPOSE 8140

ENTRYPOINT [ "/usr/bin/puppet", "master", "--no-daemonize", "--verbose" ]
