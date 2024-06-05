---Execute a custom command and get output as string
---@param command string
---@return string
local function execute_command(command)
  local exec = io.popen(command)
  if exec == nil then
    print("Couldn't execute command: " .. command)
    return ""
  end

  local output_string = exec:read("*a"):gsub("\n", "")
  exec:close()

  return output_string
end


---Get Python venvs and their versions from a provided directory
---@param directory string
---@param python_icon any
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
    print("No debuggers found.")
    return {}
  end

  local i = 1
  for debugger in directories:lines() do
    -- get python version 
    -- local version = io.popen(debugger .. "/bin/python --version")
    -- if version == nil then
    --   print("Couldn't get versions.")
    --   return {}
    -- end
    -- local python_version = version:read("*a"):gsub("\n", "")
    -- version:close()
    local python_version = execute_command(debugger .. "/bin/python -- version")
    if python_version == "" then
      print("Couldn't get versions.")
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
  local default = directory .. "/debugpy/bin/python"
  local debuggers = get_python_venvs(directory, nil)
  local venv = os.getenv("VIRTUAL_ENV")

  if vim.bo.filetype ~= "python" then
    vim.api.nvim_out_write("This isn't a Python file")
    return default
  end

  if venv == nil or venv == "" then
    vim.api.nvim_out_write("No venv in use. Using default debugging environment")
    return default
  end

  local venv_version = execute_command(venv .. "/bin/python --version")
  for _, debugger in ipairs(debuggers) do
    local version = debugger[1]

    -- if coresponding version exists, use that one
    if version == venv_version then
      vim.api.nvim_out_write("Debugging environment set to: " .. debugger[2])
      return debugger[2]  -- debugger venv path to bin/python
    end
  end

  -- else, create a new debugger environment for it
  local debugpy_path = string.format(
    "%s/debugpy%s",
    directory,
    string.match(venv_version, "%d+%.%d+%.%d+")
  )

  vim.api.nvim_out_write("Creating a new debugging environment ...")
  local exec = execute_command(
    string.format("python -m venv %s && ", debugpy_path) ..
    string.format("%s/bin/python -m pip install debugpy", debugpy_path)
  )
  if exec ~= "" then
    vim.api.nvim_out_write("Debugging environment set to: " .. debugpy_path)
    return debugpy_path
  end

  vim.api.nvim_out_write("Using default debugging environment")
  return default
end


return {
  execute_command = execute_command,
  get_python_venvs = get_python_venvs,
  get_debugpy = get_debugpy
}

