#!/bin/bash

# Run docker with the jenkins image
docker run -u root -d --name jenkins_yocto -p 8080:8080 -p 50000:50000 -v $PWD/jenkins_yocto:/var/jenkins_home jenkins_yocto
