#!/bin/bash
sudo yum -y update
sudo yum -y install install java-1.8.0-openjdk git amazon-efs-utils
sudo yum -y remove java-1.7.0-openjdk
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum -y update
sudo yum -y install jenkins
sudo chkconfig jenkins off