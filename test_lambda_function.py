import pytest
from unittest.mock import patch, MagicMock
from lambda_function import lambda_handler

@patch('lambda_function.dynamodb')  # Mock the DynamoDB resource
def test_lambda_handler(mock_dynamodb):
    # Create a mock for the table and define its return value
    mock_table = MagicMock()
    mock_table.update_item.return_value = {
        'Attributes': {'count': 42}
    }

    # When the lambda function calls 'dynamodb.Table()', return the mock table
    mock_dynamodb.Table.return_value = mock_table

    # Call lambda_handler with a fake event and context (since we're testing locally)
    response = lambda_handler({}, {})

    # Assertions: Check if the response is correct
    assert response['statusCode'] == 200
    assert 'count' in response['body']
