FROM centos:centos7

RUN yum update -y
RUN yum install -y nano nmap tree
RUN yum install -y curl wget
RUN yum install -y tar

RUN mkdir --verbose --parents /tmp/from_dockerfile
RUN ln -s /tmp/from_dockerfile ~/tmp

RUN yum install -y docker
RUN docker --version

RUN mkdir --verbose --parents /opt/from_dockerfile
RUN ln -s /opt/from_dockerfile ~/docker
RUN mkdir --verbose --parents ~/docker/certs
RUN mkdir --verbose --parents ~/docker/containers

RUN yum install -y java-1.7.0-openjdk
RUN yum install -y java-1.7.0-openjdk-devel

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN wget https://get.rvm.io -O ~/tmp/rvm-installer.sh
RUN chmod +x ~/tmp/rvm-installer.sh

RUN ~/tmp/rvm-installer.sh --version latest stable
RUN bash -l -c "rvm --default use --install jruby-1.7.18@global --binary"
RUN bash -l -c "rvm gemset install bundler"
RUN bash -l -c "rvm gemset install pry"
RUN bash -l -c "rvm gemset install docker-api"

ADD src/cmd.rb /opt/from_dockerfile/cmd.rb
ADD config_use_images.rb /opt/from_dockerfile/config_use_images.rb
RUN chmod +x ~/docker/cmd.rb

ENV DOCKER_HOST tcp://172.17.42.1:4243
ENV DOCKER_CERT_PATH /opt/from_dockerfile/certs
ENV DOCKER_TLS_VERIFY 0
ENV DOCKER_HOST_CERT_PATH /opt/from_dockerfile/certs
ENV DOCKER_HOST_NGINX_CONF /etc/nginx/conf.d
ENV DNSMASQ_CONFIG_DIR /etc/dnsmasq.d
ENV AIPO_BACKUP_DIR /var/tmp/aipo/backup

ADD _nginx /opt/from_dockerfile/containers/_nginx
ADD _dnsmasq /opt/from_dockerfile/containers/_dnsmasq

VOLUME ["/opt/from_dockerfile/certs", "/opt/from_dockerfile/nginx_conf.d"]
CMD /bin/bash -l -c "ruby ~/docker/cmd.rb"
