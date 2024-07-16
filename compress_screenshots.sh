# Note: AI generated code:

# # #!/bin/sh

# # # Check if the correct number of arguments are provided
# # if [ "$#" -ne 2 ]; then
# #     echo "Usage: $0 input_directory output_directory"
# #     exit 1
# # fi

# # # Assign input and output directories from arguments
# # INPUT_DIR="$1"
# # OUTPUT_DIR="$2"

# # # Create the output directory if it doesn't exist
# # mkdir -p "$OUTPUT_DIR"

# # # Convert PNG to AVIF
# # IFS=$(printf '\n\b')
# # for file in "$INPUT_DIR"/*.png; do
# #   if [ -f "$file" ]; then
# #     avifenc -j all "$file" "$OUTPUT_DIR/$(basename "${file%.*}.avif")"
# #     # exiftool -overwrite_original -TagsFromFile "$file" "$OUTPUT_DIR/$(basename "${file%.*}.avif")"
# #   fi
# # done

# # # Compress videos to H.265 (HEVC) using ffmpeg
# # for file in "$INPUT_DIR"/*; do
# #   case "$file" in
# #     *.mov|*.mp4)
# #       if [ -f "$file" ]; then
# #         ffmpeg -i "$file" -vcodec hevc -acodec aac "$OUTPUT_DIR/$(basename "${file%.*}.mp4")"
# #         # exiftool -overwrite_original -TagsFromFile "$file" "$OUTPUT_DIR/$(basename "${file%.*}.mp4")"
# #       fi
# #       ;;
# #   esac
# # done

# # # Copy other files
# # for file in "$INPUT_DIR"/*; do
# #   case "$file" in
# #     *.jpg|*.jpeg|*.gif|*.avi)
# #       if [ -f "$file" ]; then
# #         cp "$file" "$OUTPUT_DIR/"
# #         # exiftool -overwrite_original -TagsFromFile "$file" "$OUTPUT_DIR/$(basename "$file")"
# #       fi
# #       ;;
# #   esac
# # done

# #!/bin/bash

# input_file="test.mov"

# # Convert to H.264 (MP4) in background
# ffmpeg -i "$input_file" -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k output_h264.mp4
# # 28s

# # Convert to H.265 (HEVC) in background
# ffmpeg -i "$input_file" -c:v libx265 -crf 28 -preset medium -c:a aac -b:a 128k output_h265.mp4
# # 

# # Convert to VP9 (WebM) in background
# ffmpeg -i "$input_file" -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libvorbis -b:a 128k output_vp9.webm

# # Convert to AV1 (Matroska) in background
# ffmpeg -i "$input_file" -c:v libaom-av1 -crf 30 -b:v 0 -c:a libopus -b:a 128k output_av1.mkv

# # Wait for all background processes to complete
# # wait

# echo "All conversions completed."


#!/bin/sh

# brew install handbrake
# brew install libavif

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_directory output_directory"
    exit 1
fi

# Assign input and output directories from arguments
INPUT_DIR="$1"
OUTPUT_DIR="$2"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Initialize a counter for the number of items processed
ITEMS_PROCESSED=0

# Process all files in the input directory
IFS=$(printf '\n\b')
for file in "$INPUT_DIR"/*; do
    if [ -f "$file" ]; then
        case "$(basename "$file" | tr 'A-Z' 'a-z')" in
            *.png|*.jpg|*.jpeg)
                if ! avifenc -j all "$file" "$OUTPUT_DIR/$(basename "${file%.*}.avif")" > /dev/null 2>&1; then
                    echo "Error processing image: $(basename "$file")"
                else
                    ITEMS_PROCESSED=$((ITEMS_PROCESSED+1))
                    echo "Processed image: $(basename "$file") ($ITEMS_PROCESSED)"
                fi
                ;;
            *.mov|*.mp4)
                if ! HandBrakeCLI --input "$file" \
                                  --output "$OUTPUT_DIR/$(basename "${file%.*}.mp4")" \
                                  --encoder vt_h265 \
                                  --encoder-preset quality \
                                  --quality 40 \
                                  --vfr \
                                  --rate 30 \
                                  --format av_mp4 \
                                  --width 1920 \
                                  --height 1080 > /dev/null 2>&1; then
                    echo "Error processing video: $(basename "$file")"
                else
                    ITEMS_PROCESSED=$((ITEMS_PROCESSED+1))
                    echo "Processed video: $(basename "$file") ($ITEMS_PROCESSED)"
                fi
                ;;
            *)
                # Copy file as-is and print a message
                cp "$file" "$OUTPUT_DIR/"
                ITEMS_PROCESSED=$((ITEMS_PROCESSED+1))
                echo "Copied as-is: $(basename "$file") ($ITEMS_PROCESSED)"
                ;;
        esac
    fi
done

# Print the total number of items processed
echo "Total items processed: $ITEMS_PROCESSED"
