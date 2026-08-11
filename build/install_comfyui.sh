#!/usr/bin/env bash
set -e

# Clone the repo
git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI
cd /ComfyUI
git checkout ${COMFYUI_VERSION}

# Create and activate the venv
python3 -m venv --system-site-packages venv
source venv/bin/activate

# Install torch and xformers
pip3 install --no-cache-dir torch==${COMFYUI_TORCH_VERSION} torchvision torchaudio --index-url ${INDEX_URL}
pip3 install --no-cache-dir xformers==${COMFYUI_XFORMERS_VERSION} --index-url ${INDEX_URL}

# Install requirements
pip3 install -r requirements.txt
pip3 install accelerate
pip3 install sageattention==1.0.6
pip install setuptools --upgrade

# Patch comfy-kitchen's na3d custom op annotations so it works with torch < 2.7.
# comfy-kitchen 0.2.28 (pinned by ComfyUI v0.31.0) uses builtin list[int]/
# list[bool] annotations, which torch 2.6.0 (used by the cu124 images) cannot
# infer. Only na.py is affected; swapping in typing.List keeps the version at
# 0.2.28 so ComfyUI's version-compatibility check stays happy. torch >= 2.7
# handles builtin generics natively and needs no patch.
TORCH_MAJOR_MINOR="${COMFYUI_TORCH_VERSION%+*}"
TORCH_MINOR="${TORCH_MAJOR_MINOR#*.}"
if [ "${TORCH_MAJOR_MINOR%%.*}" -lt 2 ] || { [ "${TORCH_MAJOR_MINOR%%.*}" -eq 2 ] && [ "${TORCH_MINOR%%.*}" -lt 7 ]; }; then
python3 - <<'EOF'
from pathlib import Path
import sys

matches = list(Path("/ComfyUI/venv").glob("lib/python3.*/site-packages/comfy_kitchen/backends/eager/na.py"))
if not matches:
    sys.stderr.write("comfy-kitchen na.py not found; skipping patch\n")
    sys.exit(0)

path = matches[0]
src = path.read_text()
src = src.replace("import torch\n", "import typing\n\nimport torch\n", 1)
src = src.replace("kernel_size: list[int]", "kernel_size: typing.List[int]")
src = src.replace("is_causal: list[bool]", "is_causal: typing.List[bool]")
path.write_text(src)
EOF
fi

# Install ComfyUI Custom Nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager
cd custom_nodes/ComfyUI-Manager
pip3 install -r requirements.txt
pip3 cache purge

# Align numpy with what scipy/xformers require (>=2.0,<2.8)
pip3 install "numpy>=2.0,<2.8"
pip3 cache purge
deactivate
