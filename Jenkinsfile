pipeline {
    agent none

    environment {
        REPOSITORIO_GIT = 'https://github.com/egibide-ciberseguridad/juego-de-la-vida.git'
        RAMA_GIT        = 'main'
        RUTA_CLONADO    = 'src'
        PROYECTO_MAVEN  = 'Conway'
        RUTA_JAR        = 'target/*.jar'
    }

    stages {
        stage('Clonar el repositorio') {
            agent { label 'maven' }
            steps {
                dir(env.RUTA_CLONADO) {
                    checkout([$class: 'GitSCM',
                        branches: [[name: "*/${env.RAMA_GIT}"]],
                        userRemoteConfigs: [[url: env.REPOSITORIO_GIT]]
                    ])
                }
            }
        }

        stage('Pasar los tests') {
            agent { label 'maven' }
            steps {
                dir("${env.RUTA_CLONADO}/${env.PROYECTO_MAVEN}") {
                    sh 'mvn test'
                }
            }
        }

        stage('Empaquetar el ejecutable JAR') {
            agent { label 'maven' }
            steps {
                dir("${env.RUTA_CLONADO}/${env.PROYECTO_MAVEN}") {
                    sh 'mvn package'
                }
            }
        }

        stage('Guardar el JAR generado') {
            agent { label 'maven' }
            steps {
                dir("${env.RUTA_CLONADO}/${env.PROYECTO_MAVEN}") {
                    archiveArtifacts artifacts: env.RUTA_JAR
                }
            }
        }
    }
}
