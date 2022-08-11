# List all resources with a tag
# $resourceARN = aws resourcegroupstaggingapi get-resources --tag-filters Key=Name,Values=DemoVpc --query ResourceTagMappingList[*].ResourceARN --output text

# stop and terminate the instance
$instanceId = aws ec2 describe-instances --filters Name=tag:Name,Values=DemoEC2 --query Reservations[*].Instances[].InstanceId --output text
aws ec2 terminate-instances --instance-ids $instanceId

# 1. Delete your security group
$groupId = aws ec2 describe-security-groups --filters Name=tag:Name,Values=DemoSecurityGroup --query SecurityGroups[*].GroupId --output  text
aws ec2 delete-security-group --group-id $groupId

# 2. Delete the subnets
$subnetAId = aws ec2 describe-subnets --filters Name=tag:Name,Values=DemoSubnetA --query Subnets[*].SubnetId --output  text
aws ec2 delete-subnet --subnet-id $subnetAId

$subnetBId = aws ec2 describe-subnets --filters Name=tag:Name,Values=DemoSubnetB --query Subnets[*].SubnetId --output  text
aws ec2 delete-subnet --subnet-id $subnetBId

# 3. Delete your custom route table
$routeTableId = aws ec2 describe-route-tables --filters Name=tag:Name,Values=DemoRouteTable --query RouteTables[*].RouteTableId --output  text
aws ec2 delete-route-table --route-table-id $routeTableId

# 4. Detach your internet gateway from your VPC
$vpcId = aws ec2 describe-vpcs --filters Name=tag:Name,Values=DemoVpc --query Vpcs[*].VpcId --output  text
$igwId = aws ec2 describe-internet-gateways --filters Name=tag:Name,Values=DemoIGW --query InternetGateways[*].InternetGatewayId --output text
aws ec2 detach-internet-gateway --internet-gateway-id $igwId --vpc-id $vpcId

# 5. Delete the Internet Gateway
aws ec2 delete-internet-gateway --internet-gateway-id $igwId

# 6. Delete the VPC
$vpcId = aws ec2 describe-vpcs --filters Name=tag:Name,Values=DemoVpc --query Vpcs[*].VpcId --output  text
aws ec2 delete-vpc --vpc-id $vpcId

