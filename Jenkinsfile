pipeline {
  agent {
    docker { image 'host.docker.internal:6600/mhm-nginx' }
  }
  stages {
    stage('Test') {
      steps {
        sh 'echo mhm hellllooooo'
      }
    }
  }
}
