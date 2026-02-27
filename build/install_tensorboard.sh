#!/usr/bin/env bash
set -e

# Install tensorboard into its own venv to avoid polluting system-site-packages
python3 -m venv /venvs/tensorboard
source /venvs/tensorboard/bin/activate
pip3 install tensorboard==2.15.2 tensorflow==2.15.0.post1
pip3 cache purge
deactivate
