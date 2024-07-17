#!/bin/bash
#This script will get new IP of Ec2 instance and edit the jenkins configfile with new IP.

# Get the instance's public IP address
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids i-00c39f59ca458a156 --query "Reservations[*].Instances[*].PublicIpAddress" --output text)

# Path to the Jenkins configuration file
JENKINS_CONFIG_FILE="/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml"

# Replace the existing IP address in the Jenkins configuration file with the new public IP
#The sed command searches for the line containing the <jenkinsUrl> tag in the Jenkins configuration file and replaces the current URL with the new URL that includes the updated public IP address. The -i option ensures the changes are made directly in the file.
sed -i "s|<jenkinsUrl>http://.*:8080/</jenkinsUrl>|<jenkinsUrl>http://${PUBLIC_IP}:8080/</jenkinsUrl>|" $JENKINS_CONFIG_FILE

# Restart Jenkins to apply the changes
systemctl restart jenkins
