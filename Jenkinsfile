@NonCPS
def cancelPreviousBuilds() {
    def jobName = env.JOB_NAME
    def buildNumber = env.BUILD_NUMBER.toInteger()
    /* Get job name */
    def currentJob = Jenkins.instance.getItemByFullName(jobName)

    /* Iterating over the builds for specific job */
    for (def build : currentJob.builds) {
        def exec = build.getExecutor()
        /* If there is a build that is currently running and it's not current build */
        if (build.isBuilding() && build.number.toInteger() != buildNumber && exec != null) {
            /* Then stop it */
            exec.interrupt(
                    Result.ABORTED,
                    new CauseOfInterruption.UserInterruption("Aborted by #${currentBuild.number}")
                )
            println("Aborted previously running build #${build.number}")            
        }
    }
}

pipeline {
         agent any
          environment {
             DB_USERNAME = credentials('db-username')
             DB_PASSWORD = credentials('db-password')
             DB_HOST = credentials('db-host')
         }
         stages {
                 
                 stage('start') {
                
                   steps {
                     echo 'Start deploying.'
                     echo "Running ${env.DB_USERNAME} on ${env.DB_PASSWORD}"  
                   }
                 }
                 
                 stage('build') {
                  
                    steps {
                      script {
                           cancelPreviousBuilds()
                      }  
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
