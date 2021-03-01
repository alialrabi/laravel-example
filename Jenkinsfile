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
                
             agent {
               kubernetes {
                     containerTemplate {
                       name 'helm'
                       image 'lachlanevenson/k8s-helm:v3.1.1'
                       ttyEnabled true
                       command 'cat'
                  }
                }
             }
                
                steps {
                   container('helm') { 
                   echo "Done Uat"
                    sh "helm upgrade --install --force --set name=example --set image.tag=last ./helm"

                   }    
                 }
            }


  }
    
}
