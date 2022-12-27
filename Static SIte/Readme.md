# Serverless web sites (static sites)
It's super easy and cheap to create a static site hosted in an S3 bucket on AWS.

You can create an S3 bucket for site hosting with this line of CLI.
```
aws s3api create-bucket --bucket mywebsite --region us-east-1
aws s3 website s3://mywebsite/ --index-document index.html --error-document error.html
aws s3 cp c:/site s3://mywebsite/ --recursive
```
copy an s3 policy json file and replace the ARN with your own. 
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::mywebsite/*"
            ]
        }
    ]
}

```
Change the permissions
```
aws s3api put-bucket-policy --bucket mywebsite --policy file://bucketpolicy.json
```

to clean up the bucket use
```
aws s3api delete-bucket --bucket my-bucket --region us-east-1
```