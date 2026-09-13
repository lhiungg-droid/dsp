#!/bin/bash
set -e

echo "=== Generate App Icons ==="

if [ ! -f www/icon.svg ]; then
  echo "www/icon.svg tidak ditemukan, skip icon generation"
  exit 0
fi

mkdir -p www/icons

# PWA icons
rsvg-convert -w 1024 -h 1024 www/icon.svg -o www/icons/icon-1024.png
rsvg-convert -w 512 -h 512 www/icon.svg -o www/icons/icon-512.png
rsvg-convert -w 192 -h 192 www/icon.svg -o www/icons/icon-192.png
rsvg-convert -w 144 -h 144 www/icon.svg -o www/icons/icon-144.png
rsvg-convert -w 96 -h 96 www/icon.svg -o www/icons/icon-96.png
rsvg-convert -w 72 -h 72 www/icon.svg -o www/icons/icon-72.png

# Android mipmap dirs
MIPMAP=android/app/src/main/res
mkdir -p $MIPMAP/mipmap-mdpi
mkdir -p $MIPMAP/mipmap-hdpi
mkdir -p $MIPMAP/mipmap-xhdpi
mkdir -p $MIPMAP/mipmap-xxhdpi
mkdir -p $MIPMAP/mipmap-xxxhdpi
mkdir -p $MIPMAP/mipmap-anydpi-v26
mkdir -p $MIPMAP/values

# Standard launcher icons
rsvg-convert -w 48  -h 48  www/icon.svg -o $MIPMAP/mipmap-mdpi/ic_launcher.png
rsvg-convert -w 48  -h 48  www/icon.svg -o $MIPMAP/mipmap-mdpi/ic_launcher_round.png
rsvg-convert -w 72  -h 72  www/icon.svg -o $MIPMAP/mipmap-hdpi/ic_launcher.png
rsvg-convert -w 72  -h 72  www/icon.svg -o $MIPMAP/mipmap-hdpi/ic_launcher_round.png
rsvg-convert -w 96  -h 96  www/icon.svg -o $MIPMAP/mipmap-xhdpi/ic_launcher.png
rsvg-convert -w 96  -h 96  www/icon.svg -o $MIPMAP/mipmap-xhdpi/ic_launcher_round.png
rsvg-convert -w 144 -h 144 www/icon.svg -o $MIPMAP/mipmap-xxhdpi/ic_launcher.png
rsvg-convert -w 144 -h 144 www/icon.svg -o $MIPMAP/mipmap-xxhdpi/ic_launcher_round.png
rsvg-convert -w 192 -h 192 www/icon.svg -o $MIPMAP/mipmap-xxxhdpi/ic_launcher.png
rsvg-convert -w 192 -h 192 www/icon.svg -o $MIPMAP/mipmap-xxxhdpi/ic_launcher_round.png

# Adaptive icon foreground
rsvg-convert -w 108 -h 108 www/icon.svg -o $MIPMAP/mipmap-mdpi/ic_launcher_foreground.png
rsvg-convert -w 162 -h 162 www/icon.svg -o $MIPMAP/mipmap-hdpi/ic_launcher_foreground.png
rsvg-convert -w 216 -h 216 www/icon.svg -o $MIPMAP/mipmap-xhdpi/ic_launcher_foreground.png
rsvg-convert -w 324 -h 324 www/icon.svg -o $MIPMAP/mipmap-xxhdpi/ic_launcher_foreground.png
rsvg-convert -w 432 -h 432 www/icon.svg -o $MIPMAP/mipmap-xxxhdpi/ic_launcher_foreground.png

# Adaptive icon XML
cat > $MIPMAP/mipmap-anydpi-v26/ic_launcher.xml <<'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
XMLEOF

cp $MIPMAP/mipmap-anydpi-v26/ic_launcher.xml $MIPMAP/mipmap-anydpi-v26/ic_launcher_round.xml

# Colors XML
cat > $MIPMAP/values/colors.xml <<'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#0a0b0d</color>
</resources>
XMLEOF

echo "=== Ikon berhasil di-generate ==="
ls -lh $MIPMAP/mipmap-xxxhdpi/
