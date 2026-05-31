require("opts")
require("binds")

require("colorschemes")
require("autocmds")

require("vim._core.ui2").enable()

vim.pack.add({ "https://github.com/esmuellert/codediff.nvim" })
require("codediff").setup({
	diff = {
		ignore_trim_whitespace = true,
	},
})

vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" })
require("nvim-tree").setup()
vim.keymap.set("n", "<a-e>", "<cmd>NvimTreeToggle<cr>")

vim.pack.add({ "https://github.com/mrcjkb/rustaceanvim" })

require("plugins.filesystem")
require("plugins.grapple")
require("plugins.lualine")
require("plugins.luasnip")
require("plugins.mini")
require("plugins.navigation")
require("plugins.neotab")
require("plugins.snacks")
require("plugins.supermaven")
require("plugins.treesitter")

require("lsp")
