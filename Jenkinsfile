pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'ls -al'
                sh 'pwd'
                sh 'make image'
                sh 'make push'
            }
        }
    }
}
