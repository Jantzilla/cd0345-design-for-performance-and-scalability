provider "aws" {
    region = var.aws_region
    access_key = "{ACCESS KEY}"
    secret_key = "{SECRET KEY}"
}

resource "aws_iam_role" "role_for_lambda" {
  name = "role_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.role_for_lambda.name
}

data "archive_file" "lambda" {
  type = "zip"
  source_file = "lambda.py"
  output_path = "lambda.py.zip"
}

resource "aws_lambda_function" "my_lambda" {
    function_name = "python_lambda_function"
    filename = data.archive_file.lambda.output_path
    role = aws_iam_role.role_for_lambda.arn
    runtime = "python3.8"
    handler = "lambda.lambda_handler"
    timeout = 30
    memory_size = 128

    environment {
        variables = {
        environment = "dev"
        }
    }
}
