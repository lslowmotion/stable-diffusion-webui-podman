FROM docker.io/rocm/pytorch:rocm7.0_ubuntu22.04_py3.10_pytorch_release_2.8.0

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update && apt-get install -y git cargo nasm && apt-get clean

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip,Z \
  git clone --recursive https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  # AMD performance workaround. See https://github.com/comfyanonymous/ComfyUI/pull/10302
  git checkout a125cd84b054a57729b5eecab930ca9408719832 && \
  pip install -r requirements.txt && \
  pip list

# INSTALL GGUF
RUN --mount=type=cache,target=/root/.cache/pip,Z \
pip install --upgrade gguf

# INSTALL VARIOUS NECESSARY PACKAGE
RUN --mount=type=cache,target=/root/.cache/pip,Z \
pip install sageattention onnx onnxruntime

WORKDIR ${ROOT}
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh && cp /docker/extra_model_paths.yaml ${ROOT}

ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD TORCH_ROCM_AOTRITON_ENABLE_EXPERIMENTAL=1 python -u main.py --listen --use-pytorch-cross-attention --port 7860 ${CLI_ARGS}
