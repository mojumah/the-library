pipeline {

    agent {
        node {
            label 'agent1'
        }
    }

    environment {
      AWS_DEFAULT_REGION="us-east-1"
    }
    stages {
        stage('launch-library-front-end') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'library', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh '''
                    aws --version
                    terraform --version
                    terraform init
                    terraform plan 
                    terraform apply -auto-approve

                '''
                }
            }
        }
    }
}