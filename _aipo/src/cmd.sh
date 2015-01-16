#!/bin/bash
pushd /opt/aipo

pushd ./bin
./startup.sh
#./backup_handler.sh
popd

#rsync -av ./backup ./backup_host

popd

tail -f /opt/aipo/tomcat/logs/catalina.out
