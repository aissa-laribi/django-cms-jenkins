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
        stage('Deliver') { 
            agent {
                docker {
                    image 'cdrx/pyinstaller:python3'
                    args "--entrypoint=''"
                }
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
                    archiveArtifacts "${env.BUILD_ID} manage.py" 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'rm -rf build dist'"
                }
            }
        }
    }
}