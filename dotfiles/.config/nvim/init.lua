-- version check
if vim.fn.has("nvim-0.11") == 0 then
  vim.notify("Config requires Neovim 0.11+", vim.log.levels.ERROR)
  return
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
  vim.opt.completeopt = "menu,menuone,noinsert,fuzzy,popup"
  vim.opt.pumheight = 12
  vim.opt.winborder = 'rounded'

  vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_lines = { current_line = true },
    float = { border = "rounded" },
    jump = { float = true },
  })
end

-- keymaps
local function setup_keymaps()
  vim.keymap.set("n", "<C-c>", function() vim.cmd("silent noh") end)
  vim.keymap.set("v", "p", "\"_dP", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>c", ":e ~/.config/nvim/init.lua<CR>", { silent = true })
  vim.keymap.set("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { silent = true })
  vim.keymap.set("c", "<C-p>", "<Up>")
  vim.keymap.set("c", "<C-n>", "<Down>")
  vim.keymap.set({ "i", "n" }, "<C-s>", function()
    vim.cmd("silent update")
    vim.cmd("stopinsert")
  end)
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
    callback = function()
      vim.cmd("wincmd L")
    end
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
end

-- main
local function main()
  setup_options()
  setup_keymaps()
  setup_autocmds()
  setup_lsp()
end

main()
