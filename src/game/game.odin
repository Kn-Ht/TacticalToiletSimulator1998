package game

import rl "vendor:raylib"

Game :: struct {
    should_quit: bool,
    editor_mode: bool,
    camera: rl.Camera3D
}

game_init :: proc() -> Game {
    return Game {
        camera = {
            fovy = 75.0,
            position = {1, 1, 1},
            projection = rl.CameraProjection.PERSPECTIVE,
            target = {0, 0, 0},
            up = {0, 1, 0}
        }
    }
}

game_start :: proc(g: ^Game, flags: rl.ConfigFlags) {
    rl.SetConfigFlags(flags)

    rl.InitWindow(800, 600, "TacticalToiletSimulator1998")
    rl.InitAudioDevice()

    // Post boot up
    rl.SetExitKey(rl.KeyboardKey.KEY_NULL)
    rl.DisableCursor()

    load_assets()
}

game_close :: proc(g: ^Game) {
    unload_assets()

    rl.EnableCursor()
    rl.CloseAudioDevice();
    rl.CloseWindow();
}

game_update :: proc(g: ^Game) {
    using g

    should_quit |= rl.WindowShouldClose()

    if rl.IsKeyPressed(rl.KeyboardKey.F1) {
        editor_mode = !editor_mode;
    }
    if rl.IsKeyPressed(rl.KeyboardKey.F12) do should_quit = true
}

game_tick :: proc(g: ^Game) {
    using g
    using rl

    game_update(g)

    BeginDrawing()
    defer EndDrawing()

    ClearBackground(BLACK)

    // 3D
    {
        BeginMode3D(g.camera)
        defer EndMode3D()

        if editor_mode {
            player_look_editor(g)
            player_move_editor(g)
        } else {
            player_look(g)
            player_move(g)
        }

        DrawGrid(100, 1)
        
    }

    // 2D
    if editor_mode {
        editor_ui(g)
    } else {
        
    }
}