#!/bin/bash
# Timer Tool - Docker Uninstallation Script

set -e  # Exit on error

echo "=========================================="
echo "Timer Tool - Docker Uninstallation"
echo "=========================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker is not installed"
    exit 1
fi

# Check if container exists
if ! docker ps -a --format '{{.Names}}' | grep -q "^timer$"; then
    echo "⚠️  Container 'timer' does not exist"
    echo "Nothing to uninstall"
    exit 0
fi

echo "Found timer container"
echo ""
read -p "Do you want to remove the timer container? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Uninstallation cancelled"
    exit 1
fi

echo ""
echo "🗑️  Stopping and removing container..."
docker rm -f timer

if [ $? -eq 0 ]; then
    echo "✅ Container removed successfully"
else
    echo "❌ Failed to remove container"
    exit 1
fi

echo ""
read -p "Do you want to remove the Docker image as well? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    if docker images --format '{{.Repository}}' | grep -q "^timer$"; then
        echo "🗑️  Removing Docker image..."
        docker rmi timer
        if [ $? -eq 0 ]; then
            echo "✅ Image removed successfully"
        else
            echo "❌ Failed to remove image"
            exit 1
        fi
    else
        echo "⚠️  Image 'timer' does not exist"
    fi
fi

echo ""
echo "=========================================="
echo "✅ Uninstallation complete!"
echo "=========================================="
echo ""
echo "To redeploy the timer:"
echo "   ./deploy.sh"
echo ""
