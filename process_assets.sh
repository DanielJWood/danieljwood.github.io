#!/bin/bash

# by default this only processes new files
# if you want to update an existing file, delete the output first
# instructions for how to use this are in the README

# best practices: https://github.com/nprapps/bestpractices/blob/master/assets.md

# set to "error" to suppress logs
ffmpeg_log="error"

# convert images
# requires ImageMagick 7
cd files
mkdir -p resized
for img in *.jpg; do
  if [ ! -f resized/$img ]; then
    echo "Processing $img..."
    magick $img -resize 1600x1200\> -quality 75 -strip -sampling-factor 4:2:0 -define jpeg:dct-method=float -interlace Plane resized/$img;
  fi
done
for img in *.png; do
  if [ ! -f resized/$img ]; then
    echo "Processing $img..."
    magick $img -resize 1600x1200\> \
      -define png:compression-filter=5 \
      -define png:compression-level=9 \
      resized/$img;
  fi
done
for img in *.jpeg; do
  if [ ! -f resized/$img ]; then
    echo "Processing $img..."
    magick $img -resize 1600x1200\> \
      -define png:compression-filter=5 \
      -define png:compression-level=9 \
      resized/$img;
  fi
done

# handle silenced video
mkdir -p resized
for video in *.mp4; do
  # create the videos
  if [ ! -f resized/$video ]; then
    echo "Processing $video..."
    ffmpeg -n -nostats -hide_banner -loglevel $ffmpeg_log \
    -i $video \
    -an \
    -vcodec libx264 \
    -preset veryslow \
    -strict -2 \
    -pix_fmt yuv420p \
    -crf 25 \
    -vf scale=1600:-2 \
    -movflags +faststart \
    resized/$video;
  fi

  if [ ! -f resized/mobile-$video ]; then
    echo "Processing mobile version of $video..."
    ffmpeg -n -nostats -hide_banner -loglevel $ffmpeg_log \
    -i $video \
    -an \
    -vcodec libx264 \
    -preset veryslow \
    -strict -2 \
    -pix_fmt yuv420p \
    -crf 25 \
    -vf scale=800:-2 \
    -movflags +faststart \
    resized/mobile-$video;
  fi

  # create posters
  if [ ! -f resized/$video.jpg ]; then
    echo "Processing poster image for $video..."
    ffmpeg -n -nostats -hide_banner -loglevel $ffmpeg_log \
    -i $video \
    -vf scale=1600:-2 \
    -qscale:v 4 \
    -frames:v 1 \
    resized/$video.jpg;
  fi
done

for video in *.mov *.mp4; do
  # Get the file extension
  ext="${video##*.}"

  # If it's a .mov file, convert it to .mp4
  if [ "$ext" = "mov" ]; then
    mp4_video="${video%.mov}.mp4"
    if [ ! -f "$mp4_video" ]; then
      echo "Converting $video to $mp4_video..."
      ffmpeg -n -nostats -hide_banner -loglevel $ffmpeg_log \
      -i "$video" \
      -vcodec libx264 \
      -preset veryslow \
      -strict -2 \
      -pix_fmt yuv420p \
      -crf 25 \
      -movflags +faststart \
      "$mp4_video"
    fi
    # Use the converted .mp4 file for further processing
    video="$mp4_video"
  fi
  
  # Create resized videos
  if [ ! -f resized/$video ]; then
    echo "Processing $video..."
    ffmpeg -n -nostats -hide_banner -loglevel $ffmpeg_log \
    -i "$video" \
    -an \
    -vcodec libx264 \
    -preset veryslow \
    -strict -2 \
    -pix_fmt yuv420p \
    -crf 25 \
    -vf scale=1600:-2 \
    -movflags +faststart \
    resized/"$video"
  fi

  if [ ! -f resized/mobile-$video ]; then
    echo "Processing mobile version of $video..."
    ffmpeg -n -nostats -hide_banner -loglevel $ffmpeg_log \
    -i "$video" \
    -an \
    -vcodec libx264 \
    -preset veryslow \
    -strict -2 \
    -pix_fmt yuv420p \
    -crf 25 \
    -vf scale=800:-2 \
    -movflags +faststart \
    resized/mobile-"$video"
  fi

  # Create posters
  if [ ! -f resized/$video.jpg ]; then
    echo "Processing poster image for $video..."
    ffmpeg -n -nostats -hide_banner -loglevel $ffmpeg_log \
    -i "$video" \
    -vf scale=1600:-2 \
    -qscale:v 4 \
    -frames:v 1 \
    resized/"$video".jpg
  fi
done

# convert audio
cd ../audio
mkdir -p resized
for audio in *.mp3; do
  # create the audio
  if [ ! -f resized/$audio ]; then
    echo "Processing $audio..."
    lame -m s -b 96 $audio resized/$audio;
  fi
done

# convert ai2html images
cd ../ai-img
mkdir -p resized
for img in *.jpg; do
  if [ ! -f resized/$img ]; then
    echo "Processing $img..."
    magick $img -resize 1600x1600\> -quality 75 -strip -sampling-factor 4:2:0 -define jpeg:dct-method=float -interlace Plane resized/$img;
  fi
done

# convert thumbnails
cd ../thumbnails
mkdir -p resized
for img in *.jpg; do
  if [ ! -f resized/$img ]; then
    echo "Processing $img..."
    magick $img -resize 800x800\> -quality 70 -strip -sampling-factor 4:2:0 -define jpeg:dct-method=float -interlace Plane resized/$img;
  fi
done

# for img in *.jpeg; do
#   echo "Processing $img..."
#   # if [ ! -f $img ]; then
#     magick $img -resize 600x600\> -quality 75 -strip -sampling-factor 4:2:0 -define jpeg:dct-method=float -interlace Plane resized/$img;
#   # fi
# done
