pipeline {
    agent any
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copy all neccessary files to ansible control node"
                    sshagent(['ansible-server-key']) {
                        sh "su scp -o StrictHostKeyChecking=no ansible/* ubuntu@3.71.186.245:/ubuntu"

                        withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')])
                            sh "scp ${keyfile} ubuntu@3.71.186.245:/ubuntu/ssh-key.pem"
                    } 
                }
            }
        
        }   
    }
}