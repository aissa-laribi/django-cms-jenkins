
pipeline {
    agent any
    environment {
        API_TOKEN = credentials('django_cms_workflow_api_key')
    }
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
                    python3 -m coverage run --include='./*' manage.py test -v 1
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
        stage('API call Deploy') {
            steps {
                sh '''
                curl -H "Accept: application/vnd.github.everest-preview+json" \
                -H "Authorization: token $API_TOKEN" \
                --request POST \
                --data '{"event_type": "deploy"}' \
                https://api.github.com/repos/aissa-laribi/django-cms-jenkins/dispatches
                '''
            }
        }
    }
}