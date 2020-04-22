def REPO_SOURCE = "http://commondatastorage.googleapis.com/git-repo-downloads/repo"
def CES_BSP_SOURCE = "https://github.com/software-celo/ces-bsp-platform"
def REPO_BRANCH = "warrior"
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
               dir('/home/jenkins/jenkins-repo') {
               sh "git clone https://github.com/yzouad-christ/jenkins-yocto.git"
               sh "chmod -R 755 jenkins-yocto"
               sh "./jenkins-yocto/getRepos.sh ${HOME_PATH} 'warrior' "
               }
            }
        }
        stage('Sync-repo') {
            steps {
               dir('/home/jenkins/ces-bsp-platform') {
               sh "${HOME_PATH}/bin/repo sync"
               }
            }
        }
        stage('Set variables and source setup-environment') {
            steps {
                dir('/home/jenkins/jenkins-repo') {
                sh "./jenkins-yocto/execBitbake.sh ${HOME_PATH}"
                }
            }
        }
    }
}
