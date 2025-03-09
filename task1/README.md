          Deploying the Web Application Infrastructure on AWS
Prerequisites :
       1. An AWS account
       2. AWS CLI installed and configured
       3. A registered domain name (for ACM certificate validation)
       4. A key pair for SSH access
Deployment Steps :
1. Create the CloudFormation Stack
sh
aws cloudformation create-stack --stack-name WebAppStack --template-body file://WebServer.yaml --capabilities CAPABILITY_NAMED_IAM

2. Wait for Deployment to Complete
sh
aws cloudformation wait stack-create-complete --stack-name WebAppStack

3. Retrieve the Load Balancer DNS Name
sh
aws cloudformation describe-stacks --stack-name WebAppStack --query "Stacks[0].Outputs"
Use the DNS name to access your application via HTTPS.

Verifying the Setup : 
1. Check the IIS server: Navigate to https://<ALB-DNS-Name> in a browser.
2. Test RDP Access: Connect to the EC2 instance using the assigned key pair.
3. Check Logs in S3: Verify that logs are being written to the specified S3 bucket.

Recommendations for Production:
1. Restrict RDP access to trusted IPs.
2. Enable automatic scaling for the EC2 instances.
3. Implement logging and monitoring using AWS CloudWatch.
4. Use a stronger IAM policy for S3 access.








