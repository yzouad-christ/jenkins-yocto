# From official jenkins image.
FROM jenkins/jenkins

# Set root user
USER root

# Install recommended tools for yocto
RUN apt-get update && apt-get install -y \
    gawk wget git-core diffstat unzip texinfo gcc-multilib g++-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    pylint3 xterm file locales vim

# Update locale
RUN locale-gen en_US.UTF-8
RUN echo "152" | dpkg-reconfigure locales

# set gitsrv in /etc/hosts
RUN echo "172.19.52.230   gitsrv" >> /etc/hosts
RUN echo "172.19.52.9   ftpsrv" >> /etc/hosts

# Set working directory.
WORKDIR /home/jenkins

# copy script
ADD getHelperScripts.sh /home/jenkins

# copy bblayers.conf
ADD bblayers.conf /home/jenkins

# create directory
RUN mkdir /home/jenkins/meta-customer

# Copy customer-layer to home dir
ADD meta-customer/ /home/jenkins/meta-customer

# change owner of /home/jenkins directory
RUN chown -R jenkins /home/jenkins
RUN chgrp -R jenkins /home/jenkins

#Set user to jenkins
USER jenkins

# Update $PATH variable
ENV PATH="${PATH}:/home/jenkins/bin"

# Listening port at runtime.
EXPOSE 8080
