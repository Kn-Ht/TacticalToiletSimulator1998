package game

import rl "vendor:raylib"

editor_ui :: proc(g: ^Game) {
    rl.DrawFPS(0, 0)
}

editor_3d :: proc(g: ^Game) {
    camera_look(&g.camera, 1e-2/2)

    rl.DrawGrid(100, 1.0)
}