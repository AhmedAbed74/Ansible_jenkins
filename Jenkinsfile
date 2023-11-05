pipeline {
    agent any
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copy all neccessary files to ansible control node"
                    sshagent(['ansible-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@3.77.54.50:/home/ubuntu/ubuntu"

                    } 
                }
            }
        
        }   
    
        stage("Configure ec2 with ansible"){
            steps {
               script{
                    echo "calling ansible playbook to configure ec2 instance"
                    def remote = [:]
                    remote.name = "ansible-server-key"
                    remote.hosts = "3.77.54.50"
                    remote.allowAnyHosts = true

                withCredentials([sshUserPrivateKey(credentialsId: 'ubnuntu_node', keyFileVariable: 'keyfile', usernameVariable: 'ubuntu')]){
                    remote.user = 'ubuntu'
                    remote.identityFile = keyfile
                    sshCommand remote: remote, command: "pwd"

                     }

              }
            }
        }
    }
}