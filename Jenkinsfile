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
                sh 'python -m py_compile setup.py'
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
                    python3 manage.py test
                '''
            }
        }
        stage('Deliver') { 
            agent any {
                IMAGE = 'cdrx/pyinstaller:python3'
                ENVIRONMENT = "--entrypoint=''"
            }
            steps {
                unstash(name: 'compiled-results') 
                echo "Something"
                sh '''
                    pyinstaller -F setup.py
                    ls
                '''     
                }
            }
            post {
                success {
                    archiveArtifacts "${env.BUILD_ID}/sources/dist/add2vals" 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'rm -rf build dist'"
                }
            }
        }
    }

