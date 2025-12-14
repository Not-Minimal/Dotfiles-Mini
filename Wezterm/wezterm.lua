-- ~/.wezterm.lua
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local action = wezterm.action

-- Plugin: tabline.wez
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- Entrada y composición
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.use_dead_keys = false

-- Fuente con fallback: Google Sans Code + MesloLGL Nerd Font
config.font = wezterm.font_with_fallback({
    { family = "Google Sans Code",  weight = "Medium" },
    { family = "MesloLGL Nerd Font" },
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 15.0
config.line_height = 1.10
config.cell_width = 1.10
config.bold_brightens_ansi_colors = true

config.colors = {
    foreground = "#CBE0F0",
    background = "#011423",
    cursor_bg = "#47FF9C",
    cursor_border = "#47FF9C",
    cursor_fg = "#011423",
    selection_bg = "#033259",
    selection_fg = "#CBE0F0",
    ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#44FFB1", "#a277ff", "#000000", "#000000" },
    brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#4FdFB1", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- Tema por apariencia
local function apply_theme_by_appearance()
    local appearance = wezterm.gui.get_appearance()
    local is_dark = appearance and appearance:find("Dark")

    if is_dark then
        config.color_scheme = "Nightfox"
        config.window_background_opacity = 0.96
        config.macos_window_background_blur = 0
        config.colors = config.colors or {}
        config.colors.foreground = "#eceff4"
        config.colors.selection_bg = "#3b4252"
        config.colors.selection_fg = "#eceff4"
    else
        config.color_scheme = "Github Dark"
        config.window_background_opacity = 0.70
        config.macos_window_background_blur = 8
        config.colors = config.colors or {}
        config.colors.selection_bg = "#d8dee9"
        config.colors.selection_fg = "#2e3440"
    end
end
apply_theme_by_appearance()


-- Keybindings
local keys = {
    { key = "n",          mods = "OPT",       action = action.SendString("~") },
    { key = "UpArrow",    mods = "ALT",       action = action.SendKey({ key = "UpArrow", mods = "ALT" }) },
    { key = "DownArrow",  mods = "ALT",       action = action.SendKey({ key = "DownArrow", mods = "ALT" }) },
    { key = "LeftArrow",  mods = "ALT",       action = action.SendKey({ key = "LeftArrow", mods = "ALT" }) },
    { key = "RightArrow", mods = "ALT",       action = action.SendKey({ key = "RightArrow", mods = "ALT" }) },
    { key = "Backspace",  mods = "ALT",       action = action.SendKey({ key = "Backspace", mods = "ALT" }) },
    { key = "d",          mods = "CMD|SHIFT", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "d",          mods = "CMD",       action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "k",          mods = "CMD",       action = action.ClearScrollback("ScrollbackAndViewport") },
    { key = "w",          mods = "CMD",       action = action.CloseCurrentPane({ confirm = false }) },
    { key = "w",          mods = "CMD|SHIFT", action = action.CloseCurrentTab({ confirm = false }) },
    { key = "LeftArrow",  mods = "CMD",       action = action.SendKey({ key = "Home" }) },
    { key = "RightArrow", mods = "CMD",       action = action.SendKey({ key = "End" }) },
    { key = "p",          mods = "CMD|SHIFT", action = action.ActivateCommandPalette },

    -- Abrir config con Zed usando ruta absoluta
    {
        key = ",",
        mods = "CMD",
        action = action.SpawnCommandInNewTab({
            cwd = wezterm.home_dir,
            args = { "/opt/homebrew/bin/zed", wezterm.config_file },
        }),
    },
}

config.keys = keys

-- Configurar tabline.wez (al final, después de todos los colores)
tabline.setup({
    options = {
        icons_enabled = true,
        theme = config.colors,
        padding = { left = 1, right = 1 },
        section_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = wezterm.nerdfonts.pl_right_hard_divider,
        },
        component_separators = {
            left = wezterm.nerdfonts.pl_left_soft_divider,
            right = wezterm.nerdfonts.pl_right_soft_divider,
        },
        tab_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = wezterm.nerdfonts.pl_right_hard_divider,
        },
    },
    sections = {
        tabline_a = { " ", { "mode", padding = 2 }, " " },
        tabline_b = { { "workspace", padding = 2 } },
        tabline_c = { " " },
        tab_active = {
            " ",
            "index",
            { "parent", padding = 0 },
            "/",
            { "cwd",    padding = { left = 0, right = 1 } },
            { "zoomed", padding = 0 },
            " ",
        },
        tab_inactive = {
            " ",
            "index",
            { "process", padding = { left = 0, right = 1 } },
            " ",
        },
        tabline_x = { { "ram", padding = 2 }, { "cpu", padding = 2 } },
        tabline_y = { { "datetime", padding = 2 }, { "battery", padding = 2 } },
        tabline_z = { { "hostname", padding = 2 }, " " },
    },
    extensions = {},
})

-- Aplicar configuración de tabline al config de WezTerm
tabline.apply_to_config(config)

-- Window decorations y padding (después de tabline para no ser sobrescritos)
config.window_decorations = "RESIZE"
config.window_padding = { left = 32, right = 32, top = 32, bottom = 24 }

-- Cursor (después de tabline para no ser sobrescritos)
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 700
config.animation_fps = 60
config.cursor_thickness = 2
config.hide_mouse_cursor_when_typing = true

return config
