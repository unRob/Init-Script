# Algunas ideas de https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Descaga el repeat del teclado (no presentando opciones de acentuación)
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true # Trackpad: swipe between pages with three fingers
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain KeyRepeat -int 0
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true # Expand save panel by default
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false # Disable Resume system-wide
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Teclado rápido
defaults write NSGlobalDomain KeyRepeat -int 0


# Set highlight a rosita (254,194,220)
R=${"$((254/255.0))"[0,8]}
G=${"$((194/255.0))"[0,8]}
B=${"$((220/255.0))"[0,8]}
defaults write NSGlobalDomain AppleHighlightColor -string "$R $G $B"


# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true


# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"
# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true


# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

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
