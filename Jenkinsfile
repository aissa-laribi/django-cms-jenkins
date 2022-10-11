pipeline {
    agent none 
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:3-alpine'
                    args '--user 0:0'
                }
            }
            steps {
                sh 'python3 -m py_compile setup.py'
                stash(name: 'compiled-results', includes: '*.py*')
            }
        }
        stage('Test') { 
            agent {
                docker {
                    image 'aissalaribi/jenkins-pytest:latest'
                    args '--user 0:0'
                }
            }
            steps {
                sh '''#!/bin/bash
                    pip install -r test_requirements/django-4.0.txt --user
                    pip install -r docs/requirements.txt --user
                    pip list
                    python3 manage.py test
                '''
            }
        }
        stage('Deploy') {
            agent {
                docker {
                    image 'aissalaribi/pyinstaller-linux:latest'
                    args '--user 0:0'
                }
            }
            steps {
                sh 'pyinstaller --onefile setup.py'
            }
            post {
                success {
                    archiveArtifacts 'dist/setup'
                }
            }
        }
    }
}