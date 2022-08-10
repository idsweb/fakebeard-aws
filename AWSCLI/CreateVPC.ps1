# Check the AWS CLI Version
aws --version

# Set the default region (just for this session)
$Env:AWS_DEFAULT_REGION="us-west-2"

# Create a VPC with a CIDR block of 10.0.0.0/16
$vpcId = aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text

Write-Host Created VPC $vpcId