def REPO_SOURCE = "http://commondatastorage.googleapis.com/git-repo-downloads/repo"
pipeline {
    agent any

    stages {
        stage('Repo-init') {
            steps {
               sh echo 'Installing repo'
               sh mkdir /home/bin
               sh curl ${REPO_SOURCE} > ~/bin/repo
               sh chmod a+x /home/bin/repo
            }
        }
        stage('BSP-source download') {
            steps {
               sh PATH=${PATH}:/home/bin
               sh mkdir ces-bsp-platform
               sh cd ces-bsp-platform
               sh repo init -u https://github.com/software-celo/ces-bsp-platform -b warrior
               sh repo sync
            }
        }
    }
}

