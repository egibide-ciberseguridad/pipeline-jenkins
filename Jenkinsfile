pipeline {
    agent {
        node {
            // https://jenkins.test/manage/computer/php-runner/configure
            label 'docker'
        }
    }

    environment {
        // https://hub.docker.com/repositories
        imageName = "widemos/nginx-egibide"

        // https://hub.docker.com/settings/security
        registryCredential = 'docker-hub'

        publicPort = "80"
    }

    stages {
        stage('Test') {
            steps {
                sh 'echo Fake test'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    dockerImage = docker.build(imageName, "-f Dockerfile --no-cache .")
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Primer parámetro en blanco -> Docker Hub, si no, URL del registro privado
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Docker Run') {
            steps {
                sh "docker rm -f nginx-egibide"
                sh "docker run -d -p ${publicPort}:80 --name nginx-egibide ${imageName}:latest"
            }
        }
    }
}
