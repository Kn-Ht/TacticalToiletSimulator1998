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
    g.should_quit |= rl.WindowShouldClose()

    if rl.IsKeyPressed(rl.KeyboardKey.F1) {
        g.editor_mode = !g.editor_mode;
    }
}

game_tick :: proc(g: ^Game) {
    game_update(g)

    rl.BeginDrawing()
    defer rl.EndDrawing()

    rl.ClearBackground(rl.BLACK)

    // 3D
    {
        rl.BeginMode3D(g.camera)
        defer rl.EndMode3D()

        if g.editor_mode {
            editor_3d(g)
        } else {
    
        }
    }

    // 2D
    if g.editor_mode {
        editor_ui(g)
    } else {
        
    }
}