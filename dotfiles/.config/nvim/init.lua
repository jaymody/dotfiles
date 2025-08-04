-- version check
if vim.fn.has("nvim-0.11") == 0 then
  vim.notify("Config requires Neovim 0.11+", vim.log.levels.ERROR)
  return
end

-- helper functions
local function run(cmd)
  return function()
    vim.cmd(cmd)
  end
end

-- options
local function setup_options()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  vim.g.netrw_banner = 0
  vim.g.netrw_liststyle = 3

  vim.opt.number = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.inccommand = "split"
  vim.opt.clipboard = "unnamedplus"
  vim.opt.wrap = false
  vim.opt.confirm = true
  vim.opt.signcolumn = "yes"
  vim.opt.showmode = false
  vim.opt.cursorline = true
  vim.opt.undofile = true
  vim.opt.termguicolors = true
  vim.opt.winborder = "single"

  vim.diagnostic.config({
    underline = true,
    signs = true,
    float = { border = "single" },
    jump = { float = true },
    update_in_insert = true
  })
end

-- keymaps
local function setup_keymaps()
  vim.keymap.set("n", "<C-c>", run("silent noh"))
  vim.keymap.set("v", "p", "\"_dP", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>c", ":e ~/.config/nvim/init.lua<CR>", { silent = true })
  vim.keymap.set("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { silent = true })
  vim.keymap.set("n", "<leader>e", ":Ex<CR>", { silent = true })
  vim.keymap.set({ "i", "n", "v", "x", "c" }, "<C-p>", "<Up>")
  vim.keymap.set({ "i", "n", "v", "x", "c" }, "<C-n>", "<Down>")
  vim.keymap.set({ "i", "n" }, "<C-s>", run("silent update | stopinsert"))
end

-- autocmd
local function setup_autocmds()
  vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 50 }
    end
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = run("wincmd L")
  })
end

-- lsp
local function setup_lua()
  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
        },
      },
    },
  })
  vim.lsp.enable('lua_ls')
end

local function setup_rust()
  vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
  })
  vim.lsp.enable("rust_analyzer")
end

local function setup_ocaml()
  vim.g.no_ocaml_maps = true
  vim.lsp.config("ocamllsp", {
    cmd = { "ocamllsp" },
    filetypes = { "ocaml" },
    root_markers = { "dune-project", ".git" }
  })
  vim.lsp.enable("ocamllsp")
end

local function setup_lsp()
  -- autocomplete menu and autoformat
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

      if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      end

      if client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end,
  })

  -- use .git as the universal indicator of the root of a project
  vim.lsp.config('*', {
    root_markers = { '.git' },
  })

  -- setup language servers
  setup_lua()
  setup_rust()
  setup_ocaml()
end

-- lazy.nvim
local function setup_lazy_nvim()
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

-- plugins
local function plugin_onedark()
  return {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = "dark",
        code_style = {
          comments  = "none",
          keywords  = "none",
          functions = "none",
          strings   = "none",
          variables = "none",
        },
        diagnostics = {
          darker = true,
          undercurl = true,
          background = true,
        },
      }
      require('onedark').load()
    end
  }
end

local function plugin_surround()
  return {
    "tpope/vim-surround",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      vim.keymap.set("v", "s", "<Plug>VSurround")
    end
  }
end

local function plugin_treesitter()
  return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "rust", "ocaml", "lua", "javascript", "typescript",
          "python", "json", "css", "html", "zig", "markdown", "markdown_inline",
          "cpp", "toml", "sql", "bash", "vim", "vimdoc", "dockerfile", "gitignore"
        },
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
            scope_incremental = "\\"
          }
        }
      })
    end
  }
end

local function plugin_gitsigns()
  local function gitsigns_visual_op(op)
    return function()
      return require('gitsigns')[op]({ vim.fn.line("."), vim.fn.line("v") })
    end
  end

  local function do_and_center(op)
    return function()
      require('gitsigns').nav_hunk(op, {}, function()
        local hunks = require("gitsigns").get_hunks()
        if hunks and #hunks > 0 then vim.cmd('normal! zz') end
      end)
    end
  end

  return {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<M-[>", do_and_center('prev'))
      vim.keymap.set("n", "<M-]>", do_and_center('next'))
      vim.keymap.set("n", "<leader>gi", run('Gitsigns preview_hunk_inline'))
      vim.keymap.set("n", "<leader>gp", run('Gitsigns preview_hunk'))
      vim.keymap.set("n", "<leader>gr", run('Gitsigns reset_hunk'))
      vim.keymap.set("n", "<leader>gs", run('Gitsigns stage_hunk'))
      vim.keymap.set("n", "<leader>gu", run('Gitsigns undo_stage_hunk'))
      vim.keymap.set("v", "<leader>gr", gitsigns_visual_op("reset_hunk"))
      vim.keymap.set("v", "<leader>gs", gitsigns_visual_op("stage_hunk"))
      vim.keymap.set("v", "<leader>gu", gitsigns_visual_op("undo_stage_hunk"))
    end
  }
end

local function plugin_blink_cmp()
  -- TODO: there's this really annoying behaviour where pressing Ctrl-n
  -- after typing "vim." will cause the 'ins-completion' to trigger and will
  -- autoinsert the first entry instead of going down once in the menu.
  --
  -- I don't know how to disable this (I've tried for over an hour). Things
  -- I've tried.
  --
  --   - `vim.top.complete = ""`
  --   - overriding `C-n` and `C-p` to not use "fallback" in blink.cmp's mapping
  --   - `vim.keymap.set("i", "C-n", "<Down>")
  --   - a bunch of other stuff I can't seem to remember
  --
  -- Stuff like this really makes me frustrated when using/configuring neovim and
  -- makes me want to go back to vscode.
  vim.opt.winborder = "single"
  vim.opt.completeopt = "noselect,popup"
  vim.opt.pumheight = 12
  return {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      keymap = { preset = "super-tab" },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      signature = { enabled = true },
      fuzzy = {
        sorts = { "exact", "score", "sort_text" },
        max_typos = 0,
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0
        },
        ghost_text = { enabled = true },
      },
    },
  }
end

local function plugin_fzf_lua()
  return {
    "ibhagwan/fzf-lua",
    dependencies = { "junegunn/fzf", "nvim-tree/nvim-web-devicons" },
    config =
        function()
          vim.keymap.set("n", "<leader>ff", run("FzfLua files"))
          vim.keymap.set("n", "<leader>fo", run("FzfLua oldfiles"))
          vim.keymap.set("n", "<leader>fs", run("FzfLua lsp_document_symbols ''"))
          vim.keymap.set("n", "<leader>fS", run("FzfLua lsp_workspace_symbols ''"))
          vim.keymap.set("n", "<leader>fj", run("FzfLua jumps"))
          vim.keymap.set("n", "<leader>fz", run("FzfLua"))
          vim.keymap.set("n", "<leader>fh", run("FzfLua helptags"))
          vim.keymap.set("n", "<leader>fg", run("FzfLua grep_project"))
          vim.keymap.set("n", "<leader>fc", run("FzfLua registers ''"))
          vim.keymap.set("n", "<leader>fb", run("FzfLua buffers ''"))
          vim.keymap.set("n", "<leader>fd", run("FzfLua lsp_workspace_diagnostics ''"))
          vim.keymap.set("n", "gr", run("FzfLua lsp_references ''"))
          vim.keymap.set("n", "ga", run("FzfLua lsp_code_actions ''"))
        end
  }
end

local function setup_plugins()
  require("lazy").setup({
    spec = {
      plugin_onedark(),
      plugin_surround(),
      plugin_treesitter(),
      plugin_gitsigns(),
      plugin_fzf_lua(),
      plugin_blink_cmp(),
    }
  })
end

-- main
local function main()
  setup_lazy_nvim()
  setup_options()
  setup_keymaps()
  setup_autocmds()
  setup_lsp()
  setup_plugins()
end

main()
