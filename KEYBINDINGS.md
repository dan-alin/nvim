# Neovim Keybindings Reference

**Leader Key:** `<Space>`

## General

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>w` | Normal | Save file | Write current buffer |
| `<leader>q` | Normal | Quit | Close current window |
| `jk` | Insert | Escape | Exit insert mode |
| `ge` | Normal | End of line | Jump to end of line |
| `gs` | Normal | Start of line | Jump to start of line (first non-blank) |
| `<leader>nh` | Normal | Clear highlights | Remove search highlights |
| `<C-a>` | Normal | Select all | Select entire buffer |
| `+` | Normal | Increment | Increment number under cursor |
| `-` | Normal | Decrement | Decrement number under cursor |

## Buffer Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<TAB>` | Normal | Next buffer | Switch to next buffer |
| `<S-TAB>` | Normal | Previous buffer | Switch to previous buffer |
| `<leader>x` | Normal | Close buffer | Close current buffer (keep window) |
| `<leader>bo` | Normal | Close other buffers | Close all buffers except current |

## Line Movement

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-j>` | Normal | Move line down | Move current line down |
| `<C-k>` | Normal | Move line up | Move current line up |

## Quickfix List

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `]q` | Normal | Next quickfix | Jump to next quickfix item |
| `[q` | Normal | Previous quickfix | Jump to previous quickfix item |
| `<leader>qo` | Normal | Open quickfix | Open quickfix list |
| `<leader>qc` | Normal | Close quickfix | Close quickfix list |
| `<leader>qt` | Normal | Toggle quickfix | Toggle quickfix list |

## File Explorer (nvim-tree)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>e` | Normal | Toggle file explorer | Toggle file explorer on current file |
| `<leader>E` | Normal | Focus file explorer | Focus file explorer |
| `<esc>` | Normal | Close file explorer | Close nvim-tree |

## Telescope (Fuzzy Finder)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>f` | Normal | Find files | Fuzzy find files in cwd |
| `<leader>/` | Normal | Live grep | Search for string in cwd |
| `<leader>F` | Normal | Grep string | Find string under cursor in cwd |
| `<leader>b` | Normal | Open buffers | List open buffers |
| `<leader>h` | Normal | Help tags | Search help tags |
| `<leader>g` | Normal | Git files | Find git files |
| `<leader>A` | Normal | Open Alpha | Open Alpha dashboard |

### Telescope (Inside Picker)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<esc>` | Insert | Close | Close Telescope picker |
| `<C-k>` | Insert | Previous result | Move to previous result |
| `<C-j>` | Insert | Next result | Move to next result |

## Harpoon (File Navigation)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>a` | Normal | Add file | Add current file to harpoon |
| `<leader>hm` | Normal | Toggle menu | Toggle harpoon quick menu |
| `<leader>1` | Normal | File 1 | Jump to harpoon file 1 |
| `<leader>2` | Normal | File 2 | Jump to harpoon file 2 |
| `<leader>3` | Normal | File 3 | Jump to harpoon file 3 |
| `<leader>4` | Normal | File 4 | Jump to harpoon file 4 |
| `<C-S-P>` | Normal | Previous file | Navigate to previous harpoon file |
| `<C-S-N>` | Normal | Next file | Navigate to next harpoon file |
| `<leader>ha` | Normal | Add file | Add current file to harpoon |
| `<leader>hr` | Normal | Remove file | Remove current file from harpoon |
| `<leader>hc` | Normal | Clear list | Clear harpoon list |

## LSP (Language Server)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gR` | Normal | Show references | Show LSP references (Telescope) |
| `gD` | Normal | Go to declaration | Jump to declaration |
| `gd` | Normal | Go to definition | Jump to definition |
| `<leader>gd` | Normal | Show definitions | Show LSP definitions (Telescope) |
| `gi` | Normal | Go to implementation | Show LSP implementations (Telescope) |
| `gt` | Normal | Go to type definition | Show LSP type definitions (Telescope) |
| `<leader>ca` | Normal/Visual | Code actions | See available code actions |
| `<leader>rn` | Normal | Rename | Smart rename |
| `<leader>D` | Normal | Buffer diagnostics | Show diagnostics for file (Telescope) |
| `<leader>d` | Normal | Line diagnostics | Show diagnostics for line |
| `[d` | Normal | Previous diagnostic | Jump to previous diagnostic |
| `]d` | Normal | Next diagnostic | Jump to next diagnostic |
| `K` | Normal | Hover documentation | Show documentation for item under cursor |
| `<leader>rs` | Normal | Restart LSP | Restart LSP server |

## Completion (nvim-cmp)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-p>` | Insert | Previous item | Select previous completion item |
| `<C-n>` | Insert | Next item | Select next completion item |
| `<C-b>` | Insert | Scroll docs up | Scroll documentation up |
| `<C-f>` | Insert | Scroll docs down | Scroll documentation down |
| `<C-Space>` | Insert | Complete | Trigger completion |
| `<C-e>` | Insert | Abort | Close completion window |
| `<CR>` | Insert | Confirm | Confirm completion selection |

## Copilot (AI Suggestions)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-l>` | Insert | Accept suggestion | Accept Copilot suggestion |
| `<C-h>` | Insert | Next suggestion | Show next Copilot suggestion |
| `<C-g>` | Insert | Previous suggestion | Show previous Copilot suggestion |
| `<C-x>` | Insert | Dismiss | Dismiss Copilot suggestion |

### Copilot Panel

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<M-CR>` | Normal | Open panel | Open Copilot suggestions panel |
| `[[` | Normal | Previous | Jump to previous suggestion in panel |
| `]]` | Normal | Next | Jump to next suggestion in panel |
| `<CR>` | Normal | Accept | Accept suggestion from panel |
| `gr` | Normal | Refresh | Refresh suggestions in panel |

## Notes

- **Insert Mode Conflicts:** Copilot and nvim-cmp work independently. Copilot shows inline ghost text, while nvim-cmp shows a dropdown menu.
- **macOS Specific:** Option/Alt key bindings (`<M-...>`) may require terminal configuration to work properly.
- **Disabled Filetypes:** Copilot is disabled for: yaml, markdown, help, gitcommit, gitrebase, hgcommit, svn, cvs files.
