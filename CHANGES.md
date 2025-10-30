# Changes from Original Repository

This fork adds Apple Silicon (M1/M2/M3) Mac compatibility to RobustVideoMatting.

## Summary

The original repository uses PyTorch 1.9.0 (from 2021), which doesn't support Apple Silicon Macs. This fork updates dependencies to enable native M1/M2/M3 support with GPU acceleration via Metal Performance Shaders (MPS).

## Modified Files

### `inference_utils.py`
**Lines changed:** Added import, modified VideoWriter class

**Changes:**
- Added `from fractions import Fraction` import
- Modified `VideoWriter.__init__()` to convert `frame_rate` to `Fraction` object
- Reason: Required for compatibility with PyAV (av) library >=10.0.0

**Code change:**
```python
# Before:
self.stream = self.container.add_stream('h264', rate=frame_rate)

# After:
if isinstance(frame_rate, (int, float)):
    frame_rate = Fraction(frame_rate).limit_denominator()
self.stream = self.container.add_stream('h264', rate=frame_rate)
```

### `.gitignore`
**New entries added:**
- `weights/*.pth` - Exclude model weight files
- `weights/*.torchscript` - Exclude TorchScript models
- `weights/*.onnx` - Exclude ONNX models
- `.venv/` - Exclude virtual environment
- `input_videos/` - Exclude input video files
- `output_videos/` - Exclude output video files
- `__pycache__/` - Exclude Python cache
- `*.pyc` - Exclude compiled Python files
- `.DS_Store` - Exclude macOS system files

### `README.md`
**Changes:**
- Added M1 Mac compatibility notice at top
- Added "M1 Mac Installation" section
- Added links to M1-specific documentation

## New Files

### `requirements_inference_m1.txt`
M1-compatible dependency specifications:
- `torch>=2.0.0` (updated from 1.9.0) - Includes MPS support
- `torchvision>=0.15.0` (updated from 0.10.0)
- `av>=10.0.0` (updated from 8.0.3)
- `tqdm>=4.61.1` (unchanged)
- `pims>=0.5` (unchanged)

**Reason:** PyTorch 2.x includes Metal Performance Shaders (MPS) backend for Apple Silicon GPU acceleration.

### `inference_m1.py`
Simplified inference script specifically for M1 Macs.

**Features:**
- Auto-detects and uses MPS (Apple GPU) when available
- Falls back to CPU if MPS unavailable
- Simple command-line interface
- Clear progress feedback

**Usage:**
```bash
python inference_m1.py --input video.mp4 --output output.mp4
```

### `process_video.sh`
Bash convenience script for batch processing.

**Features:**
- Auto-activates virtual environment
- Batch processes all videos in `input_videos/` folder
- Supports MP4, MOV, AVI, MKV formats
- Colored terminal output with progress bars
- Error handling and user-friendly messages

**Usage:**
```bash
# Process all videos in input_videos/
./process_video.sh

# Process specific video
./process_video.sh input_videos/my_video.mp4

# Custom output
./process_video.sh input.mp4 output.mp4
```

### Documentation Files

#### `README_M1.md`
Comprehensive guide for M1 Mac users including:
- Installation instructions
- Usage examples
- Performance expectations
- Troubleshooting tips
- Advanced options

#### `QUICK_START.md`
Quick reference guide with:
- 3 simple usage modes
- Workflow examples
- File organization
- Supported formats

#### `HOW_TO_USE.txt`
Plain-text quick reference card for terminal viewing.

#### `CHANGES.md` (this file)
Complete documentation of all changes from original repository.

### `weights/README.md`
Instructions for downloading model weights with direct links to official releases.

## Performance on M1 Macs

With these changes, users can expect:
- **~12 FPS** processing speed with MPS (GPU acceleration)
- **~3-5 FPS** with CPU-only mode
- Full compatibility with macOS Monterey (12.x) and later
- Native Apple Silicon execution (no Rosetta required)

## Why These Changes?

Apple Silicon Macs (M1, M2, M3) use ARM architecture instead of x86. The original repository's dependencies were compiled for x86 and don't support:
1. ARM architecture
2. Metal Performance Shaders (Apple's GPU framework)
3. Modern PyAV library versions on macOS

These changes make the project fully compatible with Apple Silicon while maintaining backward compatibility with the original codebase.

## Testing

Tested on:
- MacBook Pro M1 (2021)
- macOS Sonoma 14.x
- Python 3.9.6

## License

This fork maintains the original **GPL-3.0** license. All modifications are open source and freely available.

## Attribution

Original project: [RobustVideoMatting](https://github.com/PeterL1n/RobustVideoMatting) by PeterL1n

Paper: "Robust High-Resolution Video Matting with Temporal Guidance" (WACV 2022)

## Contributing

If you find issues or have improvements for M1 compatibility, please open an issue or pull request!
