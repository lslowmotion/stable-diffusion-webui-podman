# Stable Diffusion WebUI Podman

Run Stable Diffusion web browser accessible UI on your CUDA/ROCm machine without any hassle!

NOTE:
- Supports AUTOMATIC1111 and ComfyUI
- Supports CUDA and ROCm
- Supports SD 1.5 and SDXL for AUTOMATIC1111 and ComfyUI
- Supports SD 3 and 3.5 for ComfyUI
- Supports FLUX.1-dev GGUF for ComfyUI
- Requires podman-compose 1.1.0 or newer

## Quick Setup

**Download necessary models**
```
podman-compose --profile download build
podman-compose --profile download up
```

**Run AUTOMATIC1111 Stable Diffusion Web UI with CUDA support**
```
podman-compose --profile auto-cuda build
podman-compose --profile auto-cuda up -d
```

**You can change `--profile auto-cuda` to different profile:**

| Profile    | Description |
|--------------|---------------------------------|
| `auto-cuda`    | AUTOMATIC1111 with CUDA support |
| `auto-rocm`    | AUTOMATIC1111 with ROCm support |
| `comfyui-cuda` | ComfyUI with CUDA support       |
| `comfyui-rocm` | ComfyUI with ROCm support       |

## Set the container as systemd service to allow running on user login

**Create AUTOMATIC1111 Stable Diffusion Web UI Podman service**

Find the name of the running container

```
podman ps
```

Set the container as systemd service. E.g. for container named `webui-podman_auto_1`:

```
podman generate systemd --new webui-podman_auto_1 > ~/.config/systemd/user/automatic1111.service
```

**Enable and run AUTOMATIC1111 Stable Diffusion Web UI Podman service**
```
systemctl --user enable --now automatic1111.service
```

## Stable Diffusion 3

**Download models here:**
[Stable Diffusion 3 on HuggingFace](https://huggingface.co/stabilityai/stable-diffusion-3-medium)

**Put SD3 models here:**
```
/data/models/Stable-diffusion
```

**Put SD3 text encoders here:**
```
/data/models/CLIPEncoder
```

## Stable Diffusion 3.5 GGUF

**Download models here:**

[Stable Diffusion 3.5 large GGUF by city96 on HuggingFace](https://huggingface.co/city96/stable-diffusion-3.5-large-gguf)

[Stable Diffusion 3.5 medium GGUF by city96 on HuggingFace](https://huggingface.co/city96/stable-diffusion-3.5-medium-gguf)

**Put SD3.5 GGUF models here:**
```
/data/models/unet
```

**Download SD3.5 VAE here:**
[Stable Diffusion 3.5 VAE on HuggingFace](https://huggingface.co/stabilityai/stable-diffusion-3.5-large/blob/main/vae/diffusion_pytorch_model.safetensors)

**Put SD3.5 VAE here:**
```
/data/models/VAE
```

## FLUX.1 GGUF

By default, this will download the Q3_K_S quantization. But you can download different quantization for both FLUX.1-dev GGUF model and text encoder.

**Download different quantization here:**

[FLUX.1-dev GGUF models](https://huggingface.co/city96/FLUX.1-dev-gguf/tree/main)

[Text encoder](https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/tree/main)

You will also need to download VAE manually because of HuggingFace login requirements.

**Download VAE here:**
[FLUX.1-dev VAE](https://huggingface.co/black-forest-labs/FLUX.1-dev/blob/main/ae.safetensors)

**Put FLUX.1 VAE here:**
```
/data/models/VAE
```

## Features

This repository provides multiple UIs for you to play around with stable diffusion:

### [AUTOMATIC1111](https://github.com/AUTOMATIC1111/stable-diffusion-webui)

[Full feature list here](https://github.com/AUTOMATIC1111/stable-diffusion-webui-feature-showcase), Screenshots:

| Text to image                                                                                              | Image to image                                                                                             | Extras                                                                                                     |
| ---------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| ![](https://user-images.githubusercontent.com/24505302/189541954-46afd772-d0c8-4005-874c-e2eca40c02f2.jpg) | ![](https://user-images.githubusercontent.com/24505302/189541956-5b528de7-1b5d-479f-a1db-d3f5a53afc59.jpg) | ![](https://user-images.githubusercontent.com/24505302/189541957-cf78b352-a071-486d-8889-f26952779a61.jpg) |

### [ComfyUI](https://github.com/comfyanonymous/ComfyUI)

[Full feature list here](https://github.com/comfyanonymous/ComfyUI#features), Screenshot:

| Workflow                                                                         |
| -------------------------------------------------------------------------------- |
| ![](https://github.com/comfyanonymous/ComfyUI/raw/master/comfyui_screenshot.png) |

## Contributing

Contributions are welcome! **Create a discussion first of what the problem is and what you want to contribute (before you implement anything)**

## Disclaimer

The authors of this project are not responsible for any content generated using this interface.

This license of this software forbids you from sharing any content that violates any laws, produce any harm to a person, disseminate any personal information that would be meant for harm, spread misinformation and target vulnerable groups. For the full list of restrictions please read [the license](./LICENSE).

## Thanks

Special thanks to everyone behind these awesome projects, without them, none of this would have been possible:

- [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui)
- [InvokeAI](https://github.com/invoke-ai/InvokeAI)
- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [CompVis/stable-diffusion](https://github.com/CompVis/stable-diffusion)
- [Sygil-webui](https://github.com/Sygil-Dev/sygil-webui)
- [AbdBarho/stable-diffusion-webui-docker](https://github.com/AbdBarho/stable-diffusion-webui-docker)
- [city96/ComfyUI-GGUF](https://github.com/city96/ComfyUI-GGUF)
- [city96 GGUF models](https://huggingface.co/city96)
- [zer0int/CLIP-GmP-ViT-L-14](https://huggingface.co/zer0int/CLIP-GmP-ViT-L-14/tree/main)
- and many many more.
