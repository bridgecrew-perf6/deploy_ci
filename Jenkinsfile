pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                sh 'make get_image_name'
//                script {
//                    dockerapp = docker.build("deploy_ci:nova", "-f ./docker/Dockerfile .")
//                }
            }
        }
    }
}
