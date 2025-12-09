require("config.remap")
require("config.extra")
require("config.set")

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.o.clipboard = 'unnamedplus'
-- end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- -- Highlight when yanking (copying) text
-- --  Try it with `yap` in normal mode
-- --  See `:help vim.hl.on_yank()`
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.hl.on_yank()
--   end,
-- })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  -- 'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  -- { -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --   },
  -- },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      -- { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>pws', function()
        local word = vim.fn.expand '<cword>'
        builtin.grep_string { search = word }
      end)
      vim.keymap.set('n', '<leader>pWs', function()
        local word = vim.fn.expand '<cWORD>'
        builtin.grep_string { search = word }
      end)
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string { search = vim.fn.input 'Grep > ' }
      end)
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- -- It's also possible to pass additional configuration options.
      -- --  See `:help telescope.builtin.live_grep()` for information about particular keys
      -- vim.keymap.set('n', '<leader>s/', function()
      --   builtin.live_grep {
      --     grep_open_files = true,
      --     prompt_title = 'Live Grep in Open Files',
      --   }
      -- end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>pn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[P]roject [N]eovim' })
    end,
  },

  -- LSP Plugins
  -- {
  --   -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  --   -- used for completion, annotations and signatures of Neovim apis
  --   'folke/lazydev.nvim',
  --   ft = 'lua',
  --   opts = {
  --     library = {
  --       -- Load luvit types when the `vim.uv` word is found
  --       { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  --     },
  --   },
  -- },
  -- {
  --   -- Main LSP Configuration
  --   'neovim/nvim-lspconfig',
  --   dependencies = {
  --     -- Automatically install LSPs and related tools to stdpath for Neovim
  --     -- Mason must be loaded before its dependents so we need to set it up here.
  --     -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
  --     { 'mason-org/mason.nvim', opts = {} },
  --     'mason-org/mason-lspconfig.nvim',
  --     'WhoIsSethDaniel/mason-tool-installer.nvim',
  --
  --     -- Useful status updates for LSP.
  --     { 'j-hui/fidget.nvim', opts = {} },
  --
  --     -- Allows extra capabilities provided by blink.cmp
  --     'saghen/blink.cmp',
  --   },
  --   config = function()
  --     -- Brief aside: **What is LSP?**
  --     --
  --     -- LSP is an initialism you've probably heard, but might not understand what it is.
  --     --
  --     -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  --     -- and language tooling communicate in a standardized fashion.
  --     --
  --     -- In general, you have a "server" which is some tool built to understand a particular
  --     -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  --     -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  --     -- processes that communicate with some "client" - in this case, Neovim!
  --     --
  --     -- LSP provides Neovim with features like:
  --     --  - Go to definition
  --     --  - Find references
  --     --  - Autocompletion
  --     --  - Symbol Search
  --     --  - and more!
  --     --
  --     -- Thus, Language Servers are external tools that must be installed separately from
  --     -- Neovim. This is where `mason` and related plugins come into play.
  --     --
  --     -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  --     -- and elegantly composed help section, `:help lsp-vs-treesitter`
  --
  --     --  This function gets run when an LSP attaches to a particular buffer.
  --     --    That is to say, every time a new file is opened that is associated with
  --     --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --     --    function will be executed to configure the current buffer
  --     vim.api.nvim_create_autocmd('LspAttach', {
  --       group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  --       callback = function(event)
  --         -- NOTE: Remember that Lua is a real programming language, and as such it is possible
  --         -- to define small helper and utility functions so you don't have to repeat yourself.
  --         --
  --         -- In this case, we create a function that lets us more easily define mappings specific
  --         -- for LSP related items. It sets the mode, buffer and description for us each time.
  --         local map = function(keys, func, desc, mode)
  --           mode = mode or 'n'
  --           vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  --         end
  --
  --         -- Rename the variable under your cursor.
  --         --  Most Language Servers support renaming across files, etc.
  --         map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
  --
  --         -- Execute a code action, usually your cursor needs to be on top of an error
  --         -- or a suggestion from your LSP for this to activate.
  --         map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
  --
  --         -- Find references for the word under your cursor.
  --         map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  --
  --         -- Jump to the implementation of the word under your cursor.
  --         --  Useful when your language has ways of declaring types without an actual implementation.
  --         map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  --
  --         -- Jump to the definition of the word under your cursor.
  --         --  This is where a variable was first declared, or where a function is defined, etc.
  --         --  To jump back, press <C-t>.
  --         map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  --
  --         -- WARN: This is not Goto Definition, this is Goto Declaration.
  --         --  For example, in C this would take you to the header.
  --         map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  --
  --         -- Fuzzy find all the symbols in your current document.
  --         --  Symbols are things like variables, functions, types, etc.
  --         map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
  --
  --         -- Fuzzy find all the symbols in your current workspace.
  --         --  Similar to document symbols, except searches over your entire project.
  --         map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
  --
  --         -- Jump to the type of the word under your cursor.
  --         --  Useful when you're not sure what type a variable is and you want to see
  --         --  the definition of its *type*, not where it was *defined*.
  --         map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
  --
  --         -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
  --         ---@param client vim.lsp.Client
  --         ---@param method vim.lsp.protocol.Method
  --         ---@param bufnr? integer some lsp support methods only in specific files
  --         ---@return boolean
  --         local function client_supports_method(client, method, bufnr)
  --           if vim.fn.has 'nvim-0.11' == 1 then
  --             return client:supports_method(method, bufnr)
  --           else
  --             return client.supports_method(method, { bufnr = bufnr })
  --           end
  --         end
  --
  --         -- The following two autocommands are used to highlight references of the
  --         -- word under your cursor when your cursor rests there for a little while.
  --         --    See `:help CursorHold` for information about when this is executed
  --         --
  --         -- When you move your cursor, the highlights will be cleared (the second autocommand).
  --         local client = vim.lsp.get_client_by_id(event.data.client_id)
  --         if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
  --           local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
  --           vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  --             buffer = event.buf,
  --             group = highlight_augroup,
  --             callback = vim.lsp.buf.document_highlight,
  --           })
  --
  --           vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  --             buffer = event.buf,
  --             group = highlight_augroup,
  --             callback = vim.lsp.buf.clear_references,
  --           })
  --
  --           vim.api.nvim_create_autocmd('LspDetach', {
  --             group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
  --             callback = function(event2)
  --               vim.lsp.buf.clear_references()
  --               vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
  --             end,
  --           })
  --         end
  --
  --         -- The following code creates a keymap to toggle inlay hints in your
  --         -- code, if the language server you are using supports them
  --         --
  --         -- This may be unwanted, since they displace some of your code
  --         if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
  --           map('<leader>th', function()
  --             vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
  --           end, '[T]oggle Inlay [H]ints')
  --         end
  --       end,
  --     })
  --
  --     -- Diagnostic Config
  --     -- See :help vim.diagnostic.Opts
  --     vim.diagnostic.config {
  --       severity_sort = true,
  --       float = { border = 'rounded', source = 'if_many' },
  --       underline = { severity = vim.diagnostic.severity.ERROR },
  --       signs = vim.g.have_nerd_font and {
  --         text = {
  --           [vim.diagnostic.severity.ERROR] = '󰅚 ',
  --           [vim.diagnostic.severity.WARN] = '󰀪 ',
  --           [vim.diagnostic.severity.INFO] = '󰋽 ',
  --           [vim.diagnostic.severity.HINT] = '󰌶 ',
  --         },
  --       } or {},
  --       virtual_text = {
  --         source = 'if_many',
  --         spacing = 2,
  --         format = function(diagnostic)
  --           local diagnostic_message = {
  --             [vim.diagnostic.severity.ERROR] = diagnostic.message,
  --             [vim.diagnostic.severity.WARN] = diagnostic.message,
  --             [vim.diagnostic.severity.INFO] = diagnostic.message,
  --             [vim.diagnostic.severity.HINT] = diagnostic.message,
  --           }
  --           return diagnostic_message[diagnostic.severity]
  --         end,
  --       },
  --     }
  --
  --     -- LSP servers and clients are able to communicate to each other what features they support.
  --     --  By default, Neovim doesn't support everything that is in the LSP specification.
  --     --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
  --     --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
  --     local capabilities = require('blink.cmp').get_lsp_capabilities()
  --
  --     -- Enable the following language servers
  --     --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --     --
  --     --  Add any additional override configuration in the following tables. Available keys are:
  --     --  - cmd (table): Override the default command used to start the server
  --     --  - filetypes (table): Override the default list of associated filetypes for the server
  --     --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
  --     --  - settings (table): Override the default settings passed when initializing the server.
  --     --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
  --     local servers = {
  --       -- clangd = {},
  --       -- gopls = {},
  --       -- pyright = {},
  --       -- rust_analyzer = {},
  --       -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --       --
  --       -- Some languages (like typescript) have entire language plugins that can be useful:
  --       --    https://github.com/pmizio/typescript-tools.nvim
  --       --
  --       -- But for many setups, the LSP (`ts_ls`) will work just fine
  --       -- ts_ls = {},
  --       --
  --
  --       lua_ls = {
  --         -- cmd = { ... },
  --         -- filetypes = { ... },
  --         -- capabilities = {},
  --         settings = {
  --           Lua = {
  --             completion = {
  --               callSnippet = 'Replace',
  --             },
  --             -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
  --             -- diagnostics = { disable = { 'missing-fields' } },
  --           },
  --         },
  --       },
  --     }
  --
  --     -- Ensure the servers and tools above are installed
  --     --
  --     -- To check the current status of installed tools and/or manually install
  --     -- other tools, you can run
  --     --    :Mason
  --     --
  --     -- You can press `g?` for help in this menu.
  --     --
  --     -- `mason` had to be setup earlier: to configure its options see the
  --     -- `dependencies` table for `nvim-lspconfig` above.
  --     --
  --     -- You can add other tools here that you want Mason to install
  --     -- for you, so that they are available from within Neovim.
  --     local ensure_installed = vim.tbl_keys(servers or {})
  --     vim.list_extend(ensure_installed, {
  --       'stylua', -- Used to format Lua code
  --     })
  --     require('mason-tool-installer').setup { ensure_installed = ensure_installed }
  --
  --     require('mason-lspconfig').setup {
  --       ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
  --       automatic_installation = false,
  --       handlers = {
  --         function(server_name)
  --           local server = servers[server_name] or {}
  --           -- This handles overriding only values explicitly passed
  --           -- by the server configuration above. Useful when disabling
  --           -- certain features of an LSP (for example, turning off formatting for ts_ls)
  --           server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  --           require('lspconfig')[server_name].setup(server)
  --         end,
  --       },
  --     }
  --   end,
  -- },

  -- { -- Autoformat
  --   'stevearc/conform.nvim',
  --   event = { 'BufWritePre' },
  --   cmd = { 'ConformInfo' },
  --   keys = {
  --     {
  --       '<leader>f',
  --       function()
  --         require('conform').format { async = true, lsp_format = 'fallback' }
  --       end,
  --       mode = '',
  --       desc = '[F]ormat buffer',
  --     },
  --   },
  --   opts = {
  --     notify_on_error = false,
  --     format_on_save = function(bufnr)
  --       -- Disable "format_on_save lsp_fallback" for languages that don't
  --       -- have a well standardized coding style. You can add additional
  --       -- languages here or re-enable it for the disabled ones.
  --       local disable_filetypes = { c = true, cpp = true }
  --       if disable_filetypes[vim.bo[bufnr].filetype] then
  --         return nil
  --       else
  --         return {
  --           timeout_ms = 500,
  --           lsp_format = 'fallback',
  --         }
  --       end
  --     end,
  --     formatters_by_ft = {
  --       lua = { 'stylua' },
  --       -- Conform can also run multiple formatters sequentially
  --       -- python = { "isort", "black" },
  --       --
  --       -- You can use 'stop_after_first' to run the first available formatter from the list
  --       -- javascript = { "prettierd", "prettier", stop_after_first = true },
  --     },
  --   },
  -- },

  -- { -- Autocompletion
  --   'saghen/blink.cmp',
  --   event = 'VimEnter',
  --   version = '1.*',
  --   dependencies = {
  --     -- Snippet Engine
  --     {
  --       'L3MON4D3/LuaSnip',
  --       version = '2.*',
  --       build = (function()
  --         -- Build Step is needed for regex support in snippets.
  --         -- This step is not supported in many windows environments.
  --         -- Remove the below condition to re-enable on windows.
  --         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
  --           return
  --         end
  --         return 'make install_jsregexp'
  --       end)(),
  --       dependencies = {
  --         -- `friendly-snippets` contains a variety of premade snippets.
  --         --    See the README about individual language/framework/plugin snippets:
  --         --    https://github.com/rafamadriz/friendly-snippets
  --         -- {
  --         --   'rafamadriz/friendly-snippets',
  --         --   config = function()
  --         --     require('luasnip.loaders.from_vscode').lazy_load()
  --         --   end,
  --         -- },
  --       },
  --       opts = {},
  --     },
  --     'folke/lazydev.nvim',
  --   },
  --   --- @module 'blink.cmp'
  --   --- @type blink.cmp.Config
  --   opts = {
  --     keymap = {
  --       -- 'default' (recommended) for mappings similar to built-in completions
  --       --   <c-y> to accept ([y]es) the completion.
  --       --    This will auto-import if your LSP supports it.
  --       --    This will expand snippets if the LSP sent a snippet.
  --       -- 'super-tab' for tab to accept
  --       -- 'enter' for enter to accept
  --       -- 'none' for no mappings
  --       --
  --       -- For an understanding of why the 'default' preset is recommended,
  --       -- you will need to read `:help ins-completion`
  --       --
  --       -- No, but seriously. Please read `:help ins-completion`, it is really good!
  --       --
  --       -- All presets have the following mappings:
  --       -- <tab>/<s-tab>: move to right/left of your snippet expansion
  --       -- <c-space>: Open menu or open docs if already open
  --       -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
  --       -- <c-e>: Hide menu
  --       -- <c-k>: Toggle signature help
  --       --
  --       -- See :h blink-cmp-config-keymap for defining your own keymap
  --       preset = 'default',
  --
  --       -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
  --       --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  --     },
  --
  --     appearance = {
  --       -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = 'mono',
  --     },
  --
  --     completion = {
  --       -- By default, you may press `<c-space>` to show the documentation.
  --       -- Optionally, set `auto_show = true` to show the documentation after a delay.
  --       documentation = { auto_show = false, auto_show_delay_ms = 500 },
  --     },
  --
  --     sources = {
  --       default = { 'lsp', 'path', 'snippets', 'lazydev' },
  --       providers = {
  --         lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
  --       },
  --     },
  --
  --     snippets = { preset = 'luasnip' },
  --
  --     -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  --     -- which automatically downloads a prebuilt binary when enabled.
  --     --
  --     -- By default, we use the Lua implementation instead, but you may enable
  --     -- the rust implementation via `'prefer_rust_with_warning'`
  --     --
  --     -- See :h blink-cmp-config-fuzzy for more information
  --     fuzzy = { implementation = 'lua' },
  --
  --     -- Shows a signature help window while you type arguments for a function
  --     signature = { enabled = true },
  --   },
  -- },

  {
    'deparr/tairiki.nvim',
    config = function()
      require('tairiki').setup {
        palette = 'dark', -- main palette, available options: dark, light, dimmed, tomorrow, light_legacy
        default_dark = 'dark',
        default_light = 'light',
        transparent = true, -- don't set background colors
        terminal = false, -- override nvim terminal colors
        end_of_buffer = false, -- show end of buffer filler lines (tildes)
        visual_bold = false, -- bolden visual selections
        cmp_itemkind_reverse = false, -- reverse fg/bg on nvim-cmp item kinds

        diagnostics = {
          darker = false, -- darken diagnostic virtual text
          background = true, -- add background to diagnostic virtual text
          undercurl = true, -- use undercurls for inline diagnostics
        },

        -- style for different syntactic tokens
        -- see :help nvim_set_hl() for available keys
        code_style = {
          comments = { italic = true },
          conditionals = {},
          keywords = {},
          functions = {},
          strings = {},
          variables = {},
          parameters = {},
          types = {},
        },

        -- lualine theme config
        lualine = {
          transparent = false, -- remove background from center section
        },

        -- which plugins to enable
        plugins = {
          all = false, -- enable all supported plugins
          none = false, -- ONLY set groups listed in :help highlight-groups (see lua/tairiki/groups/neovim.lua). Manually enabled plugins will also be ignored
          auto = false, -- auto detect installed plugins, currently lazy.nvim only

          -- or enable/disable plugins manually
          -- see lua/tairiki/groups/init.lua for the full list of available plugins
          -- either the key or value from the M.plugins table can be used as the key here
          --
          -- setting a specific plugin manually overrides `all` and `auto`
          treesitter = true,
          semantic_tokens = true,
        },

        -- optional function to modify or add colors to the palette
        -- palette definitions are in lua/tairiki/palette
        colors = function(colors, opts) end,

        -- optional function to override highlight groups
        highlights = function(groups, colors, opts) end,
      }

      vim.cmd 'colorscheme tairiki'
    end,
  },
  -- {
  --   'EdenEast/nightfox.nvim',
  --   config = function()
  --     -- Default options
  --     require('nightfox').setup {
  --       options = {
  --         transparent = true, -- Disable setting background
  --         inverse = { -- Inverse highlight for different types
  --           match_paren = true,
  --           visual = false,
  --           search = false,
  --         },
  --       },
  --     }
  --
  --     -- setup must be called before loading
  --     vim.cmd 'colorscheme carbonfox'
  --   end,
  -- },

  -- -- Highlight todo, notes, etc in comments
  -- { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- { -- Collection of various small independent plugins/modules
  --   'echasnovski/mini.nvim',
  --   config = function()
  --     -- Better Around/Inside textobjects
  --     --
  --     -- Examples:
  --     --  - va)  - [V]isually select [A]round [)]paren
  --     --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
  --     --  - ci'  - [C]hange [I]nside [']quote
  --     require('mini.ai').setup { n_lines = 500 }
  --
  --     -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --     --
  --     -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  --     -- - sd'   - [S]urround [D]elete [']quotes
  --     -- - sr)'  - [S]urround [R]eplace [)] [']
  --     require('mini.surround').setup()
  --
  --     -- Simple and easy statusline.
  --     --  You could remove this setup call if you don't like it,
  --     --  and try some other statusline plugin
  --     local statusline = require 'mini.statusline'
  --     -- set use_icons to true if you have a Nerd Font
  --     statusline.setup { use_icons = vim.g.have_nerd_font }
  --
  --     -- You can configure sections in the statusline by overriding their
  --     -- default behavior. For example, here we set the section for
  --     -- cursor location to LINE:COLUMN
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     statusline.section_location = function()
  --       return '%2l:%-2v'
  --     end
  --
  --     -- ... and there is more!
  --     --  Check out: https://github.com/echasnovski/mini.nvim
  --   end,
  -- },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search

  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-neotest/nvim-nio',
      "mxsdev/nvim-dap-vscode-js",
      "mfussenegger/nvim-dap-python",
      -- Make sure vscode-js-debug is installed
    },
    config = function()
      local dap = require('dap')
      local ui = require('dapui')

      require("dap-vscode-js").setup({
        debugger_path = "/usr/lib/node_modules/vscode-js-debug",
        debugger_cmd = { "/usr/lib/node_modules/vscode-js-debug/src/dapDebugServer.js" },
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })

      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {"/usr/lib/node_modules/vscode-js-debug/src/dapDebugServer.js", "${port}"},
        }
      }

      dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
          ---@diagnostic disable-next-line: undefined-field
          local port = (config.connect or config).port
          ---@diagnostic disable-next-line: undefined-field
          local host = (config.connect or config).host or '127.0.0.1'
          cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
              source_filetype = 'python',
            },
          })
        else
          cb({
            type = 'executable',
            command = 'python',
            args = { '-m', 'debugpy.adapter' },
            options = {
              source_filetype = 'python',
            },
          })
        end
      end

      require('dapui').setup()
      require('nvim-dap-virtual-text').setup {}

      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<space>gb', dap.run_to_cursor)

      -- Eval under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<F1>', dap.step_back, { desc = "step_back" })
      vim.keymap.set('n', '<F2>', dap.step_into, { desc = "step_into" })
      vim.keymap.set('n', '<F3>', dap.step_over, { desc = "step_over" })
      vim.keymap.set('n', '<F4>', dap.step_out, { desc = "step_out" })
      vim.keymap.set('n', '<F5>', dap.continue)
      vim.keymap.set('n', '<F12>', dap.restart)

      for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
        require("dap").configurations[language] = {
          -- attach to a node process that has been started with
          -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
          -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
          {
            -- use nvim-dap-vscode-js's pwa-node debug adapter
            type = "pwa-node",
            -- attach to an already running node process with --inspect flag
            -- default port: 9229
            request = "attach",
            -- allows us to pick the process using a picker
            processId = require 'dap.utils'.pick_process,
            -- name of the debug action you have to select for this config
            name = "Attach debugger to existing `node --inspect` process",
            -- for compiled languages like TypeScript or Svelte.js
            sourceMaps = true,
            -- for docker (references project root inside docker)
            localRoot = "${workspaceFolder}/challenge/src",
            remoteRoot = '/usr/app',
            -- resolve source maps in nested locations while ignoring node_modules
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**"
            },
            -- path to src in vite based projects (and most other projects as well)
            cwd = "${workspaceFolder}",
            -- we don't want to debug code inside node_modules, so skip it!
            -- skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
            },
            {
              type = "pwa-chrome",
              name = "Launch Chrome to debug client",
              request = "launch",
              url = "http://localhost:5173",
              sourceMaps = true,
              protocol = "inspector",
              port = 9229,
              webRoot = "${workspaceFolder}/src",
              -- skip files from vite's hmr
              -- skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
            },
            -- only if language is javascript, offer this debug action
            language == "javascript" and {
              -- use nvim-dap-vscode-js's pwa-node debug adapter
              type = "pwa-node",
              -- launch a new process to attach the debugger to
              request = "launch",
              -- name of the debug action you have to select for this config
              name = "Launch file in new node process",
              -- launch current file
              program = "${file}",
              cwd = "${workspaceFolder}",
            } or nil,
          }
        end

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },

  -- for show!
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      cursor_color = "#ff8800",
      stiffness = 0.8,
      trailing_stiffness = 0.6,
      trailing_exponent = 1,
      never_draw_over_target = true,
      hide_target_hack = true,
      gamma = 1,
    }
  },

  {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion"
  },

  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {

      default = {
        -- file and directory options
        -- dir_path = "/home/hxuu/blog/static/images", ---@type string
        dir_path = "images", ---@type string
        extension = "png", ---@type string
        file_name = "%Y-%m-%d-%H-%M-%S", ---@type string
        use_absolute_path = false, ---@type boolean
        relative_to_current_file = false, ---@type boolean

        -- template options
        template = "$FILE_PATH", ---@type string
        url_encode_path = false, ---@type boolean
        relative_template_path = true, ---@type boolean
        use_cursor_in_template = true, ---@type boolean
        insert_mode_after_paste = true, ---@type boolean

        -- prompt options
        prompt_for_file_name = false, ---@type boolean
        show_dir_path_in_prompt = false, ---@type boolean

        -- base64 options
        max_base64_size = 10, ---@type number
        embed_image_as_base64 = false, ---@type boolean

        -- image options
        process_cmd = "", ---@type string
        copy_images = false, ---@type boolean
        download_images = true, ---@type boolean

        -- drag and drop options
        drag_and_drop = {
          enabled = true, ---@type boolean
          insert_mode = false, ---@type boolean
        },
      },

      -- filetype specific options
      filetypes = {
        markdown = {
          url_encode_path = true, ---@type boolean
          template = "![$CURSOR]($FILE_PATH)", ---@type string
          download_images = false, ---@type boolean
        },

        vimwiki = {
          url_encode_path = true, ---@type boolean
          template = "![$CURSOR]($FILE_PATH)", ---@type string
          download_images = false, ---@type boolean
        },

        html = {
          template = '<img src="$FILE_PATH" alt="$CURSOR">', ---@type string
        },

        asciidoc = {
          template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]', ---@type string
        },
      },

      -- file, directory, and custom triggered options
      files = {}, ---@type table
      dirs = {}, ---@type table
      custom = {}, ---@type table

    },
    keys = {
      -- suggested keymap
      { "<leader>pp", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },

  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

      local hxuu_Fugitive = vim.api.nvim_create_augroup("hxuu_Fugitive", {})

      local autocmd = vim.api.nvim_create_autocmd
      autocmd("BufWinEnter", {
        group = hxuu_Fugitive,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local opts = {buffer = bufnr, remap = false}
          vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
          end, opts)

          -- rebase always
          vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git({'pull',  '--rebase'})
          end, opts)

          -- NOTE: It allows me to easily set the branch i am pushing and any tracking
          -- needed if i did not set the branch up correctly
          vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
        end,
      })


      vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
      vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
  },

  {
    "mbbill/undotree",

    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
