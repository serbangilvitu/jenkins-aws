# Jenkins on AWS
## Overview
The goal of this project is to create a secure, highly available setup for Jenkins on AWS, using dynamically provisioned agents.

## Infrastructure
The infrastructure is created using AWS Cloudformation templates, located in the `cloudformation` directory.

AMIs are being provisioned using Packer, and the templates are stored in the `packer` directory.

The templates will create:
- a VPC with 3 public and 3 private subnets
- launch configuration and autoscaling group for Jenkins (1 instance)
- EFS filesystem with 3 mount targets (used for JENKINS_HOME)
- application load balancer forwarding traffic to the Jenkins autoscaling group
- security groups, NAT gateways, route tables

### Considerations
#### High Availability
The infrastructure is deployed in 3 availability zones.
In case one AZ experiences issues, the autoscaling group will recreate the Jenkins server in another AZ, and mount the EFS volume in JENKINS_HOME via the user data.

It is not possible to have a multi-master setup with the community version, but it would be possible with the Cloudbees version.

Therefore there will be a couple of minutes of downtime while the new instance is being created.

#### Security
The Jenkins servers and agents are placed in private subnets, and their security groups are restrictive.

Encryption at rest: The EBS volumes and EFS filesystem are encrypted.

Encryption in transit: only HTTPS traffic is forwarded, HTTP traffic is redirected to HTTPS.

## Dynamic Agent Provisioning

This can be achieved using the Amazon EC2 plugin.
https://github.com/jenkinsci/ec2-plugin

When configuring the plugin, use the the security group created by Cloudformation (name ending in `-sg-jenkins-agent`) in order to enable connectivity with the Jenkins server, and the agent AMI created with Packer.