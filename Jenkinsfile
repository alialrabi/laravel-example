pipeline {
         agent any
          environment {
                  DB_USERNAME = credentials('db-password')
                  DB_PASSWORD = credentials('db-password')
                  DB_HOST = credentials('db-host')
              
         }
      
         stages {
               
                 stage('set variables') {
                    when {
                         branch 'develop' 
                    } 
                    steps { 
                       script {
                            withEnv(["DB_USERNAME="+ credentials('db-password')]) {
                              echo "@@@@@@@@@@@@@@@@@@@@@@##DB_USERNAME is = ${env.DB_USERNAME}"
                            }    
                           }
                       }    
                 }
          
                 stage("Docker build") {
                   steps {
                    //   sh "docker rmi alialrabi/laravel-example"
                       sh "docker build -t alialrabi/laravel-example --no-cache ."
                   }
                 }
                 
                 stage("Docker push") {
                    environment {
                          DOCKER_USERNAME = credentials("docker-user")
                          DOCKER_PASSWORD = credentials("docker-password")
                       }
              
                    steps {
                         sh "docker login --username ${DOCKER_USERNAME} --password ${DOCKER_PASSWORD}"
                         sh "docker push alialrabi/laravel-example"
                    } 
                 }
              
                 stage("Deploy to staging") {
                   steps {
                     sh "docker -p 8181:8181 run alialrabi/laravel-example"
                   }
                 }
         /**
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
                      sh 'php artisan migrate:refresh --seed' 
                    }
                 }
                **/
                 //stage('test') {
                  
                 //   steps {
                  //    sh 'php artisan test'
                   // }
                 //}

             //    stage('deploy') {
             //      steps {
             //        sh 'php artisan serve --host 167.99.227.217 --port=8091'
              //     }    
               //  }
              }
}
