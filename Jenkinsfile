pipeline {

    agent any
    
    stages {
     
        stage('start') {
            
            when {
                branch 'dev'
            }
                
            steps {
                  echo 'Start deploying .'
                  }
            }
                 
            stage('build') {
                     
                  when {
                        branch 'dev'
                  }
                  
                  steps {
                  
                      sh 'php --version'  
                      sh 'composer --version'
                      sh 'cp .env.example .env'  
                      sh 'composer install'
                      sh 'php artisan key:generate'
                      sh 'php artisan migrate:refresh --seed'
                  }
            }  
             
            stage('test') {
                
                 when {
                      branch 'dev'
                 }
                  
                 steps {
                      sh 'php artisan test'
                 }
            }

            stage('deploy') {

                 when {
                    branch 'dev'
                 }
                
                 steps {
                 
                     sh 'export SERVER_PORT="8090"'
                     sh 'php artisan serve --host 167.99.227.217'
                   
                 }    
                 
            }
      
       
            stage('Initialize Docker'){
                
                 when {
                    branch 'uat'
                 }
            
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
         
                 when {
                    branch 'uat'
                 }
  
                 steps {
                     git url:'https://github.com/alialrabi/laravel-example.git', branch:'kube'
                 }
            }
    
            stage("Build image") {
          
                 when {
                   branch 'uat'
                 }
                
                steps {
                     script {
                       myapp = docker.build("alialrabi/laravel-example:${env.BUILD_ID}")
                     }
                }
            }

            stage("Push image") {
                 when {
                    branch 'uat'
                 }
            
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
                
                when {
                    branch 'uat'
                }
     
                steps {
                   echo "Done Uat"
                   kubernetesDeploy(configs: "hellowhale.yml", kubeconfigId: "mykubeconfig") 
                 }
            }
        
            stage('Deploy Prod') {
                
                when {
                    branch 'prod'
                }
     
                steps {
                   echo "Done Production"
                   kubernetesDeploy(configs: "hellowhale.yml", kubeconfigId: "mykubeconfig") 
                 }
            }

  }
    
}
