pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                script {
                    VERSION = sh (script: 'make get_version', returnStdout: true).trim()
                    NAME = sh (script: 'make get_name', returnStdout: true).trim()

                    dockerapp = docker.build("${NAME}:${VERSION}", "-f ./docker/Dockerfile .")
                }

            }
        }
        stage('Push Image') {
            steps {
                script {
                    REGISTRY = sh (script: 'make get_registry', returnStdout: true).trim()

                    docker.withRegistry('${REGISTRY}', 'm2_harbor')
                    dockerapp.push('${VERSION}')
                    dockerapp.push('latest')
                }
            }
        }
    }
}
