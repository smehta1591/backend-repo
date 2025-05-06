# This Python code runs on AWS Lambda (not in the browser!)
import boto3
import json



def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('VisitCounter')
    
    result = table.update_item(
        Key={'id': 'pageVisits'},
        UpdateExpression='SET #c = if_not_exists(#c, :start) + :inc',
    ExpressionAttributeNames={
        '#c': 'count'  # <--- This maps "#c" to "count"
    },
    ExpressionAttributeValues={
        ':start': 0,
        ':inc': 1
    },
    ReturnValues='UPDATED_NEW'
)

    count_value = int(result['Attributes']['count'])
    
    return {
        'statusCode': 200,
        'headers': {'Content-Type': 'application/json'},
        'body': json.dumps({'count': count_value})
    }