import json
import pytest
from unittest.mock import MagicMock, patch
from decimal import Decimal
import lambda_function

@patch('lambda_function.table')
def test_lambda_handler_success(mock_table):
    # Mock DynamoDB update_item response
    mock_table.update_item.return_value = {
        'Attributes': {'visitor_count': Decimal(5)}
    }

    response = lambda_function.lambda_handler({}, None)

    assert response['statusCode'] == 200
    assert response['headers']['Access-Control-Allow-Origin'] == '*'
    
    body = json.loads(response['body'])
    assert body['visitor_count'] == 5
    mock_table.update_item.assert_called_once()

@patch('lambda_function.table')
def test_lambda_handler_error(mock_table):
    # Simulate a DynamoDB failure
    mock_table.update_item.side_effect = Exception("DynamoDB error")

    response = lambda_function.lambda_handler({}, None)

    assert response['statusCode'] == 500
    body = json.loads(response['body'])
    assert 'error' in body
