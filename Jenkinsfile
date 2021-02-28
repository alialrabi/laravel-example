pipeline {
    
    agent any
    
    stages {

             stage('Initialize Docker'){
                 steps {
                      script {
                           def docker = tool 'whaledocker'
                           echo "${docker}"
                           echo "${env.PATH}"
                           env.PATH = "${docker}/bin:${env.PATH}"
                           echo "${env.PATH}"
                      }
                 }
            }
        
            stage('Checkout Source') {

                 steps {
                     git url:'https://github.com/alialrabi/laravel-example.git', branch: 'uat', credentialsId: 'github'
                 }
            }
    
            stage("Build image") {
          
                steps {
                     script {
                       myapp = docker.build("alialrabi/coverwhale:${env.BUILD_ID}")
                     }
                }
            }
        
     
            stage("Run Test") {
          
                steps {
                     script {
                          docker.image("alialrabi/coverwhale:${env.BUILD_ID}").inside {
                         //   sh 'composer install'  
                          //  sh 'php artisan test'
                          }
                     }
                }
            }
        

            stage("Push image") {
            
                 steps {
                    
                     script {
                         docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                              myapp.push("latest")
                              myapp.push("${env.BUILD_ID}")
                         }
                     }
                 }
            }
    
            stage('Deploy Uat') {
                
     
                steps {
                       script {
                  container('helm') {
                      // Init authentication and config for your kubernetes cluster
                      sh("helm init --client-only --skip-refresh")
                      sh("helm upgrade --install --wait prod-my-app ./helm --namespace prod")
                     }
                   }
                }
            }
 
        

  }
    
}
