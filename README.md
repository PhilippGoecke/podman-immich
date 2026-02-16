# podman-immich

Deploy [Immich](https://immich.app/) using Podman - A self-hosted photo and video management solution.

## About Immich

[Immich](https://immich.app/) is a high-performance, self-hosted backup solution for photos and videos. It's designed as a privacy-focused alternative to cloud services like Google Photos, giving you complete control over your media library.

### Key Features

- 📱 **Mobile Apps**: Native iOS and Android apps for automatic backup
- 🔍 **Smart Search**: AI-powered search with facial recognition and object detection
- 🗺️ **Location-based**: Browse photos by location on a map
- 👥 **Multi-user**: Support for multiple users and shared albums
- 🎬 **Video Support**: Full support for videos including transcoding
- 📸 **RAW Support**: Works with RAW photos and live photos
- 🔒 **Privacy First**: Your data stays on your infrastructure
- 🚀 **Active Development**: Regular updates and new features

## About This Project

This repository provides resources and documentation for deploying Immich using Podman instead of Docker, enabling rootless container deployment and better integration with systemd.

## Prerequisites

- **Podman** installed on your system
- **podman-compose** (optional, for compose-based deployment)
- Sufficient storage space for your media library
- A modern Linux distribution (recommended)

## Installation

### Option 1: Using podman-compose

1. Install Podman and podman-compose:
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install podman

# Install podman-compose
pip install podman-compose
```

2. Download Immich compose files:
```bash
mkdir ./immich-app
cd ./immich-app

# Download docker-compose file
wget -O docker-compose.yml https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml

# Download example environment file
wget -O .env https://github.com/immich-app/immich/releases/latest/download/example.env
```

3. Configure your environment:
```bash
# Edit .env file to set:
# - UPLOAD_LOCATION (where your photos will be stored)
# - DB_DATA_LOCATION (database storage location)
# - Timezone settings
# - Database passwords
nano .env
```

4. Start Immich:
```bash
podman-compose up -d
```

### Option 2: Manual Podman Setup with Systemd

For production deployments with better systemd integration:

1. Create Podman pod and containers manually
2. Generate systemd unit files:
```bash
podman generate systemd --name your-immich-pod --files --new
systemctl --user daemon-reload
systemctl --user enable pod-your-immich-pod.service
systemctl --user start pod-your-immich-pod.service
```

## Usage

After installation, access Immich at:
```
http://YOUR_SERVER_IP:2283
```

The first user to register will become the administrator.

## Configuration

Key configuration options in your `.env` file:

- `UPLOAD_LOCATION`: Directory where uploaded photos/videos are stored
- `DB_DATA_LOCATION`: PostgreSQL database storage location
- `TZ`: Your timezone (e.g., `America/New_York`)
- Database credentials and connection settings

## Resources

- 🏠 [Immich Official Website](https://immich.app/)
- 📚 [Immich Documentation](https://docs.immich.app/)
- 💬 [Immich GitHub Repository](https://github.com/immich-app/immich)
- 📦 [Podman Documentation](https://podman.io/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For Immich-specific issues, please visit the [official Immich documentation](https://docs.immich.app/) or their [GitHub repository](https://github.com/immich-app/immich).
