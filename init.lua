-- safe_require
function safe_require(module_name)
  local status, module = pcall(require, module_name)
  if not status then
    print('Module not found: ' .. module_name)
    return nil
  end
  return module
end

safe_require('basic')
safe_require('keymaps')
safe_require('plugins')
