# Cloudflare Spectrum Sync

A containerized utility that **automatically updates the origin IP address** for Cloudflare Spectrum Applications, ensuring your services remain accessible even when the public IP changes.

Runs as a **sidecar container** in a Kubernetes Pod, automatically detecting IP changes and updating Cloudflare Spectrum accordingly.

## Features
- **Automatic IP Updates** - Detects changes to the server's public IP and updates Cloudflare Spectrum.
- **Runs as a Sidecar** - Deploys in the same Pod as your service for seamless integration.
- **Uses Kubernetes Secrets** - API tokens are stored securely.
- **Lightweight & Efficient** - Runs on an Alpine-based container with minimal resource usage.
- **Idempotent Updates** - Only updates Cloudflare if the IP has changed; no unnecessary API calls.

## Prerequisites

- **A Cloudflare account**
- **A Cloudflare API token** with the following permissions:
    - **Zone > Zone Settings > Edit**
    - **Zone > DNS > Edit**
    - **Include > Specific Zone > {Your Domain}**
- **A Kubernetes cluster** running your service
- **Docker installed** to build and push the container (or use an existing image)

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `API_TOKEN` | Yes | - | Cloudflare API token |
| `ZONE_ID` | Yes | - | Cloudflare Zone ID |
| `CUSTOM_DOMAIN` | Yes | - | Domain for the Spectrum application |
| `SPECTRUM_PROTOCOL` | No | `tcp` | Protocol for the Spectrum application |
| `SPECTRUM_PORT` | No | - | Port for the origin server |

## Getting Started

### Clone this Repository
```bash
git clone https://github.com/llajas/cloudflare-spectrum-sync.git
cd cloudflare-spectrum-sync
```

## Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
