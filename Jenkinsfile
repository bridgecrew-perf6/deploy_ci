pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                script {
                    dockerapp = docker.build("deploy_ci:nova", "-f ./docker/Dockerfile ./docker")
                }
            }
        }
    }
}
