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
                
             
                
                steps {
                    script {
                     echo "Done Uat"
                     echo "1111111111111111111111111111111111111111111111111111"
                     sh "curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3"
                     sh "chmod 700 get_helm.sh"
                     sh "./get_helm.sh"
                     sh "helm version"  
                     sh "helm list"  
                     sh "helm upgrade --install --namespace=default covering ./helm"
                     //sh "ansible-playbook  playbook.yml" 
                    }
                   
                 }
            }


  }
    
}
