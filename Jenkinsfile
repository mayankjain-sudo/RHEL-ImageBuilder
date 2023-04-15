pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                echo "Code checkout"
                checkout scm
            }
        }
        stage('setup'){
            steps {
                sh "sh requirement.sh"
            }
        }
        stage('createImage'){
            steps {
                sh "echo 'create Image step come later'"
            }
        }
    }
}