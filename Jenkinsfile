def REPO_SOURCE = "http://commondatastorage.googleapis.com/git-repo-downloads/repo"
def CES_BSP_SOURCE = "https://github.com/software-celo/ces-bsp-platform"
def REPO_BRANCH = "warrior"
def HOME_PATH = "/home/jenkins"

pipeline {
    agent any

    stages {
        stage('Install Repo') {
            steps {
               dir('/home/jenkins/jenkins-repo') {
               sh "./jenkins-yocto/installRepo.sh ${HOME_PATH}"
               }
            }
        }
        stage('Download Source') {
            steps {
               dir('/home/jenkins/jenkins-repo') {
               sh "git clone https://github.com/yzouad-christ/jenkins-yocto.git"
               sh "chmod -R 755 jenkins-yocto"
               sh "./jenkins-yocto/getRepos.sh ${HOME_PATH} 'warrior' "
               }
            }
        }
        stage('Sync Repo') {
            steps {
               dir('/home/jenkins/ces-bsp-platform') {
               sh "${HOME_PATH}/bin/repo sync"
               }
            }
        }
        stage('Build') {
            steps {
                dir('/home/jenkins/jenkins-repo') {
                sh "./jenkins-yocto/execBitbake.sh ${HOME_PATH}"
                }
            }
        }
    }
}
