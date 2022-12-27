# AWS CDK
## Getting started with AWS CDK

Follow instructions to install pre-reqs from [Getting started with the AWS CDK](https://docs.aws.amazon.com/cdk/v1/guide/getting_started.html).

```
npm install -g aws-cdk
```
You will need to bootstrap the environment
```
cdk bootstrap aws://ACCOUNT-NUMBER/REGION
```
## initialize the project
```
mkdir hello-cdk
cd hello-cdk
cdk init app --language csharp
```
This produces a folder structure 
src>[app-name] with your C# in it.
```csharp
using Amazon.CDK;
using Constructs;

namespace CdkServlerless
{
    public class CdkServlerlessStack : Stack
    {
        internal CdkServlerlessStack(Construct scope, string id, IStackProps props = null) : base(scope, id, props)
        {
            // The code that defines your stack goes here
        }
    }
}
```
Now generate the CloudFormation. This will generate a cdk.out folder with your stack(s) in it.

To add packages use
```
dotnet add package Amazon.CDK.AWS.S3
```
Remember to be in your project folder.

## Add a VPC construct
Go to the [CDK .Net reference](https://docs.aws.amazon.com/cdk/api/v2/dotnet/api/index.html) and search for __aws.ec2.vpc__ and review the docs and samples.

### Add the basic VPC
```csharp
        internal CdkServlerlessStack(Construct scope, string id, IStackProps props = null) : base(scope, id, props)
        {
            new Vpc(this, "cdkvpc");
        }
```
This creates public and private subnets with routing tables within your 10.0.0.16 CIDR range.

* Run ```cdk synth``` and review the output.
* Run ```cdk deploy``` and review the stack in the console and the VPCs and Subnets.
* Run ```cdk destroy``` to clean up.






