{ lib
, writeShellApplication
, util-linux
, firmware
}:

writeShellApplication {
  name = "flash";

  runtimeInputs = [
    util-linux
  ];

  text = ''
    available() {
        lsblk -Sno path,model | grep -F 'nRF UF2' | cut -d' ' -f1
    }

    mounted() {
        findmnt "$device" -no target
    }

    flash_part() {
        local part="$1"
        
        echo -n "Double tap reset and plug in$([ -n "$part" ] && echo " the '$part' part of") the keyboard via USB"
        while ! device="$(available)"; do
            echo -n .
            sleep 3
        done
        echo

        sleep 1

        mountpoint="$(mounted)"
        if [ -z "$mountpoint" ]; then
            echo -n "Please mount the mass storage device at $device so that the firmware file can be copied"
            while ! mountpoint="$(mounted)"; do
                echo -n .
                sleep 1
            done
        fi
        echo
            
        cp ${firmware}/*"$([ -n "$part" ] && echo "_$part")".uf2 "$mountpoint"
    }

    # Set default part to "all" if not specified
    part="all"

    # Check if the "part" argument is provided
    if [ $# -gt 0 ]; then
        part="$1"
    fi

    # Flash the specified part or all parts based on the provided argument
    case "$part" in
        "left")
            flash_part "left"
            ;;
        "right")
            flash_part "right"
            ;;
        "all")
            for part in ${toString firmware.parts or ''""''}; do
                flash_part "$part"
            done
            ;;
        *)
            echo "Invalid part option. Available options are: left, right, all."
            exit 1
            ;;
    esac
  '';

  meta = with lib; {
    description = "ZMK firmware flasher";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ lilyinstarlight ];
  };
}
