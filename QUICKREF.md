# Timer Tool - Quick Reference

## 🚀 One-Line Deploy

```bash
./deploy.sh
```

## 🗑️ One-Line Uninstall

```bash
./uninstall.sh
```

---

## 📋 Essential Commands

### Container Management

| Command | Description |
|---------|-------------|
| `docker ps` | Check if timer is running |
| `docker start timer` | Start the timer |
| `docker stop timer` | Stop the timer |
| `docker restart timer` | Restart the timer |
| `docker logs timer` | View logs |
| `docker logs -f timer` | Follow logs (live) |

### Full Lifecycle

| Command | Description |
|---------|-------------|
| `docker build -t timer .` | Build image |
| `docker run -d --name timer -p 8081:80 --restart unless-stopped timer` | Run container |
| `docker rm -f timer` | Remove container |
| `docker rmi timer` | Remove image |

### Docker Compose

| Command | Description |
|---------|-------------|
| `docker-compose up -d --build` | Build and start |
| `docker-compose down` | Stop and remove |
| `docker-compose restart` | Restart |
| `docker-compose logs -f` | View logs |
| `docker-compose ps` | Check status |

---

## 🌐 Access URLs

| Environment | URL |
|-------------|-----|
| **Local** | http://localhost:8081 |
| **Network** | http://YOUR_IP:8081 |

Find your IP:
```bash
hostname -I
# or
ip addr show
```

---

## 🔄 Update After Changes

### Using Deploy Script
```bash
./uninstall.sh
./deploy.sh
```

### Manual
```bash
docker stop timer
docker rm timer
docker build -t timer .
docker run -d --name timer -p 8081:80 --restart unless-stopped timer
```

### Using Docker Compose
```bash
docker-compose down
docker-compose up -d --build
```

---

## 🐛 Troubleshooting

### Check if Container is Running
```bash
docker ps | grep timer
```

### View Container Logs
```bash
docker logs timer
```

### Port Already in Use
```bash
# Check what's using the port
sudo lsof -i :8081

# Or use a different port
docker run -d --name timer -p 8082:80 --restart unless-stopped timer
```

### Container Exists Error
```bash
docker rm -f timer
# Then run your command again
```

### Reset Everything
```bash
docker stop timer
docker rm timer
docker rmi timer
./deploy.sh
```

---

## 💾 Data Storage

- **Location:** Browser localStorage
- **Persistence:** Survives container restarts
- **Scope:** Per browser/device
- **Clear Data:** Browser settings → Clear browsing data → localStorage

---

## 🔧 Configuration

### Change Port

Edit `docker-compose.yml`:
```yaml
ports:
  - "YOUR_PORT:80"
```

Or use Docker directly:
```bash
docker run -d --name timer -p YOUR_PORT:80 --restart unless-stopped timer
```

---

## 📊 Resource Info

- **Image Size:** ~45 MB
- **Memory:** ~5-10 MB
- **CPU:** Minimal
- **Ports:** 8081 (default)

---

## ✅ Health Check

```bash
# Is Docker running?
docker --version

# Is container running?
docker ps | grep timer

# Can access webpage?
curl http://localhost:8081

# View container details
docker inspect timer
```

---

## 🎯 Common Tasks

### Start on Boot
```bash
# Container already has --restart unless-stopped
# To verify:
docker inspect timer | grep RestartPolicy
```

### View All Timer Pairs
Check browser localStorage:
- Open browser DevTools (F12)
- Application tab → Local Storage → http://localhost:8081
- Look for `timePairs` key

### Backup Your Data
```bash
# Export from browser console:
JSON.stringify(localStorage.getItem('timePairs'))

# Copy the output and save to a file
```

### Restore Data
```bash
# In browser console:
localStorage.setItem('timePairs', 'YOUR_BACKUP_DATA')
# Refresh the page
```

---

## 📞 Quick Help

**Problem:** Container won't start
```bash
docker logs timer
```

**Problem:** Can't access webpage
```bash
# Check if running
docker ps | grep timer

# Check port
sudo lsof -i :8081
```

**Problem:** Need to start fresh
```bash
./uninstall.sh
./deploy.sh
```

---

For detailed documentation, see [INSTALLATION.md](INSTALLATION.md)
