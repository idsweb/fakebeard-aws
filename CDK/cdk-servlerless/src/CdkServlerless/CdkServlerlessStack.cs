using Amazon.CDK;
using Constructs;
using Amazon.CDK.AWS.EC2;

namespace CdkServlerless
{
    public class CdkServlerlessStack : Stack
    {
        internal CdkServlerlessStack(Construct scope, string id, IStackProps props = null) : base(scope, id, props)
        {
            // step 1. new Vpc(this, "cdkvpc");

            new Vpc(this, "cdkvpc", new VpcProps{
                IpAddresses = IpAddresses.Cidr("10.0.0.0/16"),
                MaxAzs =2,
                SubnetConfiguration = new SubnetConfiguration({
                    CidrMask = 24,
                    Name = "web",
                    SubnetType = SubnetType.PUBLIC}
            });
        }
    }
}
