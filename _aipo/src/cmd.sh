#!/bin/bash
pushd /opt/aipo

pushd ./bin
./startup.sh
./backup_handler.sh
popd

popd

tail -f /opt/aipo/tomcat/logs/catalina.out
