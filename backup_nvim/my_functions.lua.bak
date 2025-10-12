local M = {}

function M.find_files_expanded_word()
  -- Get the word under the cursor
  local word = vim.fn.expand("<cword>")
  print(word)

  -- Get the line under the cursor
  local line = vim.fn.getline(".")

  -- Pattern to match substring enclosed by either single or double quotes
  local pattern = "['\"]([^'\"]-)['\"]"

  expanded_word = word
  -- Iterate over all matches
  for match in string.gmatch(line, pattern) do
      if string.find(match, word) then
	    expanded_word = match
  	break
      end
  end


  -- Use the expanded word for further processing
  -- (e.g., call the Telescope find_files function)
  local telescope_cmd = string.format(
  ":lua require('telescope.builtin').find_files({find_command={'fd', '-tf', '-p', '%s'}})",
    expanded_word
  )
  vim.cmd(telescope_cmd)


  --require('telescope.builtin').find_files({find_command={'fd', expanded_word}})
end

return M
