pipeline {
        agent any
    
    parameters { 
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: "SELECT THE ACCOUNT YOU'D LIKE TO DEPLOY TO.")
        choice(name: 'ACTION', choices: ['apply', 'apply', 'destroy'], description: 'Select action, BECAREFUL IF YOU SELECT DESTROY TO PROD')
    }
    stages{    
        stage('Git checkout') {
            steps{
                checkout scm
                    sh """
                        pwd
                        ls -l
                    """
                }
        }
        stage('TerraformInit'){
            steps {
                    sh """
                        terraform init -upgrade=true
                        echo \$PWD
                        whoami
                    """
            }
        }
    stage('Create Terraform workspace'){
            steps {
                script {
                    try {
                        sh "terraform workspace select ${params.ENVIRONMENT}"
                    } catch (Exception e) {
                        echo "Error occurred: ${e.getMessage()}"
                        sh """
                            terraform workspace new ${params.ENVIRONMENT}
                            terraform workspace select ${params.ENVIRONMENT}
                        """
                    }
    
                }
        }
    }
        stage('Terraform plan'){
            steps {
                    script {
                        try{
                            sh "terraform plan -var-file='${params.ENVIRONMENT} -refresh=true -lock=false -no-color -out='${params.ENVIRONMENT}.plan'"
                        } catch (Exception e){
                            echo "Error occurred while running"
                            echo e.getMessage()
                            sh "terraform plan -refresh=true -lock=false -no-color -out='${params.ENVIRONMENT}.plan'"
                        }
                    }
            
            }
        }
        stage('Confirm your action') {
            steps {
                script {
                    def userInput = input(id: 'confirm', message: params.ACTION + '?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                }
            }
        }
    stage('Terraform apply or destroy ----------------') {
            steps {
            sh 'echo "continue"'
            script{  
                if (params.ACTION == "destroy"){
                    script {
                        try {
                            sh """
                                echo "llego" + params.ACTION
                                terraform destroy -var-file=${params.ENVIRONMENT} -no-color -auto-approve
                            """
                        } catch (Exception e){
                            echo "Error occurred: ${e}"
                            sh "terraform destroy -no-color -auto-approve"
                        }
                    }
                    
            }else {
                        sh"""
                            echo  "llego" + params.ACTION
                            terraform apply ${params.ENVIRONMENT}.plan
                        """ 
                }  // if

            }
            } //steps
        }  //stage
}

}   