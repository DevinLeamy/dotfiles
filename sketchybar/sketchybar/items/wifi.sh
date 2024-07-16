sketchybar --add item wifi right                              \
           --set wifi    script="$PLUGIN_DIR/wifi.sh"          \
                        icon=                               \
                        label.padding_right=0                \
                        label.padding_left=0                 \
           --subscribe wifi wifi_change                        \
            