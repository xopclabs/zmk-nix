{ lib
, buildSplitKeyboard
, self
}:

buildSplitKeyboard {
  name = "cradio-firmware";

  src = lib.sourceFilesBySuffices self [ ".conf" ".keymap" ".yml" ".h" ];

  board = "nrfmicro_13";
  shield = "cradio_%PART%";

  zephyrDepsHash = "sha256-NYVVv048264zKRlVD9p0pN4xy6/Oy5F5ryGi01LpYi8=";

  meta = with lib; {
    description = "Keyboard firmware for Ferris Sweep";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ lilyinstarlight ];
  };
}
