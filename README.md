# Stable Diffusion WebUI Podman

Run Stable Diffusion on your Radeon machine with a nice UI without any hassle!

NOTE:
- Only ROCm supported for now
- Supports AUTOMATIC1111 and ComfyUI
- CUDA support to be worked on later
- Requires podman-compose 1.1.0 or newer

## Setup & Usage

> Note: In progress

**Download necessary models**
```
podman-compose --profile download build
podman-compose --profile download up -d
```

**Run AUTOMATIC1111 Stable Diffusion Web UI**
```
podman-compose --profile auto build
podman-compose --profile auto up -d
```

**Create AUTOMATIC1111 Stable Diffusion Web UI Podman service**
```
podman generate systemd --new webui-docker_auto_1 > ~/.config/systemd/user/automatic1111.service
```

**Enable and run AUTOMATIC1111 Stable Diffusion Web UI Podman service**
```
systemctl --user enable --now automatic1111.service
```

You can change `--profile auto` to `--profile comfy` to change AUTOMATIC1111 to ComfyUI

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
- and many many more.
