{ lib
, buildSplitKeyboard
, self
}:

buildSplitKeyboard {
  name = "cradio-firmware";

  src = lib.sourceFilesBySuffices self [ ".conf" ".keymap" ".yml" ".h" ];

  board = "nrfmicro_13";
  shield = "cradio_%PART%";

  zephyrDepsHash = "sha256-4R8NUx+VRz/EiqYuEGtQqidVkI8z6KxFHYoQK7twe9o=";

  meta = with lib; {
    description = "Keyboard firmware for Ferris Sweep";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ lilyinstarlight ];
  };
}
