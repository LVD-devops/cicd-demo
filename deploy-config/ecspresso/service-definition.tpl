{
  "launchType": "FARGATE",
  "desiredCount": $ECS_SERVICE_DESIRED_CNT,
  "taskDefinition": "${ECS_TASK_DEFINITION}",
  "networkConfiguration": {
    "awsvpcConfiguration": {
      "subnets": [
        "${ECS_PUB_SUBNET1}",
        "${ECS_PUB_SUBNET2}"
      ],
      "securityGroups": [
        "${ECS_SECURITY_GROUP}"
      ],
      "assignPublicIp": "ENABLED"
    }
  },
  "loadBalancers": [
    {
      "targetGroupArn": "${ECS_ALB_TARGET_GROUP_ARN}",
      "containerName": "${ECS_CONTAINER_NAME}-web",
      "containerPort": 80
    }
  ]
}
