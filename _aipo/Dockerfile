FROM centos:centos6

RUN yum update -y
RUN yum install -y nano nmap tree
RUN yum install -y curl wget

RUN mkdir --verbose --parents /tmp/from_dockerfile
RUN ln -s /tmp/from_dockerfile ~/tmp

RUN yum install -y tar
RUN yum install -y net-tools
RUN yum install -y sudo

RUN touch /etc/sudoers.d/01_docker
RUN chmod 0440 /etc/sudoers.d/01_docker
RUN echo 'Defaults !requiretty' >> /etc/sudoers.d/01_docker

RUN yum install -y make gcc readline-devel zlib-devel nmap

RUN wget "http://iij.dl.sourceforge.jp/aipo/60038/aipo7020aja_linux64.tar.gz" -O ~/tmp/aipo7020aja_linux64.tar.gz
RUN mkdir --verbose --parents ~/tmp/aipo_01
RUN tar -xvzf ~/tmp/aipo7020aja_linux64.tar.gz -C ~/tmp/aipo_01
RUN tar -xvzf ~/tmp/aipo_01/aipo7020aja_linux/aipo7020.tar.gz -C /opt/

RUN bash /opt/aipo/bin/installer.sh
RUN rm -rf ~/tmp/aipo01
ADD src/cmd.sh /cmd.sh
RUN chmod +x /cmd.sh

RUN yum install -y rsync

EXPOSE 80
WORKDIR /opt/aipo
CMD /cmd.sh
