pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
        REGION = "eu-central-1"
        ECR_REPO = credentials('ECR_REPO')
        ECR_REPO_URL = credentials('ECR_REPO_URL')
        EKS_CLUTER_NAME = "demo-dev"
        IMAGE_NAME = "node${BUILD_ID}"
    }
    stages {
        stage('DOCKER IMAGE BUILD') {
        steps {
            sh '''
                docker build -t $ECR_REPO:${IMAGE_NAME} node-app/
                echo "completed"
                echo $IMAGE_NAME
                '''
            }
        }
        stage('DOCKER IMAGE PUSH') {
        steps {
            sh '''
                aws configure set region $REGION
                $(aws ecr get-login --region $REGION --no-include-email)
                docker push $ECR_REPO:$IMAGE_NAME
                docker logout $ECR_REPO_URL
                docker rmi $ECR_REPO:$IMAGE_NAME
                echo "completed"
                '''
            }
        }
    stage('KUBERNETES DEPLOYMENT') {
        steps {
            sh '''
                export imageNameandversion=$ECR_REPO:$IMAGE_NAME
                sed -i "s|containerImageName|$imageNameandversion|" kube-deployment/main.yml
                aws eks --region $REGION update-kubeconfig --name $EKS_CLUTER_NAME
                /usr/local/bin/kubectl apply -f kube-deployment/ 
                sleep 30
                /usr/local/bin/kubectl get all
                unset imageNameandversion
            '''
            }
        }
    }
}
