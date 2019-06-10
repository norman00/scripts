!/bin/bash

# Usage: Run lint.sh followed by the jenkinsfile you want to check
# ./lint.sh Jenkinsfile

JENKINS_FILE=$1
SSHD_PORT=9999
JENKINS_HOSTNAME=localhost
JENKINS_HOME=/var/jenkins_home
LINT_USR=jenkins
SSH_KEY_PATH=/tmp/jenkins-ci-lint.key
LINT_IMG=lint_jenkins
CONT_NAME=jenkins_linter
H_REPO=repourl/project

check_image() {
        # Verify if the lint image is present on the host, otherwise pull it from Repository
        docker images | grep $LINT_IMG &>/dev/null
        if [ "$?" -ne "0" ]; then
                echo "Image $LINT_IMG was not found on this host, it will be pulled from Repository..."
                docker pull $H_REPO/$LINT_IMG
        fi
}


add_key() {
        # Adds temp jenkins-ci-lint.key
        cat <<EOF >> $SSH_KEY_PATH
-----BEGIN OPENSSH PRIVATE KEY-----
asdfb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAACFwAAAAdzc2
----END OPENSSH PRIVATE KEY-----
EOF
        chmod 600 $SSH_KEY_PATH
}

start_container() {
        echo "Jenkins container is being started..."
        CONT_ID=$(docker run -d --name $CONT_NAME -p $SSHD_PORT:50001 -v jenkins_home:$JENKINS_HOME $LINT_IMG)
        echo -ne '\n'
        # Progress bar
        echo -ne '###                             (10%)\r'
        #sleep 10
        echo -ne '#####                           (20%)\r'
        #sleep 10
        echo -ne '########                        (30%)\r'
        #sleep 10
        echo -ne '###########                     (40%)\r'
        sleep 10
        echo -ne '###############                 (50%)\r'
        sleep 10
        echo -ne '##################              (60%)\r'
        sleep 10
        echo -ne '#####################           (70%)\r'
        sleep 10
        echo -ne '########################        (80%)\r'
        sleep 10
        echo -ne '###########################     (90%)\r'
        sleep 10
        echo -ne '############################## (100%)\r'
        echo -ne '\n'
        echo -ne '\n'

}

validate() {
        echo "Validation is in progress..."
        echo -ne '\n'
        ssh -i $SSH_KEY_PATH -l $LINT_USR -p $SSHD_PORT $JENKINS_HOSTNAME declarative-linter < $JENKINS_FILE
        if [ "$?" -ne "0" ]; then
                terminate_container
                exit 1
        fi
}

terminate_container() {
        # Terminate container and remove temp ssh key
        docker stop $CONT_ID &>/dev/null
        docker rm $CONT_ID &>/dev/null
        rm $SSH_KEY_PATH &>/dev/null
        echo -ne '\n'

}

main() {
        add_key
        check_image
        start_container
        validate
        terminate_container
}

main
