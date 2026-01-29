#!/bin/bash

set -Eeuo pipefail

mkdir -vp /data/config/comfy/custom_nodes

declare -A MOUNTS

MOUNTS["/root/.cache"]="/data/.cache"
MOUNTS["${ROOT}/input"]="/data/config/comfy/input"
MOUNTS["${ROOT}/custom_nodes"]="/data/config/comfy/custom_nodes"
MOUNTS["${ROOT}/my_workflows"]="/data/config/comfy/my_workflows"
MOUNTS["${ROOT}/output"]="/output/comfy"
MOUNTS["${ROOT}/user"]="/data/config/comfy/user"

for to_path in "${!MOUNTS[@]}"; do
  set -Eeuo pipefail
  from_path="${MOUNTS[${to_path}]}"
  rm -rf "${to_path}"
  if [ ! -f "$from_path" ]; then
    mkdir -vp "$from_path"
  fi
  mkdir -vp "$(dirname "${to_path}")"
  ln -sT "${from_path}" "${to_path}"
  echo Mounted $(basename "${from_path}")
done

# --- Helper function to handle install safely ---
# This prevents the container from crashing if a requirements.txt is missing
install_node() {
    local DIR="/data/config/comfy/custom_nodes/$1"
    local REPO="$2"
    
    if [ -z "$(ls -A $DIR 2>/dev/null)" ]; then
        git -C /data/config/comfy/custom_nodes clone "$REPO" "$1" --recursive
    else
        git -C "$DIR" pull
    fi

    if [ -f "$DIR/requirements.txt" ]; then
        echo "Installing requirements for $1..."
        pip install -r "$DIR/requirements.txt"
    fi
}

# --- Node Installations (Refactored for cleaner reading) ---

install_node "ComfyUI_UltimateSDUpscale" "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
# install_node "comfyui-workspace-manager" "https://github.com/11cafe/comfyui-workspace-manager.git"

install_node "ComfyUI-GGUF" "https://github.com/city96/ComfyUI-GGUF.git"

install_node "ComfyUI-WanVideoWrapper" "https://github.com/kijai/ComfyUI-WanVideoWrapper.git"

install_node "ComfyUI-TeaCache" "https://github.com/welltop-cn/ComfyUI-TeaCache.git"

install_node "ComfyUI-nunchaku" "https://github.com/nunchaku-tech/ComfyUI-nunchaku.git"

# ComfyUI-Long-CLIP doesn't seem to have a requirements.txt in your original script, but using the function is safe.
install_node "ComfyUI-Long-CLIP" "https://github.com/SeaArtLab/ComfyUI-Long-CLIP.git"

install_node "ComfyUI-FramePackWrapper" "https://github.com/kijai/ComfyUI-FramePackWrapper.git"

install_node "ComfyUI-KJNodes" "https://github.com/kijai/ComfyUI-KJNodes.git"

install_node "ComfyUI-VideoHelperSuite" "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git"

install_node "ComfyUI_essentials" "https://github.com/cubiq/ComfyUI_essentials.git"

# install_node "comfyui_HiDream-Sampler" "https://github.com/lum3on/comfyui_HiDream-Sampler.git"
if [ -f "/data/config/comfy/startup.sh" ]; then
  pushd ${ROOT}
  . /data/config/comfy/startup.sh
  popd
fi

exec "$@"
