vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

  -- optionally enable 24-bit colour
  vim.opt.termguicolors = true

require("shortcuts")
require("user_cmd")



vim.cmd('packadd! nohlsearch')

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-mini/mini.completion', 
  'https://github.com/stevearc/quicker.nvim',   --smth
  'https://github.com/lewis6991/gitsigns.nvim', --git integration
  "https://github.com/neanias/everforest-nvim",  --everforest colorscheme
  'https://github.com/nvim-tree/nvim-tree.lua',  --sidebar
  'https://github.com/nvim-tree/nvim-web-devicons' --icon pack
})


require('fzf-lua').setup { fzf_colors = true }
require('mini.completion').setup {}
require('quicker').setup {}
require('gitsigns').setup {}
require("everforest").setup({ background = "hard"  })
require("nvim-tree").setup()
require'nvim-web-devicons'.setup {
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 color_icons = true;
 default = true;
 strict = true;
 variant = "light|dark";
 blend = 0;
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
 override_by_operating_system = {
  ["apple"] = {
    icon = "",
    color = "#A2AAAD",
    cterm_color = "248",
    name = "Apple",
  },
 };
}

vim.cmd([[colorscheme everforest]])

if not vim.lsp.is_enabled('clangd') then
	vim.lsp.enable('clangd', clangd_opts)
end

local configs = require("lspconfig.configs")
local nvim_lsp = require("lspconfig")
if not configs.neocmake then
    configs.neocmake = {
        default_config = {
            cmd = { "/home/cool/.cargo/bin/neocmake", "stdio" },
            filetypes = { "cmake" },
            root_dir = function(fname)
                return nvim_lsp.util.find_git_ancestor(fname)
            end,
            single_file_support = true,-- suggested
            on_attach = on_attach, -- on_attach is the on_attach function you defined
            init_options = {
                format = {
                    enable = true
                },
                lint = {
                    enable = true
                },
                scan_cmake_in_package = true -- default is true
            }
        }
    }
    nvim_lsp.neocmake.setup({})
end
