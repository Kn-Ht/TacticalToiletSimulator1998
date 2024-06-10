package main

import "core:fmt"
import rl "vendor:raylib"
import "src/game"

main :: proc() {
    using game;

    game := game_init()
    defer game_close(&game)

    game_start(&game)

    for !game.should_quit {
        game_tick(&game)
    }
}