#!/bin/bash
# Simple Installation Script for New Systems
# Run this after copying the TimeCalculator folder

echo "=========================================="
echo "Timer Tool - Simple Installation"
echo "=========================================="
echo ""

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed!"
    echo ""
    echo "Please install Docker first:"
    echo "  sudo apt update"
    echo "  sudo apt install docker.io -y"
    echo "  sudo systemctl start docker"
    echo "  sudo systemctl enable docker"
    echo ""
    exit 1
fi

echo "✅ Docker found"
echo ""
echo "🔨 Building and deploying Timer..."
echo ""

# Stop and remove if exists
docker stop timer 2>/dev/null
docker rm timer 2>/dev/null

# Build the image
echo "🔨 Building Docker image..."
docker build -t timer .

if [ $? -ne 0 ]; then
    echo "❌ Failed to build Docker image"
    exit 1
fi

echo "✅ Image built successfully"
echo ""
echo "🚀 Starting container..."
echo ""

# Try multiple ports automatically
PORTS=(8081 8082 8083 8084 8085)
STARTED=false

for PORT in "${PORTS[@]}"; do
    echo "   Trying port $PORT..."
    if docker run -d --name timer -p $PORT:80 --restart unless-stopped timer 2>/dev/null; then
        STARTED=true
        SELECTED_PORT=$PORT
        break
    fi
done

if [ "$STARTED" = true ]; then
    echo ""
    echo "=========================================="
    echo "✅ Installation Complete!"
    echo "=========================================="
    echo ""
    echo "📍 Access your timer at:"
    echo "   http://localhost:$SELECTED_PORT"
    echo ""
    echo "🔧 Useful commands:"
    echo "   docker stop timer    # Stop the timer"
    echo "   docker start timer   # Start the timer"
    echo "   docker restart timer # Restart the timer"
    echo "   docker logs timer    # View logs"
    echo ""
else
    echo ""
    echo "❌ Installation failed"
    echo "All attempted ports (${PORTS[*]}) are in use"
    echo "Please free up a port or specify a custom port:"
    echo "   docker run -d --name timer -p YOUR_PORT:80 --restart unless-stopped timer"
    exit 1
fi
