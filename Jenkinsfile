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
                script {
                    try {
                        sshagent (credentials: ['M2AutomationSRV-02']) {
                            sh "ssh -o StrictHostKeyChecking=no 192.168.0.77 'cat /etc/os-release'"
                        }
                    } catch (Exception e) {
                        echo 'Exception occurred: ' + e.toString()
                    }

                    docker_server = docker.withServer('tcp://192.168.0.77:2376', 'M2AutomationSRV-02') {
                        docker.image("harbor.m2digital.com.br/m2_automation/deploy_ci:latest").withRun('') {
                        }

                        //docker.withRegistry("https://${IMAGE_REGISTRY}/", 'm2_harbor') {
                        //    docker.image("${IMAGE_REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}").withRun('') {
                        //    }
                        //}
                    }

                }
            }
        }
    }
}
