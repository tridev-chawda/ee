#!/bin/bash


sudo yum update –y
sudo yum remove java-1.7.0-openjdk -y
sudo yum install java-1.8.0 -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key

sudo yum install jenkins -y
sudo service jenkins start

sudo pip install ansible
