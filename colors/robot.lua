-- ROBOT
-- created on https://nvimcolors.com

-- Clear existing highlights and reset syntax
vim.cmd('highlight clear')
vim.cmd('syntax reset')

-- Basic UI elements
vim.cmd('highlight Normal guibg=#1c1c1c guifg=#d6d6d6')
vim.cmd('highlight NonText guibg=#1c1c1c guifg=#1c1c1c')
vim.cmd('highlight CursorLine guibg=#2f2f2f')
vim.cmd('highlight LineNr guifg=#797979')
vim.cmd('highlight CursorLineNr guifg=#d6d6d6')
vim.cmd('highlight SignColumn guibg=#1c1c1c')
vim.cmd('highlight StatusLine gui=bold guibg=#d6d6d6 guifg=#1c1c1c')
vim.cmd('highlight StatusLineNC gui=bold guibg=#d6d6d6 guifg=#797979')
vim.cmd('highlight Directory guifg=#9375ff')
vim.cmd('highlight Visual guibg=#545454')
vim.cmd('highlight Search guibg=#797979 guifg=#d6d6d6')
vim.cmd('highlight CurSearch guibg=#9375ff guifg=#1c1c1c')
vim.cmd('highlight IncSearch gui=None guibg=#9375ff guifg=#1c1c1c')
vim.cmd('highlight MatchParen guibg=#797979 guifg=#d6d6d6')
vim.cmd('highlight Pmenu guibg=#494949 guifg=#d6d6d6')
vim.cmd('highlight PmenuSel guibg=#737373 guifg=#bfffb3')
vim.cmd('highlight PmenuSbar guibg=#737373 guifg=#d6d6d6')
vim.cmd('highlight VertSplit guifg=#d6d6d6')
vim.cmd('highlight MoreMsg guifg=#b1b1b1')
vim.cmd('highlight Question guifg=#b1b1b1')
vim.cmd('highlight Title guifg=#91eeca')

-- Syntax highlighting
vim.cmd('highlight Comment guifg=#797979 gui=italic')
vim.cmd('highlight Constant guifg=#b190ee')
vim.cmd('highlight Identifier guifg=#91eeca')
vim.cmd('highlight Statement guifg=#eeeb91')
vim.cmd('highlight PreProc guifg=#eeeb91')
vim.cmd('highlight Type guifg=#f58a8a gui=None')
vim.cmd('highlight Special guifg=#b1b1b1')

-- Refined syntax highlighting
vim.cmd('highlight String guifg=#b190ee')
vim.cmd('highlight Number guifg=#a0ee91')
vim.cmd('highlight Boolean guifg=#b190ee')
vim.cmd('highlight Function guifg=#91c1ee')
vim.cmd('highlight Keyword guifg=#eeeb91 gui=italic')

-- Html syntax highlighting
vim.cmd('highlight Tag guifg=#91eeca')
vim.cmd('highlight @tag.delimiter guifg=#b1b1b1')
vim.cmd('highlight @tag.attribute guifg=#91c1ee')

-- Messages
vim.cmd('highlight ErrorMsg guifg=#ff4d4d')
vim.cmd('highlight Error guifg=#ff4d4d')
vim.cmd('highlight DiagnosticError guifg=#ff4d4d')
vim.cmd('highlight DiagnosticVirtualTextError guibg=#332121 guifg=#ff4d4d')
vim.cmd('highlight WarningMsg guifg=#ffbe4d')
vim.cmd('highlight DiagnosticWarn guifg=#ffbe4d')
vim.cmd('highlight DiagnosticVirtualTextWarn guibg=#332c21 guifg=#ffbe4d')
vim.cmd('highlight DiagnosticInfo guifg=#4da9ff')
vim.cmd('highlight DiagnosticVirtualTextInfo guibg=#212a33 guifg=#4da9ff')
vim.cmd('highlight DiagnosticHint guifg=#4dffa3')
vim.cmd('highlight DiagnosticVirtualTextHint guibg=#21332a guifg=#4dffa3')
vim.cmd('highlight DiagnosticOk guifg=#4dff58')

-- Common plugins
vim.cmd('highlight CopilotSuggestion guifg=#797979') -- Copilot suggestion
vim.cmd('highlight TelescopeSelection guibg=#545454') -- Telescope selection
