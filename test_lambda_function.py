import os
from unittest.mock import patch, MagicMock
from lambda_function import lambda_handler

# Ensure AWS region is set to avoid boto3 issues (optional safety)
os.environ['AWS_REGION'] = 'us-east-1'

@patch('lambda_function.boto3.resource')
def test_lambda_handler(mock_boto_resource):
    # Create a mock DynamoDB table
    mock_table = MagicMock()
    mock_table.update_item.return_value = {
        'Attributes': {'count': 42}
    }

    # Configure the mock resource to return the mock table
    mock_boto_resource.return_value.Table.return_value = mock_table

    # Call your lambda function handler
    response = lambda_handler({}, {})

    # Assertions
    assert response['statusCode'] == 200
    assert 'count' in response['body']
