# CloudProxy-IaC
```
CloudProxy-IaC is a Terraform project that provisions a highly available infrastructure using Infrastructure as Code (IaC) principles. It sets up a Virtual Private Cloud (VPC) with an Internet Gateway (IGW), subnets, an Application Load Balancer (ALB), and EC2 instances. The architecture enables routing requests from an internet-facing ALB to Nginx reverse proxy instances in public subnets, which then forward the requests to an internal ALB. The internal ALB directs the traffic to Apache web server instances in private subnets, serving the website content.
```

## Infrastructure Overview
The project provisions the following components using Terraform as the IaC tool:

### VPC and IGW
Creates a VPC and attaches an Internet Gateway to enable internet connectivity.

### Subnets
Defines two public subnets and two private subnets within the VPC.

### ALB (Public)
Sets up an internet-facing Application Load Balancer (ALB) in the public subnets, listening on port 80 for HTTP requests.

### EC2 Instances (Public)
Launches EC2 instances in the public subnets. Uses Terraform provisioner to install Nginx reverse proxy on the instances and configure them to proxy requests to the internal ALB.

### ALB (Internal)
Creates an internal Application Load Balancer (ALB) in the private subnets, listening on the desired port for requests from the public instances.

### EC2 Instances (Private)
Launches EC2 instances in the private subnets with Apache web server installed, serving the website content. Uses userdata to configure the Apache server.

### Traffic Flow
Client requests are directed to the public ALB, which forwards them to the public EC2 instances running Nginx. Nginx redirects the requests to the internal ALB, which then forwards them to the private EC2 instances running Apache. The response flows back through the same path, reaching the client.

### Usage
To use this Infrastructure as Code (IaC) project, follow these steps:

Install Terraform: Make sure you have Terraform installed on your machine.

Configure AWS Credentials: Set up your AWS credentials and ensure they have the necessary permissions to create the required resources.

Configure Variables: Modify the variables in the variables.tf file to match your desired configuration. Update any other settings as needed in the Terraform files.

Initialize and Apply: Run the following commands to initialize Terraform and apply the configuration:
```
terraform init
terraform apply
```
Review the planned changes and confirm by typing "yes" when prompted.

Access the Website: After the Terraform deployment is complete, you can access the website through the public ALB's DNS name or endpoint.

###Cleanup
To clean up and destroy the created resources, run the following command:
```
terraform destroy
```
Review the planned actions and confirm by typing "yes" when prompted.
```
Note: Be cautious when running the destroy command as it will remove all the resources created by this IaC Terraform project.
```
### Customization
Feel free to customize the project as per your requirements. You can modify the VPC CIDR ranges, security groups, instance types, or add additional configurations as needed.

### Contributions
Contributions to enhance or expand this Terraform project are welcome! If you find any issues or have suggestions, please open an issue or submit a pull request.

### License
This project is licensed under the MIT License.




