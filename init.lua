require("git"):setup()
require("full-border"):setup()
require("starship"):setup({
	-- Hide flags (such as filter, find and search). This is recommended for starship themes which
	-- are intended to go across the entire width of the terminal.
	hide_flags = false, -- Default: false
	-- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
	flags_after_prompt = true, -- Default: true
	-- Custom starship configuration file to use
	config_file = "/Users/fcabrera/.config/starship.toml", -- Default: nil
})
require("easyjump"):setup()
require("copy-file-contents"):setup({
	append_char = "\n",
	notification = true,
})
require("duckdb"):setup()

require("recycle-bin"):setup()

require("projects"):setup({
	save = {
		method = "yazi", -- yazi | lua
		yazi_load_event = "@projects-load", -- event name when loading projects in `yazi` method
		lua_save_path = "", -- path of saved file in `lua` method, comment out or assign explicitly
		-- default value:
		-- windows: "%APPDATA%/yazi/state/projects.json"
		-- unix: "~/.local/state/yazi/projects.json"
	},
	last = {
		update_after_save = true,
		update_after_load = true,
		load_after_start = false,
	},
	merge = {
		event = "projects-merge",
		quit_after_merge = false,
	},
	event = {
		save = {
			enable = true,
			name = "project-saved",
		},
		load = {
			enable = true,
			name = "project-loaded",
		},
		delete = {
			enable = true,
			name = "project-deleted",
		},
		delete_all = {
			enable = true,
			name = "project-deleted-all",
		},
		merge = {
			enable = true,
			name = "project-merged",
		},
	},
	notify = {
		enable = true,
		title = "Projects",
		timeout = 3,
		level = "info",
	},
})

local function detect_dark_mode()
	local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
	local result = handle:read("*a")
	handle:close()

	if string.find(result, "Dark") then
		return true
	else
		return false
	end
end

local theme

-- Kanagawa Lotus Palette (your tmux colors mapped)
local lotus = {
	white_3 = "#DCD7BA", -- light fg
	true_white = "#f2ecbc",
	gray_3 = "#938056", -- muted gray
	white_2 = "#e7dba0", -- softer fg
	violet_1 = "#a09cac", -- subtle accent
	violet_2 = "#d9a594", -- stronger accent
	aqua_2 = "#5e857a", -- aqua
	red_3 = "#4d699b", -- green-ish (lotus twist, actually looks reddish)
	orange_2 = "#6f894e", -- green/olive
	yellow_3 = "#e98a00", -- orange-red
	pink = "#b35b79", -- pink accent
	red_2 = "#5a7785", -- dusty yellow/steel
	bg_dark = "#54546D", -- custom: dark terminal bg
	bg_light = "#545464", -- custom: lighter section bg
	green_2 = "#C34043", -- red
}

local dragon = {
	white_3 = "#DCD7BA", -- light fg
	true_white = "#181616",
	gray_3 = "#181616", -- muted gray
	white_2 = "#393836", -- softer fg
	violet_1 = "#938aa9", -- subtle accent
	violet_2 = "#b6927b", -- stronger accent
	aqua_2 = "#87a987", -- aqua
	red_3 = "#949fb5", -- green-ish (lotus twist, actually looks reddish)
	orange_2 = "#8a9a7b", -- green/olive
	yellow_3 = "#5e857a", -- orange-red
	pink = "#b98d7b", -- pink accent
	red_2 = "#5a7785", -- dusty yellow/steel
	bg_dark = "#54546D", -- custom: dark terminal bg
	bg_light = "#f2ecbc", -- custom: lighter section bg
	green_2 = "#8ea4a2", -- red
}

local wave = {
	white_3 = "#DCD7BA", -- light fg
	true_white = "#dcd7ba",
	gray_3 = "#181616", -- muted gray
	white_2 = "#2a2a37", -- softer fg
	violet_1 = "#938aa9", -- subtle accent
	violet_2 = "#54546D", -- stronger accent
	aqua_2 = "#98bb6c", -- aqua
	red_3 = "#949fb5", -- green-ish (lotus twist, actually looks reddish)
	orange_2 = "#87a987", -- green/olive
	yellow_3 = "#dca561", -- orange-red
	pink = "#d9a594", -- pink accent
	red_2 = "#5a7785", -- dusty yellow/steel
	bg_dark = "#54546D", -- custom: dark terminal bg
	bg_light = "#dcd7ba", -- custom: lighter section bg
	green_2 = "#938aa9", -- red
}

if detect_dark_mode() then
	-- theme = dragon
	theme = wave
else
	theme = lotus
end

-- ---@class PaletteColors
-- local palette = {
--
-- 	-- Bg Shades
-- 	sumiInk0 = "#16161D",
-- 	sumiInk1 = "#181820",
-- 	sumiInk2 = "#1a1a22",
-- 	sumiInk3 = "#1F1F28",
-- 	sumiInk4 = "#2A2A37",
-- 	sumiInk5 = "#363646",
-- 	sumiInk6 = "#54546D", --fg
--
-- 	-- Popup and Floats
-- 	waveBlue1 = "#223249",
-- 	waveBlue2 = "#2D4F67",
--
-- 	-- Diff and Git
-- 	winterGreen = "#2B3328",
-- 	winterYellow = "#49443C",
-- 	winterRed = "#43242B",
-- 	winterBlue = "#252535",
-- 	autumnGreen = "#76946A",
-- 	autumnRed = "#C34043",
-- 	autumnYellow = "#DCA561",
--
-- 	-- Diag
-- 	samuraiRed = "#E82424",
-- 	roninYellow = "#FF9E3B",
-- 	waveAqua1 = "#6A9589",
-- 	dragonBlue = "#658594",
--
-- 	-- Fg and Comments
-- 	oldWhite = "#C8C093",
-- 	fujiWhite = "#DCD7BA",
-- 	fujiGray = "#727169",
--
-- 	oniViolet = "#957FB8",
-- 	oniViolet2 = "#b8b4d0",
-- 	crystalBlue = "#7E9CD8",
-- 	springViolet1 = "#938AA9",
-- 	springViolet2 = "#9CABCA",
-- 	springBlue = "#7FB4CA",
-- 	lightBlue = "#A3D4D5", -- unused yet
-- 	waveAqua2 = "#7AA89F", -- improve lightness: desaturated greenish Aqua
--
-- 	-- waveAqua2  = "#68AD99",
-- 	-- waveAqua4  = "#7AA880",
-- 	-- waveAqua5  = "#6CAF95",
-- 	-- waveAqua3  = "#68AD99",
--
-- 	springGreen = "#98BB6C",
-- 	boatYellow1 = "#938056",
-- 	boatYellow2 = "#C0A36E",
-- 	carpYellow = "#E6C384",
--
-- 	sakuraPink = "#D27E99",
-- 	waveRed = "#E46876",
-- 	peachRed = "#FF5D62",
-- 	surimiOrange = "#FFA066",
-- 	katanaGray = "#717C7C",
--
-- 	dragonBlack0 = "#0d0c0c",
-- 	dragonBlack1 = "#12120f",
-- 	dragonBlack2 = "#1D1C19",
-- 	dragonBlack3 = "#181616",
-- 	dragonBlack4 = "#282727",
-- 	dragonBlack5 = "#393836",
-- 	dragonBlack6 = "#625e5a",
--
-- 	dragonWhite = "#c5c9c5",
-- 	dragonGreen = "#87a987",
-- 	dragonGreen2 = "#8a9a7b",
-- 	dragonPink = "#a292a3",
-- 	dragonOrange = "#b6927b",
-- 	dragonOrange2 = "#b98d7b",
-- 	dragonGray = "#a6a69c",
-- 	dragonGray2 = "#9e9b93",
-- 	dragonGray3 = "#7a8382",
-- 	dragonBlue2 = "#8ba4b0",
-- 	dragonViolet = "#8992a7",
-- 	dragonRed = "#c4746e",
-- 	dragonAqua = "#8ea4a2",
-- 	dragonAsh = "#737c73",
-- 	dragonTeal = "#949fb5",
-- 	dragonYellow = "#c4b28a", --"#a99c8b",
-- 	-- "#8a9aa3",
--
-- 	lotusInk1 = "#545464",
-- 	lotusInk2 = "#43436c",
-- 	lotusGray = "#dcd7ba",
-- 	lotusGray2 = "#716e61",
-- 	lotusGray3 = "#8a8980",
-- 	lotusWhite0 = "#d5cea3",
-- 	lotusWhite1 = "#dcd5ac",
-- 	lotusWhite2 = "#e5ddb0",
-- 	lotusWhite3 = "#f2ecbc",
-- 	lotusWhite4 = "#e7dba0",
-- 	lotusWhite5 = "#e4d794",
-- 	lotusViolet1 = "#a09cac",
-- 	lotusViolet2 = "#766b90",
-- 	lotusViolet3 = "#c9cbd1",
-- 	lotusViolet4 = "#624c83",
-- 	lotusBlue1 = "#c7d7e0",
-- 	lotusBlue2 = "#b5cbd2",
-- 	lotusBlue3 = "#9fb5c9",
-- 	lotusBlue4 = "#4d699b",
-- 	lotusBlue5 = "#5d57a3",
-- 	lotusGreen = "#6f894e",
-- 	lotusGreen2 = "#6e915f",
-- 	lotusGreen3 = "#b7d0ae",
-- 	lotusPink = "#b35b79",
-- 	lotusOrange = "#cc6d00",
-- 	lotusOrange2 = "#e98a00",
-- 	lotusYellow = "#77713f",
-- 	lotusYellow2 = "#836f4a",
-- 	lotusYellow3 = "#de9800",
-- 	lotusYellow4 = "#f9d791",
-- 	lotusRed = "#c84053",
-- 	lotusRed2 = "#d7474b",
-- 	lotusRed3 = "#e82424",
-- 	lotusRed4 = "#d9a594",
-- 	lotusAqua = "#597b75",
-- 	lotusAqua2 = "#5e857a",
-- 	lotusTeal1 = "#4e8ca2",
-- 	lotusTeal2 = "#6693bf",
-- 	lotusTeal3 = "#5a7785",
-- 	lotusCyan = "#d7e3d8",
-- }

--  fuji_white='#dcd7ba'
--  sumi_ink_4='#2a2a37'
--  sumi_ink_2='#1a1a22'
--  sumi_ink_5='#363646'
--  sumi_ink_6='#54546D'
--  wave_aqua='#6a9589'
--  ronin_yellow='#ff9e3b'
--  dragon_green='#8a9a7b'
--  dragon_aqua='#8ea4a2',
--  autumn_orange='#dca561'
--  wawe_red='#e46876'
--  sakura_pink='#d27e99'
--  ronin_yellow='#ff9e3b'
--  spring_violet_1='#938aa9'
--  crystal_blue='#7e9cd8'
--  wave_blue_2='#2d4f67'
--  wave_blue_1='#223249'
--  wave_red='#e46876'
--  spring_violet_2='#9cabca'
--  wave_aqua_2='#7aa89f'
--  carp_yellow='#e6c384'
--  winter_blue='#252535'
--  surimi_orange='#ffa066'
--  spring_green='#98bb6c'
--  katana_gray='#717c7c'
--  spring_blue='#7fb4ca'
--  oni_violet='#957fb8'
--  autumn_yellow='#dca561'
--  winter_yellow='#49443c'
--  winter_red='#43242b'
--  fuji_gray='#727169'
--  light_blue='#a3d4d5'
--  old_white='#c8c093'
--  samurai_red='#e82424'
--  sumi_ink_1='#1e1f28'
--  sumi_ink_0='#16161d'
--  peach_red='#ff5d62'
--  sumi_ink_3='#363646'
--  winter_green='#2b3328'
--  boat_yellow_2='#c0a36e'
--  dragon_blue='#658594'
--  boat_yellow_1='#938056'
--  autumn_green='#76946a'
--  autumn_red='#c34043'
--  dragon_orange='#b6927b'
--  dragon_gray='#a6a69c'
--  lotus_pink='#b35b79'
--  lotus_cyan='#d7e3d8'
--  lotus_orange='#cc6d00'
--  lotus_yellow='#77713f'
--  dragon_red='#c4746e'
--  dragon_pink='#a292a3'
--  lotus_white_3='#f2ecbc'
--  lotus_ink_1='#545464'
--  lotus_ink_2='#43436c'
--  lotus_red_2='#d7474b'
--  lotus_yellow_2='#836f4a'
--  lotus_teal_2='#6693bf'
--  lotus_gray_3='#8a8980'
--  lotus_violet_1='#a09cac'
--  lotus_violet_2='#766b90'
--  lotus_orange_2='#e98a00'
--  lotus_yellow_3='#de9800'
--  lotus_gray_2='#716e61'
-- dragon_white='#c5c9c5'
-- dragon_green='#87a987'
-- dragon_orange_2='#b98d7b'
-- dragon_gray_2='#9e9b93'
-- dragon_gray_3='#7a8382'
-- dragon_blue_2='#8ba4b0'
-- dragon_violet='#8992a7'
-- dragon_aqua='#8ea4a2'
-- dragon_ash='#737c73'
-- dragon_teal='#949fb5'
-- dragon_yellow='#c4b28a'
-- dragon_black_0='#0d0c0c'
-- dragon_black_1='#12120f'
-- dragon_black_2='#1D1C19'
-- dragon_black_3='#181616'
-- dragon_black_4='#282727'
-- dragon_black_5='#393836'
-- dragon_black_6='#625e5a'
-- lotus_yellow_4='#f9d791'
-- lotus_red='#c84053'
-- lotus_red_4='#d9a594'
-- lotus_aqua='#597b75'
-- lotus_aqua_2='#5e857a'
-- lotus_teal_1='#4e8ca2'
-- lotus_teal_3='#5a7785'

require("yatline"):setup({
	section_separators = { left = "", right = "" },
	section_separator = { close = "", open = "" },
	part_separator = { open = "╱", close = "╲" },
	inverse_separator = { open = "", close = "" },

	style_a = {
		fg = theme.white_2,
		bg_mode = {
			normal = theme.green_2,
			select = theme.red_2,
			un_set = theme.gray_3,
		},
	},
	style_b = { bg = theme.violet_2, fg = theme.true_white },
	style_c = { bg = theme.white_2, fg = theme.bg_light },

	permissions_t_fg = theme.orange_2,
	permissions_r_fg = theme.red_2,
	permissions_w_fg = theme.red_3,
	permissions_x_fg = theme.orange_2,
	permissions_s_fg = theme.pink,

	tab_width = 20,
	tab_use_inverse = false,

	selected = { icon = "󰻭", fg = theme.yellow_3 },
	copied = { icon = "", fg = theme.aqua_2 },
	cut = { icon = "", fg = theme.red_3 },

	total = { icon = "󰮍", fg = theme.yellow_3 },
	succ = { icon = "", fg = theme.aqua_2 },
	fail = { icon = "", fg = theme.red_2 },
	found = { icon = "󰮕", fg = theme.violet_1 },
	processed = { icon = "󰐍", fg = theme.green_2 },

	show_background = true,

	display_header_line = true,
	display_status_line = true,

	component_positions = { "header", "tab", "status" },

	header_line = {
		left = { section_a = {}, section_b = {}, section_c = {} },
		right = { section_a = {}, section_b = {}, section_c = {} },
	},

	status_line = {
		left = {
			section_a = { { type = "string", custom = false, name = "tab_mode" } },
			section_b = { { type = "string", custom = false, name = "hovered_size" } },
			section_c = {
				{ type = "string", custom = false, name = "hovered_path" },
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
		right = {
			section_a = { { type = "string", custom = false, name = "cursor_position" } },
			section_b = { { type = "string", custom = false, name = "cursor_percentage" } },
			section_c = {
				-- { type = "line", custom = false, name = "tabs", params = { "right" } },
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})

-- Status:children_add(function(self)
-- 	local h = self._current.hovered
-- 	if h and h.link_to then
-- 		return " -> " .. tostring(h.link_to)
-- 	else
-- 		return ""
-- 	end
-- end, 3300, Status.LEFT)
