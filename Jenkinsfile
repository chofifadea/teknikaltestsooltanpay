pipeline {  
  agent any
  options { 
    buildDiscarder(logRotator(numToKeepStr: '5'))   
  }
  stages {
     stage('Login to registry') {
        steps {
            script {
            sh 'cat /home/ubuntu/password_docker.txt | docker login --username chofifadea --password-stdin'
                }
            }
        }

    stage('Build Image') {
        steps {
            script {
                if (env.BRANCH_NAME == 'development') {                     
            sh 'docker build -t chofifadea/laravel-8-crud:1.$BUILD_NUMBER-dev .'
                } 
                else if (env.BRANCH_NAME == 'staging') {
            sh ''
                }
                else if (env.BRANCH_NAME == 'prod') {
            sh ''                }
                else {
                    sh 'echo Nothing to Build'
                }
            }
        }
    }
    stage('Push to Registry') {
        steps {
            script {
           if (env.BRANCH_NAME == 'development') {
                sh 'docker push chofifadea/laravel-8-crud:1.$BUILD_NUMBER-dev'
            }
           else {
                sh 'echo Nothing to Build'
            }
            }
        }
    }     
  }
    post {
        success {
            slackSend channel: '#jenkins',
            color: 'good',
            message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}"
        }
        failure {
            slackSend channel: '#jenkins',
            color: 'danger',
            message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}"
        }
    } 
}

