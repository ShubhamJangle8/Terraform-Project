pipeline {
    agent any
    
    tools {
        terraform "terraform"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ShubhamJangle8/Terraform-Project'
            }
        }
        stage('Initialize') {
            steps {
                sh "terraform init"
            }
        }
        stage('Plan') {
            steps {
                sh "terraform plan"
            }
        }
        
        stage('User Confirmation') {
            steps {
                script {
                    def userInput = input(
                        id: 'confirmDeploy', message: 'Proceed with Terraform apply?',
                        parameters: [choice(name: 'CONFIRMATION', choices: 'yes\nno', description: 'Choose yes to proceed.')]
                    )
                    if (userInput == 'yes') {
                        echo 'User confirmed. Proceeding with apply.'
                    } else {
                        error 'User chose not to proceed. Aborting.'
                    }
                }
            }
        }
        stage('Terraform Apply') {
            when {
                expression { return params.CONFIRMATION == 'yes' }
            }
            steps {
                script {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
}
