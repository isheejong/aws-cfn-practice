#!/bin/sh

echo "Please input development account number"
read DevelopmentAccount
echo 'Please input development Profile Name of Development Account'
read DevelopmentAccountProfileName

aws cloudformation deploy \
    --stack-name production-s3-deploy-role \
    --template-file ./template/s3AcrossRolePolicy.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides DevelopmentAccount=$DevelopmentAccount

aws cloudformation deploy 
    --stack-name s3-access-role \
    --template-file ./template/S3AccessRole.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --profile=$DevelopmentAccountProfileName

