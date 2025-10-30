#!/bin/bash

# RobustVideoMatting - Easy Video Background Removal Script for M1 Mac
# Usage:
#   ./process_video.sh input.mp4                    # Specify input file
#   ./process_video.sh                               # Process all videos in input_videos/
#   ./process_video.sh input.mp4 custom_output.mp4  # Specify both input and output

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  RobustVideoMatting - M1 Video Background Removal${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if virtual environment exists
if [ ! -d ".venv" ]; then
    echo -e "${RED}Error: Virtual environment not found!${NC}"
    echo "Please run: python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements_inference_m1.txt"
    exit 1
fi

# Activate virtual environment
echo -e "${GREEN}✓ Activating virtual environment...${NC}"
source .venv/bin/activate

# Create output directory if it doesn't exist
mkdir -p output_videos

# Function to process a single video
process_video() {
    local input_file="$1"
    local output_file="$2"

    if [ ! -f "$input_file" ]; then
        echo -e "${RED}Error: Input file '$input_file' not found!${NC}"
        return 1
    fi

    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}Processing:${NC} $input_file"
    echo -e "${GREEN}Output:${NC}     $output_file"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    python inference_m1.py --input "$input_file" --output "$output_file"

    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✓ Success! Video saved to: $output_file${NC}"

        # Show file size
        if [ -f "$output_file" ]; then
            size=$(ls -lh "$output_file" | awk '{print $5}')
            echo -e "${GREEN}  File size: $size${NC}"
        fi
        echo ""
        return 0
    else
        echo -e "${RED}✗ Error processing video${NC}"
        return 1
    fi
}

# Main logic
if [ $# -eq 0 ]; then
    # No arguments - process all videos in input_videos/
    echo -e "${YELLOW}No input file specified. Processing all videos in input_videos/ folder...${NC}"
    echo ""

    if [ ! -d "input_videos" ]; then
        echo -e "${RED}Error: input_videos/ directory not found!${NC}"
        echo "Please create it and add your videos, or specify an input file:"
        echo "  ./process_video.sh your_video.mp4"
        exit 1
    fi

    # Find all video files
    video_count=0
    shopt -s nullglob
    for video in input_videos/*.mp4 input_videos/*.MP4 input_videos/*.mov input_videos/*.MOV input_videos/*.avi input_videos/*.AVI input_videos/*.mkv input_videos/*.MKV; do
        if [ -f "$video" ]; then
            filename=$(basename "$video")
            name="${filename%.*}"
            ext="${filename##*.}"
            output="output_videos/${name}_green.${ext}"

            process_video "$video" "$output"
            ((video_count++))
        fi
    done
    shopt -u nullglob

    if [ $video_count -eq 0 ]; then
        echo -e "${YELLOW}No video files found in input_videos/${NC}"
        echo "Supported formats: .mp4, .mov, .avi, .mkv"
        echo ""
        echo "Usage examples:"
        echo "  ./process_video.sh input_videos/my_video.mp4"
        echo "  ./process_video.sh my_video.mp4 output.mp4"
        exit 1
    fi

    echo -e "${GREEN}✓ Processed $video_count video(s)${NC}"

elif [ $# -eq 1 ]; then
    # One argument - input file specified
    input_file="$1"
    filename=$(basename "$input_file")
    name="${filename%.*}"
    ext="${filename##*.}"
    output_file="output_videos/${name}_green.${ext}"

    process_video "$input_file" "$output_file"

else
    # Two arguments - both input and output specified
    input_file="$1"
    output_file="$2"

    process_video "$input_file" "$output_file"
fi

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Done!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
