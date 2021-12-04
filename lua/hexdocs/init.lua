-- https://hex.pm/api/packages?search=ecto&sort=downloads

local M = {}
local curl = require("plenary.curl")

M.get_packages = function()
  local response = curl.request({
    url = "https://hex.pm/api/packages?sort=downloads",
    method = "get",
    accept = "application/json"
  })

  if response.status ~= 200 then
    error("Failed to search hex.pm, got a status: " .. response.status)
    return {}
  end

  local decoded = vim.fn.json_decode(response.body)
  local results = {}

  for index, value in ipairs(decoded) do
    results[index] = value["name"]
  end

  return results
end

return M
