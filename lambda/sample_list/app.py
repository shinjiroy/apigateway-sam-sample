import pymysql
import json

def lambda_handler(event, context):
    # Connect to the database
    # TODO 環境変数から取得するようにする
    connection = pymysql.connect(
        host='apigatewaysample-db',
        user='sample_user',
        password='U1s2e3r4P5a6s7s8w9o0rd',
        database='sample'
    )

    # Create a cursor object to execute SQL queries
    cursor = connection.cursor()

    # Execute the SQL query to retrieve the samples data
    query = """
    SELECT
        id,
        name
    FROM samples
    """
    cursor.execute(query)
    samples = cursor.fetchall()

    # Close the database connection
    connection.close()

    # Convert the samples data to a list of dictionaries
    samples_dict = []
    for sample in samples:
        sample_dict = {
            'id': sample[0],
            'name': sample[1]
        }
        samples_dict.append(sample_dict)

    # Return the samples data as the response
    return {
        'statusCode': 200,
        'body': json.dumps(samples_dict)
    }
