pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:2-alpine'
                }
            }
            steps {
                sh 'python -m py_compile ./manage.py'
                stash(name: 'compiled-results', includes: '*.py*')
            }
        }
        stage('Test') { 
            agent {
                docker {
                    image 'ubuntu' 
                }
            }
            steps {
                sh 'apt-get update -y'
                sh 'apt-get install python3 git pip'
                sh 'ls' 
            }
        }
    }
}
