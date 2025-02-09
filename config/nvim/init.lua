----------------------------------
--- global constants/functions ---
----------------------------------

local kset = vim.keymap.set
local function run(cmd)
  return function()
    vim.cmd(cmd)
  end
end

---------------
--- options ---
---------------

local function setup_options()
  vim.g.editorconfig = true         -- use editrconfig settings

  vim.opt.number = true             -- show line numbers
  vim.opt.relativenumber = true     -- use relative line numbers

  vim.opt.mouse = ""                -- disable the mouse

  vim.opt.incsearch = true          -- highlight search matches as you type
  vim.opt.ignorecase = true         -- ignore case in search
  vim.opt.smartcase = true          -- unless the search has a capital

  vim.opt.inccommand = "split"      -- preview substitutions as you type

  vim.opt.clipboard = "unnamedplus" -- use system clipboard

  vim.opt.wrap = false              -- don't wrap lines

  vim.opt.shortmess:append("I")     -- don't show neovim splash screen message

  vim.opt.colorcolumn = "80"        -- show ruler at col 80

  vim.opt.termguicolors = true      -- idk a lot of ppl have this in their .vimrc

  -- better indenting
  vim.opt.autoindent = true
  vim.opt.smartindent = true

  -- reserve a space in the gutter
  -- this avoids the annoying layout shift when stuff pops in/out of the gutter
  vim.opt.signcolumn = "yes"

  -- diagnostics
  vim.diagnostic.config({
    update_in_insert = false,
    underline = true
  })

  -- use persistent undo and remove swap files
  local undo_dir = "/tmp/.nvim-undo-dir"
  if vim.fn.isdirectory(undo_dir) == 0 then vim.fn.mkdir(undo_dir, "", "0700") end
  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.undofile = true
  vim.opt.undodir = undo_dir
end

-------------
-- keymaps --
-------------

local function setup_keymaps()
  -- use C-c as escape, and exit search highlighting on C-c
  kset({ "i", "x" }, "<C-c>", "<Esc>", { noremap = true, silent = true })
  kset("n", "<C-c>", ":noh<CR><Esc>", { noremap = true, silent = true })

  -- mark loc before starting a search as s
  kset("n", "/", "ms/", { noremap = true })

  -- swap ' and `
  kset({ "n", "v" }, "'", "`", { noremap = true })
  kset({ "n", "v" }, "`", "'", { noremap = true })

  -- scroll up/down
  kset({ "n", "v" }, "<C-k>", "<C-y>", { noremap = true, silent = true })
  kset({ "n", "v" }, "<C-j>", "<C-e>", { noremap = true, silent = true })

  -- better pasting (paste yanked text below in new line with indenting)
  kset('n', '<leader>p', 'o<Esc>p`[v`]=<Esc>`]', { noremap = true, silent = true })

  -- indent/dedent
  kset("n", ">", ">>", { noremap = true, silent = true })
  kset("n", "<", "<<", { noremap = true, silent = true })
  kset("v", ">", ">gv", { noremap = true, silent = true })
  kset("v", "<", "<gv", { noremap = true, silent = true })

  -- stop pasting in visual from overriding you're yank register
  kset("v", "p", "\"_dP", { noremap = true, silent = true })

  -- don't immediately jump to next thing under cursor when using *
  kset("n", '*', 'mi*<CR>`i', { noremap = true, silent = true })
  kset("v", '*', 'mi"yy/<C-r>y<CR>`i', { noremap = true, silent = true })

  -- init.lua stuff
  kset("n", "<leader>cc", run("e ~/.config/nvim/init.lua"))
  kset("n", "<leader>cr", run("luafile ~/.config/nvim/init.lua"))


  -- toggle case sensitivity
  kset("n", "<leader>cs", function()
    vim.o.ignorecase = not vim.o.ignorecase
    vim.o.smartcase = not vim.o.smartcase
    print("Case Sensitivity: " .. (vim.o.ignorecase and "Off" or "On"))
  end)

  -- toggle cursor/line column
  kset("n", "<leader>cl", function()
    if vim.wo.cursorline and vim.wo.cursorcolumn then
      vim.wo.cursorline = false
      vim.wo.cursorcolumn = false
    else
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = true
    end
  end)

  -- when exiting visual mode, return back to the place where it was started
  vim.keymap.set('n', 'v', 'mvv', { noremap = true })
  vim.keymap.set('n', 'V', 'mvV', { noremap = true })
  vim.keymap.set('v', '<C-c>', "<Esc>`v", { noremap = true, silent = true })

  -- window navigation
  kset({ "n", "v" }, "<C-1>", "<Esc>1<C-w>w", { noremap = true })
  kset({ "n", "v" }, "<C-2>", "<Esc>2<C-w>w", { noremap = true })
  kset({ "n", "v" }, "<C-3>", "<Esc>3<C-w>w", { noremap = true })
  kset({ "n", "v" }, "<C-4>", "<Esc>4<C-w>w", { noremap = true })
end

--------------------
--- autocommands ---
--------------------

local function setup_autocommands()
  -- open help windows on a rightmost split
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
      vim.cmd("wincmd L")
    end,
  })

  -- highlight yanked contents
  vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 20 }
    end,
  })
end

---------------
--- plugins ---
---------------

-------------------------------------------------------------------------------

local function harpoon_plugin()
  return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      kset("n", "<C-g>j", function() harpoon:list():replace_at(1) end)
      kset("n", "<C-g>k", function() harpoon:list():replace_at(2) end)
      kset("n", "<C-g>l", function() harpoon:list():replace_at(3) end)
      kset("n", "<C-g>;", function() harpoon:list():replace_at(4) end)
      kset("n", "<C-g><C-j>", function() harpoon:list():select(1) end)
      kset("n", "<C-g><C-k>", function() harpoon:list():select(2) end)
      kset("n", "<C-g><C-l>", function() harpoon:list():select(3) end)
      kset("n", "<C-g><C-;>", function() harpoon:list():select(4) end)
    end
  }
end

-------------------------------------------------------------------------------

local function treesitter_plugin()
  return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "rust", "ocaml", "lua", "javascript", "typescript", "python", "json", "css", "html" },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "v",
            node_decremental = "V"
          }
        }
      })
    end
  }
end

-------------------------------------------------------------------------------

local function fzf_lua_plugin()
  return {
    "fzf-lua",
    dependencies = { "junegunn/fzf", "nvim-tree/nvim-web-devicons" },
    config =
        function()
          kset("n", "<leader>ff", run("FzfLua files"))
          kset("n", "<leader>fo", run("FzfLua oldfiles"))
          kset("n", "<leader>fs", run("FzfLua lsp_document_symbols ''"))
          kset("n", "<leader>fS", run("FzfLua lsp_workspace_symbols ''"))
          kset("n", "<leader>fj", run("FzfLua jumps"))
          kset("n", "<leader>fz", run("FzfLua"))
          kset("n", "<leader>fh", run("FzfLua helptags"))
          kset("n", "<leader>fg", run("FzfLua grep_visual ''"))
          kset("n", "<leader>fc", run("FzfLua registers ''"))
          kset("n", "<leader>fb", run("FzfLua buffers ''"))
          kset("n", "<leader>fd", run("FzfLua lsp_workspace_diagnostics ''"))
          kset("n", "gr", run("FzfLua lsp_references ''"))
        end
  }
end

-------------------------------------------------------------------------------

local function noice_plugin()
  return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opt = {}, -- idk why, but when I remove this line things break
    config = function()
      require("noice").setup({
        presets = {
          command_palette = true, -- put the command pallete at the top
        },
      })
    end
  }
end

-------------------------------------------------------------------------------

local function lspconfig_plugin()
  local function setup_cmp()
    local cmp = require("cmp")

    local function make_mapping()
      IN_CMP = false
      local next_item = function(fallback)
        if cmp.visible() then
          IN_CMP = true
          cmp.select_next_item()
        else
          cmp.abort()
          fallback()
        end
      end
      local prev_item = function(fallback)
        if cmp.visible() then
          IN_CMP = true
          cmp.select_prev_item()
        else
          cmp.abort()
          fallback()
        end
      end
      local select_item = function(fallback)
        if IN_CMP then
          IN_CMP = false
          cmp.confirm()
        else
          cmp.abort()
          fallback()
        end
      end
      local cancel_cmp = function(fallback)
        if cmp.visible() then
          IN_CMP = false
          cmp.abort()
        else
          fallback()
        end
      end

      return next_item, prev_item, select_item, cancel_cmp
    end

    local mapping = (function()
      local next_item, prev_item, select_item, cancel_cmp = make_mapping()
      return {
        ["<Tab>"] = { i = next_item },
        ["<S-Tab>"] = { i = prev_item },
        ["<CR>"] = { i = select_item },
        ["<C-BS>"] = { i = cancel_cmp },
      }
    end)()

    local mapping_cmdline = (function()
      local next_item, prev_item, select_item, cancel_cmp = make_mapping()
      return {
        ["<Tab>"] = { c = next_item },
        ["<S-Tab>"] = { c = prev_item },
        ["<CR>"] = { c = select_item },
        ["<C-BS>"] = { c = cancel_cmp },
      }
    end)()

    cmp.setup({
      snippet = {
        -- REQUIRED, a snippet engine must be set
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      mapping = mapping,
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = mapping_cmdline,
      sources = { { name = "buffer" } },
    })

    cmp.setup.cmdline(":", {
      mapping = mapping_cmdline,
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end

  local function setup_lspconfig()
    -- https://lsp-zero.netlify.app/docs/getting-started.html
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local opts = { buffer = event.buf }

        kset("n", "gh", run("lua vim.lsp.buf.hover()"), opts)
        kset("n", "gd", run("lua vim.lsp.buf.definition()"), opts)
        kset("n", "gD", run("lua vim.lsp.buf.declaration()"), opts)
        kset("n", "gi", run("lua vim.lsp.buf.implementation()"), opts)
        kset("n", "go", run("lua vim.lsp.buf.type_definition()"), opts)
        kset("n", "gr", run("lua vim.lsp.buf.references()"), opts)
        kset("n", "gs", run("lua vim.lsp.buf.signature_help()"), opts)
        kset("n", "gR", run("lua vim.lsp.buf.rename()"), opts)
        kset("n", "<F3>", run("lua vim.lsp.buf.format({async = true})"), opts)
        kset("n", "<F4>", run("lua vim.lsp.buf.code_action()"), opts)
      end
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

  local function setup_lsp_servers()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp = require("lspconfig")
    lsp.ocamllsp.setup({ capabilities = capabilities })
    lsp.ruff.setup({ capabilities = capabilities })
    lsp.rust_analyzer.setup({ capabilities = capabilities })
    lsp.lua_ls.setup({ capabilities = capabilities, settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
  end

  local function setup_mason()
    require("mason").setup()
  end

  return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "williamboman/mason.nvim"
    },
    config = function()
      setup_lspconfig()
      setup_cmp()
      setup_lsp_servers()
      setup_mason()
    end
  }
end

-------------------------------------------------------------------------------

local function readline_plugin()
  return {
    "jaymody/readline.nvim",
    config = function()
      local readline = require("readline")
      -- navigation
      kset({ "i", "c", "n", "v" }, "<C-a>", readline.back_to_indentation)
      kset({ "i", "c", "n", "v" }, "<C-e>", readline.end_of_line)
      kset({ "i", "c", "n", "v" }, "<M-f>", readline.forward_word)
      kset({ "i", "c", "n", "v" }, "<M-b>", readline.backward_word)
      kset({ "i", "c", "n", "v" }, "<C-f>", "<Right>")
      kset({ "i", "c", "n", "v" }, "<C-b>", "<Left>")
      kset({ "i", "c", "n", "v" }, "<C-n>", "<Down>")
      kset({ "i", "c", "n", "v" }, "<C-p>", "<Up>")

      -- deletion
      kset("!", "<C-d>", "<Delete>")
      kset("!", "<C-k>", readline.kill_line)
      kset("!", "<C-u>", readline.backward_kill_to_indentation)
      kset("!", "<M-d>", readline.kill_word)
      kset("!", "<M-BS>", readline.backward_kill_word)
    end
  }
end

-------------------------------------------------------------------------------

local function gitsigns_plugin()
  local function gitsigns_visual_op(op)
    return function()
      return require('gitsigns')[op]({ vim.fn.line("."), vim.fn.line("v") })
    end
  end

  local function do_and_center(op)
    return function()
      vim.cmd(op)
      local hunks = require("gitsigns").get_hunks()
      if hunks and #hunks > 0 then vim.cmd('normal! zz') end
    end
  end

  return {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      kset("n", "[c", do_and_center('Gitsigns prev_hunk'))
      kset("n", "]c", do_and_center('Gitsigns next_hunk'))
      kset("n", "<leader>gi", run('Gitsigns preview_hunk_inline'))
      kset("n", "<leader>gp", run('Gitsigns preview_hunk'))
      kset("n", "<leader>gr", run('Gitsigns reset_hunk'))
      kset("n", "<leader>gs", run('Gitsigns stage_hunk'))
      kset("n", "<leader>gu", run('Gitsigns undo_stage_hunk'))
      kset("v", "<leader>gr", gitsigns_visual_op("reset_hunk"))
      kset("v", "<leader>gs", gitsigns_visual_op("stage_hunk"))
      kset("v", "<leader>gu", gitsigns_visual_op("undo_stage_hunk"))
    end
  }
end

-------------------------------------------------------------------------------

------------
--- main ---
------------

local setup_lazy_nvim = function()
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

  -- setting leader key needs to happen early after setting up lazy_nvim,
  -- or at least that's what lazy.nvim tells me
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
end

local function setup_plugins()
  require("lazy").setup({
    spec = {
      harpoon_plugin(),
      treesitter_plugin(),
      fzf_lua_plugin(),
      noice_plugin(),
      lspconfig_plugin(),
      gitsigns_plugin(),
      readline_plugin(),
      { "tpope/vim-surround" },
      { "EdenEast/nightfox.nvim" }
    }
  })
end

-------------------------------------------------------------------------------

local function main()
  setup_lazy_nvim()
  setup_options()
  setup_keymaps()
  setup_autocommands()
  setup_plugins()
  vim.cmd.colorscheme("nordfox")
end

main()
