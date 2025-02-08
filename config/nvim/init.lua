----------------------------------
--- global constants/functions ---
----------------------------------
local kset = vim.keymap.set

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

  -- reserve a space in the gutter
  -- this avoids the annoying layout shift when stuff pops in/out of the gutter
  vim.opt.signcolumn = "yes"

  vim.diagnostic.config({
    update_in_insert = true, -- show diagnostics in insert mode
    underline = true         -- underline location of diagnostics
  })

  -- large scrollback buffer for :terminal sessions
  vim.g.terminal_scrollback_buffer_size = 100000
end

-------------
-- keymaps --
-------------

local function setup_keymaps()
  -- search highlighting on esc
  kset("n", "<esc>", ":noh<enter><esc>", { noremap = true, silent = true })

  -- mark loc before starting a search as s
  kset("n", "/", "ms/", { noremap = true })

  -- scroll up/down
  kset({ "n", "v" }, "<C-k>", "<C-y>", { noremap = true, silent = true }, { desc = "Scroll up" })
  kset({ "n", "v" }, "<C-j>", "<C-e>", { noremap = true, silent = true }, { desc = "Scroll down" })

  -- indent/dedent
  kset("n", ">", ">>", { noremap = true, silent = true }, { desc = "Indent" })
  kset("n", "<", "<<", { noremap = true, silent = true }, { desc = "Dedent" })
  kset("v", ">", ">gv", { noremap = true, silent = true }, { desc = "Indent" })
  kset("v", "<", "<gv", { noremap = true, silent = true }, { desc = "Dedent" })

  -- select all
  kset("n", "<leader>a", "ggVG", { remap = false }, { desc = "Select all" })

  -- buffer stuff
  kset("n", "<leader>s", function() vim.cmd("update") end, { desc = "Save buffer" })
  kset("n", "<leader>cq", function() vim.cmd("quitall!") end, { desc = "Force quit all" })

  kset({ "n", "i", "v" }, "<C-w><C-c>", function()
    local buf = vim.api.nvim_get_current_buf()

    -- do nothing if we are in the default unnamed buffer or if we are in buff 0
    if vim.fn.expand('%') == '' or vim.fn.bufnr('#') == 0 then
      return
    end

    -- print an error if the buffer has unsaved changes
    if vim.api.nvim_buf_get_option(buf, 'modified') then
      print("Error: Buffer has unsaved changes!")
      return
    end

    -- if there exists another buffer, switch to it else
    vim.cmd('buffer #') -- Switch to the alternate buffer
    vim.cmd('bdelete ' .. buf)
  end, { noremap = true }, { desc = "Close buffer" })

  -- init.lua stuff
  kset("n", "<leader>cc", function() vim.cmd("e ~/.config/nvim/init.lua") end, { desc = "Go to init.lua" })
  kset("n", "<leader>cr", function() vim.cmd("luafile ~/.config/nvim/init.lua") end,
    { desc = "Reload init.lua" })

  -- toggle case sensitivity
  kset("n", "<leader>cs", function()
    vim.o.ignorecase = not vim.o.ignorecase
    vim.o.smartcase = not vim.o.smartcase
    print("Case Sensitivity: " .. (vim.o.ignorecase and "Off" or "On"))
  end, { desc = "Toggle case sensitivity for search" })

  -- toggle cursor/line column
  kset("n", "<leader>cl", function()
    if vim.wo.cursorline and vim.wo.cursorcolumn then
      vim.wo.cursorline = false
      vim.wo.cursorcolumn = false
    else
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = true
    end
  end, { desc = "Toggle cursorline and cursorcolumn" })

  -- window navigation
  kset({ "n", "v" }, "<C-1>", "<Esc>1<C-w>w", { noremap = true }, { desc = "Focus window 1" })
  kset({ "n", "v" }, "<C-2>", "<Esc>2<C-w>w", { noremap = true }, { desc = "Focus window 2" })
  kset({ "n", "v" }, "<C-3>", "<Esc>3<C-w>w", { noremap = true }, { desc = "Focus window 3" })
  kset({ "n", "v" }, "<C-4>", "<Esc>4<C-w>w", { noremap = true }, { desc = "Focus window 4" })
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

      kset("n", "<C-g>j", function() harpoon:list():replace_at(1) end, { desc = "Go to Harpoon 1" })
      kset("n", "<C-g>k", function() harpoon:list():replace_at(2) end, { desc = "Go to Harpoon 2" })
      kset("n", "<C-g>l", function() harpoon:list():replace_at(3) end, { desc = "Go to Harpoon 3" })
      kset("n", "<C-g>;", function() harpoon:list():replace_at(4) end, { desc = "Go to Harpoon 4" })
      kset("n", "<C-g><C-j>", function() harpoon:list():select(1) end, { desc = "Set Harpoon 1" })
      kset("n", "<C-g><C-k>", function() harpoon:list():select(2) end, { desc = "Set Harpoon 2" })
      kset("n", "<C-g><C-l>", function() harpoon:list():select(3) end, { desc = "Set Harpoon 3" })
      kset("n", "<C-g><C-;>", function() harpoon:list():select(4) end, { desc = "Set Harpoon 4" })
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
        indent = { enable = true }
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
          kset({ "n", "v" }, "<leader>ff", function() vim.cmd("FzfLua files") end, { desc = "Files" })
          kset({ "n", "v" }, "<leader>fo", function() vim.cmd("FzfLua oldfiles") end, { desc = "Old Files" })
          kset({ "n", "v" }, "<leader>fs", function() vim.cmd("FzfLua lsp_document_symbols ''") end,
            { desc = "Symbols in file" })
          kset({ "n", "v" }, "<leader>fS", function() vim.cmd("FzfLua lsp_workspace_symbols ''") end,
            { desc = "Symbols in workspace" })
          kset("n", "<leader>fj", function() vim.cmd("FzfLua jumps") end, { desc = "Jumps" })
          kset("n", "<leader>fz", function() vim.cmd("FzfLua") end, { desc = "Fzf" })
          kset("n", "<leader>fh", function() vim.cmd("FzfLua helptags") end, { desc = "Help" })
          kset("n", "<leader>fg", function() vim.cmd("FzfLua grep_visual ''") end, { desc = "Grep" })
          kset("n", "<leader>fc", function() vim.cmd("FzfLua registers ''") end, { desc = "Registers" })
          kset("n", "<leader>fb", function() vim.cmd("FzfLua buffers ''") end, { desc = "Buffers" })
          kset("n", "<leader>fd", function() vim.cmd("FzfLua lsp_workspace_diagnostics ''") end,
            { desc = "Problems in workspace" })
          kset("n", "gr", function() vim.cmd("FzfLua lsp_references ''") end, { desc = "References" })
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
          command_palette = true, -- position the cmdline and popupmenu together at the top
        },
      })
    end
  }
end

-------------------------------------------------------------------------------

local function toggleterm_plugin()
  return {
    'akinsho/toggleterm.nvim',
    config =
        function()
          kset({ "n", "i", "t", "v", "c" }, "<C-0>", function() vim.cmd("ToggleTerm") end)
          require("toggleterm").setup { direction = 'float' }
        end
  }
end

-------------------------------------------------------------------------------

local function lspconfig_plugin()
  local function setup_cmp()
    local cmp = require("cmp")

    local function make_mapping()
      IN_CMP = false
      local tab = function(fallback)
        if cmp.visible() then
          IN_CMP = true
          cmp.select_next_item()
        else
          cmp.abort()
          fallback()
        end
      end
      local shift_tab = function(fallback)
        if cmp.visible() then
          IN_CMP = true
          cmp.select_prev_item()
        else
          cmp.abort()
          fallback()
        end
      end
      local cr = function(fallback)
        if IN_CMP then
          IN_CMP = false
          cmp.confirm()
        else
          cmp.abort()
          fallback()
        end
      end
      local cc = function(fallback)
        if cmp.visible() then
          IN_CMP = false
          cmp.abort()
        else
          fallback()
        end
      end

      return tab, shift_tab, cr, cc, cspace
    end

    local mapping = (function()
      local tab, shift_tab, cr, cc, cspace = make_mapping()
      return {
        ["<Tab>"] = { i = tab },
        ["<S-Tab>"] = { i = shift_tab },
        ["<CR>"] = { i = cr },
        ["<C-c>"] = { i = cc },
      }
    end)()

    local mapping_cmdline = (function()
      local tab, shift_tab, cr, cc, cspace = make_mapping()
      return {
        ["<Tab>"] = { c = tab },
        ["<S-Tab>"] = { c = shift_tab },
        ["<CR>"] = { c = cr },
        ["<C-c>"] = { c = cc },
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
      desc = "LSP actions",
      callback = function(event)
        local opts = { buffer = event.buf }

        kset("n", "gh", function() vim.cmd("lua vim.lsp.buf.hover()") end, opts)
        kset("n", "gd", function() vim.cmd("lua vim.lsp.buf.definition()") end, opts)
        kset("n", "gD", function() vim.cmd("lua vim.lsp.buf.declaration()") end, opts)
        kset("n", "gi", function() vim.cmd("lua vim.lsp.buf.implementation()") end, opts)
        kset("n", "go", function() vim.cmd("lua vim.lsp.buf.type_definition()") end, opts)
        kset("n", "gr", function() vim.cmd("lua vim.lsp.buf.references()") end, opts)
        kset("n", "gs", function() vim.cmd("lua vim.lsp.buf.signature_help()") end, opts)
        kset("n", "gR", function() vim.cmd("lua vim.lsp.buf.rename()") end, opts)
        kset({ "n", "x" },
          "<F3>",
          function() vim.cmd("lua vim.lsp.buf.format({async = true})") end,
          opts)
        kset("n", "<F4>", function() vim.cmd("lua vim.lsp.buf.code_action()") end, opts)
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

  local function setup_lsp_servers()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp = require("lspconfig")
    lsp.ocamllsp.setup({ capabilities = capabilities })
    lsp.ruff.setup({ capabilities = capabilities })
    lsp.rust_analyzer.setup({ capabilities = capabilities })
    lsp.lua_ls.setup({ capabilities = capabilities, settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
  end

  return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline"
    },
    config = function()
      setup_lspconfig()
      setup_cmp()
      setup_lsp_servers()
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
  return {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      kset("n", "[c", function()
        vim.cmd("Gitsigns prev_hunk")
        vim.cmd("normal! zz")
      end, { desc = "Go to next hunk", silent = true })
      kset("n", "]c", function()
        vim.cmd("Gitsigns next_hunk")
        vim.cmd("normal! zz")
      end, { desc = "Go to next hunk", silent = true })
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
      toggleterm_plugin(),
      gitsigns_plugin(),
      readline_plugin(),
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
