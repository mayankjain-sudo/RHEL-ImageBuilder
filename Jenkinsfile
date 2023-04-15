pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                echo "Code checkout"
                checkout scm
            }
        }
        stage('Test'){
            steps {
                sh "ls"
            }
        }
    }
}