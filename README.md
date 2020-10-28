# Terraform-Code-1-AWS
Deploy Secure Web-Page on EC2 instances on AWS Cloud Platform using Terraform.

# What is this repository for?
This is an example of Terraform project which deploys a web application using AWS infrastructure that is:

Isolated in a VPC
Load balanced
Auto scaled
Secured by SSL
DNS routed with Route53
Restricted to traffic from a list of allowed IP addresses
Accessible by SSH

# How do I get set up?
This project assumes that you are already familiar with AWS and Terraform.

There are several dependencies that are needed before the Terraform project can be run. Make sure that you have:

The Terraform binary installed and available on the PATH.
The Access Key ID and Secret Access Key of an AWS IAM user that has programmatic access enabled.
A Hosted Zone in AWS Route 53 for the desired domain name of the application.
The certificate ARN of an AWS Certificate Manager SSL certificate for the domain name.
An OpenSSH key pair that will be used to control login access to EC2 instances.

# Access credentials 
AWS access credentials must be supplied on the command line. This Terraform script was tested in my own AWS account with a user that has the AmazonEC2FullAccess and AmazonVPCFullAccess policies. It was also tested in the AWS account with a user that has the AdministratorAccess policy.

# Files
1. provider.tf - AWS Provider.
2. alb.tf - Launches application load balancer for EC2 instances running httpd.
3. vars.tf - Used by other files, sets default AWS region, AMIs, etc.
4. vpc.tf - Launches VPC, subnets, route tables, Internet Gateway etc.
5. autoscaling.tf - Create the auto scaling group and Create a new EC2 launch configuration
6. autoscalingpolicy.tf - Create the auto scaling policy
7. key.tf - Create a key pair that will be assigned to our instances
8. securitygroup.tf - Create Security Group for instances and ALB Security Group for ALB
9. install-httpd.sh - Contain Shell Script to install HTTPD service
10. rout53.tf - Define a record set in Route 53 for the load balancer
11. output.tf - Shows output of ALB
12. datasource.tf - data source for our Route 53 hosted zone

# Deployment

1. First you have to create a key pair that will be assigned to our instances. I have used name as "mykey" by passing command : "ssh-keygen -f mykey" in same 
   directory where all the files are placed.
2. terraform init :- To setup provisioner
3. terraform plan :- It will show the planning of resources. 
4. terraform apply :- It will provision the mentioned services in mentioned AWS account.
5. terraform destroy : - It will destroy all the resources which are provisioned by terraform.

If the deployment is successful you should now be able to see the infrastructure created in the AWS web console. After a delay while the web instances are 
initialised you should be able to launch the sample web application at https://terraform.[your-domain.com].






