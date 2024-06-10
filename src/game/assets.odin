package game

import rl "vendor:raylib"

Font :: enum {
    Hivehead,
    Max
}

fonts: [Font.Max]rl.Font

load_font :: #force_inline proc(bytes: []u8) -> rl.Font {
    return rl.LoadFontFromMemory(
        ".ttf", &bytes[0], cast(i32)len(bytes), 100, {}, 100
    )
}

load_fonts :: proc() {
    fonts[Font.Hivehead] = load_font(#load("../../assets/hivehead-handwriting.regular.ttf", []u8))
}

load_assets :: proc() {
    load_fonts()
}

unload_assets :: proc() {
    for i in 0..<int(Font.Max) do rl.UnloadFont(fonts[i])
}