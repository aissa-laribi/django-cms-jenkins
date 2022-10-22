
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
                    python3 -m coverage run --include='./*' manage.py test
                    python3 -m coverage report > test-report.xml
                '''
                publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: '.',
                    reportFiles: 'test-report.xml',
                    reportName: 'RCov Report'
                ]
            }
        }
    }
    post {
        success {
            mail to: 'aissa2retour@gmail.com',
                subject: "Successful Pipeline:",
                body: "Deploy from Github"
        }
    }
}