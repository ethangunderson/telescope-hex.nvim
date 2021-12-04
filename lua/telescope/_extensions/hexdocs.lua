local finders = require("telescope.finders")
local conf = require("telescope.config").values
local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local hexdocs = require ("hexdocs")

local search = function(opts)
  local results = hexdocs.get_packages()
  pickers.new(opts or {}, {
    prompt_title = "Search Hex Packages",
    finder = finders.new_table {
      results = results
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selected = action_state.get_selected_entry()["value"]
        local url = "https://hexdocs.pm/" .. selected
        vim.cmd(":silent !open " .. vim.fn.fnameescape(url))
      end)

      return true
    end
  }):find()
end

return require("telescope").register_extension(
  {
    exports = {
      search = search
    }
  }
)
