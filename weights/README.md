# Model Weights

**⚠️ Important:** Model weights are NOT included in this repository to keep the repo size small. You must download them separately.

## Download Links

Download the model weights from the official RobustVideoMatting releases:

### MobileNetV3 (Recommended)
Best balance of speed and quality. Recommended for most use cases.

- **PyTorch (.pth)**: [rvm_mobilenetv3.pth](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_mobilenetv3.pth) (15 MB)
- **TorchScript FP32**: [rvm_mobilenetv3_fp32.torchscript](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_mobilenetv3_fp32.torchscript) (15 MB)
- **TorchScript FP16**: [rvm_mobilenetv3_fp16.torchscript](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_mobilenetv3_fp16.torchscript) (8 MB)
- **ONNX FP32**: [rvm_mobilenetv3_fp32.onnx](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_mobilenetv3_fp32.onnx) (15 MB)
- **ONNX FP16**: [rvm_mobilenetv3_fp16.onnx](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_mobilenetv3_fp16.onnx) (8 MB)

### ResNet50 (Higher Quality)
Larger model with slightly better quality. Slower than MobileNetV3.

- **PyTorch (.pth)**: [rvm_resnet50.pth](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_resnet50.pth) (97 MB)
- **TorchScript FP32**: [rvm_resnet50_fp32.torchscript](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_resnet50_fp32.torchscript) (97 MB)
- **TorchScript FP16**: [rvm_resnet50_fp16.torchscript](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_resnet50_fp16.torchscript) (49 MB)
- **ONNX FP32**: [rvm_resnet50_fp32.onnx](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_resnet50_fp32.onnx) (97 MB)
- **ONNX FP16**: [rvm_resnet50_fp16.onnx](https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_resnet50_fp16.onnx) (49 MB)

## Installation Methods

### Method 1: Direct Download (Easiest)

Click the links above to download directly via your browser, then move the file to this `weights/` directory.

### Method 2: Command Line (macOS/Linux)

```bash
# Navigate to weights directory
cd weights

# Download MobileNetV3 (recommended)
curl -L -O https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_mobilenetv3.pth

# Or download ResNet50
curl -L -O https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_resnet50.pth
```

### Method 3: wget

```bash
cd weights
wget https://github.com/PeterL1n/RobustVideoMatting/releases/download/v1.0.0/rvm_mobilenetv3.pth
```

## For M1 Mac Users

For M1/M2/M3 Macs, we recommend:
- **MobileNetV3 PyTorch (.pth)** - Best performance with MPS acceleration
- Use the `inference_m1.py` script or `process_video.sh` for automatic device detection

## Verify Download

After downloading, verify the file is in the correct location:

```bash
ls -lh weights/
```

You should see:
```
-rw-r--r--  15M  rvm_mobilenetv3.pth
```

## Alternative Mirrors

If GitHub releases are slow, models are also available on:
- [Google Drive](https://drive.google.com/drive/folders/1pBsG-SCTatv-95SnEuxmnvvlRx208VKj?usp=sharing)
- [Baidu Pan](https://pan.baidu.com/s/1puPSxQqgBFOVpW4W7AolkA) (code: gym7)

## Note

These weights are from the official [RobustVideoMatting repository](https://github.com/PeterL1n/RobustVideoMatting) and are licensed under GPL-3.0.
