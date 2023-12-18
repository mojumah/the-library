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
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'mohammad_jumh_aws_cli', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh '''
                    aws --version
                    aws s3 sync --include "*.jpg" s3://aleppo-library-books-covers-resized/ .
                    rsync -a /home/mo/workspace/aws-pipeline/ ubuntu@192.168.1.135:/home/ubuntu/rsync-project/
                '''
                }
            }
        }
    }
}