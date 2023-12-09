pipeline {
    agent {
        node {
            label 'agent1'
        }
    }
    environment {
      AWS_DEFAULT_REGION="eu-west-2"
    }
    stages {
        stage('get-thumbnail-from-s3') {
            steps {
                sh '''
                    aws --version
                   
                '''
            }
        }
    }
}