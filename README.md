# pulsemining-csd

Public Docker image and deployment assets for the CSD miner.

## What this does

This repository builds a small Docker image that runs the CSD miner with a bundled runtime layout.
The image is intended for container platforms that provide NVIDIA GPUs.

Docker Hub image:

- `acoilier/pulsemining-csd:latest`
- `acoilier/pulsemining-csd:0.3.1`

## Features

- minimal `debian:bookworm-slim` base
- bundled miner archive download during build
- automatic library path setup for bundled runtime libraries
- hostname-derived worker name by default
- environment-variable driven configuration
- GitHub Actions workflow to build and push the Docker image

## Requirements

- NVIDIA GPU capable environment
- valid payout address
- access to the Docker Hub repository `acoilier/pulsemining-csd`
- GitHub repository secrets for Docker Hub authentication

## Usage

### Build locally

```bash
docker build -t acoilier/pulsemining-csd:latest .
```

### Run locally

```bash
docker run --rm \
  -e ARIA_ADDRESS=0xYOUR_ADDRESS_HERE \
  -e ARIA_POOL=csd.ariabrain.com:13333 \
  acoilier/pulsemining-csd:latest
```

Optional variables:
- `ARIA_WORKER`: override the worker name
- `ARIA_GPU`: select a GPU index when the runtime supports a single-device override
- `ARIA_THREADS`: set CPU threads if supported by your miner build
- `ARIA_TARBALL_URL`: override the miner archive URL at build time or runtime if your workflow uses a different release

## Environment variables

Required at runtime:
- `ARIA_ADDRESS`

Common runtime variables:
- `ARIA_POOL`
- `ARIA_WORKER`
- `ARIA_GPU`
- `ARIA_THREADS`

Build-time variable:
- `ARIA_TARBALL_URL`

## Notes

- The default worker name is derived from the container hostname when `ARIA_WORKER` is not set.
- The image expects the bundled runtime libraries to live next to the miner binary in the extracted archive.
- This repository is public and intentionally avoids site-specific secrets or org-only values.

## License

MIT
