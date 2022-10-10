pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:3-alpine'
                }
            }
            steps {
                sh 'python3 -m py_compile setup.py'
                stash(name: 'compiled-results', includes: '*.py*')
            }
        }
        stage('Deliver') { 
            agent any
            environment { 
                VOLUME = '$(pwd)/sources:/src'
                IMAGE = 'cdrx/pyinstaller-linux:python3'
            }
            steps {
                dir(path: env.BUILD_ID) { 
                    unstash(name: 'compiled-results') 
                    sh "docker run -dit --name py-installer --rm -v ${VOLUME} ${IMAGE}"
                    sh "docker exec py-installer sh -c 'pyinstaller manage.py'"
                     
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