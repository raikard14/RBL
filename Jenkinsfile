pipeline{
    agent any
    environment{
        registry= "raikard14/jenkins"
        registryCredentials="dockehub"
        project="jenkins-ejercicio"
        projectVersion="1.0"
        repository=" https://github.com/raikard14/RBL.git "
        repositoryCredentials="github"
    }
    stages{
        stage('Clean Workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout code'){
            steps{
                script{
                    git branch: 'main',
                        credentialsId: repositoryCredentials,
                        url: repository
                }
            }
        }
        stage('Build'){
            steps{
                script{
                    dockerImage= docker.build registry
                }
            }
        }

        stage('Test'){
            steps{
                script{
                    try{
                        sh 'docker run --name $project -e $registry'
                    }finally{
                        sh 'docker rm $project'
                    }

                }
            }
        }

        stage('Deploy'){
            steps{
                script{
                    docker.withRegistry('',registryCredentials ){
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Cleaning Up'){
            steps{
                script{
                    sh 'docker rmi $registry'
                }
            }
        }

    }
    post{
        failure{
            echo ' El pipeline ha fallado'
        }
    }
}
