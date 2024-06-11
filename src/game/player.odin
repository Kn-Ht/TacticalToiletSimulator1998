package game

import rl "vendor:raylib"

player_look :: proc(g: ^Game) {
    camera_look(&g.camera, 1e-2/2)
}

player_look_editor :: proc(g: ^Game) {
    camera_look(&g.camera, 1e-2/2)
}

player_move :: proc(g: ^Game) {

}

player_move_editor :: proc(g: ^Game) {
    using rl
    using g

    dt := GetFrameTime()

    move_speed := (IsKeyDown(KeyboardKey.LEFT_CONTROL)? 10.0 : 20.0) * dt

    // 3D move code
    forward := Vector3Normalize(camera.target - camera.position)
    right := Vector3Normalize(Vector3CrossProduct(forward, camera.up))

    forward_scaled := forward * move_speed
    right_scaled := right * move_speed


    if IsKeyDown(KeyboardKey.SPACE) {
        camera.position[1] += move_speed
        camera.target[1] += move_speed
    }
    if IsKeyDown(KeyboardKey.LEFT_SHIFT) {
        camera.position[1] -= move_speed
        camera.target[1] -= move_speed
    }
    if IsKeyDown(KeyboardKey.W) {
        camera.position += forward_scaled
        camera.target += forward_scaled
    }
    if IsKeyDown(KeyboardKey.S) {
        camera.position -= forward_scaled
        camera.target -= forward_scaled
    }
    if IsKeyDown(KeyboardKey.A) {
        camera.position -= right_scaled
        camera.target -= right_scaled
    }
    if IsKeyDown(KeyboardKey.D) {
        camera.position += right_scaled
        camera.target += right_scaled
    }
}