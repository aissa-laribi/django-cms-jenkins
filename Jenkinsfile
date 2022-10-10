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
                    image 'aissalaribi/jenkins-pytest:latest' 
                }
            }
            steps {
                sh '''#!/bin/bash 
                    apt install python3.10-venv
                    python3 -m venv venv
                    venv/source/bin
                    pip install -r test_requirements/django-4.0.txt --user
                    pip install -r docs/requirements.txt --user
                    python3 manage.py test
                '''
            }
        }
    }
}
