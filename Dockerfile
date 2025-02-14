cat Dockerfile 
FROM container-registry.oracle.com/os/oraclelinux:8

USER root
# install main packages
RUN dnf install -y sudo hostname zip unzip which java-17-openjdk
RUN dnf install -y net-tools 
RUN dnf install -y iputils 
RUN dnf install -y mlocate
RUN dnf install -y sshpass gcc openssl-devel bzip2-devel libffi-devel zlib-devel
RUN dnf install -y wget    
RUN yum install git -y 
RUN yum install openssh-clients -y
RUN updatedb
RUN yum update -y

# install repo for jenkins
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# install jenkins
RUN yum install jenkins -y 

# allow jenkins to execute sudo
RUN echo -e "jenkins ALL=(ALL) NOPASSWD:ALL" /etc/sudoers


USER jenkins
WORKDIR /jenkins

# create plugins.txt file to add plugins to jenkins with Docker creation
RUN echo "ant:latest                        " >  /jenkins/plugins.txt
RUN echo "antisamy-markup-formatter:latest " >>  /jenkins/plugins.txt
RUN echo "build-timeout:latest " >>  /jenkins/plugins.txt
RUN echo "cloudbees-folder:latest " >>  /jenkins/plugins.txt
RUN echo "configuration-as-code:latest " >>  /jenkins/plugins.txt
RUN echo "credentials-binding:latest " >>  /jenkins/plugins.txt
RUN echo "email-ext:latest " >>  /jenkins/plugins.txt
RUN echo "git:latest " >>  /jenkins/plugins.txt
RUN echo "github-branch-source:latest " >>  /jenkins/plugins.txt
RUN echo "gradle:latest " >>  /jenkins/plugins.txt
RUN echo "ldap:latest " >>  /jenkins/plugins.txt
RUN echo "mailer:latest " >>  /jenkins/plugins.txt
RUN echo "matrix-auth:latest " >>  /jenkins/plugins.txt
RUN echo "pam-auth:latest " >>  /jenkins/plugins.txt
RUN echo "pipeline-github-lib:latest " >>  /jenkins/plugins.txt
RUN echo "pipeline-stage-view:latest " >>  /jenkins/plugins.txt
RUN echo "ssh-slaves:latest " >>  /jenkins/plugins.txt
RUN echo "timestamper:latest " >>  /jenkins/plugins.txt
RUN echo "workflow-aggregator:latest " >>  /jenkins/plugins.txt
RUN echo "ws-cleanup:latest " >>  /jenkins/plugins.txt

# set jenkins password 
ENV JENKINS_USER=admin
ENV JENKINS_PASS=oracle_4U

# Disable first screen wizard
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

EXPOSE 8080

USER jenkins
WORKDIR /jenkins

# download plugins manager
RUN wget -O jenkins-plugin-manager-2.13.2.jar https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.13.2/jenkins-plugin-manager-2.13.2.jar
RUN java -jar jenkins-plugin-manager-2.13.2.jar --plugin-download-directory /jenkins/ --plugin-file /jenkins/plugins.txt --plugins delivery-pipeline-plugin:1.3.2 deployit-plugin

RUN mkdir /var/lib/jenkins/.jenkins/plugins/ -p
RUN cp  /jenkins/* /var/lib/jenkins/.jenkins/plugins/

# run jenkins
CMD ["/usr/bin/jenkins", "--webroot=/jenkins/.jenkins/web"]
