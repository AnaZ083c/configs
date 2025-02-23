# Basic usage of this configuration (keymaps and other how-tos)

* `<leader>` == space
* `<S>` == shift
* `<C>` == ctrl

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
| `<leader>fc` | grep through nvim colorschemes |
| `<leader>fp` | pick a Python debugger |

> [!NOTE]
> Picking a Python debugger manually is now replaced with an automatic setting up of the Python debugger based on which Python 
environment you're currently running when you press `F5` for debugging (see chapter below).


## 4. Vim DAP (Debug Adapter Protocol)

### Requirements

> [!NOTE]
> This step with the command line (below) is now optional, since this config is now able to automatically do this for you.
```shell
# deprecated step

mkdir ~/.virtualenvs
cd ~/.virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

> [!NOTE]
> This configuration also accepts vscode launch configurations. To use those, simply create a `.vscode/launch.json` inside your workspace (your project root directory)
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

## 5. AI (Ollama for a local 'copilot')
### Requirements

For this to work, you must have Ollama installed. You can install it as shown below.
```shell
curl -fsSL https://ollama.com/install.sh | sh
```

Then, you must also pull a model you'd like to use locally. Keep in mind that 7B models require 8 GB of RAM, 16 GB to run 13B models, and 32 GB to run the 33B models.

I personally recommend the Mistral model, since it's fine-tuned to suit the programmers best.
```shell
ollama pull mistral
```

For more info, you can check the official [Ollama GitHub page](https://github.com/ollama/ollama) or their [website](https://ollama.com/search) with all the available models to choose from.

### Usage
| keymaps | what it does |
| -------------- | --------------- |
| `<leader>ai` | Opens up actions to choose from |
| `<leader>ap` | Continue the chat in the prompt buffer |

