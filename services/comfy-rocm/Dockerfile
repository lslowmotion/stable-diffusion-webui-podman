FROM rocm/pytorch:rocm6.3.2_ubuntu24.04_py3.12_pytorch_release_2.4.0

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update && apt-get install -y git cargo nasm && apt-get clean

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip,Z \
  git clone --recursive https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git checkout tags/v0.3.14 && \
  pip install torchsde numpy>=1.25.0 einops transformers>=4.28.1 tokenizers>=0.13.3 sentencepiece safetensors>=0.4.2 aiohttp pyyaml Pillow scipy tqdm psutil kornia>=0.7.1 spandrel soundfile && \
  # pip install -r requirements.txt && \
  # pip install --pre --force-reinstall torch torchvision torchaudio numpy==1.26.4 --index-url https://download.pytorch.org/whl/nightly/rocm6.3 && \
  pip list

# INSTALL GGUF
RUN --mount=type=cache,target=/root/.cache/pip,Z \
pip install --upgrade gguf

WORKDIR ${ROOT}
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh && cp /docker/extra_model_paths.yaml ${ROOT}

ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python -u main.py --listen --port 7860 ${CLI_ARGS}
