pipeline {
         agent any
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
                      sh 'php artisan key:generate'
                      sh 'composer install'
                    }
                 }    

                 stage('deploy') {
                   steps {
                     sh 'php artisan serve'
                   }    
                 }
              }
}
