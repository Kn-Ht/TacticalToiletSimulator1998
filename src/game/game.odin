package game

import rl "vendor:raylib"
import "../input"
import "../assets"

Game :: struct {
    should_quit: bool,
    editor_mode: bool,
    res: assets.AssetManager,
    player: Player,
}

game_init :: proc() -> Game {
    return Game {
        should_quit = false,
        editor_mode = false,
        player = player_new(rl.Camera3D {
            fovy = 75.0,
            position = {1, 1, 1},
            projection = rl.CameraProjection.PERSPECTIVE,
            target = {0, 0, 0},
            up = {0, 1, 0}
        }),
    }
}

game_start :: proc(using g: ^Game, flags: rl.ConfigFlags) {
    rl.SetConfigFlags(flags)

    rl.InitWindow(800, 600, "TacticalToiletSimulator1998")
    rl.InitAudioDevice()

    // Post boot up
    rl.SetExitKey(rl.KeyboardKey.KEY_NULL)
    rl.DisableCursor()

    res = assets.asset_manager_create()
}

game_close :: proc(using g: ^Game) {
    rl.EnableCursor()
    rl.CloseAudioDevice();

    // Free all objects
    assets.asset_manager_destroy(&res)
    free_all()

    rl.CloseWindow();
}

game_update :: proc(using g: ^Game) {
    using input

    should_quit |= rl.WindowShouldClose()

    if rl.IsKeyPressed(keymap.ed_toggle) do editor_mode = !editor_mode
    if rl.IsKeyPressed(keymap.ed_exit) do should_quit = true
}

game_tick :: proc(using g: ^Game) {
    using rl

    game_update(g)

    BeginDrawing()
    defer EndDrawing()

    ClearBackground(BLACK)

    // 3D
    {
        BeginMode3D(player.camera)
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