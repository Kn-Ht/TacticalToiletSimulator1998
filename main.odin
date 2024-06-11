package main

import rl "vendor:raylib"
import "src/game"

main :: proc() {
    using game;

    game := game_init()
    defer game_close(&game)

    flags :: rl.ConfigFlags{.WINDOW_RESIZABLE, .MSAA_4X_HINT}

    game_start(&game, flags)

    for !game.should_quit do game_tick(&game)
}