# From official jenkins image.
FROM jenkins/jenkins

# Set root user
USER root

# Install recommended tools for yocto
RUN apt-get update && apt-get install -y \
    gawk wget git-core diffstat unzip texinfo gcc-multilib g++-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    pylint3 xterm file

# Set working directory.
WORKDIR /home/jenkins

# Add user jenkins
RUN adduser -D jenkins

# change owner of /home/jenkins directory
RUN chown -R jenkins /home/jenkins

#Set user to jenkins
USER jenkins

# Update $PATH variable
ENV PATH="${PATH}:/home/jenkins/bin"

# Listening port at runtime.
EXPOSE 8080
