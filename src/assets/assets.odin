package assets

import rl "vendor:raylib"

IndexMap :: map[string]int

Font :: enum {
    Hivehead,
    Max
}

AssetManager :: struct {
    textures: [dynamic]TextureData,
    texture_map: IndexMap,

    models: [dynamic]ModelData,
    model_map: IndexMap,

    fonts: [Font.Max]rl.Font
}

asset_manager_create :: proc() -> AssetManager {
    fonts: [Font.Max]rl.Font = ---
    fonts[Font.Hivehead] = load_font(#load("../../assets/hivehead-handwriting.regular.ttf", []u8))

    expected :: 64
    return AssetManager {
        textures = make([dynamic]TextureData, expected),
        texture_map = make(IndexMap, expected),
        models = make([dynamic]ModelData, expected),
        model_map = make(IndexMap, expected)
    }
}

asset_manager_destroy :: proc(using am: ^AssetManager) {
    // Dynamic Maps
    delete(textures)
    delete(texture_map)
    delete(models)
    delete(model_map)
    // Fonts
    for i in 0..<int(Font.Max) do rl.UnloadFont(fonts[i])
}

load_font :: #force_inline proc(bytes: []u8) -> rl.Font {
    return rl.LoadFontFromMemory(
        ".ttf", &bytes[0], cast(i32)len(bytes), 100, {}, 100
    )
}