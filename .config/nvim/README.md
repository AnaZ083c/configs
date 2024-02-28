# Basic usage of this configuration (keymaps and other how-tos)

`<leader>` ... space
`<S>` ... shift
`<C>` ... ctrl

## 1. Vim Git
| keymap | what it does |
| --- | --- |
| `<leader>hp` | preview hunk |
| `<leader>hb` | blame line |
| `<leader>tb` | toggle line blame |


## 2. Vim Trouble (suggestions)
| keymap | what it does |
| --- | --- |
| `<leader>xx` | view all diagnostics |
| `<leader>xw` | workspace diagnostics |
| `<leader>xd` | document diagnostics |
| `<leader>xq` | quick fix |
| `<leader>xl` | locklist |
| `<leader>gR` | lsp references |


## 3. Vim Telescope
| keymap | what it does |
| --- | --- |
| `<C-p>` | find files |
| `<leader><leader>` | old files |
| `<leader>fg` | grep through files (live grep) |
| `<leader>fh` | grep through nvim docs (live grep) |
| `<leader>fk` | grep through nvim keymaps |


## 4. Vim DAP (Debug Adapter Protocol)

### Requirements

```shell
mkdir ~/.virtualenvs
cd ~/.virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

**NOTE**: This configuration also accepts vscode launch configurations. To use those, simply create a `.vscode/launch.json` 
as you normally would when developing in VSCode. Then, to load this configuration, press `F5` and choose your configuration 
from the prompt.

### Usage
| keymaps | what it does |
| --- | --- |
| `<F5>` | loads your `.vscode/launch.json` file then runs the debugger |
| `<F9>` |  runs the debugger, resumes running |
| `<F8>` |  step over |
| `<F7>` |  step into |
| `<S-F7>` |  step out |
| `<leader>b` | toggle breakpoint |
| `<leader>bc` | clear breakpoint |
| `<leader>dt` | toggle DAP UI |
| `<leader>dr` | reset DAP UI (won't prompt for a configuration on the next run) |


