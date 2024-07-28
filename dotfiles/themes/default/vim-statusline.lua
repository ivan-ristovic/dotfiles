local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup {
    options = {
        theme = 'codedark',
        
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        icons_enabled = true,
        
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
}

