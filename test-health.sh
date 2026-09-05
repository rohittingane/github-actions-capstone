#!/bin/bash

echo "Starting Flask app for testing..."
python app.py &
APP_PID=$!

echo "Waiting for app to start..."
sleep 3

echo "Testing /health endpoint..."
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:5000/health)

if [ "$RESPONSE" -eq 200 ]; then
    echo "✅ Health check PASSED (HTTP $RESPONSE)"
    kill $APP_PID
    exit 0
else
    echo "❌ Health check FAILED (HTTP $RESPONSE)"
    kill $APP_PID
    exit 1
fi
