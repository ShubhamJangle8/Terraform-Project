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
                sh "terraform plan -out=tfplan"
            }
        }
        
        stage('User Confirmation') {
            steps {
                script {
                    // Capture user input
                    def userInput = input(
                        id: 'confirmDeploy', message: 'Proceed with Terraform apply?',
                        parameters: [choice(name: 'CONFIRMATION', choices: 'yes\nno', description: 'Choose yes to proceed.')]
                    )
                    // Set the confirmation as a build variable if user selected "yes"
                    currentBuild.description = "User selected: ${userInput}"
                    if (userInput == 'no') {
                        error 'User chose not to proceed. Aborting pipeline.'
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
