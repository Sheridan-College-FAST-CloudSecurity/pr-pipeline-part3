from flask import Flask, request, jsonify
import requests
import os
import json

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify({
        "message": "Hello from Secure CI/CD Flask App!",
        "version": "1.0.0",
        "status": "running"
    })

@app.route('/health')
def health_check():
    return jsonify({
        "status": "healthy",
        "service": "flask-app",
        "timestamp": "2024-01-15T10:30:00Z"
    })

@app.route('/api/users/<user_id>')
def get_user(user_id):
    # Simple user endpoint
    users = {
        "1": {"name": "John Doe", "role": "admin"},
        "2": {"name": "Jane Smith", "role": "user"}
    }
    return jsonify(users.get(user_id, {"error": "User not found"}))

@app.route('/api/data', methods=['POST'])
def process_data():
    # API endpoint that processes data
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    
    # Simulate processing
    result = {
        "received": data,
        "processed": True,
        "items_processed": len(data) if isinstance(data, list) else 1
    }
    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
