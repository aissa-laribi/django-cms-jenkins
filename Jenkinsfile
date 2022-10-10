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
                    image 'aissalaribi/jenkins-pytest' 
                }
            }
            steps {
                bash 'apt install python3.10-venv'
                bash 'python3 -m venv venv'
                bash 'venv/source/bin'
                bash 'pip install -r test_requirements/django-4.0.txt --user'
                bash 'pip install -r docs/requirements.txt --user'
                bash 'python3 manage.py test' 
            }
        }
    }
}
