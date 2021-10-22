#!/usr/bin/env bash

mapper=$(cat <<-JSON
def dockTile(tiles): tiles | map({
      "tile-type": .["tile-type"],
      "tile-data": {
        "bundle-identifier": .["tile-data"]["bundle-identifier"],
        "dock-extra": .["tile-data"]["dock-extra"],
        "file-label": .["tile-data"]["file-label"],
        "file-type": .["tile-data"]["file-type"],
        url: .["tile-data"]["file-data"]._CFURLString,
        showas: (.["tile-data"].showas // null),
        arrangement: (.["tile-data"].arrangement // null),
        displayas: (.["tile-data"].displayas // null),
      } | del(.[] | select(. == null))
    });
{
  "payload-type": "com.apple.dock",
  "payload-display-name": "Dock",
  "payload-description": "Configures the dock",
  "payload-version": 1,
  "payload-identifier": "mx.rob.personal-computar.dock",
  "payload-UUID": "",
  "orientation": (.orientation // "botom"),
  "autohide": (.autohide // true),
  "magnification": (.magnification // true),
  "largesize": (.largesize // 70),
  "launchanim": (.launchanim // 1),
  "magnification": (.magnification // 1),
  "persistent-apps": dockTile(.["persistent-apps"]),
  "persistent-others": dockTile(.["persistent-others"])
}
JSON
)

defaults read com.apple.dock |
  plutil -convert xml1 -o - - |
  sed '/<data>/,/<\/data>/d;/<key>book<\/key>/d' |
  plutil -convert json -o - - |
  jq "$mapper" |
  ruby -ryaml -rjson -e 'puts JSON.parse(ARGF.read).to_yaml'
