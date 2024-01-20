{ lib
, buildSplitKeyboard
, self
}:

buildSplitKeyboard {
  name = "cradio-firmware";

  src = lib.sourceFilesBySuffices self [ ".conf" ".keymap" ".yml" ];

  board = "nrfmicro_13";
  shield = "cradio_%PART%";

  zephyrDepsHash = "sha256-u7zdkwXerCmL9OOI3/v2czIb8Vfr1yx8wuK2IpIdzv0=";

  meta = with lib; {
    description = "Keyboard firmware for Ferris Sweep";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ lilyinstarlight ];
  };
}
