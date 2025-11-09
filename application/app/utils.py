import os
import subprocess
import pickle
import base64

# These will trigger security tools for testing
AWS_ACCESS_KEY = "AKIAIOSFODNN7EXAMPLE"
AWS_SECRET_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
DATABASE_URL = "postgresql://user:password123@localhost/mydb"

def insecure_deserialization(data):
    # This will trigger Bandit
    return pickle.loads(base64.b64decode(data))

def execute_system_command(cmd):
    # This will trigger Bandit
    return subprocess.call(cmd, shell=True)

def hardcoded_secrets():
    api_key = "sk_live_51abc123"
    password = "SuperSecret123!"
    return f"API: {api_key}, Pass: {password}"

def sql_query(user_input):
    # SQL injection vulnerability for testing
    query = f"SELECT * FROM users WHERE id = {user_input}"
    return query
