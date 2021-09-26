return {
    {
        "wbthomason/packer.nvim",
    },

    {
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient").enable_profile()
        end,
    },

    {
        "neovim/nvim-lspconfig",
        after = "nvim-lspinstall",
        config = function()
            if vim.fn.eval("&filetype") ~= "man" then
                require("_nvlx.config.lsp")
            end
        end,
    },

    {
        "kabouzeid/nvim-lspinstall",
        event = "CursorHold",
    },

    {
        "Pocco81/AutoSave.nvim",
        config = function()
            require("autosave").setup(require("_nvlx.config.plugins")["AutoSave.nvim"])
        end,
        --disable = not nvlx.general.autosave,
        after = "nordbuddy",
    },

    {
        "grvxs/persistence.nvim",
        config = function()
            require("persistence").setup(require("_nvlx.config.plugins")["persistence.nvim"])
        end,
        after = "nordbuddy",
    },

    {
        "maaslalani/nordbuddy",
        event = "VimEnter",
        config = function()
            require("_nvlx.colors")
            --if require("_nvlx.colors") == false then
            --vim.cmd("colorscheme " .. nvlx.general.colorscheme)
            --end
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        event = "BufReadPost",
        config = function()
            require("colorizer").setup()
            vim.cmd("ColorizerToggle")
        end,
    },

    {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = function()
            require("compe").setup(require("_nvlx.config.plugins")["nvim-compe"])
        end,
    },

    {
        "hrsh7th/vim-vsnip",
        event = "InsertCharPre",
    },

    {
        "rafamadriz/friendly-snippets",
        event = "InsertCharPre",
    },

    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup(require("_nvlx.config.plugins")["bufferline.nvim"])
        end,
        after = "nordbuddy",
    },

    {
        "famiu/feline.nvim",
        config = function()
            require("feline").setup(require("_nvlx.config.plugins")["feline.nvim"])
        end,
        after = "nordbuddy",
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead,BufNewFile,InsertEnter",
        config = function()
            require("nvim-treesitter.configs").setup(
                require("_nvlx.config.plugins")["nvim-treesitter"]
            )
        end,
    },

    {
        "sbdchd/neoformat",
        cmd = "Neoformat",
        config = function()
            local g = vim.g
            g.neoformat_c_clangformat = { exe = "clang-format", stdin = true }
            g.neoformat_cpp_clangformat = {
                exe = "clang-format",
                args = { "--style='{BasedOnStyle: chromium, IndentWidth: 4}'" },
                stdin = true,
            }
            g.neoformat_enabled_c = { "clangformat" }
            g.neoformat_enabled_cpp = { "clangformat" }
            g.neoformat_enabled_css = { "prettier" }
            g.neoformat_enabled_haskell = { "brittany" }
            g.neoformat_enabled_html = { "prettier" }
            g.neoformat_enabled_java = { "prettier" }
            g.neoformat_enabled_javascript = { "prettier" }
            g.neoformat_enabled_json = { "prettier" }
            g.neoformat_enabled_lua = { "stylua" }
            g.neoformat_enabled_python = {}
            g.neoformat_enabled_rust = { "rustfmt" }
            g.neoformat_enabled_typescript = { "prettier" }
            g.neoformat_enabled_yaml = { "prettier" }
            g.neoformat_rust_rustfmt = {
                exe = "rustfmt",
                args = { "--edition 2018" },
                stdin = true,
            }
        end,
    },

    {
        "kyazdani42/nvim-web-devicons",
        after = "nordbuddy",
    },

    {
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = function()
            local g = vim.g
            g.nvim_tree_width = 25
            g.nvim_tree_gitignore = 1
            g.nvim_tree_auto_ignore_ft = { "dashboard" }
            g.nvim_tree_quit_on_open = 1
            g.nvim_tree_indent_markers = 1
            g.nvim_tree_hide_dotfiles = 1
            g.nvim_tree_git_hl = 1
            g.nvim_tree_highlight_opened_files = 0
            g.nvim_tree_root_folder_modifier = ":t"
            g.nvim_tree_allow_resize = 1
            g.nvim_tree_add_trailing = 0
            g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1 }
            g.nvim_tree_icons = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "", -- 
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                lsp = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            }
            require("nvim-tree").setup({
                hijack_cursor = true,
                update_cwd = true,
                lsp_diagnostics = true,
                update_focused_file = {
                    enable = false,
                    update_cwd = false,
                    ignore_list = { ".git", "node_modules", ".cache", "target" },
                },
            })
        end,
    },

    {
        "nvim-lua/plenary.nvim",
        event = "BufEnter",
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        module = "telescope.finders",
        config = function()
            require("telescope").setup(require("_nvlx.config.plugins")["telescope.nvim"])
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup(require("_nvlx.config.plugins")["gitsigns.nvim"])
        end,
        after = "plenary.nvim",
    },

    {
        "glepnir/dashboard-nvim",
        setup = function()
            local g = vim.g
            g.dashboard_custom_header = {
                [[    _   ___    __     __          ]],
                [[   / | / / |  / /__  / /___  _  __]],
                [[  /  |/ /| | / / _ \/ / __ \| |/_/]],
                [[ / /|  / | |/ /  __/ / /_/ />  <  ]],
                [[/_/ |_/  |___/\___/_/\____/_/|_|  ]],
                [[                                  ]],
            }

            g.dashboard_custom_section = {
                a = {
                    description = { "  Sessions                             " },
                    command = "lua require('_nvlx.sessions').sload()",
                },
                b = {
                    description = { "  Restore Session for current directory" },
                    command = "lua require('persistence').load_current()",
                },
                c = {
                    description = { "  Config                               " },
                    command = ":e ~/.config/nvlx/init.lua",
                },
                d = {
                    description = { "  Find Files                           " },
                    command = "Telescope find_files",
                },
            }
            g.dashboard_custom_footer = {}
        end,
        after = "nordbuddy",
    },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup(require("_nvlx.config.plugins")["nvim-autopairs"])
            require("nvim-autopairs.completion.compe").setup()
        end,
        after = "nvim-compe",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup(
                require("_nvlx.config.plugins")["indent-blankline.nvim"]
            )
        end,
        after = "nordbuddy",
    },

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup(require("_nvlx.config.plugins")["toggleterm.nvim"])
        end,
        after = "which-key.nvim",
    },

    {
        "folke/which-key.nvim",
        config = function()
            local nvlx = require("_nvlx.user"):get_nvlx()
            require("_nvlx.leader").load(nvlx.maps.leader)
            require("which-key").setup(require("_nvlx.config.plugins")["which-key.nvim"])
        end,
    },

    {
        "ygm2/rooter.nvim",
        setup = function()
            vim.g.rooter_pattern = {
                ".git",
                "Makefile",
                "build/env.sh",
                "Cargo.toml",
                "input1",
                "output1",
            }
        end,
        after = "nordbuddy",
    },

    {
        "preservim/nerdcommenter",
        event = "CursorHold",
    },
}
