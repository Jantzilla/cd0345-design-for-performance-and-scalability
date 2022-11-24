output "lambda_output" {
    value = aws_lambda_function.my_lambda.arn
    description = "A list of the lambda function permissions"
}