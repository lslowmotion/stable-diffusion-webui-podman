FROM intel/intel-extension-for-pytorch:2.6.10-xpu

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update && apt-get install -y git cargo nasm && apt-get clean

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip,Z \
  git clone --recursive https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git checkout tags/v0.3.19 && \
  pip install -r requirements.txt && \
  pip list

# INSTALL GGUF
RUN --mount=type=cache,target=/root/.cache/pip,Z \
pip install --upgrade gguf

WORKDIR ${ROOT}
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh && cp /docker/extra_model_paths.yaml ${ROOT}


ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""

# I have no idea about these Arc specific env
ENV SYCL_CACHE_PERSISTENT=1 SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1 ZES_ENABLE_SYSMAN=1

EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python -u main.py --listen --port 7860 ${CLI_ARGS}
