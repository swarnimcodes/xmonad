#!/bin/env bash

INTERNAL="eDP-1"
EXTERNAL="HDMI-1"

if xrandr | grep "$EXTERNAL connected"; then
	xrandr --output "$INTERNAL" --primary --auto --output "$EXTERNAL" --auto --right-of "$INTERNAL"
else
	xrandr --output "$INTERNAL" --auto --primary --output "$EXTERNAL" --off
fi

