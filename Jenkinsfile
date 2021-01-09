pipeline {
         agent any
          environment {
              DB_USERNAME = credentials('db-username')
              DB_PASSWORD = credentials('db-password')
         }
         stages {
                 
                 stage('start') {
                
                   steps {
                     echo 'Start deploying.'
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

                 stage('deploy') {
                   steps {
                     sh 'php artisan serve'
                   }    
                 }
              }
}
