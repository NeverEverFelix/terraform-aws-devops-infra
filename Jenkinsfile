pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  name: jenkins-kaniko
spec:
  serviceAccountName: jenkins-irsa-sa
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:latest
      command:
        - /busybox/cat
      tty: true
      volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
  volumes:
    - name: kaniko-secret
      projected:
        sources:
          - secret:
              name: kaniko-ecr-secret
              items:
                - key: .dockerconfigjson
                  path: config.json
"""
        }
    }

    environment {
        IMAGE = 'felixmoronge/felixmoronge-portfolio'
        TAG = 'latest'
        CONTEXT = '.'
        DOCKERFILE = 'Dockerfile'
    }

    stages {
        stage('Build & Push Image') {
            steps {
                container('kaniko') {
                    script {
                        sh """
                            /kaniko/executor \
                              --dockerfile=${DOCKERFILE} \
                              --context=${CONTEXT} \
                              --destination=${IMAGE}:${TAG} \
                              --verbosity=info
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Docker image built and pushed to ECR: ${IMAGE}:${TAG}"
        }
        failure {
            echo "Build failed. Please check the Kaniko logs."
        }
    }
}
