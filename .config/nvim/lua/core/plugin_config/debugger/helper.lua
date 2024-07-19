--#region Constants
local constants = {
  DEBUGPY_VENV_DIR = "~/.virtualenvs/"
}
--#endregion


--#region Functions

---Execute a custom command and get output as string
---@param command any
---@return string|nil
local function execute_command(command)
  local exec = io.popen(command)
  if exec == nil then
    print("Couldn't execute command: " .. command .. "\n")
    return nil
  end

  local output_string = exec:read("*a"):gsub("\n", "")
  exec:close()

  return output_string
end


---Get Python venvs and their versions from a provided directory
---@param directory string
---@param python_icon string|nil
---@return table
local function get_python_venvs(directory, python_icon)
  if python_icon == nil then
    python_icon = ""
  else
    python_icon = python_icon .. " "
  end

  local debuggers = {}

  local directories = io.popen("find " .. directory .. " -maxdepth 1 -type d | sed 1d")
  if directories == nil then
    print("No debuggers found.\n")
    return {}
  end

  local i = 1
  for debugger in directories:lines() do
    -- get python version 
    local python_version = execute_command(debugger .. "/bin/python --version")
    if python_version == nil then
      print("Couldn't get versions.\n")
      return {}
    end

    -- get relative paths
    debuggers[#debuggers+1] = {
      python_icon .. python_version,
      debugger .. "/bin/python"
    }

    i = i + 1
  end
  directories:close()

  return debuggers
end


---Automatic debugpy settings
---@param directory string
---@return string
local function get_debugpy(directory)
  local default = directory .. "debugpy/bin/python"
  local debuggers = get_python_venvs(directory, nil)
  local venv = os.getenv("VIRTUAL_ENV")

  if vim.bo.filetype ~= "python" then
    print(
      "Not a python file\n" ..
      "Using default debugging environment: " .. default .. "\n"
    )
    vim.api.nvim_out_write(
      "Not a python file\n" ..
      "Using default debugging environment: " .. default .. "\n"
    )
    return default
  end

  if venv == nil or venv == "" then
    print(
      "No venv in use.\n" ..
      "Using default debugging environment: " .. default .. "\n"
    )
    vim.api.nvim_out_write(
      "No venv in use.\n" ..
      "Using default debugging environment: " .. default .. "\n"
    )
    return default
  end

  local venv_version = execute_command(venv .. "/bin/python --version")
  if venv_version == nil then
    print(
      "Couldn't find your venv Python version.\n" ..
      "Using default debugging environment: " .. default .. "\n"
    )
    vim.api.nvim_out_write(
      "Couldn't find your venv Python version.\n" ..
      "Using default debugging environment: " .. default .. "\n"
    )
    return default
  end

  for _, debugger in ipairs(debuggers) do
    local version = debugger[1]

    -- if coresponding version exists, use that one
    if version == venv_version then
      print("Debugging environment set to: " .. debugger[2] .. "\n")
      vim.api.nvim_out_write("Debugging environment set to: " .. debugger[2] .. "\n")
      return debugger[2]  -- debugger venv path to bin/python
    end
  end

  -- else, create a new debugger environment for it
  local debugpy_path = string.format(
    "%sdebugpy%s",
    directory,
    string.match(venv_version, "%d+%.%d+%.%d+")
  )

  print("Creating a new debugging environment ...")
  vim.api.nvim_out_write("Creating a new debugging environment ...\n")
  local exec = execute_command(
    string.format("python -m venv %s && ", debugpy_path) ..
    string.format("%s/bin/python -m ensurepip --upgrade && ", debugpy_path) ..
    string.format("%s/bin/python -m pip install debugpy", debugpy_path)
  )
  if exec ~= "" then
    print("Debugging environment set to: " .. debugpy_path .. "\n")
    vim.api.nvim_out_write("Debugging environment set to: " .. debugpy_path .. "\n")
    return debugpy_path
  end

  print("Using default debugging environment\n")
  vim.api.nvim_out_write("Using default debugging environment\n")
  return default
end

--#endregion


return {
  execute_command = execute_command,
  get_python_venvs = get_python_venvs,
  get_debugpy = get_debugpy,

  constants = constants
}

