-- Using nvim-osc52 as clipboard provider
local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

return {
  colorscheme = "nordfox",

  plugins = {
    {
      "EdenEast/nightfox.nvim",
      as = "nightfox",
      config = function()
        require("nightfox").setup {}
      end,
    },
    {
      "goolord/alpha-nvim",
      opts = function(_, opts) -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
          [[                                   .-'''-.                                         ]],
          [[                                  '   _    \                                       ]],
          [[   _..._         __.....__      /   /` '.   \.----.     .----..--. __  __   ___    ]],
          [[ .'     '.   .-''         '.   .   |     \  ' \    \   /    / |__||  |/  `.'   `.  ]],
          [[.   .-.   . /     .-''"'-.  `. |   '      |  ' '   '. /'   /  .--.|   .-.  .-.   ' ]],
          [[|  '   '  |/     /________\   \\    \     / /  |    |'    /   |  ||  |  |  |  |  | ]],
          [[|  |   |  ||                  | `.   ` ..' /   |    ||    |   |  ||  |  |  |  |  | ]],
          [[|  |   |  |\    .-------------'    '-...-'`    '.   `'   .'   |  ||  |  |  |  |  | ]],
          [[|  |   |  | \    '-.____...---.                 \        /    |  ||  |  |  |  |  | ]],
          [[|  |   |  |  `.             .'                   \      /     |__||__|  |__|  |__| ]],
          [[|  |   |  |    `''-...... -'                      '----'                           ]],
          [[|  |   |  |                                                                        ]],
          [['--'   '--'                                                                        ]],
        }
      end,
    },
    {
      "ojroques/nvim-osc52",
      as = "osc52",
      config = function() 
        require("osc52").setup {}
      end,
    },
    { "max397574/better-escape.nvim", enabled = false },
  },

  mappings = {
    n = {
      ["<leader>c"] = {
        function()
          local bufs = vim.fn.getbufinfo { buflisted = true }
          require("astronvim.utils.buffer").close(0)
          if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
        end,
        desc = "Close buffer",
      },
      ["<C-q>"] = { "<C-v>", desc = "blockwise-visual" },
      -- ["<leader>y"] = { require('osc52').copy_operator, expr = true, desc = "osc52 copy" },
      -- ["<leader>yy"] = { '<leader>c_', remap = true, desc = "osc52 copy line" },
    },
    v = {
      -- ["<leader>y"] = { require('osc52').copy_visual, desc = "osc52 copy visual" },
    }
  },

  options = {
    opt = {
      -- mouse = "", -- Disable mouse
      -- Absolute line numbers
      relativenumber = false,
      number = true,
    },
    g = {
      -- Using nvim-osc52 as clipboard provider
      -- +y and +yy now copy to terminal's system keyboard
      -- even through ssh
      clipboard = {
        name = 'osc52',
        copy = {['+'] = copy, ['*'] = copy},
        paste = {['+'] = paste, ['*'] = paste},
      },
    }
  },
}
