#!/bin/bash
# Timer Tool - Docker Deployment Script

set -e  # Exit on error

echo "=========================================="
echo "Timer Tool - Docker Deployment"
echo "=========================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker is not installed"
    echo "Please install Docker first: https://docs.docker.com/get-docker/"
    exit 1
fi

echo "✅ Docker is installed"
echo ""

# Check if container already exists
if docker ps -a --format '{{.Names}}' | grep -q "^timer$"; then
    echo "⚠️  Container 'timer' already exists"
    read -p "Do you want to remove it and redeploy? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🗑️  Removing old container..."
        docker rm -f timer
        echo "✅ Old container removed"
    else
        echo "❌ Deployment cancelled"
        exit 1
    fi
fi

echo ""
echo "🔨 Building Docker image..."
docker build -t timer .

if [ $? -eq 0 ]; then
    echo "✅ Image built successfully"
else
    echo "❌ Failed to build image"
    exit 1
fi

echo ""
echo "🚀 Starting container..."

# Try port 8081 first, then try other ports if occupied
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
    echo "✅ Timer tool deployed successfully!"
    echo "=========================================="
    echo ""
    echo "📍 Access your timer at:"
    echo "   http://localhost:$SELECTED_PORT"
    echo ""
    echo "🔧 Useful commands:"
    echo "   Stop:    docker stop timer"
    echo "   Start:   docker start timer"
    echo "   Restart: docker restart timer"
    echo "   Logs:    docker logs timer"
    echo "   Remove:  docker rm -f timer"
    echo ""
    echo "📚 For more information, see:"
    echo "   - INSTALLATION.md for detailed guide"
    echo "   - README.md for usage instructions"
    echo ""
    
    # Try to open in browser (Linux)
    if command -v xdg-open &> /dev/null; then
        echo "🌐 Opening in browser..."
        sleep 2
        xdg-open http://localhost:$SELECTED_PORT &
    fi
else
    echo "❌ Failed to start container"
    echo "All attempted ports (${PORTS[*]}) are in use"
    echo "Please stop services using these ports or specify a custom port:"
    echo "   docker run -d --name timer -p YOUR_PORT:80 --restart unless-stopped timer"
    exit 1
fi
