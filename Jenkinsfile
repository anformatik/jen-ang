/* groovylint-disable NestedBlockDepth */
/* groovylint-disable-next-line CompileStatic */

pipeline {
    agent any

    options {
        skipDefaultCheckout(true) //prevent default checkout of git branch
        timestamps() //Add timestamps to the Console Output
    }

    environment{
        /*
readJSON method comes from the Pipeline Utility Steps plugin in Jenkins
        */
        DOCKER_HUB_CRED=credentials('dockerHubRegistryCredentials') //pulling the DockerHub crendetials saved in Jenkins-->Dashboard--->Credentials
        environ="${env.environment}" //environment info from pipeline input
        buildNumber="${env.BUILD_NUMBER}"
        branchName="${env.Branch}"
        containerPort=80 //fix the container port
        toRepositoryName="angular-nginx-${env.environment}" //repository to which the image will be pushed
        containerName="angular-nginx-${env.environment}-container"
        serviceName="nginx-${env.environment}"
        server_ip="20.51.236.140"
        docker_daemon_port=2375
        DOCKER_HOST="tcp://${server_ip}:${docker_daemon_port}"
        LOCAL_REGISTRY="localhost:6600" // Local Docker Registry Address
        def envConfig = readJSON file: "src/assets/environments/${env.environment}.config.json"
        appPort="${envConfig.port}" //decide the application port based on the environment
    }

    stages{
        stage('Docker Workflow') {
            stages{
                stage('Clone') {
                    steps {
                        echo 'Cloning...'
                        cleanWs() //Workspace Clean Plugin to delete the workspace before cloning and building
                        //we are using the installed Git plugin to clone the branch from the repo
                        git branch: "${branchName}", url: 'https://github.com/ramyabala221190/jenkinsTest.git'
                    }
                }

                stage('Docker Build') {
                    steps {
                        echo 'Running Docker Compose build'
                        bat  "docker compose -f docker/docker-compose.yml build ${serviceName}"
                    }
                }

                stage('Docker Login'){
                    steps {
                        echo 'Skipping login as we are using local registry'
                    }
                }

                stage('Docker Push') {
                    steps{
                        echo 'Pushing image to local registry'
                        bat  "docker tag ${DOCKER_HUB_CRED_USR}/${toRepositoryName}:${buildNumber} ${LOCAL_REGISTRY}/${toRepositoryName}:${buildNumber}"
                        bat  "docker push ${LOCAL_REGISTRY}/${toRepositoryName}:${buildNumber}"
                    }
                }

                stage('Deploy to Remote VM'){
                    steps{
                        echo 'Execute SSH..'
                        withCredentials([sshUserPrivateKey(
                            credentialsId: 'sshConnection', usernameVariable: 'username', keyFileVariable:'keyfile')]) {
                            bat "ssh -o StrictHostKeyChecking=no -i ${keyfile} ${username}@${server_ip} \
                            docker --version \
                            && docker image pull ${LOCAL_REGISTRY}/${toRepositoryName}:${buildNumber} \
                            && docker compose -f docker/docker-compose.yml up -d --remove-orphans --no-build ${serviceName} \
                            && docker cp src/assets/environments/${environ}.config.json ${containerName}:/usr/share/nginx/html/assets/environments/runtime-environment.json \
                            && docker image prune --force \
                            && docker ps \
                            && docker images"
                        }
                    }
                }
            }
        }
    }
}
