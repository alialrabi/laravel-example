pipeline {
         agent any
          environment {
              
                  DB_USERNAME = credentials('db-username')
                  DB_PASSWORD = credentials('db-password')
                  DB_HOST = credentials('db-host')
              
         }
         stages {
                stage('set variables') {
                   when {
                        branch 'develop' 
                    }  
                    withEnv(['DB_USERNAME=aliali']) {
                       sh "echo $DB_USERNAME" // prints newvalue
                    }
                 }   
                 stage('start') { 
                
                   steps {
                     script {
                           def buildNumber = env.BUILD_NUMBER as int
                           if (buildNumber > 1) milestone(buildNumber - 1)
                           milestone(buildNumber)
                           echo "Build number: ${env.BUILD_NUMBER}"
                     }  
                     echo 'Start deploying.'
                     echo "Running ${env.DB_USERNAME} on ${env.DB_PASSWORD}"  
                   }
                     
                    
                 }
                 
                 stage('build') {
                  
                    steps {
                      sh 'php --version'  
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
