pipeline {
  agent {
    docker {
      image 'docker:latest'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
  }
  stages {
    stage('Test') {
      steps {
        sh 'docker --version'
        sh 'docker pull host.docker.internal:6600/mhm-nginx'
        sh 'echo mhm hellllooooo'
      }
    }
  }
}
