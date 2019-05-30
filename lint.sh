#!/bin/bash

# Jenkins syntax validator
# Usage: Run lint.sh followed by the jenkinsfile you want to check
# ./lint.sh Jenkinsfile

JENKINS_FILE=$1
SSHD_PORT=9999
JENKINS_HOSTNAME=localhost
LINT_USR=jenkins
SSH_KEY_PATH=~/.ssh/lint/jenkins-ci-lint.key

start_container() {
        echo "The Jenkinsfile is being analyzed..."
        #CONT_ID=$(docker run -d --name lint_jenkins_test -p 8081:8080 -p $SSHD_PORT:50001 -v jenkins_home:/var/jenkins_home lint_jenkins:v1)
        CONT_ID=$(docker run -d --name lint_jenkins_test -p $SSHD_PORT:50001 -v jenkins_home:/var/jenkins_home lint_jenkins:v2)
        sleep 10
}

validate() {
        ssh -i $SSH_KEY_PATH -l $LINT_USR -p $SSHD_PORT $JENKINS_HOSTNAME declarative-linter < $JENKINS_FILE
        if [ "$?" -ne "0" ]; then
                terminate_container
                exit 1
        fi
}

terminate_container() {
        docker stop $CONT_ID &>/dev/null
        docker rm $CONT_ID &>/dev/null

}

main() {
        start_container
        validate
        terminate_container
}

main
