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
│   ├── auto_cmd.lua  # Run this every time a event happen 
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
- *<leader>* is **space**

## MUST KNOW TIPS:

---

### COMMAND ;-;
|key|usage|
|---|-----|
|**:** |to enter command mod|
|**w** |for save|
|**q** |for [q]uit|
|**a** |for [a]ll|
|**!** |for force|

- you can do **:wqa**(save quit all)
             **:wa** (save all)
             **:qa** (quit all) 
             **q!**  (force quit)

- **Lazy sync** for update plugins (is not recommended)

---

### BUFFER NAVIGATION
|key|usage|
|---|-----|
| **<C-w>** with **h** **j** **k** **l** or arrow keys| move between buffer|
| **C-W>T**| create new tab for buffer|

- for more at `:help wincmd`  

---

### ACTION IN VIM
|key|usage|
|---|-----|
| **i** |[i]nsert mode|
| **v** |[v]isual mode (the select mode)|
| **d** |[d]elete|
| **s** |cut and insert|
| **c** |[c]hange (no copy)|
| **y** |[y]ank (copy)|
| **p** |[p]ut  (paste and cut)|
| **<leader>p**| [p]aste (no cut)|

---

### NORMAL MODE LINE MOTION

|key|usage|
|---|-----|
| **0** |  go for fist place in a line|
| **^** |  go for fist word|
| **$** |  go to end of line|
| **g_**|  go for last word|

---

### NEOTREE - the file explorer

####  in file
|key|usage|
|---|-----|
| **<leader>eo** |n[e]o tree t[o]ggle|
| **<leader>ef** |n[e]o tree [f]orce open (if not want to use <C-w>)|

#### inside neotree:
|key|usage|
|---|-----|
| **a**| [a]dd file|
| **d**| [d]irectory|
| **D**| [D]elete file|
| **t**| open in new [t]ab|
| **v**| open in [v]ertical split|
| **s**| open in horzontal [s]plit|

---

### CMP
#### this is the auto-completion things!
|key|usage|
|---|-----|
| **<tab>** |next select|
| **<S-tab>** |previous select|
| **Enter** or **<CR>** |accept select (they are the same)|

---

### TEXT OBJECTS

- this is just extended vim motion
- how to use: **verb** + **adj** + **noun** (must be in order)

#### verb
|key|mean|
|---|-----|
| **c**| [c]hange (delete and insert)|
| **v**| select or [v]isual mode|
| **d**| [d]elete|

#### adj
|key|mean|
|---|-----|
| **i**|  [i]nside|
| **a**|  [a]round|

#### noun
|key|mean|
|---|-----|
| **f**| [f]unction|
| **b**| [b]lock (while,for loops or if)|
| **p**| [p]aragraph (the continuous graph)|
| **w**| [w]ord|
| **[**,**{**,**(** | brackets ;-; |

- example: **ci[**  delete and insert in the **[]** in front of u 

---

### LSP

#### navigation 
|key|usage|
|---|-----|
| **gd**| [g]o to [d]efinition |
| **gD**| [g]o to [D]eclearation|
| **gt**| [g]o to [t]ype definition|
| **gi**| [g]o to [i]mplementation|  
| **gr**| [g]o to [r]eference|
| **la**| [l]ist [a]ll components (like function,variable...)|
| **K** | show doc for current selecting word 

#### action
|key|usage|
|---|-----|
| **rn**| [r]e[n]ame current selecting word safety|
| **ca**| [c]ode [a]tion  do things.... (if error log said fix available press this!)|

---

### SPELL (vim cmp for word)
#### motion
|key|usage|
|---|-----|
| **[s**| go to previous miss [s]pell word|
| **]s**| go to next miss [s]pell word|

#### action
|key|usage|
|---|-----|
| **<leader>cl**| [c]hange [l]anguage|
| **<leader>wa**| [w]ord [a]dd|
| **<leader>wua**| [w]ord [a]dd [u]ndo |

---

### DIAGNOSE AND LOG
#### log
|key|usage|
|---|-----|
| **<leader>lo**|  [l]og [o]pen| 
| **<leader>lc**|  [l]og [c]lose|

#### diagnose (only enable when lsp is showing error)
|key|usage|
|---|-----|
| **<leader>df**| [d]iagnose [f]loat open|
| **[d**        | [d]iagnose previous|
| **]d**        | [d]iagnose next|

#### terminal
|key|usage|
|---|-----|
| **<leader>th**| [t]erminal open [h]orzontal| 
| **<leader>tv**| [t]erminal open [v]ertical|
- note im too lazy to make a script for closing terminal

 ---

### VIM SURROUND

- See `lua/keymap/surround.lua`  
- Common commands
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
