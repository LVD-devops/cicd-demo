## Setting .env.sample file
Firstly, create or upload file .env.sample for web to S3 bucket: [environment-setting](https://ap-northeast-1.console.aws.amazon.com/s3/buckets/environment-setting?region=ap-northeast-1).
Then, change value of environment variable `ENV_SAMPLE_PATH` to your s3 path to env sample file. The path to env file is S3 URI and must be `s3://{BUCKET_NAME}/{ENV_FILE}`
## Secret Key Setting

| Key               | Value                                                                |
| -----------------   | ------------------------------------------------------------------ |
| `AWS_ACCESS_KEY_ID` | ******************* |
| `AWS_ACCOUNT_ID`    | ******************* |
| `AWS_REGION` | ap-northeast-1 |
| `AWS_SECRET_ACCESS_KEY` | ******************* |
| `PAT_TOKEN` | [Github Personal Access Token for update Variables Environment](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#personal-access-tokens-classic) |

## Variables Setting

| Key               | Required | Value  |
| ----------------- | ----------|--------|
| `ECS_ALB_TARGET_GROUP_ARN` | △ | (*)  |
| `ECS_PUB_SUBNET1`    |   △  |  (*)    |
| `ECS_PUB_SUBNET2`    |   △  |   (*)   |
| `ECS_SECURITY_GROUP` |  △   |   (*)   |
| `ECS_VPC_ID` |  △   |   (*)  |

(*) If you already have an existing network that includes load balancing, please enter the corresponding information for the environment variables. Otherwise, if you don't have one, check the checkbox 'Create new Network'; the environment variable information will be automatically filled in when the new network is created
