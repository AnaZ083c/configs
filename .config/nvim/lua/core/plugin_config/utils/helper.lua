--#region Constants
local constants = {
  GLOBAL_PYTHON_ICON = " ",
  CONDA_PYTHON_ICON = "󱔎 ",
  VENV_PYTHON_ICON = " ",
  VERSION_ICON = " ",
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

--Fetch python version
---@return string
local function fetch_python_version()
  if vim.bo.filetype ~= "python" then
    return ""
  end

  -- Check if using python venv
  local venv = os.getenv("VIRTUAL_ENV")
  local venv_version = nil
  if venv ~= nil then
    venv_version = execute_command(venv .. "/bin/python --version")
  end

  -- Check if using conda python venv
  local conda_venv = os.getenv("CONDA_PREFIX")
  local conda_venv_version = nil
  if conda_venv ~= nil then
    conda_venv_version = execute_command(conda_venv .. "/bin/python --version")
  end

  -- Check for global python installation bin
  local global_python_path = execute_command("which python")
  local global_python_version = nil
  if global_python_path ~= nil then
    global_python_version = execute_command(global_python_path .. " --version")
  end

  if conda_venv_version ~= nil then
    conda_venv_version = string.gsub(conda_venv_version, "Python", constants.VERSION_ICON)
    return conda_venv_version .. " (conda)"
  end

  if venv_version ~= nil then
    venv_version = string.gsub(venv_version, "Python", constants.VERSION_ICON)
    return venv_version .. " (venv)"
  end

  if global_python_version ~= nil then
    global_python_version = string.gsub(global_python_version, "Python", constants.VERSION_ICON)
    return global_python_version .. " (global)"
  end

  vim.notify("Python not installed on this system", "warn")
  return ""
end

--#endregion


return {
  execute_command = execute_command,
  fetch_python_version = fetch_python_version,
}
