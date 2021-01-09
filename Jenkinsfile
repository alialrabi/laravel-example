pipeline {
         agent any
         stages {
                 
                 stage('start') {
                
                   steps {
                     echo 'Hi, this is a gradle project'
                   }
                 }
                 
                 stage('build') {
                  
                    steps {
                      sh 'composer install --ignore-platform-reqs'
                    }
                 }    

                 stage('deploy') {
                   steps {
                     sh 'php artisan serve'
                   }    
                 }
              }
}
