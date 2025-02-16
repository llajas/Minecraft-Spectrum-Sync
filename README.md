# Minecraft Spectrum Sync

This repository contains a containerized script that **automatically updates the IP address** for a Cloudflare Spectrum Application, ensuring that your Minecraft server remains accessible even when its public IP changes.

The updater runs as a **sidecar container** in the same Kubernetes Pod as your Minecraft server, automatically checking for IP changes and updating Cloudflare Spectrum accordingly.

## 🚀 Features
- **Automatic IP Updates** – Detects changes to the server's public IP and updates Cloudflare Spectrum.
- **Runs as a Sidecar** – Deploys in the same Pod as the Minecraft server for seamless integration.
- **Uses Kubernetes Secrets** – API tokens are stored securely.
- **Lightweight & Efficient** – Runs on an Alpine-based container with minimal resource usage.
- **Idempotent Updates** – Only updates Cloudflare if the IP has changed; no unnecessary API calls.

---

## 🛠️ Prerequisites

Before getting started, make sure you have the following:

- **A Cloudflare account**
- **A Cloudflare API token** with the following permissions:
    - **Zone → Zone Settings → Edit**
    - **Zone → DNS → Edit**
    - **Include → Specific Zone → {Your Domain}**
- **A Kubernetes cluster** running your Minecraft server
- **Docker installed** to build and push the updater container (or use an existing image)

---

## 🚀 Getting Started

### **1️⃣ Clone this Repository**
```bash
git clone https://github.com/llajas/minecraft-spectrum-sync.git
cd minecraft-spectrum-sync

## Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).