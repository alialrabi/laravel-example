pipeline {

    agent any
    
    stages {
     
        stage('start') {
            
            when {
                branch 'develop'
            }
                
            steps {
                  echo 'Start deploying.'
                  echo "Running ${env.DB_USERNAME} on ${env.DB_PASSWORD}"  
                  }
            }
                 
            stage('build') {
                     
                  when {
                        branch 'develop'
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
                      branch 'develop'
                 }
                  
                 steps {
                      sh 'php artisan test'
                 }
            }

            stage('deploy') {

                 when {
                    branch 'develop'
                 }
                
                 steps {
                 
                     sh 'export SERVER_PORT="8090"'
                     sh 'php artisan serve --host 167.99.227.217'
                   
                 }    
                 
            }
      
       
            stage('Initialize'){
                
                 when {
                    branch 'kube'
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
                    branch 'kube'
                 }
  
                 steps {
                     git url:'https://github.com/alialrabi/laravel-example.git', branch:'kube'
                 }
            }
    
            stage("Build image") {
          
                 when {
                   branch 'kube'
                 }
                
                steps {
                     script {
                       myapp = docker.build("alialrabi/laravel-example:${env.BUILD_ID}")
                     }
                }
            }

            stage("Push image") {
                 when {
                    branch 'kube'
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
    
            stage('Deploy App') {
                
                when {
                    branch 'kube'
                }
     
                steps {
                   echo "Done Ali"
                   kubernetesDeploy(configs: "hellowhale.yml", kubeconfigId: "mykubeconfig") 
                 }
            }

  }
    
}
