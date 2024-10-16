import pandas as pd
import mysql.connector

# Load the CSV
file_path = r'C:\Users\jayes\OneDrive\Desktop-JayeshSingh\Jayesh\MYSELF\DataAnalytics\Projects\SQL\India Election Result 2024\constituencywise_details.csv'
data = pd.read_csv(file_path)

# Connect to MySQL
connection = mysql.connector.connect(
    host='127.0.0.1',
    user='root',
    password='JayeshS@123456',
    database='ice2024'
)
cursor = connection.cursor()

# Insert data row by row
for _, row in data.iterrows():
    sql = """
    INSERT INTO constituencywise_results (
        `S.No`, `Parliament Constituency`, `Winning Candidate`, `Total Votes`, `Margin`, `Constituency ID`, `Party ID`
    ) VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    cursor.execute(sql, tuple(row))

# Commit the transaction and close connections
connection.commit()
cursor.close()
connection.close()
