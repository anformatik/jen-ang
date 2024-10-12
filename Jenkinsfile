pipeline {
    agent any
    tools {nodejs "NODEJS"}
    environment {
      PATH = "C:\\Program Files\\Git\\usr\\bin;C:\\Program Files\\Git\\bin;${env.PATH}"
        stages {
            stage('Build') {
                steps {
                    sh 'npm install'
                }
            }
            stage('Deliver') {
                steps {
                    sh 'chmod -R +rwx ./jenkins/scripts/deliver.sh'
                    sh 'chmod -R +rwx ./jenkins/scripts/kill.sh'
                    sh './jenkins/scripts/deliver.sh'
                    input message: 'Finished using the web site? (Click "Proceed" to continue)'
                    sh './jenkins/scripts/kill.sh'
                }
            }
        }
    }
}
