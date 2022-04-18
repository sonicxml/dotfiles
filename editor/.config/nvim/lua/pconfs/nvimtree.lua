local M = {}

function M.config()
    vim.api.nvim_set_keymap('n', '<C-o>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
    vim.g.nvim_tree_active = true
    vim.g.nvim_tree_on_config_done = nil
    vim.g.nvim_tree_side = "left"
    vim.g.nvim_tree_width = 30
    -- vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
    -- vim.g.nvim_tree_auto_open = 1
    vim.g.nvim_tree_auto_close = 1
    -- vim.g.nvim_tree_quit_on_open = 0
    -- vim.g.nvim_tree_follow = 1
    -- vim.g.nvim_tree_hide_dotfiles = 1
    vim.g.nvim_tree_git_hl = 1
    vim.g.nvim_tree_root_folder_modifier = ":t"
    -- vim.g.nvim_tree_tab_open = 0
    vim.g.nvim_tree_allow_resize = 1
    -- vim.g.nvim_tree_lsp_diagnostics = 1
    vim.g.nvim_tree_icons = {
        default = "",
        symlink = "",
        git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
        },
        folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
        }
    }
    vim.g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
        tree_width = 30,
    }
end

function M.setup()
  M.config()
  require'nvim-tree'.setup {
    open_on_setup = true,
    open_on_tab = false,
    filters = {
        dotfiles = true,
        custom = {
            ".git",
            "node_modules",
            ".cache",
        },
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
    update_focused_file = {
        enable = true,
    },

  }
  local tree_view = require "nvim-tree.view"

  -- Add nvim_tree open callback
  local open = tree_view.open
  tree_view.open = function()
    M.on_open()
    open()
  end

  -- Add nvim_tree close callback
  local close = tree_view.close
  tree_view.close = function()
    M.on_close()
    close()
  end

end

function M.on_open()
    require("bufferline.state").set_offset(vim.g.nvim_tree_width, "FileTree")
end

function M.on_close()
    require("bufferline.state").set_offset(0)
end

return M
