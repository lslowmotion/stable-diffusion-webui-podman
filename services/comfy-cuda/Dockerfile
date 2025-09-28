FROM ghcr.io/pytorch/pytorch:2.8.0-cuda12.9-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update && apt-get install -y git cargo nasm ffmpeg libsm6 libxext6 && apt-get clean

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip,Z \
  git clone --recursive https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git checkout tags/v0.3.60 && \
  pip install -r requirements.txt && \
  pip list

# INSTALL NUNCHAKU SVDQUANT SUPPORT
RUN --mount=type=cache,target=/root/.cache/pip,Z \
  pip install https://huggingface.co/nunchaku-tech/nunchaku/resolve/main/nunchaku-1.0.0+torch2.8-cp311-cp311-linux_x86_64.whl

# INSTALL GGUF
RUN --mount=type=cache,target=/root/.cache/pip,Z \
  pip install --upgrade gguf

# INSTALL cv2, matplotlib
RUN --mount=type=cache,target=/root/.cache/pip,Z \
pip install opencv-python-headless matplotlib

# INSTALL sageattention
RUN --mount=type=cache,target=/root/.cache/pip,Z \
pip install sageattention

# INSTALL apex
RUN --mount=type=cache,target=/root/.cache/pip,Z \
pip install apex

# INSTALL xformers
# RUN --mount=type=cache,target=/root/.cache/pip,Z \
# pip install -U xformers --index-url https://download.pytorch.org/whl/cu129

WORKDIR ${ROOT}
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh && cp /docker/extra_model_paths.yaml ${ROOT}

ENV NVIDIA_VISIBLE_DEVICES=all PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python -u main.py --listen --port 7860 ${CLI_ARGS}
