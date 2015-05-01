#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java          
echo "export JAVA_HOME=/usr/lib/jvm/java" >> ~/.bashrc
echo "export PGDATA =/opt/gsn_data" >> ~/.bashrc
source ~/.bashrc

#psql -U postgres createdb gsn
#psql -U postgres -c "psql -c \"CREATE USER gsn WITH PASSWORD 'gsnpassword';\""
 
sudo -u postgres createuser -P gsn 
sudo -u postgres createdb gsn
