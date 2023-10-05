  pipeline {

  environment {
    dockerimagename = "x3nomorpheus/front"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/x3nomorpheus/azure_test_front.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying React.js container to Kubernetes') {
      steps {
         sh 'ssh -i /home/jenkins/.ssh/id_rsa -o "StrictHostKeyChecking no" kio@workstation export KUBECONFIG=/home/kio/k8s/azurek8s && kubectl apply -f /home/kio/k8s/kubernetes-apps/front.yaml' 
      }
    }

  }

}
