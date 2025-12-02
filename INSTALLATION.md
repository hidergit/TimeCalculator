# Timer Tool - Docker Installation Guide

This guide will walk you through deploying the Timer tool using Docker.

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

1. **Docker** - [Install Docker](https://docs.docker.com/get-docker/)
   ```bash
   # Verify Docker installation
   docker --version
   ```

2. **Docker Compose (Optional)** - [Install Docker Compose](https://docs.docker.com/compose/install/)
   ```bash
   # Verify Docker Compose installation
   docker-compose --version
   ```

## 📁 Project Structure

```
TimeCalculator/
├── timer.html              # Main application file
├── Dockerfile             # Docker image configuration
├── docker-compose.yml     # Docker Compose configuration
├── deploy.sh              # Automated deployment script
├── uninstall.sh           # Automated uninstallation script
├── .dockerignore         # Files to exclude from Docker
├── README.md             # Project documentation
└── INSTALLATION.md       # This file
```

## 🚀 Installation Methods

### Method 0: Automated Deployment Script (Easiest)

The quickest way to deploy the timer tool using our automated script.

#### Step 1: Navigate to the project directory
```bash
cd /path/to/TimeCalculator
```

#### Step 2: Run the deployment script
```bash
./deploy.sh
```

The script will:
- ✅ Check if Docker is installed
- ✅ Build the Docker image
- ✅ Find an available port automatically (tries 8081-8085)
- ✅ Start the container
- ✅ Open the timer in your browser

**To uninstall:**
```bash
./uninstall.sh
```

---

### Method 1: Using Docker Compose (Recommended)

Docker Compose makes it easy to manage your container with a single command.

#### Step 1: Navigate to the project directory
```bash
cd /path/to/TimeCalculator
```

#### Step 2: Build and start the container
```bash
docker-compose up -d --build
```

**Explanation:**
- `up` - Creates and starts the container
- `-d` - Runs in detached mode (background)
- `--build` - Builds the image before starting

#### Step 3: Verify the container is running
```bash
docker-compose ps
```

You should see:
```
NAME      IMAGE     COMMAND                  SERVICE   CREATED          STATUS         PORTS
timer     timer     "/docker-entrypoint.…"   timer     10 seconds ago   Up 9 seconds   0.0.0.0:8081->80/tcp
```

#### Step 4: Access the application
Open your web browser and navigate to:
```
http://localhost:8081
```

### Method 2: Using Docker Commands

If you prefer using Docker commands directly without Docker Compose:

#### Step 1: Navigate to the project directory
```bash
cd /path/to/TimeCalculator
```

#### Step 2: Build the Docker image
```bash
docker build -t timer .
```

**Explanation:**
- `build` - Builds a Docker image
- `-t timer` - Tags the image with the name "timer"
- `.` - Uses the current directory for build context

#### Step 3: Run the container
```bash
docker run -d --name timer -p 8081:80 --restart unless-stopped timer
```

**Explanation:**
- `run` - Creates and starts a new container
- `-d` - Runs in detached mode (background)
- `--name timer` - Names the container "timer"
- `-p 8081:80` - Maps port 8081 on host to port 80 in container
- `--restart unless-stopped` - Auto-restart container on system reboot
- `timer` - The image name to use

#### Step 4: Verify the container is running
```bash
docker ps | grep timer
```

You should see:
```
CONTAINER ID   IMAGE    COMMAND                  CREATED          STATUS          PORTS                    NAMES
8b50a51071a2   timer    "/docker-entrypoint.…"   10 seconds ago   Up 9 seconds    0.0.0.0:8081->80/tcp     timer
```

#### Step 5: Access the application
Open your web browser and navigate to:
```
http://localhost:8081
```

## 🔧 Common Operations

### Stop the Container

**Using Docker Compose:**
```bash
docker-compose down
```

**Using Docker:**
```bash
docker stop timer
```

### Start the Container

**Using Docker Compose:**
```bash
docker-compose start
```

**Using Docker:**
```bash
docker start timer
```

### Restart the Container

**Using Docker Compose:**
```bash
docker-compose restart
```

**Using Docker:**
```bash
docker restart timer
```

### View Container Logs

**Using Docker Compose:**
```bash
docker-compose logs -f
```

**Using Docker:**
```bash
docker logs -f timer
```

Press `Ctrl+C` to exit log viewing.

### Check Container Status

**Using Docker Compose:**
```bash
docker-compose ps
```

**Using Docker:**
```bash
docker ps -a | grep timer
```

### Remove the Container

**Using Docker Compose:**
```bash
docker-compose down
```

**Using Docker:**
```bash
docker stop timer
docker rm timer
```

### Remove the Docker Image

**After removing the container:**
```bash
docker rmi timer
```

## 🔄 Updating the Application

When you make changes to `timer.html`:

### Using Docker Compose:
```bash
# Stop and remove the old container
docker-compose down

# Rebuild and start with new changes
docker-compose up -d --build
```

### Using Docker:
```bash
# Stop and remove the old container
docker stop timer
docker rm timer

# Rebuild the image
docker build -t timer .

# Run the new container
docker run -d --name timer -p 8081:80 --restart unless-stopped timer
```

## 🌐 Changing the Port

If port 8081 is already in use or you want to use a different port:

### Using Docker Compose:
Edit `docker-compose.yml`:
```yaml
ports:
  - "YOUR_PORT:80"  # Change to your desired port, e.g., "9090:80"
```

Then run:
```bash
docker-compose up -d --build
```

### Using Docker:
```bash
docker run -d --name timer -p YOUR_PORT:80 --restart unless-stopped timer
```

Replace `YOUR_PORT` with your desired port number (e.g., 9090).

## 🐛 Troubleshooting

### Port Already in Use

**Error:**
```
Error: bind: address already in use
```

**Solution:**
1. Check what's using the port:
   ```bash
   sudo lsof -i :8081
   ```

2. Change to a different port (see "Changing the Port" section above)

### Container Name Already Exists

**Error:**
```
Error: container name "/timer" is already in use
```

**Solution:**
```bash
# Remove the existing container
docker rm -f timer

# Run the command again
```

### Docker Daemon Not Running

**Error:**
```
Cannot connect to the Docker daemon
```

**Solution:**
```bash
# Start Docker service
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker
```

### Permission Denied

**Error:**
```
Permission denied while trying to connect to Docker daemon
```

**Solution:**
```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker
```

## 🔐 Accessing from Other Devices

To access the timer from other devices on your network:

1. Find your computer's IP address:
   ```bash
   # Linux
   ip addr show
   
   # Or
   hostname -I
   ```

2. From another device on the same network, access:
   ```
   http://YOUR_IP_ADDRESS:8081
   ```

   Example: `http://192.168.1.100:8081`

## 📊 Resource Usage

The timer tool uses minimal resources:
- **Image Size:** ~45 MB (nginx:alpine base)
- **Memory Usage:** ~5-10 MB
- **CPU Usage:** Negligible when idle

## 🔒 Security Notes

1. **Local Development:** The current setup is for local use (localhost)
2. **Production:** For internet-facing deployments, consider:
   - Using HTTPS (add SSL certificate)
   - Setting up a reverse proxy (nginx/Caddy)
   - Implementing authentication if needed

## ✅ Verification Checklist

After installation, verify:

- [ ] Container is running: `docker ps | grep timer`
- [ ] Application loads in browser: http://localhost:8081
- [ ] Can add time pairs
- [ ] Calculate button works
- [ ] Data persists after page refresh
- [ ] Container auto-restarts: `docker restart timer`

## 📞 Support

If you encounter issues:

1. Check container logs: `docker logs timer`
2. Verify Docker is running: `docker ps`
3. Check port availability: `sudo lsof -i :8081`
4. Rebuild from scratch:
   ```bash
   docker stop timer
   docker rm timer
   docker rmi timer
   docker build -t timer .
   docker run -d --name timer -p 8081:80 --restart unless-stopped timer
   ```

## 🎉 Success!

Once you see the timer application in your browser and can:
- ✅ Add and remove time pairs
- ✅ Calculate total hours
- ✅ See data persist after refresh

Your installation is complete! The container will automatically restart on system reboots.

---

**Quick Reference:**

| Command | Purpose |
|---------|---------|
| `docker ps` | View running containers |
| `docker ps -a` | View all containers |
| `docker logs timer` | View container logs |
| `docker stop timer` | Stop container |
| `docker start timer` | Start container |
| `docker restart timer` | Restart container |
| `docker rm timer` | Remove container |
| `docker rmi timer` | Remove image |
