#! /usr/bin/env bash
# cf: https://github.com/kevinSuttle/macOS-Defaults/blob/master/.macos

# ============================================================================
# Init
# ============================================================================
# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ============================================================================

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Disable window animations and Get info animations.
defaults write com.apple.finder DisableAllAnimations -bool true

# Disable Workspace Change animation
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES && killall Dock

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# ============================================================================
# Dock, Dashboard, and hot corners
# ============================================================================

# Enable highlight hover effect for the grid view of a stack (Dock)
# defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 36 pixels
# defaults write com.apple.dock tilesize -int 36

# Change minimize/maximize window effect
# defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when seting up a new Mac, or if you don’t use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
#defaults write com.apple.dock static-only -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false
