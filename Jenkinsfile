pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {

                script {
                    IMAGE_NAME = sh ( // get image name
                        script: 'make get_image_name', returnStdout: true
                    ).trim()
                    dockerapp = docker.build("${IMAGE_NAME}", "-f ./docker/Dockerfile .")
                }

            }
        }
    }
}
