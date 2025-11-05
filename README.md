<div align="center">

# Docker image for A1111 Stable Diffusion Web UI, Kohya_ss, ComfyUI and InvokeAI

[![GitHub Repo](https://img.shields.io/badge/github-repo-green?logo=github)](https://github.com/ashleykleynhans/stable-diffusion-docker)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/ashleykza/stable-diffusion-webui?logo=docker&label=dockerhub&color=blue)](https://hub.docker.com/repository/docker/ashleykza/stable-diffusion-webui)
[![RunPod.io Template](https://img.shields.io/badge/runpod_template-deploy-9b4ce6?logo=linuxcontainers&logoColor=9b4ce6)](https://runpod.io/gsc?template=jqw8e1my59&ref=2xxro4sy)
<br>
![Docker Pulls](https://img.shields.io/docker/pulls/ashleykza/stable-diffusion-webui?style=for-the-badge&logo=docker&label=Docker%20Pulls&link=https%3A%2F%2Fhub.docker.com%2Frepository%2Fdocker%2Fashleykza%2Fstable-diffusion-webui%2Fgeneral)
![Template Version](https://img.shields.io/github/v/tag/ashleykleynhans/stable-diffusion-docker?style=for-the-badge&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDI2LjUuMywgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHZpZXdCb3g9IjAgMCAyMDAwIDIwMDAiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDIwMDAgMjAwMDsiIHhtbDpzcGFjZT0icHJlc2VydmUiPgo8c3R5bGUgdHlwZT0idGV4dC9jc3MiPgoJLnN0MHtmaWxsOiM2NzNBQjc7fQo8L3N0eWxlPgo8Zz4KCTxnPgoJCTxwYXRoIGNsYXNzPSJzdDAiIGQ9Ik0xMDE3Ljk1LDcxMS4wNGMtNC4yMiwyLjM2LTkuMTgsMy4wMS0xMy44NiwxLjgyTDM4Ni4xNyw1NTUuM2MtNDEuNzItMTAuNzYtODYuMDItMC42My0xMTYuNiwyOS43MwoJCQlsLTEuNCwxLjM5Yy0zNS45MiwzNS42NS0yNy41NSw5NS44LDE2Ljc0LDEyMC4zbDU4NC4zMiwzMjQuMjNjMzEuMzYsMTcuNCw1MC44Miw1MC40NSw1MC44Miw4Ni4zMnY4MDYuNzYKCQkJYzAsMzUuNDktMzguNDEsNTcuNjctNjkuMTUsMzkuOTRsLTcwMy4xNS00MDUuNjRjLTIzLjYtMTMuNjEtMzguMTMtMzguNzgtMzguMTMtNjYuMDJWNjY2LjYzYzAtODcuMjQsNDYuNDUtMTY3Ljg5LDEyMS45Mi0yMTEuNjYKCQkJTDkzMy44NSw0Mi4xNWMyMy40OC0xMy44LDUxLjQ3LTE3LjcsNzcuODMtMTAuODRsNzQ1LjcxLDE5NC4xYzMxLjUzLDguMjEsMzYuOTksNTAuNjUsOC41Niw2Ni41N0wxMDE3Ljk1LDcxMS4wNHoiLz4KCQk8cGF0aCBjbGFzcz0ic3QwIiBkPSJNMTUyNy43NSw1MzYuMzhsMTI4Ljg5LTc5LjYzbDE4OS45MiwxMDkuMTdjMjcuMjQsMTUuNjYsNDMuOTcsNDQuNzMsNDMuODIsNzYuMTVsLTQsODU3LjYKCQkJYy0wLjExLDI0LjM5LTEzLjE1LDQ2Ljg5LTM0LjI1LDU5LjExbC03MDEuNzUsNDA2LjYxYy0zMi4zLDE4LjcxLTcyLjc0LTQuNTktNzIuNzQtNDEuOTJ2LTc5Ny40MwoJCQljMC0zOC45OCwyMS4wNi03NC45MSw1NS4wNy05My45Nmw1OTAuMTctMzMwLjUzYzE4LjIzLTEwLjIxLDE4LjY1LTM2LjMsMC43NS00Ny4wOUwxNTI3Ljc1LDUzNi4zOHoiLz4KCQk8cGF0aCBjbGFzcz0ic3QwIiBkPSJNMTUyNC4wMSw2NjUuOTEiLz4KCTwvZz4KPC9nPgo8L3N2Zz4K&logoColor=%23ffffff&label=Template%20Version&color=%23673ab7)

</div>

Now with SDXL support.

## Installs

* Ubuntu 22.04 LTS
* CUDA 12.4
* Python 3.10.12
* Torch 2.6.0
* xformers 0.0.29.post3
* [Jupyter Lab](https://github.com/jupyterlab/jupyterlab)
* [code-server](https://github.com/coder/code-server)
* [Automatic1111 Stable Diffusion Web UI](
  https://github.com/AUTOMATIC1111/stable-diffusion-webui) 1.10.1
* [ControlNet extension](
  https://github.com/Mikubill/sd-webui-controlnet) v1.1.455
* [After Detailer extension](
  https://github.com/Bing-su/adetailer) v25.3.0
* [Locon extension](
  https://github.com/ashleykleynhans/a1111-sd-webui-locon)
* [ReActor extension](https://github.com/Gourieff/sd-webui-reactor)
* [Deforum extension](https://github.com/deforum-art/sd-webui-deforum)
* [Inpaint Anything extension](https://github.com/Uminosachi/sd-webui-inpaint-anything)
* [Infinite Image Browsing extension](https://github.com/zanllp/sd-webui-infinite-image-browsing)
* [CivitAI extension](https://github.com/civitai/sd_civitai_extension)
* [CivitAI Browser+ extension](https://github.com/BlafKing/sd-civitai-browser-plus)
* [Stable Diffusion Dynamic Thresholding (CFG Scale Fix) extension](https://github.com/mcmonkeyprojects/sd-dynamic-thresholding)
* [Kohya_ss](https://github.com/bmaltais/kohya_ss) v25.2.1
* [ComfyUI](https://github.com/comfyanonymous/ComfyUI) v0.3.68
* [ComfyUI Manager](https://github.com/ltdrdata/ComfyUI-Manager)
* [InvokeAI](https://github.com/invoke-ai/InvokeAI) v6.9.0
* [inswapper_128.onnx](
  https://github.com/facefusion/facefusion-assets/releases/download/models/inswapper_128.onnx)
* [runpodctl](https://github.com/runpod/runpodctl)
* [OhMyRunPod](https://github.com/kodxana/OhMyRunPod)
* [RunPod File Uploader](https://github.com/kodxana/RunPod-FilleUploader)
* [croc](https://github.com/schollz/croc)
* [rclone](https://rclone.org/)
* [Application Manager](https://github.com/ashleykleynhans/app-manager)
* [CivitAI Downloader](https://github.com/ashleykleynhans/civitai-downloader)

## Available on RunPod

This image is designed to work on [RunPod](https://runpod.io?ref=2xxro4sy).
You can use my custom [RunPod template](
https://runpod.io/console/deploy?template=jqw8e1my59&ref=2xxro4sy)
to launch it on RunPod.

## Downloading models

```bash
cd /workspace/stable-diffusion-webui/models/Stable-diffusion
wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors
wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors
cd /workspace/stable-diffusion-webui/models/VAE
wget https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors
```

## Building the Docker image

> [!NOTE]
> You will need to edit the `docker-bake.hcl` file and update `REGISTRY_USER`,
> and `RELEASE`.  You can obviously edit the other values too, but these
> are the most important ones.

> [!IMPORTANT]
> In order to cache the models, you will need at least 32GB of CPU/system
> memory (not VRAM) due to the large size of the models.  If you have less
> than 32GB of system memory, you can comment out or remove the code in the
> `Dockerfile` that caches the models.

```bash
# Clone the repo
git clone https://github.com/ashleykleynhans/stable-diffusion-docker.git

# Download the models
cd stable-diffusion-docker
wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned.safetensors
wget https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors
wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors
wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors
wget https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors

# Log in to Docker Hub
docker login

# Build the image, tag the image, and push the image to Docker Hub
docker buildx bake -f docker-bake.hcl --push

# Same as above but customize registry/user/release:
REGISTRY=ghcr.io REGISTRY_USER=myuser RELEASE=my-release docker buildx \
    bake -f docker-bake.hcl --push
```

## Running Locally

### Install Nvidia CUDA Driver

- [Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)
- [Windows](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/index.html)

### Start the Docker container

```bash
docker run -d \
  --gpus all \
  -v /workspace \
  -p 2999:2999 \
  -p 3000:3001 \
  -p 3010:3011 \
  -p 3020:3021 \
  -p 6006:6066 \
  -p 7777:7777 \
  -p 8000:8000 \
  -p 8888:8888 \
  -p 9090:9090 \
  -e VENV_PATH=/workspace/venvs/a1111 \
  -e JUPYTER_PASSWORD=Jup1t3R! \
  -e ENABLE_TENSORBOARD=1 \
  ashleykza/stable-diffusion-webui:latest
```

You can obviously substitute the image name and tag with your own.

### Ports

| Connect Port | Internal Port | Description                   |
|--------------|---------------|-------------------------------|
| 3000         | 3001          | A1111 Stable Diffusion Web UI |
| 3010         | 3011          | Kohya_ss                      |
| 3020         | 3021          | ComfyUI                       |
| 9090         | 9090          | InvokeAI                      |
| 6006         | 6066          | Tensorboard                   |
| 7777         | 7777          | Code Server                   |
| 8000         | 8000          | Application Manager           |
| 8888         | 8888          | Jupyter Lab                   |
| 2999         | 2999          | Runpod File Uploader          |

### Environment Variables

| Variable             | Description                                      | Default                |
|----------------------|--------------------------------------------------|------------------------|
| VENV_PATH            | Set the path for the Python venv for the app     | /workspace/venvs/a1111 |
| JUPYTER_LAB_PASSWORD | Set a password for Jupyter lab                   | not set - no password  |
| DISABLE_AUTOLAUNCH   | Disable Web UIs from launching automatically     | (not set)              |
| DISABLE_SYNC         | Disable syncing if using a RunPod network volume | (not set)              |
| ENABLE_TENSORBOARD   | Enables Tensorboard on port 6006                 | enabled                |

## Logs

Stable Diffusion Web UI, Kohya SS, ComfyUI, and InvokeAI each
create log files, and you can tail the log files instead of
killing the services to view the logs

| Application             | Log file                     |
|-------------------------|------------------------------|
| Stable Diffusion Web UI | /workspace/logs/webui.log    |
| Kohya SS                | /workspace/logs/kohya_ss.log |
| ComfyUI                 | /workspace/logs/comfyui.log  |
| InvokeAI                | /workspace/logs/invokeai.log |

For example:

```bash
tail -f  /workspace/logs/webui.log
```

## Community and Contributing

Pull requests and issues on [GitHub](https://github.com/ashleykleynhans/stable-diffusion-docker)
are welcome. Bug fixes and new features are encouraged.

## Appreciate my work?

<a href="https://www.buymeacoffee.com/ashleyk" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
