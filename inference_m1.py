"""
Simple inference script for M1 Macs
Usage:
    python inference_m1.py --input input_videos/input_video.mp4 --output output_green.mp4
"""

import torch
from model import MattingNetwork
from inference import convert_video

def main():
    import argparse

    parser = argparse.ArgumentParser(description='RobustVideoMatting inference for M1 Macs')
    parser.add_argument('--input', type=str, required=True, help='Input video path')
    parser.add_argument('--output', type=str, required=True, help='Output video path')
    parser.add_argument('--model', type=str, default='weights/rvm_mobilenetv3.pth',
                        help='Path to model weights')
    parser.add_argument('--variant', type=str, default='mobilenetv3',
                        choices=['mobilenetv3', 'resnet50'],
                        help='Model variant')
    parser.add_argument('--device', type=str, default='auto',
                        choices=['auto', 'mps', 'cpu'],
                        help='Device to use (auto will try mps first, then cpu)')
    args = parser.parse_args()

    # Determine device
    if args.device == 'auto':
        if torch.backends.mps.is_available():
            device = 'mps'
            print(f"Using Metal Performance Shaders (MPS) - GPU acceleration on M1")
        else:
            device = 'cpu'
            print(f"MPS not available, using CPU")
    else:
        device = args.device
        print(f"Using device: {device}")

    # Load model
    print(f"Loading model: {args.variant}")
    model = MattingNetwork(args.variant).eval().to(device)
    model.load_state_dict(torch.load(args.model, map_location=device))
    print(f"Model loaded from {args.model}")

    # Convert video
    print(f"Processing video: {args.input}")
    print(f"Output will be saved to: {args.output}")
    print(f"Background will be replaced with green screen")

    convert_video(
        model,
        input_source=args.input,
        output_type='video',
        output_composition=args.output,
        output_video_mbps=4,
        downsample_ratio=None,  # Auto-adjust
        seq_chunk=1,  # Process 1 frame at a time (safer for M1)
        device=device,
        dtype=torch.float32
    )

    print(f"\nDone! Output saved to: {args.output}")

if __name__ == '__main__':
    main()
