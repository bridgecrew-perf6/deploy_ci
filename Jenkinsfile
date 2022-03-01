pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                script {
                    dockerapp = docker.build("italojohnny/api-produto", "-f ./docker/Dockerfile")
                }
            }
        }
    }
}
