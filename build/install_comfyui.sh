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

# Patch comfy-kitchen's custom-op annotations so they work with torch < 2.7.
# comfy-kitchen 0.2.28+ (pinned by ComfyUI) uses builtin list[int]/
# list[bool] annotations, which torch 2.6.0 (used by the cu124 images) cannot
# infer (ValueError: Parameter ... has unsupported type list[int]). Initially
# only na.py's na3d op was affected (v0.31.0), but 0.2.33 (ComfyUI v0.35.0)
# adds sol_attn with sink_blocks/sink_q: list[int] which hits the same
# failure. Patch every .py under comfy_kitchen that uses list[int]/list[bool]
# to use typing.List instead, keeping the package version unchanged so
# ComfyUI's version-compatibility check stays happy. torch >= 2.7 (the cu128
# images) handles builtin generics natively and is left unpatched.
TORCH_MAJOR_MINOR="${COMFYUI_TORCH_VERSION%+*}"
TORCH_MINOR="${TORCH_MAJOR_MINOR#*.}"
if [ "${TORCH_MAJOR_MINOR%%.*}" -lt 2 ] || { [ "${TORCH_MAJOR_MINOR%%.*}" -eq 2 ] && [ "${TORCH_MINOR%%.*}" -lt 7 ]; }; then
python3 - <<'EOF'
from pathlib import Path
import sys

roots = list(Path("/ComfyUI/venv").glob("lib/python3.*/site-packages/comfy_kitchen"))
if not roots:
    sys.stderr.write("comfy-kitchen not found; skipping patch\n")
    sys.exit(0)

patched = 0
for root in roots:
    for path in root.rglob("*.py"):
        src = path.read_text()
        orig = src
        if "list[int]" in src or "list[bool]" in src or "list[float]" in src or "list[str]" in src:
            if "import typing" not in src:
                if "import torch\n" in src:
                    src = src.replace("import torch\n", "import typing\n\nimport torch\n", 1)
                else:
                    src = "import typing\n" + src
            src = src.replace("list[int]", "typing.List[int]")
            src = src.replace("list[bool]", "typing.List[bool]")
            src = src.replace("list[float]", "typing.List[float]")
            src = src.replace("list[str]", "typing.List[str]")
        if src != orig:
            path.write_text(src)
            patched += 1
            print(f"patched {path}")

if patched == 0:
    # Fallback: at least ensure the known eager files are covered even if
    # rglob missed due to layout differences.
    for rel in ["backends/eager/na.py", "backends/eager/sol_attn.py"]:
        for root in roots:
            p = root / rel
            if p.exists():
                print(f"checked {p} (already handled)")

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
