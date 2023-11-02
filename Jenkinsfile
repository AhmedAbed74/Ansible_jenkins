pipeline {
    agent any
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copy all neccessary files to ansible control node"
                    sshagent(['ansible-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@3.71.186.245:/home/ubuntu/ubuntu"

                    } 
                }
            }
        
        }   
    }
        stage("Configure ec2 with ansible")
            steps {
              script{
                echo "calling ansible playbook to configure ec2 instance"
                def remote = [:]
                remote.name = "ansible-server"
                remote.hosts = "3.71.186.245"
                remote.allowAnyHosts = true
                withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                    remote.user = user
                    remote.identityFile = keyfile
                    sshCommand remote: remote, command: " ls -la "

                     }

                  }
            }
}