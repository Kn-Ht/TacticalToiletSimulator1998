package main

import "core:fmt"
import rl "vendor:raylib"
import "src/game"

main :: proc() {
    using game;

    game := game_init()
    defer game_close(&game)

    flags :: rl.ConfigFlags{rl.ConfigFlag.WINDOW_RESIZABLE}

    game_start(&game, flags)

    for !game.should_quit {
        game_tick(&game)
    }
}