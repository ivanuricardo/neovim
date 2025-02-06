local M = {}

function M.get_date()
  return vim.fn.strftime("%Y%m%d")
end

return M
