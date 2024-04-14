{ lib
, buildSplitKeyboard
, self
}:

buildSplitKeyboard {
  name = "cradio-firmware";

  src = lib.sourceFilesBySuffices self [ ".conf" ".keymap" ".yml" ".h" ".dtsi" ];

  board = "nrfmicro_13";
  shield = "cradio_%PART%";

  zephyrDepsHash = "sha256-XVFuGnRrPiTsnYXVvsB/npWKiUKFbhJTw4+DlxMyDu0=";

  meta = with lib; {
    description = "Keyboard firmware for Ferris Sweep";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ lilyinstarlight ];
  };
}
