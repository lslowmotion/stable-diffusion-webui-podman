#!/bin/bash

set -Eeuo pipefail

mkdir -vp /data/config/comfy/custom_nodes

declare -A MOUNTS

MOUNTS["/root/.cache"]="/data/.cache"
MOUNTS["${ROOT}/input"]="/data/config/comfy/input"
MOUNTS["${ROOT}/custom_nodes"]="/data/config/comfy/custom_nodes"
MOUNTS["${ROOT}/my_workflows"]="/data/config/comfy/my_workflows"
MOUNTS["${ROOT}/output"]="/output/comfy"

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

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI_UltimateSDUpscale)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive
else
  git -C /data/config/comfy/custom_nodes/ComfyUI_UltimateSDUpscale pull
fi

if [ -z "$(ls -A /data/config/comfy/custom_nodes/comfyui-workspace-manager)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/11cafe/comfyui-workspace-manager.git
else
  git -C /data/config/comfy/custom_nodes/comfyui-workspace-manager pull
fi

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI-GGUF)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/city96/ComfyUI-GGUF.git
else
  git -C /data/config/comfy/custom_nodes/ComfyUI-GGUF pull
fi

pip install -r /data/config/comfy/custom_nodes/ComfyUI-GGUF/requirements.txt

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI-WanVideoWrapper)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
else
  git -C /data/config/comfy/custom_nodes/ComfyUI-WanVideoWrapper pull
fi

pip install -r /data/config/comfy/custom_nodes/ComfyUI-WanVideoWrapper/requirements.txt

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI-TeaCache)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/welltop-cn/ComfyUI-TeaCache.git
else
  git -C /data/config/comfy/custom_nodes/ComfyUI-TeaCache pull
fi

pip install -r /data/config/comfy/custom_nodes/ComfyUI-TeaCache/requirements.txt

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI-nunchaku)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/nunchaku-tech/ComfyUI-nunchaku.git ComfyUI-nunchaku
else
  git -C /data/config/comfy/custom_nodes/ComfyUI-nunchaku pull
fi

pip install -r /data/config/comfy/custom_nodes/ComfyUI-nunchaku/requirements.txt

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI-Long-CLIP)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/SeaArtLab/ComfyUI-Long-CLIP.git
else
  git -C /data/config/comfy/custom_nodes/ComfyUI-Long-CLIP pull
fi

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI-FramePackWrapper)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/kijai/ComfyUI-FramePackWrapper.git
else
  git -C /data/config/comfy/custom_nodes/ComfyUI-FramePackWrapper pull
fi

pip install -r /data/config/comfy/custom_nodes/ComfyUI-FramePackWrapper/requirements.txt

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI-KJNodes)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/kijai/ComfyUI-KJNodes.git
else
  git -C /data/config/comfy/custom_nodes/ComfyUI-KJNodes pull
fi

pip install -r /data/config/comfy/custom_nodes/ComfyUI-KJNodes/requirements.txt

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI-VideoHelperSuite)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
else
  git -C /data/config/comfy/custom_nodes/ComfyUI-VideoHelperSuite pull
fi

pip install -r /data/config/comfy/custom_nodes/ComfyUI-VideoHelperSuite/requirements.txt

if [ -z "$(ls -A /data/config/comfy/custom_nodes/ComfyUI_essentials)" ]; then
  git -C /data/config/comfy/custom_nodes clone https://github.com/cubiq/ComfyUI_essentials.git
else
  git -C /data/config/comfy/custom_nodes/ComfyUI_essentials pull
fi

pip install -r /data/config/comfy/custom_nodes/ComfyUI_essentials/requirements.txt

# if [ -z "$(ls -A /data/config/comfy/custom_nodes/comfyui_HiDream-Sampler)" ]; then
#   git -C /data/config/comfy/custom_nodes clone https://github.com/lum3on/comfyui_HiDream-Sampler.git
# else
#   git -C /data/config/comfy/custom_nodes/comfyui_HiDream-Sampler pull
# fi

# pip install -r /data/config/comfy/custom_nodes/comfyui_HiDream-Sampler/requirements.txt

if [ -f "/data/config/comfy/startup.sh" ]; then
  pushd ${ROOT}
  . /data/config/comfy/startup.sh
  popd
fi

exec "$@"
