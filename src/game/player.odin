package game

import rl "vendor:raylib"
import "../input"

Player :: struct {
    camera: rl.Camera3D,
    position: rl.Vector3, 
    velocity: rl.Vector3,   
}

PLAYER_HEIGHT :: 100.0

player_new :: proc(camera: rl.Camera3D) -> Player {
    player_pos := camera.position
    player_pos[1] += PLAYER_HEIGHT

    return Player {
        camera = camera,
        position = player_pos,
        velocity = [3]f32{0, 0, 0}
    }
}

player_look :: proc(using g: ^Game) {
    camera_look(&player.camera, input.mouse_sens)
}

player_look_editor :: proc(using g: ^Game) {
    camera_look(&player.camera, input.mouse_sens)
}

player_move :: proc(using g: ^Game) {
    
}

player_move_editor :: proc(using g: ^Game) {
    using rl

    dt := GetFrameTime()

    move_speed: f32 = 10.0
    if IsKeyDown(KeyboardKey.LEFT_CONTROL) do move_speed *= 2
    move_speed *= dt

    // 3D move code
    forward := Vector3Normalize(player.camera.target - player.camera.position)
    right := Vector3Normalize(Vector3CrossProduct(forward, player.camera.up))

    forward_scaled := forward * move_speed
    right_scaled := right * move_speed

    using input
    if IsKeyDown(keymap.ed_mv_up) {
        player.camera.position[1] += move_speed
        player.camera.target[1] += move_speed
    }
    if IsKeyDown(keymap.ed_mv_down) {
        player.camera.position[1] -= move_speed
        player.camera.target[1] -= move_speed
    }
    if IsKeyDown(keymap.mv_forward) {
        player.camera.position += forward_scaled
        player.camera.target += forward_scaled
    }
    if IsKeyDown(keymap.mv_backward) {
        player.camera.position -= forward_scaled
        player.camera.target -= forward_scaled
    }
    if IsKeyDown(keymap.mv_left) {
        player.camera.position -= right_scaled
        player.camera.target -= right_scaled
    }
    if IsKeyDown(keymap.mv_right) {
        player.camera.target += right_scaled
        player.camera.position += right_scaled
    }
}