# RobustVideoMatting on M1 Mac - Quick Start Guide

This guide explains how to run RobustVideoMatting on Apple Silicon (M1/M2/M3) Macs.

## What Was Fixed

The original project requirements specified old PyTorch versions (1.9.0) that don't support M1 Macs. The following changes were made:

1. **Updated dependencies** - Created `requirements_inference_m1.txt` with PyTorch 2.x that supports Apple Silicon MPS (Metal Performance Shaders)
2. **Fixed VideoWriter** - Updated `inference_utils.py` to work with newer `av` library versions
3. **Created M1-friendly script** - Created `inference_m1.py` that automatically detects and uses MPS for GPU acceleration

## Installation

All dependencies are already installed in the `.venv` virtual environment. If you need to reinstall:

```bash
source .venv/bin/activate
pip install -r requirements_inference_m1.txt
```

## Usage

### Basic Usage - Green Screen Background

```bash
source .venv/bin/activate
python inference_m1.py --input input_videos/input_video.mp4 --output output_green.mp4
```

### Custom Options

```bash
python inference_m1.py \
    --input path/to/input.mp4 \
    --output path/to/output.mp4 \
    --model weights/rvm_mobilenetv3.pth \
    --variant mobilenetv3 \
    --device auto  # Options: auto, mps, cpu
```

### Options Explained

- `--input`: Path to your input video
- `--output`: Path for the output video with green screen background
- `--model`: Path to model weights (default: weights/rvm_mobilenetv3.pth)
- `--variant`: Model variant - mobilenetv3 or resnet50 (default: mobilenetv3)
- `--device`: Device to use:
  - `auto` (default): Automatically uses MPS if available, falls back to CPU
  - `mps`: Force use of M1 GPU acceleration
  - `cpu`: Force use of CPU only

## Performance

On M1 Mac, you can expect:
- **With MPS (GPU)**: ~11-13 frames per second
- **With CPU only**: ~3-5 frames per second

MPS provides significant speedup by utilizing the M1's GPU.

## Custom Background Color

To change the background color from green to another color, you can edit `inference.py` line 115:

```python
# Current (green): RGB(120, 255, 155)
bgr = torch.tensor([120, 255, 155], device=device, dtype=dtype).div(255).view(1, 1, 3, 1, 1)

# For blue: RGB(0, 0, 255)
bgr = torch.tensor([0, 0, 255], device=device, dtype=dtype).div(255).view(1, 1, 3, 1, 1)

# For pure green: RGB(0, 255, 0)
bgr = torch.tensor([0, 255, 0], device=device, dtype=dtype).div(255).view(1, 1, 3, 1, 1)
```

## Advanced Usage

For more control (e.g., outputting alpha matte, foreground only, or using image sequences), use the original inference script with the `mps` device:

```bash
python inference.py \
    --variant mobilenetv3 \
    --checkpoint weights/rvm_mobilenetv3.pth \
    --device mps \
    --input-source input_videos/input_video.mp4 \
    --output-type video \
    --output-composition composition.mp4 \
    --output-alpha alpha.mp4 \
    --output-foreground foreground.mp4 \
    --output-video-mbps 4 \
    --seq-chunk 1
```

## Troubleshooting

### "MPS backend not available"
If you see this error, your Mac might not support MPS, or you're running an older macOS. Use `--device cpu` instead.

### Out of Memory Errors
If you encounter memory errors:
1. Try using `--device cpu` instead of MPS
2. Close other applications to free up memory
3. Process shorter video clips

### Slow Processing
- Make sure you're using `--device auto` or `--device mps` to use GPU acceleration
- The first few frames are slower as the model warms up
- Expected speed: 11-13 FPS on M1 with MPS

## Files Modified for M1 Compatibility

1. `requirements_inference_m1.txt` - New M1-compatible requirements
2. `inference_utils.py` - Updated VideoWriter for newer av library
3. `inference_m1.py` - New simplified inference script for M1
