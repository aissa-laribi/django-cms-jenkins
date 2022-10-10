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
                    pip install -r test_requirements/django-4.0.txt --cache-dir="$(mktemp --directory)" --user
                    pip install -r docs/requirements.txt --cache-dir="$(mktemp --directory)" --user
                    pip list
                '''
            }
        }
    }
}
