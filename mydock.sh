#! /bin/bash

# make it small
defaults write com.apple.dock tilesize -integer 2

# put it at the bottom left
defaults write com.apple.dock pinning -string start
defaults write com.apple.dock orientation -string bottom

# set it to 2D mode
defaults write com.apple.dock no-glass -boolean YES

# set the max magnification size from 128 pixels to 160 pixels
defaults write com.apple.dock largesize -float 96

# show only active applications
defaults write com.apple.dock static-only -boolean true

# turn on "Suck" animation
defaults write com.apple.dock mineffect suck

# dim hidden applications
defaults write com.apple.dock showhidden -boolean true

# turn on/off autohide
defaults write com.apple.dock autohide -boolean false


killall Dock
