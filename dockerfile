#use jenkins image and create a new image called Jenkins#
FROM jenkins/jenkins:lts as local-jenkins

USER root

RUN apt-get update && \
    apt-get install -y python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install awscli --upgrade

USER jenkins

RUN jenkins-plugin-cli --plugins s3

# RUN aws s3api create-bucket --bucket jenkinsartifactbucket --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1