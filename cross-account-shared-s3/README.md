## 시작하며..
2개의 AWS Account 를 준비 합니다. account 1개는 production 으로 사용하고, 다른 하나는 development 환경으로 사용되며, development 에 있는 IAM User 가 production 환경에서 S3 Bucket을 읽고 저장하고며 데이터를 삭제 할 수 있습니다. 2개 access key를 ./aws/credential 에 모두 저장합니다. prodcution profile 을 default 로 하고 development credential 을 추가합니다.

### cloudformation deploy
> aws cloudformation deploy --stack-name production-s3-deploy-role --template-file ./template/S3AcrossRolePolicy.yaml --capabilities CAPABILITY_NA
MED_IAM --parameter-overrides DevelopmentAccount='<development account number>'

> CAPABILITY_NAMED_IAM : cloudformation template 이 IAM 과 관련된 리소스를 포함하고 있는 경우 해당 옵션을 반드시 추가 한다.
> 다음 리소스에는 CAPABILITY_IAM 또는 CAPABILITY_NAMED_IAM을 지정해야 합니다. AWS::IAM::Group, AWS::IAM::InstanceProfile, AWS::IAM::Policy, and AWS::IAM::Role. 애플리케이션에 사용자 지정 이름을 가진 IAM 리소스가 포함되어 있는 경우 CAPABILITY_NAMED_IAM을 지정해야 합니다. 기능을 지정하는 방법에 대한 예제는 애플리케이션 기능 확인 및 승인(AWS CLI) 단원을 참조하십시오.

> 다음 리소스에는 CAPABILITY_RESOURCE_POLICY를 지정해야 합니다. AWS::Lambda::LayerVersionPermission, AWS::Lambda::Permission, AWS::Events::EventBusPolicy, AWS::IAM:Policy, AWS::ApplicationAutoScaling::ScalingPolicy, AWS::S3::BucketPolicy, AWS::SQS::QueuePolicy, and AWS::SNS::TopicPolicy.


### Policy 만 단독으로 생성 할 수 없다.
> aws cloudformation deploy --stack-name s3-policy --template-file ./template/s3policy.yaml

위와 같에 policy 를  cloudformation template 으로 생성하게 되면, "CREATE_FAILED   At least one of [Groups,Roles,Users] must be non-empty." 오류가 발생한다.
Policy 를 Cloudformation 을 통해서 생성하게 되는 경우, 반드시 Groups, Roles, Users 중 적어도 1개의 이상이 포함되어 있어야 한다.


### cloudformation deploy to devaccount
> aws cloudformation deploy --stack-name s3-access-role --template-file ./template/S3AccessRole.yaml --capabilities CAPABILITY_NAMED_IAM --profile=devAccount


## 참고
### CloudFormation CLI Link
https://docs.aws.amazon.com/cli/latest/reference/cloudformation/index.html

### cloudformation template validatoin
aws cloudformation validate-template --template-body file://./template/production.yaml 