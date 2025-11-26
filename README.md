# Timer - Professional Time Calculator

A beautiful, professional time calculator for tracking work hours with persistent storage.

## Features

- ⏱️ Track multiple clock-in/clock-out pairs
- 💾 Automatic data persistence using localStorage
- 🎨 Modern, responsive design with smooth animations
- 📊 Real-time calculation of total working hours
- 🐳 Docker-ready for easy deployment

## 📖 Documentation

- **[Installation Guide](INSTALLATION.md)** - Detailed step-by-step Docker installation instructions
- **[Quick Start](#quick-start)** - Get up and running in seconds

## Quick Start

### Automated Deployment (Easiest)

```bash
./deploy.sh
```

That's it! The script handles everything and opens the timer in your browser.

**To uninstall:**
```bash
./uninstall.sh
```

---

## Docker Deployment

### Using Docker Compose

1. **Build and start the container:**
   ```bash
   docker-compose up -d --build
   ```

2. **Access the timer:**
   Open your browser and navigate to: `http://localhost:8081`

3. **Stop the container:**
   ```bash
   docker-compose down
   ```

### Alternative: Using Docker Commands

1. **Build the Docker image:**
   ```bash
   docker build -t timer .
   ```

2. **Run the container:**
   ```bash
   docker run -d --name timer -p 8081:80 --restart unless-stopped timer
   ```

3. **Stop the container:**
   ```bash
   docker stop timer
   ```

4. **Remove the container:**
   ```bash
   docker rm timer
   ```

### Useful Docker Commands

- **View logs:**
  ```bash
  docker-compose logs -f
  ```

- **Restart the container:**
  ```bash
  docker-compose restart
  ```

- **Rebuild after changes:**
  ```bash
  docker-compose up -d --build
  ```

- **Check container status:**
  ```bash
  docker ps
  ```

## Usage

1. **Add Time Pairs:** Click "➕ Add Time Pair" to add more clock-in/clock-out entries
2. **Edit Times:** Modify hours, minutes, and AM/PM for each pair
3. **Remove Pairs:** Click "✕ Remove" to delete unwanted pairs
4. **Calculate Total:** Click "🧮 Calculate Total" to see your total working hours
5. **Auto-Save:** All changes are automatically saved to your browser

## Port Configuration

The default port is `8081`. To use a different port, edit `docker-compose.yml`:

```yaml
ports:
  - "YOUR_PORT:80"  # Change YOUR_PORT to desired port
```

## License

Free to use and modify.
