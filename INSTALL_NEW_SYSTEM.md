# Installing Timer on a New System

## Quick Installation (3 Steps)

1. **Copy the `TimeCalculator` folder** to the new system

2. **Open terminal** in the TimeCalculator folder:
   ```bash
   cd /path/to/TimeCalculator
   ```

3. **Run the install script**:
   ```bash
   ./install.sh
   ```

That's it! Access the timer at **http://localhost:8081**

---

## What You Need

- **Docker** must be installed on the system
- If Docker is not installed, the script will show you how to install it

---

## Files Needed

Copy the entire `TimeCalculator` folder which contains:
- `timer.html` - The application
- `Dockerfile` - Docker configuration
- `install.sh` - Installation script
- Other documentation files

---

## Alternative: Manual Installation

If you prefer manual commands:

```bash
cd /path/to/TimeCalculator

# Build the image
docker build -t timer .

# Run the container
docker run -d --name timer -p 8081:80 --restart unless-stopped timer
```

---

## Common Commands

```bash
# Check if running
docker ps

# Stop
docker stop timer

# Start
docker start timer

# Restart
docker restart timer

# Remove
docker stop timer && docker rm timer
```

---

## Troubleshooting

**Port 8081 already in use?**
```bash
docker run -d --name timer -p 8082:80 --restart unless-stopped timer
```
Then access at `http://localhost:8082`

**Permission denied?**
```bash
sudo ./install.sh
```

---

For detailed instructions, see [QUICKSTART.md](QUICKSTART.md)
