---

# My Neovim Configuration
**made by khanhnotbruh or kh4nhdev**

This is my personal Neovim setup — organized, fast, and designed for coding productivity.  
It includes plugins for LSP, auto-completion, syntax highlighting, multi-cursor editing, and more.

---

## 📂 File Structure

```

lua/
├── plugins/          # Plugin installation
│   ├── core/         # Essential plugins
│   └── theme/        # Color themes (switch with <F5>)
├── config/           # Plugin configurations
│   └── ...           # Individual plugin configs
├── custom/           # Custom function 
│   ├── utils.lua     # Contain utilities for custom function
│   └── ...           # Custom function 
├── keymap.lua        # All keymaps (including plugin keymaps)
├── option.lua        # Basic Vim options
init.lua              # Entry point: loads configs and creates popup

```

---

## ⚡ Installed Plugins

- **Completion & LSP**: `nvim-cmp`, `LuaLS`, `pyright`, `clangd`  
- **Syntax Highlighting**: `nvim-treesitter`  
- **File Explorer**: `neo-tree.nvim`  
- **UI Enhancements**: `noice.nvim`, `twilight.nvim`  
- **Navigation & Productivity**: `harpoon`  
- **Editing Helpers**: `nvim-autopairs`, `nvim-surround`  
- **Multi-Cursor Editing**: `vim-visual-multi`

---

# ⌨ Keybindings
- **<leader>** is **space**

## MUST KNOW KEYBIND:

### BUFFER NAVIGATION
- for more at `:help wincmd`  
+ <C-w> with hjkl or arrow keys: move between buffer
+ <C-W>T: create new tab for buffer

### NORMAL MODE LINE MOTION:
+ '0'    go for fist place in a line 
+ '^'    go for fist word
+ '$'    go to end of line
+ 'g_'   go for last word

### NEOTREE - the file explorer
- in file
+ "<leader>eo" n[e]o tree t[o]ggle
+ "<leader>ef" n[e]o tree [f]orce open (if not want to use <C-w>)

-inside neotree:
+ "a" [a]dd file
+ "d" [d]irectory
+ "D" [D]elete file
+ "t" open in new [t]ab
+ "v" open in [v]ertical split
+ "s" open in horzontal [s]plit

### TEXTOBJECTS
- this is just extended vim motion
- usage: verb + adj + noun (must be in order)
- VERB:
+ "c" [c]hange (delete and insert)
+ "v" select or [v]isual mode
+ "d" [d]elete

- ADJ:
+ "i" [i]nside 
+ "a" [a]round

- NOUN:
+ "f" [f]unction
+ "b" [b]lock (while,for loops or if)
+ "p" [p]aragraph (the continuous graph)

### LSP
- navigation 
+ "gd" [g]o to [d]efinition
+ "gD" [g]o to [D]eclearation
+ "gt" [g]o to [t]ype definition
+ "gi" [g]o to [i]mplementation
+ "gr" [g]o to [r]eference
+ "la" [l]ist [a]ll components (like function,variable...)
+ "K"  show doc for current selecting word 
- action
+ "rn" [r]e[n]ame current selecting word safety
+ "ca" [c]ode [a]tion : do things.... (if error log said fix available press this!)

### VIM SURROUND

- See `lua/keymap/surround.lua`  
- Common commands:
  - `ysiw)` → surround current word with parentheses `(word)`  
  - `ds"` → delete surrounding quotes  
  - `cs"'` → change surrounding quotes from `"` to `'`

### MULTI-CURSOR (Visual Multi)

- `Ctrl+n` add cursor to word/selection  
- `Ctrl+x` skip match  
- `Esc` exit multi-cursor mode  
- Supports both word selection and visual block editing

### Misc / Other

- Theme switch  <F5>  (the function was defined in lua/custom) 
- All other plugin keymaps are defined in `lua/keymap/`

---

- All configs are modular — feel free to add/remove plugins  
- Lazy-loaded where possible for performance  
- Designed for programming in Lua, Python, JS/TS, C/C++  

---

> ⚡ Enjoy your fast, modern Neovim setup!

---
