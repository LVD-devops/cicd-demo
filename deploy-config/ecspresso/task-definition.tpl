{
    "family": "${ECS_TASK_DEFINITION}",
    "networkMode": "awsvpc",
    "containerDefinitions": [
        {
            "name": "${ECS_CONTAINER_NAME}-web",
            "image": "${ECS_IMAGE}",
            "cpu": $ECS_CONTAINER_WEB_VCPU,
            "memory": $ECS_CONTAINER_WEB_MEMORY,
            "essential": true,
            "portMappings": [
                {
                    "containerPort": 80,
                    "hostPort": 80,
                    "protocol": "tcp",
                    "appProtocol": "http"
                }
            ],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/${ECS_SERVICE_NAME}/web/${ECS_CONTAINER_NAME}-log",
                    "awslogs-region": "${AWS_REGION}",
                    "awslogs-stream-prefix": "web"
                }
            }
        }
    ],
    "requiresCompatibilities": ["FARGATE"],
    "cpu": $ECS_TASK_VCPU,
    "memory": $ECS_TASK_MEMORY,
    "runtimePlatform": {
        "cpuArchitecture": "X86_64",
        "operatingSystemFamily": "LINUX"
    },
    "executionRoleArn": "arn:aws:iam::${AWS_ACCOUNT_ID}:role/${ECS_TASK_EXECUTE_ROLE}"
}