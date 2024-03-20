-- Statusline plugin written in pure lua.
local function spellStatus()
	if vim.wo.spell == true then -- Note that 'spell' is a window option, so: wo
		return "󱓷 " .. vim.bo.spelllang
	end
	return ""
end

return {
	"nvim-lualine/lualine.nvim",

	opts =  {
		options = {
			theme = "tokyonight"
		},
		sections = {
			lualine_a = {"mode"},
			lualine_b = {"diagnostics"},
			lualine_c = {
				{
					"filename",
					symbols = {
						readonly = "󰌾"
					}
				},
				spellStatus,
			},
			lualine_x = {{"filetype", icon_only = true}},
			lualine_y = {"progress"},
			lualine_z = {"location"}
		},
		tabline = {
			lualine_a = {"buffers"},
			lualine_z = {"tabs"}
		}
	}
}
