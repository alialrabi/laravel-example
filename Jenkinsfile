pipeline {
         agent any
          environment {
             DB_USERNAME = credentials('db-username')
             DB_PASSWORD = credentials('db-password')
             DB_HOST = credentials('db-host')
         }
         stages {
                 
                 stage('start') {
                
                   steps {
                     echo 'Start deploying.'
                     echo "Running ${env.DB_USERNAME} on ${env.DB_PASSWORD}"  
                   }
                 }
                 
                 stage('build') {
                  
                    steps {
                      sh 'composer --version'
                      sh 'cp .env.example .env'  
                      sh 'composer install'
                      sh 'php artisan key:generate'
                    }
                 }
             
                 stage('test') {
                  
                    steps {
                      sh 'php artisan test'
                    }
                 }

                 stage('deploy') {
                   steps {
                     sh 'php artisan serve --host 167.99.227.217 --port=8091'
                   }    
                 }
              }
}
