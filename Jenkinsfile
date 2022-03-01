pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                script {
                    IMAGE_REGISTRY = sh (script: 'make get_registry', returnStdout: true).trim()
                    IMAGE_VERSION = sh (script: 'make get_version', returnStdout: true).trim()
                    IMAGE_NAME = sh (script: 'make get_name', returnStdout: true).trim()

                    dockerapp = docker.build("${IMAGE_REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}", "-f ./docker/Dockerfile .")
                }

            }
        }
        stage('Push Image') {
            steps {
                script {
                    IMAGE_VERSION = sh (script: 'make get_version', returnStdout: true).trim()
                    IMAGE_REGISTRY = sh (script: 'make get_registry', returnStdout: true).trim()

                    docker.withRegistry("https://${IMAGE_REGISTRY}/", 'm2_harbor') {
                        dockerapp.push("${IMAGE_VERSION}")
                        dockerapp.push('latest')
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sshagent(credentials: ['M2AutomationSRV-02']) {
                    RESULT = sh "docker ps -a --format 'table {{.Names}}' --filter name=^/SOS_ | tail -n +2"


//                        docker.withRegistry("https://${IMAGE_REGISTRY}/", 'm2_harbor') {
//                            dockerapp.pull()
//                        }

//                    sh "docker login harbor.m2digital.com.br"
//                    sh "docker pull ${IMAGE_REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}"
//                    sh "docker pull ${IMAGE_REGISTRY}/${IMAGE_NAME}:latest"

//                    sh '''
//                        docker rm -f $(docker ps -a --format 'table {{.Names}}' --filter name=^/SOS_ | tail -n +2)
//                    '''
                }
                sh 'echo ${RESULT}'
            }
        }
    }
}
