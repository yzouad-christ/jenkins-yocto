# From official jenkins image.
FROM jenkins/jenkins

# Set working directory.
WORKDIR /home/jenkins

# Listening port at runtime.
EXPOSE 8080
