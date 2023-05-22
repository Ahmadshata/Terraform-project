# CloudProxy-IaC

![image](https://github.com/Ahmadshata/Terraform-project/assets/124501795/ba320c05-5dc1-4423-ba94-73d89cc5286b)

CloudProxy-IaC is a project that provisions a highly available infrastructure using Infrastructure as Code (IaC) principles.
It sets up a Virtual Private Cloud (VPC) with an Internet Gateway , subnets, an Application Load Balancers (ALB), and EC2 instances.
The architecture enables routing requests from an internet-facing ALB to Nginx reverse proxy instances in public subnets,
which then forward the requests to an internal ALB. 
The internal ALB directs the traffic to Apache web server instances in private subnets, serving the website content.

- The Terraform project incorporates a robust state management system to track and manage the infrastructure's state. This is achieved by configuring the project to store the state file in an S3 bucket and using DynamoDB to monitor and manage the state.

- When the Terraform project is executed, the state file, which contains information about the deployed infrastructure's current state, is uploaded instantaneously to an S3 bucket. This ensures that the state file is stored securely and centrally accessible.

- Additionally, DynamoDB is utilized as a backend for state locking and consistency. This means that when multiple users or processes attempt to modify the infrastructure concurrently, DynamoDB ensures that only one process can make changes at a given time, preventing conflicts and maintaining consistency.

- By leveraging S3 for storing the state file and DynamoDB for state locking and consistency management, the Terraform project ensures efficient and reliable state management. This allows for collaboration, scalability, and smooth orchestration of infrastructure changes, enhancing the overall management and control of the infrastructure deployed using Terraform.

- The project follows a modular approach by leveraging the concept of modules in Terraform. Modules allow for the creation of reusable, self-contained components that encapsulate infrastructure resources and configurations.

- In this project, various modules are defined to represent different logical components of the infrastructure. Each module focuses on a specific aspect, such as VPC creation, subnet configuration, load balancer setup, or EC2 instance provisioning.


## Infrastructure Overview

The project provisions the following components using Terraform as the IaC tool:

### VPC and IGW
```
Creates a VPC and attaches an Internet Gateway to enable internet connectivity.
```
### Subnets
```
Defines two public subnets and two private subnets within the VPC.
```
### ALB (Public)
```
Sets up an internet-facing Application Load Balancer (ALB) in the public subnets, listening on port 80 for HTTP requests.
```
### EC2 Instances (Public)
```
Launches EC2 instances in the public subnets. Utilizes Terraform provisioner to install Nginx reverse proxy on the instances
and configure them to proxy requests to the internal ALB.
```
### ALB (Internal)
```
Creates an internal Application Load Balancer (ALB) in the private subnets, listening on the desired port for requests from
the public instances.
```
### EC2 Instances (Private)
```
Launches EC2 instances in the private subnets with Apache web server installed, serving the website content. 
Uses userdata to install and configure the Apache server.
```
### Traffic Flow
```
Client requests are directed to the public ALB, which forwards them to the public EC2 instances running Nginx.
Nginx redirects the requests to the internal ALB, which then forwards them to the private EC2 instances running Apache.
The response flows back through the same path, reaching the client.
```
### Usage
To use this Infrastructure as Code (IaC) project, follow these steps:

Install Terraform: Make sure you have Terraform installed on your machine.

Configure AWS Credentials: Set up your AWS credentials and ensure they have the necessary permissions to create the required resources.

Configure Variables: Modify the variables in the variables.tf file to match your desired configuration. Update any other settings as needed in the Terraform files.

Initialize and Apply: Run the following commands to initialize Terraform and apply the configuration:
```
$ terraform init
$ terraform apply
```
Review the planned changes and confirm by typing "yes" when prompted.

Access the Website: After the Terraform deployment is complete, you can access the website through the public ALB's DNS name or endpoint.

###Cleanup
To clean up and destroy the created resources, run the following command:
```
$ terraform destroy
```
Review the planned actions and confirm by typing "yes" when prompted.

> :warning: Be cautious when running the destroy command as it will remove all the resources created by this IaC Terraform project.

### Customization
Feel free to customize the project as per your requirements. You can modify the VPC CIDR ranges, security groups, instance types, or add additional configurations as needed.

### Contributions
Contributions to enhance or expand this Terraform project are welcome! If you find any issues or have suggestions, please open an issue or submit a pull request.

### License
This project is licensed under the MIT License.




