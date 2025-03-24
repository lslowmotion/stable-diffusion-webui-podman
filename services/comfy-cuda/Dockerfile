# FROM pytorch/pytorch:2.6.0-cuda12.6-cudnn9-runtime
# FROM nvcr.io/nvidia/pytorch:25.02-py3
FROM ghcr.io/pytorch/pytorch-nightly:2.8.0.dev20250323-cuda12.8-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update && apt-get install -y git cargo nasm && apt-get clean

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip,Z \
  git clone --recursive https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git checkout tags/v0.3.27 && \
  pip install -r requirements.txt && \
  # pip install torchsde numpy>=1.25.0 einops transformers>=4.28.1 tokenizers>=0.13.3 sentencepiece safetensors>=0.4.2 aiohttp pyyaml Pillow scipy tqdm psutil kornia>=0.7.1 spandrel soundfile && \
  pip list

# INSTALL GGUF
RUN --mount=type=cache,target=/root/.cache/pip,Z \
  pip install --upgrade gguf

WORKDIR ${ROOT}
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh && cp /docker/extra_model_paths.yaml ${ROOT}

ENV NVIDIA_VISIBLE_DEVICES=all PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python -u main.py --listen --port 7860 ${CLI_ARGS}
