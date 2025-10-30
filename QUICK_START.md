# Quick Start - Video Background Removal on M1 Mac

## Super Simple Usage

### Option 1: Process a specific video
```bash
./process_video.sh input_videos/my_video.mp4
```
Output will be saved as `output_videos/my_video_green.mp4`

### Option 2: Process ALL videos in input_videos/ folder
```bash
./process_video.sh
```
All videos in `input_videos/` will be processed automatically!

### Option 3: Specify custom output name
```bash
./process_video.sh input_videos/my_video.mp4 my_custom_output.mp4
```

## Workflow

1. **Put your videos** in the `input_videos/` folder
2. **Run the script**: `./process_video.sh`
3. **Get your results** from the `output_videos/` folder with green screen backgrounds!

## Examples

```bash
# Process one video
./process_video.sh input_videos/vacation.mp4

# Process all videos in input_videos/ at once
./process_video.sh

# Custom output location
./process_video.sh my_video.mp4 ~/Desktop/output.mp4
```

## What You Get

- ✅ Background removed
- ✅ Green screen background (RGB: 120, 255, 155)
- ✅ M1 GPU acceleration (MPS)
- ✅ Same quality as original
- ✅ ~11-13 FPS processing speed

## Supported Formats

- MP4 (.mp4)
- MOV (.mov)
- AVI (.avi)
- MKV (.mkv)

## File Organization

```
RobustVideoMatting/
├── input_videos/          ← Put your videos here
│   ├── video1.mp4
│   └── video2.mp4
├── output_videos/         ← Processed videos appear here
│   ├── video1_green.mp4
│   └── video2_green.mp4
├── process_video.sh       ← Run this script
└── weights/
    └── rvm_mobilenetv3.pth
```

## Tips

- **Batch processing**: Drop multiple videos in `input_videos/` and run `./process_video.sh` to process them all
- **File naming**: Output files automatically get `_green` suffix
- **Progress**: You'll see a progress bar while processing
- **Speed**: First few frames are slower (model warmup), then speeds up to ~11-13 FPS

## Troubleshooting

### "Permission denied" error
Run: `chmod +x process_video.sh`

### Script not working
Make sure you're in the correct directory:
```bash
cd /Users/petr/Documents/vlog/RobustVideoMatting/RobustVideoMatting
./process_video.sh
```

### Out of memory
Close other applications or process shorter videos

## Advanced Usage

For more control (custom colors, alpha channel, etc.), see `README_M1.md`
