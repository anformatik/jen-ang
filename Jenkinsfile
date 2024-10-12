pipeline {
    agent any
    // tools {nodejs "NODEJS"}
    stages {
        stage('Build') {
            steps {
                bat 'npm install'
            }
        }
        stage('Deliver') {
            steps {
                // bat 'chmod -R +rwx ./jenkins/scripts/deliver.sh'
                // bat 'chmod -R +rwx ./jenkins/scripts/kill.sh'
                bat 'sh ./jenkins/scripts/deliver.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                bat 'sh ./jenkins/scripts/kill.sh'
            }
        }
    }
}
