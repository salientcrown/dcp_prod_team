properties([ parameters([
  string( name: 'AWS_ACCESS_KEY_ID', defaultValue: 'AKIAZQKYEJVGBNCMQBD6'),
  string( name: 'AWS_SECRET_ACCESS_KEY', defaultValue: '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'),
  string( name: 'AWS_REGION', defaultValue: 'us-east-1'),
]), pipelineTriggers([]) ])

// Environment Variables.
env.access_key = AWS_ACCESS_KEY_ID
env.secret_key = AWS_SECRET_ACCESS_KEY
env.region = AWS_REGION


pipeline {
    agent any
    stages {
        stage ('Terraform Init'){
            steps {
                sh "export TF_VAR_region='${env.aws_region}' && export TF_VAR_access_key='${env.access_key}' && export TF_VAR_secret_key='${env.secret_key}' && terraform init"
            }
        }
        stage ('Terraform Plan'){
            steps {
                sh "export TF_VAR_region='${env.aws_region}' && export TF_VAR_access_key='${env.access_key}' && export TF_VAR_secret_key='${env.secret_key}' && terraform plan" 
            }
        }
        stage ('Terraform Apply'){
            steps {
                sh "export TF_VAR_region='${env.aws_region}' && export TF_VAR_access_key='${env.access_key}' && export TF_VAR_secret_key='${env.secret_key}' && terraform apply --auto-approve"
            }
        }
    }
}
