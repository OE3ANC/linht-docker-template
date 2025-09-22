# LinHT Docker Template

A GitHub template repository for building and releasing multi-architecture Docker images for LinHT (Linux handheld radio transceiver) projects.

## Use This Template

Click the **"Use this template"** button above to create a new repository with this Docker build workflow pre-configured.

## Features

- **Multi-architecture support**: Builds for both AMD64 (x64) and ARM64 architectures
- **Native ARM64 builds**: Uses GitHub's native ARM64 runners for faster compilation
- **Automated releases**: Attaches Docker image tar files to GitHub releases
- **Build caching**: Leverages GitHub Actions cache for faster subsequent builds
- **Container registry integration**: Pushes images to GitHub Container Registry (ghcr.io)
- **Template ready**: Pre-configured workflow that works out of the box

## Quick Start

### Using the Template
1. Click **"Use this template"** → **"Create a new repository"**
2. Name your new LinHT project repository
3. **Make the new repository public** (required for ARM64 runners)
4. Add your Dockerfile and application code
5. Create a release to trigger the first build

### Manual Setup (Alternative)
1. Copy `.github/workflows/docker-build.yml` to your existing project
2. Follow the [Customization](#customization) steps below

## Setup Package Permissions
To push Docker images to GitHub Container Registry, you need to enable package creation:

### Repository Workflow Permissions:
1. In your repository, go to **Settings** → **Actions** → **General**
2. Under **Workflow permissions**, select **"Read and write permissions"**


## Workflow Overview

The workflow consists of two main jobs:

### 1. Build and Push (`build-and-push`)
- Runs in parallel for AMD64 and ARM64 architectures
- Uses matrix strategy to avoid code duplication
- Builds Docker images and pushes to `ghcr.io`
- Exports images as tar files for offline distribution
- Uploads tar files as temporary artifacts

### 2. Upload Release Assets (`upload-release-assets`)
- Downloads the tar files from previous job
- Attaches them to the GitHub release

## Generated Artifacts

For each release, the workflow creates:

### Docker Images (pushed to ghcr.io)
- `ghcr.io/owner/repo:tag-amd64` - AMD64 image
- `ghcr.io/owner/repo:tag-arm64` - ARM64 image

### Release Assets (attached to GitHub release)
- `linht-amd64.tar` - AMD64 image tar file
- `linht-arm64.tar` - ARM64 image tar file

## Usage Examples

### Pull and run a specific architecture
```bash
# Pull AMD64 image
docker pull ghcr.io/oe3anc/linht-project:v1.0.0-amd64

# Pull ARM64 image  
docker pull ghcr.io/oe3anc/linht-project:v1.0.0-arm64

# Run the image
docker run -it ghcr.io/oe3anc/linht-project:v1.0.0-amd64
