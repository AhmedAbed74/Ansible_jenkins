pipeline {
    agent any
    environment {
        ANSIBLE_SERVER = "3.77.54.50"
    }
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copying all neccessary files to ansible control node"
                    sshagent(['ansible-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@${ANSIBLE_SERVER}:/home/ubuntu/ubuntu"

                        withCredentials([sshUserPrivateKey(credentialsId: 'ubnuntu_node', keyFileVariable: 'keyfile', usernameVariable: 'ubuntu')]) {
                            sh 'scp $keyfile ubuntu@$ANSIBLE_SERVER:/root/ssh-key.pem'
                        }
                    }
                }
            }
        }
        stage("execute ansible playbook") {
            steps {
                script {
                    echo "calling ansible playbook to configure ec2 instances"
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = ANSIBLE_SERVER
                    remote.allowAnyHosts = true

                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                        remote.user = user
                        remote.identityFile = keyfile
                        sshCommand remote: remote, command: "pwd"
                    }
                }
            }
        }
    }   
}
