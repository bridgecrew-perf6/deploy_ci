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
                    sshagent (credentials: ['italo']) {
                        def passwd = 'M2Digital\\$Harbor'
                        sh '''
                            ssh -o StrictHostKeyChecking=no 192.168.0.77 \
                            docker rm -f $(docker ps -a --format "table {{.Names}}" --filter name=^/deploy_ci | tail -n +2)
                        '''
/*
                        sh """
                            ssh -o StrictHostKeyChecking=no 192.168.0.77 "\
                            docker login -u admin -p ${passwd} https://harbor.m2digital.com.br; \
                            docker run -d --name deploy_ci harbor.m2digital.com.br/m2_automation/deploy_ci:latest"
                        """
*/
                    }
                }
            }
        }
    }
}
