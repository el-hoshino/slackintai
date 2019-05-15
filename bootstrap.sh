#!/bin/sh

# Setup Brews
echo "Install Brews"
brew bundle

# Download Carthage cache via Rome
echo "Download Carthage binaries cache via Rome"
rome download --platform macOS

# Install dependencies via Carthage
echo "Install dependencies via Carthage"
carthage bootstrap --no-use-binaries --cache-builds --platform macos

# Upload Carthage cache via Rome if needed
echo "Upload Carthage binaries cache via Rome if needed"
rome list --missing --platform macos | awk '{print $1}' |
xargs rome upload --platform macos

# Setup finished
echo "Enjoy Programming!"

# Open workspace
open slackintai.xcworkspace
