pipeline{
    agent any
    stages{
        stage('checkout the code from github'){
            steps{
                 git url: 'https://github.com/shrathan/FinanceMe.git', branch: "master"
                 echo 'github url checkout'
            }
        }
        stage('Code package '){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Build dockerfiles'){
          steps{
              sh 'docker rm -f banking'
              sh 'docker rmi -f shrathan/banking:v1'
              sh 'docker build -t shrathan/banking:v1 .'
           }
         }
         stage('Docker login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push shrathan/banking:v1'
                }
            }
        }
        stage('port expose'){
            steps{
                sh 'docker run -dt -p 8005:8005 --name banking shrathan/banking:v1'
            }
        }   
    }
}
