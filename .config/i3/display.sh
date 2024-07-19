#!/bin/sh

if xrandr | grep "DisplayPort-1 connected"; then
  xrandr --newmode "3840x2160_29.56"  333.75  3840 4080 4488 5136  2160 2163 2168 2199 -hsync +vsync && \
    xrandr --newmode "1920x1200_60.00"  193.25  1920 2056 2256 2592  1200 1203 1209 1245 -hsync +vsync && \
    xrandr --addmode DisplayPort-0 "3840x2160_29.56" && \
    xrandr --addmode DisplayPort-1 "3840x2160_29.56" && \
    xrandr --addmode eDP "1920x1200_60.00" && \
    xrandr --dpi 120 --output DisplayPort-1 --mode 3840x2160_29.56 --scale 1x1 --above eDP --auto
elif xrandr | grep "HDMI-A-0 connected"
then
  xrandr --dpi 96 --output eDP --primary --auto --right-of HDMI-A-0
fi

redshift -P -O 4700 && \
feh --bg-center --bg-fill ~/Wallpapers/wall.jpg && \
xset s off -dpms

