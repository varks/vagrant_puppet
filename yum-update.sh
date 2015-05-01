#!/bin/bash 

# Required for Postgres installation
sudo sed -i "19i exclude=postgresql*" /etc/yum.repos.d/CentOS-Base.repo
sudo sed -i "27i exclude=postgresql*" /etc/yum.repos.d/CentOS-Base.repo
