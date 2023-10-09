  pipeline {

  environment {
    dockerimagename = "x3nomorpheus/front"
    dockerImage = ""
  }

  agent any

  stages {


    stage('Running lint test') {
      agent {

      	docker { 
	  image 'node:18.18.0-alpine3.18'
 	}

      } 

      steps {
	  sh 'cd react-docker && npm install --cache=".customdir/"'
	  sh 'cd react-docker && npm run lint src/*.js*'
      }
    }


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
         sh 'ssh -i /home/jenkins/.ssh/id_rsa -o "StrictHostKeyChecking no" kio@workstation kubectl --kubeconfig /home/kio/k8s/azurek8s delete deployment react-staging || true'
	 sh 'ssh -i /home/jenkins/.ssh/id_rsa -o "StrictHostKeyChecking no" kio@workstation kubectl --kubeconfig /home/kio/k8s/azurek8s apply -f /home/kio/k8s/kubernetes-apps-staging/front.yaml'
      }
    }

  }

}
