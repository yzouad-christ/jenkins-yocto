
pipeline {
    agent any

    stages {
        stage('Repo-init') {
            steps {
               sh echo 'Installing repo'
               sh mkdir ~/bin
               sh curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
               sh chmod a+x ~/bin/repo
            }
        }
        stage('BSP-source download') {
            steps {
               sh PATH=${PATH}:~/bin
               sh mkdir ces-bsp-platform
               sh cd ces-bsp-platform
               sh repo init -u https://github.com/software-celo/ces-bsp-platform -b warrior
               sh repo sync
            }
        }
    }
}

