pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                def image_name = sh 'make get_image_name'
                echo '${image_name}'
//                script {
//                    dockerapp = docker.build("deploy_ci:nova", "-f ./docker/Dockerfile .")
//                }
            }
        }
    }
}
