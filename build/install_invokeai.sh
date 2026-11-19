#!/usr/bin/env bash
set -e

# Create and activate venv
mkdir /InvokeAI
cd /InvokeAI
mkdir -p /venvs
python3 -m venv --system-site-packages /venvs/invokeai
source /venvs/invokeai/bin/activate

# Install torch and xformers
#
# These are installed explicitly rather than letting InvokeAI's dependency
# resolver pick them. Without a pin, pip resolves xformers>=0.0.28.post1 to
# the latest release (0.0.36), which requires torch>=2.10 and mslk. The mslk
# package on PyPI is only an empty placeholder, so xformers installs but
# xformers.ops.memory_efficient_attention is unavailable, breaking InvokeAI
# at startup:
#
#   AttributeError: xformers.ops.memory_efficient_attention ... because mslk
#   could not be imported: No module named 'mslk'
#
# Torch/xformers come from PyPI rather than ${INDEX_URL} because the cu124
# PyTorch index only goes up to torch 2.6.0, while InvokeAI requires
# torch>=2.7.0. torch 2.7.1 ships CUDA 12.6 wheels which run on the cu124
# image, and xformers 0.0.31.post1 is the matching release for that torch
# version.
pip3 install --no-cache-dir torch==${INVOKEAI_TORCH_VERSION} torchvision torchaudio==${INVOKEAI_TORCH_VERSION}
pip3 install --no-cache-dir xformers==${INVOKEAI_XFORMERS_VERSION}

# Install InvokeAI
pip3 install InvokeAI[xformers]==${INVOKEAI_VERSION} --use-pep517
pip3 cache purge
deactivate
