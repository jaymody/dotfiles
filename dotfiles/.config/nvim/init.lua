if vim.fn.has "nvim-0.11" == 0 then error "This config requires Neovim 0.11+" end

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
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  vim.opt.number = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.inccommand = "split"
  vim.opt.clipboard = "unnamedplus" -- use system clipboard
  vim.opt.wrap = false
  vim.opt.shortmess:append("I")     -- don't show neovim splash screen message
  vim.opt.confirm = true
  vim.opt.signcolumn = "yes"        -- always show sign column to avoid it popping in/out
  vim.opt.cursorline = true
  vim.opt.undofile = true
  vim.opt.showmode = false
end

-------------
-- keymaps --
-------------

local function setup_keymaps()
  -- use <C-c> as <Esc>
  kset({ "i", "c", "n", "v" }, "<C-c>", "<Esc>", { remap = true })

  -- clear highlighting when pressing <Esc> in normal mode
  kset("n", "<Esc>", "<cmd>nohlsearch<CR>")

  -- when pasting in visual mode, do not override the yank register
  kset("v", "p", "\"_dP", { noremap = true, silent = true })

  -- jump straight to init.lua
  kset("n", "<leader>cc", run("e ~/.config/nvim/init.lua"))

  -- reload init.lua
  kset("n", "<leader>cr", run("luafile ~/.config/nvim/init.lua"))
end

-------------
-- autocmd --
-------------

local function setup_autocmd()
  -- highlight yanked contents
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank { timeout = 40 }
    end,
  })

  -- open help windows on a right split
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
      vim.cmd("wincmd L")
    end,
  })
end

---------
-- lsp --
---------

local function setup_lsp()
  vim.g.have_nerd_font = true
  vim.opt.winborder = 'rounded'

  vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        }
      }
    }
  }
  vim.lsp.enable('luals')


  vim.lsp.config('*', {
    capabilities = {
      textDocument = {
        semanticTokens = {
          multilineTokenSupport = true,
        }
      }
    },
    root_markers = { '.git' },
  })


  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

      -- Auto-format ("lint") on save.
      -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
      if not client:supports_method('textDocument/willSaveWaitUntil')
          and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end,
  })

  vim.diagnostic.config({
    virtual_lines = { current_line = true }
  })
end

---------------
--- plugins ---
---------------

-------------------------------------------------------------------------------

local function treesitter_plugin()
  return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "rust", "ocaml", "lua", "javascript", "typescript",
          "python", "json", "css", "html", "zig", "markdown", "markdown_inline",
          "cpp", "toml", "sql"
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

-------------------------------------------------------------------------------

local function fzf_lua_plugin()
  return {
    "ibhagwan/fzf-lua",
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
          kset("n", "<leader>fg", run("FzfLua grep_project"))
          kset("n", "<leader>fc", run("FzfLua registers ''"))
          kset("n", "<leader>fb", run("FzfLua buffers ''"))
          kset("n", "<leader>fd", run("FzfLua lsp_workspace_diagnostics ''"))
          -- kset("n", "gr", run("FzfLua lsp_references ''"))
          -- kset("n", "ga", run("FzfLua lsp_code_actions ''"))
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
      kset("n", "<M-[>", do_and_center('Gitsigns prev_hunk'))
      kset("n", "<M-]>", do_and_center('Gitsigns next_hunk'))
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

local function nvim_tree_plugin()
  return {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local api = require("nvim-tree.api")

      -- open file tree at with the root at the cwd, else open it at the files
      -- parent dir
      kset("n", "<leader>e",
        function()
          local cwd = vim.fn.getcwd()
          local file_parent = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
          local path = file_parent:find(cwd, 1, true) == 1 and cwd or file_parent
          api.tree.open({
            path = path,
            current_window = true,
            find_file = true
          })
        end)

      require("nvim-tree").setup({ view = { float = { enable = true } } })
    end
  }
end

-------------------------------------------------------------------------------

local function onedark_theme()
  return {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup { style = 'darker' }
      require('onedark').load()
    end
  }
end

-------------------------------------------------------------------------------

local function surround_plugin()
  return {
    "tpope/vim-surround",
    config = function()
      kset("v", "s", "<Plug>VSurround")
    end
  }
end

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
end

local function setup_plugins()
  require("lazy").setup({
    spec = {
      treesitter_plugin(), -- syntax highlighting
      fzf_lua_plugin(),    -- search
      gitsigns_plugin(),   -- git gutter and hunk manipulation/navigation
      readline_plugin(),   -- emacs like bindings for basic text stuff
      nvim_tree_plugin(),  -- file explorer because :Ex is very feature poor
      surround_plugin(),   -- easily surround things in brackets
      onedark_theme(),     -- theme
    }
  })
end

-------------------------------------------------------------------------------

local function main()
  setup_lazy_nvim()
  setup_options()
  setup_keymaps()
  setup_autocmd()
  setup_plugins()
  setup_lsp()
end

main()
