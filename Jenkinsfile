pipeline {
    
    agent {
        kubernetes {
            defaultContainer 'jnlp'
            yamlFile 'build.yaml'
        }
    }
    
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
                     container('docker') {
                    sh "docker build -t alialrabi/coverwhale:${env.BUILD_ID} ."
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
                     
                     
                     
                     
                       container('docker') {
                    withDockerRegistry([credentialsId: "dockerhub", url: ""]) {
                        sh "docker push alialrabi/coverwhale:${env.BUILD_ID}"
                    }
                }
                     
                     
                 }
            }
    
            stage('Deploy Uat') {
                
     
                steps {
                       script {
                           echo "11111111111111111111111111111111111111111"
                //  container('helm') {
                  //    echo "222222222222222222222222222222222222"
                   //  }
                   }
                }
            }
 
        

  }
    
}
