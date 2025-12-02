# Quick Start Guide - Installing Timer on a New System

## Prerequisites
- Docker must be installed on the target system
- If Docker is not installed, see [INSTALLATION.md](INSTALLATION.md) for detailed instructions

## Installation Steps

### 1. Copy the TimeCalculator Folder
Copy the entire `TimeCalculator` folder to the new system. You can place it anywhere, for example:
```bash
/home/username/TimeCalculator
```

### 2. Navigate to the Folder
```bash
cd /path/to/TimeCalculator
```

### 3. Run the Deployment Script
```bash
chmod +x deploy.sh
./deploy.sh
```

That's it! The script will:
- ✅ Check if Docker is installed
- ✅ Build the Docker image
- ✅ Start the container on port 8081 (or next available port)
- ✅ Open the timer in your browser automatically

## Access the Timer
After deployment, access the timer at:
```
http://localhost:8081
```

## Manual Installation (Alternative)

If you prefer to run commands manually:

```bash
# Navigate to the folder
cd /path/to/TimeCalculator

# Build the Docker image
docker build -t timer .

# Run the container
docker run -d --name timer -p 8081:80 --restart unless-stopped timer

# Verify it's running
docker ps
```

## Useful Commands

### Check Status
```bash
docker ps
```

### Stop the Timer
```bash
docker stop timer
```

### Start the Timer
```bash
docker start timer
```

### Restart the Timer
```bash
docker restart timer
```

### View Logs
```bash
docker logs timer
```

### Remove the Container
```bash
docker stop timer
docker rm timer
```

### Rebuild After Updates
```bash
# Stop and remove old container
docker stop timer
docker rm timer

# Rebuild and restart
docker build -t timer .
docker run -d --name timer -p 8081:80 --restart unless-stopped timer
```

## Uninstall

To completely remove the timer:
```bash
chmod +x uninstall.sh
./uninstall.sh
```

Or manually:
```bash
docker stop timer
docker rm timer
docker rmi timer
```

## Troubleshooting

### Port Already in Use
If port 8081 is already in use, specify a different port:
```bash
docker run -d --name timer -p 8082:80 --restart unless-stopped timer
```
Then access at `http://localhost:8082`

### Docker Not Installed
Install Docker first:
- **Ubuntu/Debian**: See [INSTALLATION.md](INSTALLATION.md)
- **Other systems**: https://docs.docker.com/get-docker/

### Permission Denied
If you get permission errors, you may need to:
```bash
sudo chmod +x deploy.sh
sudo ./deploy.sh
```

Or add your user to the docker group:
```bash
sudo usermod -aG docker $USER
```
Then log out and log back in.

## Features

Your Timer Calculator includes:
- ⏱️ **Stopwatch Mode**: Automatically capture clock-in/out times
- 🎯 **Target Duration**: Set work hour goals
- 📋 **Manual Entry**: Add/edit time pairs manually
- 💾 **Auto-Save**: Data persists in browser localStorage
- 🔄 **Reset**: Clear all entries for a fresh start

## Support

For detailed installation instructions, see [INSTALLATION.md](INSTALLATION.md)  
For usage instructions, see [README.md](README.md)
