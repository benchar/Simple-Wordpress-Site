# Simple-Wordpress-Site
![ECS/ALB/RDS/VPC Architecture](arch.png)

I created a VPC with public and private subnets. I have also attached an internet gateway to a new route table and associated this route table with the public subnet. The private subnet are assoicated with the default VPC route table.

For ECS, I used Fargate for this demonstration. I created a task definition that pulls the Wordpress image from Dockerhub, exposing the neccessary port and setting the cpu and memory. Before creating my service definition, I created an Application load balancer that will listen on port 80. The ECS security group allows inbound traffic from the ALB security group, while the ALB secuiryty group allows HTTP port 80 inbound traffic.

For RDS, I choose Aurora Serverless because you pay for only what you consume and the auto-pause feature helps keep my account in the free tier. I created a security group that allows inbound traffic to my ECS security group.

The terraform module will output the RDS endpoint and ALB DNS name for simplicity.
