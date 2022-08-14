# Create a stack using the AWS CLI

## Using a local template file
The ids-s3demo-template.yml temlate creates an s3 bucket. The resources section containse a resource with a logical name idss3bucket.
When you create the stack the name of the template will prefix the resource name
aws cloudformation create-stack --stack-name myteststack --template-body file://idss3demotemplate.yml

# Using an s3 bucket

## Create an S3 bucket
aws s3 mb s3://fakebeardcloudformationn

## Tag the bucket
aws s3api put-bucket-tagging --bucket fakebeardcloudformation --tagging "TagSet=[{Key=ProductName, Value=Demo}]"

## Copy the template into the bucket
aws s3 cp template.yml s3://fakebeardcloudformation/templates
