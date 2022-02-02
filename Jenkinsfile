node {
    stage('Build') {
        echo 'Building....'
        sh 'make image'
    }
    stage('Test') {
        echo 'Testing....'
        sh 'make test'
    }
    stage('Deploy') {
        echo 'Deploying....'
    }
}
