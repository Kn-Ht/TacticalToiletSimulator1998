package input

import rl "vendor:raylib"

Key :: rl.KeyboardKey

Keymap :: struct {
    // Movement
    mv_forward, mv_backward,
    mv_left, mv_right, mv_jump,
    // Editor controls
    ed_toggle, ed_mv_up, ed_mv_down, ed_exit: Key
}

KEYMAP_DEFAULT :: Keymap {
    mv_forward = Key.W,
    mv_backward = Key.S,
    mv_left = Key.A,
    mv_right = Key.D,
    mv_jump = Key.SPACE,
    ed_mv_up = Key.SPACE,
    ed_mv_down = Key.LEFT_SHIFT,
    ed_exit = Key.F10,
    ed_toggle = Key.F1,
}

keymap := KEYMAP_DEFAULT