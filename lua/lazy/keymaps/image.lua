local function notify(msg)
	vim.notify(msg, vim.log.levels.INFO)
end

local function current_file()
	local file = vim.fn.expand("%:p")
	if file == "" then
		notify("No file")
		return nil
	end
	return file
end

-- Always view with imv
vim.keymap.set("n", "<leader>iv", function()
	local file = current_file()
	if not file then
		return
	end

	vim.fn.jobstart({ "imv", file }, { detach = true })
end, { desc = "View image (imv)" })

-- Edit based on filetype
vim.keymap.set("n", "<leader>ie", function()
	local file = current_file()
	if not file then
		return
	end

	local ext = vim.fn.expand("%:e"):lower()

	local editor
	if ext == "svg" then
		editor = "inkscape"
	elseif ext == "png" or ext == "jpg" or ext == "jpeg" or ext == "webp" then
		editor = "gimp"
	else
		notify("No editor configured for ." .. ext)
		return
	end

	vim.fn.jobstart({ editor, file }, { detach = true })
end, { desc = "Edit image (by type)" })
