# Docker image for A1111 Stable Diffusion Web UI, Kohya_ss and ComfyUI

## Installs

* Ubuntu 22.04 LTS
* CUDA 11.8
* Python 3.10.12
* [Automatic1111 Stable Diffusion Web UI](
  https://github.com/AUTOMATIC1111/stable-diffusion-webui.git) 1.6.0
* [Dreambooth extension](
  https://github.com/d8ahazard/sd_dreambooth_extension) 1.0.14
* [Deforum extension](
  https://github.com/deforum-art/sd-webui-deforum)
* [ControlNet extension](
  https://github.com/Mikubill/sd-webui-controlnet) v1.1.410
* [After Detailer extension](
  https://github.com/Bing-su/adetailer) v23.9.2
* [Locon extension](
  https://github.com/ashleykleynhans/a1111-sd-webui-locon)
* [Kohya_ss](https://github.com/bmaltais/kohya_ss) v21.8.10
* [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
* [ComfyUI Manager](https://github.com/ltdrdata/ComfyUI-Manager.git)
* Torch 2.0.1
* xformers 0.0.21
* deliberate_v2.safetensors
* vae-ft-mse-840000-ema-pruned.safetensors
* [runpodctl](https://github.com/runpod/runpodctl)
* [croc](https://github.com/schollz/croc)
* [rclone](https://rclone.org/)
* [Application Manager](https://github.com/ashleykleynhans/app-manager)

## Available on RunPod

This image is designed to work on [RunPod](https://runpod.io?ref=2xxro4sy).
You can use my custom [RunPod template](
https://runpod.io/gsc?template=ya6013lj5a&ref=2xxro4sy)
to launch it on RunPod.

## Building the Docker image

Since the Stable Diffusion models are pretty large, you will need at least
8GB of system memory (not GPU VRAM) to build this image.

The image **CAN** be built on a `t3a.large` AWS EC2 instance
which has 2 x vCPU and 8GB of system memory.  It **CANNOT** be built on
any instances with less memory, eg. `t3a.medium`.

```bash
# Clone the repo
git clone https://github.com/RuKapSan/stable-diffusion-docker.git

# Download the models
cd stable-diffusion-docker
wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned.safetensors
wget https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors
wget https://civitai.com/api/download/models/156110

# Build and tag the image
docker build -t username/image-name:1.0.0 .

# Log in to Docker Hub
docker login

# Push the image to Docker Hub
docker push username/image-name:1.0.0
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
  -p 3000:3001 \
  -p 3010:3011 \
  -p 3020:3021 \
  -p 6006:6066 \
  -p 8888:8888 \
  -e JUPYTER_PASSWORD=Jup1t3R! \
  -e ENABLE_TENSORBOARD=1 \
  ashleykza/stable-diffusion-webui:3.1.0
```


