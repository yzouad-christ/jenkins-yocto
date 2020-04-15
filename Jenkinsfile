def REPO_SOURCE = "http://commondatastorage.googleapis.com/git-repo-downloads/repo"
def CES_BSP_SOURCE = "https://github.com/software-celo/ces-bsp-platform"
def REPO_BRANCH = "rocko"
def HOME_PATH = "/home/jenkins"

pipeline {
    agent any

    stages {
        stage('Repo-init') {
            steps {
               sh "echo 'Installing repo'"
               sh "mkdir ${HOME_PATH}/bin"
               sh "curl ${REPO_SOURCE} > ${HOME_PATH}/bin/repo"
               sh "chmod a+x ${HOME_PATH}/bin/repo"
            }
        }
        stage('BSP-source download') {
            steps {
               sh "mkdir ${HOME_PATH}/ces-bsp-platform"
               sh "cd ${HOME_PATH}/ces-bsp-platform"
               sh "yes | $HOME_PATH/bin/repo init -u ${CES_BSP_SOURCE} -b ${REPO_BRANCH}"
            }
        }
        stage('Sync-repo') {
            steps {
               sh "$HOME_PATH/bin/repo sync"
            }
        }
        stage('Set variables and source setup-environment') {
            when {
                expression { fileExists '${HOME_PATH}/ces-bsp-platform/setup-environment' == 'true' }
            }
            steps {
                sh "cd ${HOME_PATH}/ces-bsp-platform"
                sh "MACHINE=pixi-cdl100 DISTRO=ces-fb source .${HOME_PATH}/ces-bsp-platform/setup-environment build"
            }
        }
        stage('Image-build') {
            steps {
                sh "bitbake ces-qt-demoimage"
            }
        }
    }
}
