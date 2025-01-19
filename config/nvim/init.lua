-- constant
local kopt = { noremap = true, silent = true }

-----------------
--- lazy.nvim ---
-----------------
local setup_lazy_nvim = function()
    -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out,                            "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)
end
setup_lazy_nvim()

---------------
--- options ---
---------------
local setup_options = function()
    -- leader key
    vim.g.mapleader = "\\"
    vim.g.maplocalleader = "\\"

    -- enable editorconfig
    vim.g.editorconfig = true

    -- line numbers
    vim.opt.number = true

    -- disable the mouse
    vim.opt.mouse = ""

    -- incremental search
    vim.opt.incsearch = true

    -- use smart casing for search
    vim.opt.ignorecase = true
    vim.opt.smartcase = true

    -- preview substitutions as you type
    vim.opt.inccommand = "split"

    -- use system keyboard
    vim.opt.clipboard = "unnamedplus"

    -- no wrapping
    vim.opt.wrap = false

    -- don't show the intro message when opening neovim
    vim.opt.shortmess:append("I")

    -- reserve a space in the gutter, this avoids the annoying
    -- layout shift in the gutter
    vim.opt.signcolumn = "yes"

    -- automatically set the current dir to the dir of the buffer
    -- vim.opt.autochdir = true
end
setup_options()

-------------
-- keymaps --
-------------
local setup_keymaps = function()
    -- toggle case sensitivity
    vim.keymap.set("n", "<leader>cs", function()
        vim.o.ignorecase = not vim.o.ignorecase
        vim.o.smartcase = not vim.o.smartcase
        print("Case Sensitivity: " .. (vim.o.ignorecase and "Off" or "On"))
    end, { desc = "Toggle case sensitivity for search" })

    -- esc will stop search highlighting
    vim.keymap.set("n", "<esc>", ":noh<enter><esc>", kopt)

    -- mark the place where you started a search as '
    vim.keymap.set("n", "/", "ms/", kopt)

    -- scroll up/down
    vim.keymap.set({ "n", "v" }, "<C-k>", "<C-y>", kopt)
    vim.keymap.set({ "n", "v" }, "<C-j>", "<C-e>", kopt)

    -- super commands
    vim.keymap.set("n", "<D-e>", ":e ~/.config/nvim/init.lua<enter>", kopt)
    vim.keymap.set("n", "<D-s>", ":w<enter>", kopt)
    vim.keymap.set("i", "<D-s>", "<esc>:w<enter>a", kopt)
    vim.keymap.set("n", "<D-r>", "<cmd>luafile ~/.config/nvim/init.lua<cr>", kopt)

    -- function to toggle cursorline and cursorcolumn
    function ToggleCursorHighlight()
        if vim.wo.cursorline and vim.wo.cursorcolumn then
            vim.wo.cursorline = false
            vim.wo.cursorcolumn = false
        else
            vim.wo.cursorline = true
            vim.wo.cursorcolumn = true
        end
    end

    vim.keymap.set("n", "<D-y>", ":lua ToggleCursorHighlight()<CR>", kopt)
end
setup_keymaps()

---------------
--- plugins ---
---------------
local plugins = {}

-------------------------------------------------------------------------------

local function nightfox_plugin()
    return { "EdenEast/nightfox.nvim" }
end
table.insert(plugins, nightfox_plugin())

-------------------------------------------------------------------------------

local function web_devicons_plugin()
    return { "nvim-tree/nvim-web-devicons" }
end
table.insert(plugins, web_devicons_plugin())

-------------------------------------------------------------------------------

local function treesitter_plugin()
    return { "nvim-treesitter/nvim-treesitter" }
end
table.insert(plugins, treesitter_plugin())

-------------------------------------------------------------------------------

local function readline_plugin()
    local function config()
        local readline = require("readline")
        -- navigation
        vim.keymap.set({ "i", "c", "n", "v" }, "<C-a>", readline.beginning_of_line)
        vim.keymap.set({ "i", "c", "n", "v" }, "<C-e>", readline.end_of_line)
        vim.keymap.set({ "i", "c", "n", "v" }, "<M-f>", readline.forward_word)
        vim.keymap.set({ "i", "c", "n", "v" }, "<M-b>", readline.backward_word)
        vim.keymap.set({ "i", "c", "n", "v" }, "<C-f>", "<Right>")
        vim.keymap.set({ "i", "c", "n", "v" }, "<C-b>", "<Left>")
        vim.keymap.set({ "i", "c", "n", "v" }, "<C-n>", "<Down>")
        vim.keymap.set({ "i", "c", "n", "v" }, "<C-p>", "<Up>")

        -- deletion
        vim.keymap.set("!", "<C-d>", "<Delete>")
        vim.keymap.set("!", "<C-k>", readline.kill_line)
        vim.keymap.set("!", "<C-u>", readline.backward_kill_line)
        vim.keymap.set("!", "<M-d>", readline.kill_word)
        vim.keymap.set("!", "<M-BS>", readline.backward_kill_word)
    end
    return { "assistantcontrol/readline.nvim", config = config }
end
table.insert(plugins, readline_plugin())

-------------------------------------------------------------------------------

local function fzf_plugin()
    return { "junegunn/fzf" }
end
table.insert(plugins, fzf_plugin())

-------------------------------------------------------------------------------

local function fzf_lua_plugin()
    -- fzf keymaps
    local function config()
        vim.keymap.set("n", "<leader>ff", "<cmd> FzfLua <cr>", kopt)
        vim.keymap.set("n", "<leader>fo", "<cmd> FzfLua files <cr>", kopt)
        vim.keymap.set("n", "<leader>fh", "<cmd> FzfLua oldfiles <cr>", kopt)
        vim.keymap.set("n", "<leader>fg", "<cmd> FzfLua grep_visual '' <cr>", kopt)
        vim.keymap.set("n", "<leader>fc", "<cmd> FzfLua registers '' <cr>", kopt)
        vim.keymap.set("n", "<leader>fb", "<cmd> FzfLua buffers '' <cr>", kopt)
        vim.keymap.set("n", "<leader>fs", "<cmd> FzfLua lsp_document_symbols '' <cr>", kopt)
        vim.keymap.set("n", "<leader>fS", "<cmd> FzfLua lsp_workspace_symbols '' <cr>", kopt)
        vim.keymap.set("n", "<leader>fd", "<cmd> FzfLua lsp_workspace_diagnostics '' <cr>", kopt)
        vim.keymap.set("n", "<leader>fr", "<cmd> FzfLua lsp_references '' <cr>", kopt)
    end
    return { "fzf-lua", config = config }
end
table.insert(plugins, fzf_lua_plugin())

-------------------------------------------------------------------------------

local function noice_plugin()
    return {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
    }
end
table.insert(plugins, noice_plugin())

-------------------------------------------------------------------------------
local function yazi_plugin()
    local function config()
        vim.keymap.set("n", "<leader>y", "<cmd> Yazi <cr>", kopt)
        vim.keymap.set("n", "<leader>Y", "<cmd> Yazi cwd <cr>", kopt)
    end
    return { "mikavilpas/yazi.nvim", config = config }
end
table.insert(plugins, yazi_plugin())

-------------------------------------------------------------------------------
local function lspconfig_plugin()
    local function config()
        -- misc options
        vim.lsp.diagnostic.underline = true

        -- https://lsp-zero.netlify.app/docs/getting-started.html
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
            end,
        })

        --------------------
        -- format on save --
        --------------------
        -- https://lsp-zero.netlify.app/docs/getting-started
        local buffer_autoformat = function(bufnr)
            local group = "lsp_autoformat"
            vim.api.nvim_create_augroup(group, { clear = false })
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                group = group,
                desc = "LSP format on save",
                callback = function()
                    -- note: do not enable async formatting
                    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
                end,
            })
        end
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local id = vim.tbl_get(event, "data", "client_id")
                local client = id and vim.lsp.get_client_by_id(id)
                if client == nil then
                    return
                end

                -- make sure there is at least one client with formatting capabilities
                if client.supports_method("textDocument/formatting") then
                    buffer_autoformat(event.buf)
                end
            end,
        })
    end

    return { "nvim/nvim-lspconfig", config = config }
end
table.insert(plugins, lspconfig_plugin())

-------------------------------------------------------------------------------

local function cmp_plugin()
    local function config()
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            window = {},
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "path" },
            }),
        })

        local cmp_mapping = cmp.mapping
        cmp.setup({
            mapping = {
                ["<C-p>"] = cmp_mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }), -- Enable in insert and select modes

                ["<C-n>"] = cmp_mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
        })
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })
    end

    return { "hrsh7th/nvim-cmp", config = config }
end
table.insert(plugins, { "hrsh7th/cmp-nvim-lsp" })
table.insert(plugins, { "hrsh7th/cmp-buffer" })
table.insert(plugins, { "hrsh7th/cmp-path" })
table.insert(plugins, { "hrsh7th/cmp-cmdline" })
table.insert(plugins, cmp_plugin())

-------------------------------------------------------------------------------

local function toggleterm_plugin()
    local function config()
        vim.keymap.set({ "n", "i", "t", "v", "c" }, "<D-j>", "<cmd> ToggleTerm <cr>", kopt)
        require("toggleterm").setup {
            border = 'curved',
            direction = 'float',
        }
    end
    return { 'akinsho/toggleterm.nvim', config = config }
end
table.insert(plugins, toggleterm_plugin())

-------------------------------------------------------------------------------

local function gitsigns_plugin()
    local function config()
        vim.keymap.set("n", "<leader>gn", "<cmd> Gitsigns next_hunk <cr>", kopt)
        vim.keymap.set("n", "<leader>gp", "<cmd> Gitsigns prev_hunk <cr>", kopt)
        vim.keymap.set("n", "<leader>gi", "<cmd> Gitsigns preview_hunk_inline <cr>", kopt)
        vim.keymap.set("n", "<leader>gr", "<cmd> Gitsigns reset_hunk <cr>", kopt)
    end
    return { "lewis6991/gitsigns.nvim", config = config }
end
table.insert(plugins, gitsigns_plugin())

-------------------------------------------------------------------------------

local function diffview_plugin()
    return { "sindrets/diffview.nvim" }
end
table.insert(plugins, diffview_plugin())

-------------------------------------------------------------------------------

local function comment_plugin()
    return { "numToStr/Comment.nvim" }
end
table.insert(plugins, comment_plugin())

-------------------------------------------------------------------------------

local function vim_fugitive_plugin()
    return { "topope/vim-fugitive" }
end
table.insert(plugins, vim_fugitive_plugin())

-------------------------------------------------------------------------------

-- load plugins
require("lazy").setup({ spec = plugins })

-- colorscheme
vim.cmd.colorscheme("nordfox")

-- lsp servers
local function setup_lsp_servers()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local c = require("lspconfig")
    c.ocamllsp.setup({ capabilities = capabilities })
    c.ruff.setup({ capabilities = capabilities })
    c.rust_analyzer.setup({ capabilities = capabilities })
    c.lua_ls.setup({ capabilities = capabilities, settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
end
setup_lsp_servers()
