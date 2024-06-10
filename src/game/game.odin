package game

import rl "vendor:raylib"
import "../editor"

Game :: struct {
    should_quit: bool
}

game_init :: proc() -> Game {
    return Game{}
}

game_start :: proc(g: ^Game) {
    rl.InitWindow(800, 600, "TacticalToiletSimulator1998")
    rl.InitAudioDevice()

    load_assets()
}

game_close :: proc(g: ^Game) {
    unload_assets()

    rl.CloseAudioDevice();
    rl.CloseWindow();
}

game_tick :: proc(g: ^Game) {
    g.should_quit |= rl.WindowShouldClose()

    rl.BeginDrawing()
    defer rl.EndDrawing()

    rl.ClearBackground(rl.BLACK)
    rl.DrawFPS(0, 0)
}