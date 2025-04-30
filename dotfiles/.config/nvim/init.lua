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

  vim.o.number = true
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.inccommand = "split"
  vim.o.clipboard = "unnamedplus"
  vim.o.wrap = false
  vim.o.confirm = true
  vim.o.signcolumn = "yes"
  vim.o.cursorline = true
  vim.o.undofile = true
  vim.o.termguicolors = true
  vim.o.completeopt = "noinsert,menuone,preview,popup"

  vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_lines = { current_line = true },
  })
end

-- keymaps
local function setup_keymaps()
  vim.keymap.set({ "i", "c", "n", "v" }, "<C-c>", "<Esc>", { remap = true })
  vim.keymap.set("n", "<Esc>", ":noh<CR><C-c>")
  vim.keymap.set("v", "p", "\"_dP", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>c", run("e ~/.config/nvim/init.lua"))
  vim.keymap.set("n", "<leader>r", run("luafile ~/.config/nvim/init.lua"))
  vim.keymap.set("c", "<C-p>", "<Up>")
  vim.keymap.set("c", "<C-n>", "<Down>")
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
    root_markers = { ".git" },
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

  -- setup various language servers
  setup_lua()
end

-- main
local function main()
  setup_options()
  setup_keymaps()
  setup_autocmds()
  setup_lsp()
  vim.cmd("colorscheme habamax")
end

main()
