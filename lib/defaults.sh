# Descaga el repeat del teclado (no presentando opciones de acentuación)
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true # Trackpad: swipe between pages with three fingers
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 # Trackpad: enable tap to click for this user and for the login screen
defaults write NSGlobalDomain KeyRepeat -int 0 # Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true # Expand save panel by default
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false # Disable Resume system-wide
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1


defaults write com.apple.dock autohide -bool true # Automatically hide the Dock
# defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock launchanim -bool true
defaults write com.apple.dock magnification -int 1
defaults write com.apple.dock showhidden -bool true

defaults write com.apple.finder NewWindowTarget -string 'PfHm'
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true # Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true # Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true # Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowPathbar 1
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true # Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowStatusBar -bool true # Finder: show status bar


defaults read com.apple.menuextra.battery ShowPercent -string "YES" # Show remaining battery time; hide percentage
defaults write com.apple.menuextra.battery ShowTime -string "NO" # Show remaining battery time; hide percentage


defaults write com.apple.Safari IncludeDevelopMenu -bool true # Enable the Develop menu and the Web Inspector in Safari


defaults write com.apple.screensaver askForPassword -int 1 # Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPasswordDelay -int 0 # Require password immediately after sleep or screen saver begins


defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d h:mm a"

echo "

Algunas de estas madres requieren que hagas logout y login, btw

"