package game

import rl "vendor:raylib"

camera_look :: proc(camera: ^rl.Camera3D, sens: f32) {
    mouse_pos := rl.GetMouseDelta()

    forward := rl.Vector3Normalize(camera.target - camera.position)
    right := rl.Vector3CrossProduct(camera.up, forward)

    yaw := rl.QuaternionFromAxisAngle(camera.up, -mouse_pos[0] * sens)
    pitch := rl.QuaternionFromAxisAngle(right, mouse_pos[1] * sens)

    forward = rl.Vector3RotateByQuaternion(forward, yaw * pitch)
    camera.target = camera.position + forward

    camera.up = rl.Vector3RotateByQuaternion(camera.up, yaw)
}