local map = vim.keymap.set
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
map("n", "<leader>iv", function()
	local file = current_file()
	if not file then
		return
	end

	vim.fn.jobstart({ "imv", file }, { detach = true })
end, { desc = "View image (imv)" })

-- view img via path
local function open_image_under_cursor()
	local line = vim.api.nvim_get_current_line()

	-- extract markdown image path: ![...](path)
	local path = line:match("%!%[.-%]%((.-)%)")

	if not path then
		notify("No image found on line")
		return
	end

	-- handle relative paths
	local fullpath = vim.fn.expand("%:p:h") .. "/" .. path
	fullpath = vim.fn.fnamemodify(fullpath, ":p")

	vim.fn.jobstart({ "imv", fullpath }, { detach = true })
end

map("n", "<leader>ip", open_image_under_cursor, { desc = "Preview image (markdown)" })

-- Edit based on filetype
map("n", "<leader>ie", function()
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
