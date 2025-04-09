#!/usr/bin/env bash

id=$(hyprctl -j activeworkspace | jq ".id")
rid="r[$id-$id]"

gaps_in_default=$(hyprctl getoption general:gaps_in -j | jq -r ".custom" | sed "s/ .*//")
gaps_out_default=$(hyprctl getoption general:gaps_out -j | jq -r ".custom" | sed "s/ .*//")
border_size=$(hyprctl getoption general:border_size -j | jq -r ".int")
rounding=$(hyprctl getoption decoration:rounding -j | jq -r ".int")

gaps_in_current=$(hyprctl workspacerules -j | jq --arg rid "$rid" '[.[] | select(.workspaceString | startswith($rid)) | .gapsIn[0]] | .[0]')
gaps_out_current=$(hyprctl workspacerules -j | jq --arg rid "$rid" '[.[] | select(.workspaceString | startswith($rid)) | .gapsOut[0]] | .[0]')

if [[ ("$gaps_in_current" == "null" && "$gaps_out_current" == "null") ||
      ("$gaps_in_current" == "$gaps_in_default" && "$gaps_out_current" == "$gaps_out_default") ]]; then
    hyprctl keyword workspace $rid f[1], gapsin:0, gapsout:0
    hyprctl keyword workspace $rid w[tv1], gapsin:0, gapsout:0
    hyprctl keyword windowrulev2 "bordersize 0, floating:0, onworkspace:$id"
    hyprctl keyword windowrulev2 "rounding 0, floating:0, onworkspace:$id"
else
    hyprctl keyword workspace $rid f[1], gapsin:$gaps_in_default, gapsout:$gaps_out_default
    hyprctl keyword workspace $rid w[tv1], gapsin:$gaps_in_default, gapsout:$gaps_out_default
    hyprctl keyword windowrulev2 "bordersize $border_size, floating:0, onworkspace:$id"
    hyprctl keyword windowrulev2 "rounding $rounding, floating:0, onworkspace:$id"
fi

hyprctl dispatch workspace 10
hyprctl dispatch workspace $id
