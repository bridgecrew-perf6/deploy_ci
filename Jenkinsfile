pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                IMAGE_NAME = sh (script: 'make get_image_name', returnStdout: true).trim()
                echo "Image name: ${IMAGE_NAME}"

//                script {
//                    dockerapp = docker.build("deploy_ci:nova", "-f ./docker/Dockerfile .")
//                }
            }
        }
    }
}
