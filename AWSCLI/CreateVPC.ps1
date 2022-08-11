# Credits: this is from Create an IPv4-enabled VPC and subnets using the AWS CLI.

# Check the AWS CLI Version
aws --version

# Set the default region (just for this session)
$Env:AWS_DEFAULT_REGION="us-east-1"

# 1. CREATE A VPC AND SUBNETS
# ---------------------------

# Create a VPC with a CIDR block of 10.0.0.0/16
$vpcId = aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text
aws ec2 create-tags --resources $vpcId --tags Key=Name,Value=DemoVpc
aws ec2 create-tags --resources $vpcId --tags Key=ProductName,Value=Demo
Write-Host Created VPC $vpcId

# Create the first subnet in the VPC
$subnetAId = aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.0.0/24 --query Subnet.SubnetId --output text
aws ec2 create-tags --resources $subnetAId --tags Key=Name,Value=DemoSubnetA 
aws ec2 create-tags --resources $subnetAId --tags Key=ProductName,Value=Demo

# Create the second subnet in the VPC
$subnetBId = aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.1.0/24 --query Subnet.SubnetId --output text
aws ec2 create-tags --resources $subnetBId --tags Key=Name,Value=DemoSubnetB 
aws ec2 create-tags --resources $subnetBId --tags Key=ProductName,Value=Demo

# 2. MAKE YOUR SUBNETS PUBLIC
# ---------------------------
# Create an IGW
$igwId = aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text
aws ec2 create-tags --resources $igwId --tags Key=Name,Value=DemoIGW
aws ec2 create-tags --resources $igwId --tags Key=ProductName,Value=Demo

# attach it to the VPC
aws ec2 attach-internet-gateway --vpc-id $vpcId --internet-gateway-id $igwId

# Create a custom route table
$routeTableId = aws ec2 create-route-table --vpc-id $vpcId --query RouteTable.RouteTableId --output text
aws ec2 create-tags --resources $routeTableId --tags Key=Name,Value=DemoRouteTable
aws ec2 create-tags --resources $routeTableId --tags Key=ProductName,Value=Demo

# Create a custom route
aws ec2 create-route --route-table-id $routeTableId --destination-cidr-block 0.0.0.0/0 --gateway-id $igwId

# Associate with the public subnet (A)
aws ec2 associate-route-table  --subnet-id $subnetAId --route-table-id $routeTableId

# 3. LAUNCH AN INSTANCE IN THE PUBLIC SUBNET
# ------------------------------------------

# Create a key pair - (this will get saved in your current directory)
aws ec2 create-key-pair --key-name DemoKeyPair --query "KeyMaterial" --output text > DemoKeyPair.pem
$keyPairId = aws ec2 describe-key-pairs --key-name DemoKeyPair --query KeyPairs[*].KeyPairId --output text
aws ec2 create-tags --resources $keyPairId --tags Key=Name,Value=DemoRouteTable
aws ec2 create-tags --resources $keyPairId --tags Key=ProductName,Value=Demo


# Create a Security Group
$groupId = aws ec2 create-security-group --group-name DemoSecurityGroup --description "Demom security group for SSH access" --vpc-id $vpcId --query GroupId --output text
aws ec2 create-tags --resources $groupId --tags Key=Name,Value=DemoSecurityGroup
aws ec2 create-tags --resources $groupId --tags Key=ProductName,Value=Demo

# Add a rule that allows SSH access
aws ec2 authorize-security-group-ingress --group-id $groupId --protocol tcp --port 22 --cidr 0.0.0.0/0

# Launch an instance
$instanceId = aws ec2 run-instances --image-id ami-a4827dc9 --count 1 --instance-type t2.micro --key-name DemoKeyPair --security-group-ids $groupId --subnet-id $subnetAId
aws ec2 create-tags --resources $instanceId --tags Key=Name,Value=DemoEC2
aws ec2 create-tags --resources $instanceId --tags Key=ProductName,Value=Demo