# Stage 1: Base
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04 as base

ARG WEBUI_VERSION=af617748aa27692947ce7e908ee9841ae72336e0
ARG DREAMBOOTH_COMMIT=cf086c536b141fc522ff11f6cffc8b7b12da04b9
ARG KOHYA_VERSION=v21.8.10

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Africa/Johannesburg \
    PYTHONUNBUFFERED=1 \
    SHELL=/bin/bash

# Create workspace working directory
WORKDIR /

# Install Ubuntu packages
RUN apt update && \
    apt -y upgrade && \
    apt install -y --no-install-recommends \
    build-essential \
    software-properties-common \
    python3.10-venv \
    python3-pip \
    python3-tk \
    python3-dev \
    nodejs \
    npm \
    bash \
    dos2unix \
    git \
    git-lfs \
    ncdu \
    nginx \
    net-tools \
    inetutils-ping \
    openssh-server \
    libglib2.0-0 \
    libsm6 \
    libgl1 \
    libxrender1 \
    libxext6 \
    ffmpeg \
    wget \
    curl \
    psmisc \
    rsync \
    vim \
    zip \
    unzip \
    p7zip-full \
    htop \
    pkg-config \
    plocate \
    libcairo2-dev \
    libgoogle-perftools4 \
    libtcmalloc-minimal4 \
    apt-transport-https \
    ca-certificates && \
    update-ca-certificates && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

# Set Python
RUN ln -s /usr/bin/python3.10 /usr/bin/python

# Install Torch, xformers and tensorrt
RUN pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
    pip3 install --no-cache-dir xformers==0.0.21 tensorrt

# Stage 2: Install applications
FROM base as setup

RUN mkdir -p /sd-models

# Add SD models and VAE
# These need to already have been downloaded:
#   wget https://civitai.com/api/download/models/15236 -O deliberate_v2.safetensors
#   wget https://civitai.com/api/download/models/114076 -O matrixVAE_v30.pt
COPY deliberate_v2.safetensors /sd-models/deliberate_v2.safetensors
COPY matrixVAE_v30.pt /sd-models/matrixVAE_v30.pt

# Clone the git repo of the Stable Diffusion Web UI by Automatic1111
# and set version
WORKDIR /
RUN git clone https://github.com/RuKapSan/stable-diffusion-webui && \
    cd /stable-diffusion-webui && \
    git checkout ${WEBUI_VERSION}

WORKDIR /stable-diffusion-webui
RUN python3 -m venv --system-site-packages /venv && \
    source /venv/bin/activate && \
    pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
    pip install --no-cache-dir xformers && \
    deactivate

# Install the dependencies for the Automatic1111 Stable Diffusion Web UI
COPY a1111/requirements.txt a1111/requirements_versions.txt ./
COPY a1111/cache-sd-model.py a1111/install-automatic.py ./
RUN source /venv/bin/activate && \
    python -m install-automatic --skip-torch-cuda-test && \
    deactivate

# Cache the Stable Diffusion Models
RUN source /venv/bin/activate && \
    python3 cache-sd-model.py --use-cpu=all --ckpt /sd-models/deliberate_v2.safetensors && \
    deactivate

# Clone the Automatic1111 Extensions
RUN git clone https://github.com/d8ahazard/sd_dreambooth_extension.git extensions/sd_dreambooth_extension && \
    git clone --depth=1 https://github.com/deforum-art/sd-webui-deforum.git extensions/deforum && \
    git clone --depth=1 https://github.com/Mikubill/sd-webui-controlnet.git extensions/sd-webui-controlnet && \
    git clone --depth=1 https://github.com/ashleykleynhans/a1111-sd-webui-locon.git extensions/a1111-sd-webui-locon && \
    git clone --depth=1 https://github.com/Bing-su/adetailer.git extensions/adetailer && \
    git clone --depth=1 https://github.com/BlafKing/sd-civitai-browser-plus.git extensions/sd-civitai-browser-plus && \
    git clone --depth=1 https://github.com/RuKapSan/stable-diffusion-webui-rembg.git extensions/stable-diffusion-webui-rembg && \
    git clone --depth=1 https://github.com/RuKapSan/stable-diffusion-webui-vectorstudio.git extensions/sd-vectorstudio



# Install dependencies for Deforum, ControlNet, vectorstudio, civitAI and After Detailer extensions
RUN source /venv/bin/activate && \
    cd /stable-diffusion-webui/extensions/deforum && \
    pip3 install -r requirements.txt && \
    cd /stable-diffusion-webui/extensions/sd-webui-controlnet && \
    pip3 install -r requirements.txt && \
    deactivate

RUN source /venv/bin/activate && \
    cd /stable-diffusion-webui/extensions/sd-vectorstudio && \
    pip3 install -r requirements.txt && \
    cd /stable-diffusion-webui/extensions/adetailer && \
    python -m install && \
    deactivate

RUN source /venv/bin/activate && \
    cd /stable-diffusion-webui/extensions/stable-diffusion-webui-rembg && \
    pip3 install rembg onnxruntime pymatting pooch && \
    deactivate

# Set Dreambooth extension version
WORKDIR /stable-diffusion-webui/extensions/sd_dreambooth_extension
RUN git checkout main && \
    git reset ${DREAMBOOTH_COMMIT} --hard

# Install the dependencies for the Dreambooth extension
WORKDIR /stable-diffusion-webui
COPY a1111/requirements_dreambooth.txt ./requirements.txt
RUN source /venv/bin/activate && \
    cd /stable-diffusion-webui/extensions/sd_dreambooth_extension && \
    pip3 install -r requirements.txt && \
    deactivate

# Fix Tensorboard
RUN source /venv/bin/activate && \
    pip3 uninstall -y tensorboard tb-nightly && \
    pip3 install tensorboard tensorflow && \
    pip3 cache purge && \
    deactivate

# Install Kohya_ss
RUN git clone https://github.com/bmaltais/kohya_ss.git /kohya_ss
WORKDIR /kohya_ss
RUN git checkout ${KOHYA_VERSION} && \
    python3 -m venv --system-site-packages venv && \
    source venv/bin/activate && \
    pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
    pip3 install --no-cache-dir xformers==0.0.21 \
    bitsandbytes==0.41.1 \
    tensorboard==2.12.3 \
    tensorflow==2.12.0 \
    wheel \
    tensorrt && \
    pip3 install -r requirements.txt && \
    pip3 install . && \
    pip3 cache purge && \
    deactivate

# Install ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI
WORKDIR /ComfyUI
RUN python3 -m venv --system-site-packages venv && \
    source venv/bin/activate && \
    pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
    pip3 install --no-cache-dir xformers==0.0.21 && \
    pip3 install -r requirements.txt && \
    pip3 cache purge && \
    deactivate

# Install ComfyUI Custom Nodes
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager

# Install Application Manager
WORKDIR /
RUN git clone https://github.com/ashleykleynhans/app-manager.git /app-manager && \
    cd /app-manager && \
    npm install

# Install Jupyter
WORKDIR /
RUN pip3 install -U --no-cache-dir jupyterlab \
    jupyterlab_widgets \
    ipykernel \
    ipywidgets \
    gdown

# Install rclone
RUN curl https://rclone.org/install.sh | bash

# Install runpodctl
RUN wget https://github.com/runpod/runpodctl/releases/download/v1.10.0/runpodctl-linux-amd -O runpodctl && \
    chmod a+x runpodctl && \
    mv runpodctl /usr/local/bin

# Install croc
RUN curl https://getcroc.schollz.com | bash

# Install speedtest CLI
RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
    apt install speedtest

# Install CivitAI Model Downloader
RUN git clone --depth=1 https://github.com/ashleykleynhans/civitai-downloader.git && \
    mv civitai-downloader/download.sh /usr/local/bin/download-model && \
    chmod +x /usr/local/bin/download-model

# Copy Stable Diffusion Web UI config files
COPY a1111/relauncher.py a1111/webui-user.sh a1111/config.json a1111/ui-config.json /stable-diffusion-webui/

# ADD SD styles.csv
ADD https://raw.githubusercontent.com/RuKapSan/SD-styles/main/styles.csv /stable-diffusion-webui/styles.csv

ADD https://civitai.com/api/download/models/64596 /sd-models/Lora/Color_Icons.safetensors
ADD https://civitai.com/api/download/models/96612 /sd-models/Lora/flaticon_v1_2.safetensors
ADD https://civitai.com/api/download/models/61877 /sd-models/Lora/logo_v1-000012.safetensors
ADD https://civitai.com/api/download/models/55466 /sd-models/Lora/logogotypes.safetensors


# Copy ComfyUI Extra Model Paths (to share models with A1111)
COPY comfyui/extra_model_paths.yaml /ComfyUI/

# NGINX Proxy
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/502.html /usr/share/nginx/html/502.html
COPY nginx/README.md /usr/share/nginx/html/README.md

WORKDIR /

# Copy the scripts
COPY --chmod=755 pre_start.sh start.sh fix_venv.sh download.sh ./

# Copy the accelerate configuration
COPY kohya_ss/accelerate.yaml ./

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]