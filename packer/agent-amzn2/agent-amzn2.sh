#!/bin/bash
sudo yum -y update
sudo amazon-linux-extras install docker
sudo yum -y install install java-1.8.0-openjdk git
sudo usermod -a -G docker ec2-user