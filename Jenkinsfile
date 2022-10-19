pipeline {
    agent none 
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:3.9-bullseye'
                    args '--user 0:0'
                }
            }
            steps {
                sh '''#!/bin/bash
                    pip install -r test_requirements/django-4.0.txt --user
                    pip install -r docs/requirements.txt --user
                '''
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
            post {
                always {
                    junit 'test-results/*.xml'
                }
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