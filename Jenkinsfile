def call(body) {
    def config = [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = config
    body()
}

pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                script {
                    IMAGE_VERSION = sh (script: 'make get_version', returnStdout: true).trim()
                    IMAGE_NAME = sh (script: 'make get_name', returnStdout: true).trim()
                    IMAGE_REGISTRY = sh (script: 'make get_registry', returnStdout: true).trim()

                    dockerapp = docker.build("${IMAGE_NAME}:${IMAGE_VERSION}", "-f ./docker/Dockerfile .")

                    docker.withRegistry("https://harbor.m2digital.com.br/", 'm2_harbor') {
                        dockerapp.push("${IMAGE_VERSION}")
                        dockerapp.push('latest')
                    }
                }

            }
        }
//        stage('Push Image') {
//            steps {
//                script {
//                    IMAGE_VERSION = sh (script: 'make get_version', returnStdout: true).trim()
//                    IMAGE_REGISTRY = sh (script: 'make get_registry', returnStdout: true).trim()
//
//                    docker.withRegistry("https://harbor.m2digital.com.br/", 'm2_harbor') {
//                    dockerapp.push("${IMAGE_VERSION}")
//                    dockerapp.push('latest')
//    }
//                }
//            }
//        }
    }
}
