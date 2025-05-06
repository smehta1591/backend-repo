# tests/test_lambda_function.py

import json
from unittest.mock import patch, MagicMock
from lambda_function import lambda_handler

@patch('lambda_function.table')
def test_lambda_handler_returns_count(mock_table):
    # Mock the DynamoDB response
    mock_table.update_item.return_value = {
        'Attributes': {
            'count': 42
        }
    }

    # Mock event/context
    event = {}
    context = None

    response = lambda_handler(event, context)

    assert response['statusCode'] == 200
    body = json.loads(response['body'])
    assert 'count' in body
    assert body['count'] == 42
