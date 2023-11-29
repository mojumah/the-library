pipeline {
    agent any
    stages {
        stage('Hello') {
            steps {
                sh '''
                    cd /var/www/html/images
                    sudo aws s3 sync --include "*.jpg" s3://aleppo-library-books-covers-resized .
                '''
            }
        }
    }
}