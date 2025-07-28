-- ~/.config/nvim/colors/muted_ocean.lua

local M = {}

-- Define your color palette
M.colors = {
    -- Base Colors
    base_0 = "#0a1325",
    base_1 = "#172441",
    base_2 = "#0C162B",
    base_3 = "#1D2A4B",
    base_4 = "#14213C",

    -- Text Colors
    text_primary = "#e0e0e0",
    text_secondary = "#b0b0b0",
    text_highlight = "#88C0D0",
    text_comment = "#8F9BAA",

    -- Accent Colors
    accent_1 = "#A3BE8C",
    accent_2 = "#B48EAD",
    accent_3 = "#BF616A",

    -- Window & Border Colors (These are i3/WM specific, but we'll use them where applicable)
    window_focus = "#1D2A4B",
    window_unfocus = "#0C162B",
    window_urgent = "#BF616A",

    -- Status Bar Colors (from Polybar, for reference if needed elsewhere)
    status_bg = "#B3e0e0e0", -- This includes opacity
    status_fg = "#172441",
    status_highlight = "#88C0D0",

    -- Additional UI (from Polybar, for reference if needed elsewhere)
    background_primary = "#0a1325",
    background_secondary = "#172441",
}

-- Helper function to set highlight groups
local function set_hl(group, fg, bg, style)
    local cmd = "hi " .. group
    if fg then cmd = cmd .. " guifg=" .. fg end
    if bg then cmd = cmd .. " guibg=" .. bg end
    if style then cmd = cmd .. " gui=" .. style end
    vim.cmd(cmd)
end

-- Clear existing highlights
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end
vim.o.background = "dark" -- Or "light" depending on your base_0/background_primary

local c = M.colors -- Shorthand for colors

-- General UI highlights
set_hl("Normal", c.text_primary, c.base_0)              -- Default text and background
set_hl("NormalFloat", c.text_primary, c.base_2)         -- Floating windows background (like completion popups)
set_hl("FloatBorder", c.base_3, c.base_2)               -- Border for floating windows
set_hl("CursorLine", nil, c.base_1, "none")             -- Current line background
set_hl("CursorLineNr", c.accent_1, c.base_1, "bold")    -- Line number on current line
set_hl("LineNr", c.text_comment, c.base_0)              -- Line numbers
set_hl("Folded", c.text_comment, c.base_1)              -- Folded text
set_hl("NonText", c.base_4)                             -- '~' at end of buffer
set_hl("SpecialKey", c.base_4)                          -- Special characters (e.g., tabs, trailing spaces)
set_hl("VertSplit", c.base_3, c.base_3)                 -- Vertical split line
set_hl("ColorColumn", nil, c.base_1)                    -- Column for textwidth
set_hl("SignColumn", c.text_comment, c.base_0)          -- Column for git signs, etc.

-- Visual modes
set_hl("Visual", nil, c.base_3, "reverse")             -- Visual selection
set_hl("VisualNOS", nil, c.base_3, "underline")        -- Visual mode after selection is done (no stroke)

-- Search
set_hl("Search", c.base_0, c.text_highlight)           -- Search results (text_highlight for bg)
set_hl("IncSearch", c.base_0, c.accent_1)              -- Incremental search

-- Commands and messages
set_hl("ErrorMsg", c.text_primary, c.accent_3, "bold")  -- Error messages
set_hl("WarningMsg", c.text_primary, c.accent_2, "bold")-- Warning messages
set_hl("MoreMsg", c.accent_1, nil, "bold")              -- -- More -- message
set_hl("Question", c.accent_1, nil, "bold")             -- :prompt input
set_hl("ModeMsg", c.text_highlight, nil, "bold")        -- Mode message (e.g., INSERT)

-- Syntax highlighting basics (these are common, but real syntax files vary)
set_hl("Comment", c.text_comment, nil, "italic")        -- Comments
set_hl("Constant", c.accent_2)                          -- Numbers, booleans, etc.
set_hl("String", c.accent_1)                            -- Strings
set_hl("Character", c.accent_1)                         -- Chars
set_hl("Number", c.accent_2)
set_hl("Boolean", c.accent_2)
set_hl("Float", c.accent_2)
set_hl("Identifier", c.text_highlight)                  -- Variable names
set_hl("Function", c.text_highlight)                    -- Function names
set_hl("Statement", c.accent_1)                         -- if, for, return, etc.
set_hl("Conditional", c.accent_1)
set_hl("Repeat", c.accent_1)
set_hl("Label", c.accent_1)
set_hl("Operator", c.text_primary)
set_hl("Keyword", c.accent_1)                           -- Keywords
set_hl("Exception", c.accent_3)                         -- try, catch, throw
set_hl("PreProc", c.accent_2)                           -- Preprocessor directives (#include, #define)
set_hl("Include", c.accent_2)
set_hl("Define", c.accent_2)
set_hl("Macro", c.accent_2)
set_hl("Type", c.accent_1)                              -- int, char, class, struct
set_hl("StorageClass", c.accent_1)
set_hl("Structure", c.accent_1)
set_hl("Typedef", c.accent_1)
set_hl("Special", c.accent_2)                           -- Special symbols
set_hl("Underlined", nil, nil, "underline")             -- Underlined text
set_hl("Error", c.accent_3, c.base_2)                   -- Errors
set_hl("Todo", c.base_0, c.accent_2, "bold")            -- TODOs

-- Diff highlighting
set_hl("DiffAdd", c.base_0, c.accent_1)                 -- Added lines
set_hl("DiffChange", c.base_0, c.base_3)                -- Changed lines
set_hl("DiffDelete", c.accent_3, c.base_0)              -- Deleted lines (fg for deleted char, bg for line)
set_hl("DiffText", c.base_0, c.accent_2)                -- Changed text within a line

-- LSP related highlights (common groups)
set_hl("LspReferenceText", nil, c.base_3, "underline")
set_hl("LspReferenceRead", nil, c.base_3, "underline")
set_hl("LspReferenceWrite", nil, c.base_3, "underline")
set_hl("DiagnosticError", c.accent_3, nil, "underline")
set_hl("DiagnosticWarn", c.accent_2, nil, "underline")
set_hl("DiagnosticInfo", c.text_highlight, nil, "underline")
set_hl("DiagnosticHint", c.accent_1, nil, "underline")

-- Completion popups (e.g., from nvim-cmp)
set_hl("Pmenu", c.text_primary, c.base_2)                -- Popup menu normal item
set_hl("PmenuSel", c.base_0, c.text_highlight)           -- Popup menu selected item
set_hl("PmenuSbar", nil, c.base_1)                       -- Scrollbar of the popup menu
set_hl("PmenuThumb", nil, c.base_3)                      -- Thumb of the popup menu scrollbar

-- Statusline/Tabline (using colors from your palette)
set_hl("StatusLine", c.text_primary, c.base_3, "none")
set_hl("StatusLineNC", c.text_secondary, c.base_1, "none") -- Not Current
set_hl("TabLine", c.text_secondary, c.base_1, "none")
set_hl("TabLineFill", c.base_1, c.base_1, "none")
set_hl("TabLineSel", c.text_primary, c.accent_1, "bold")

-- Git signs (if using a plugin like `gitsigns.nvim`)
set_hl("GitSignsAdd", c.accent_1, nil, "none")
set_hl("GitSignsChange", c.text_highlight, nil, "none")
set_hl("GitSignsDelete", c.accent_3, nil, "none")

return M
