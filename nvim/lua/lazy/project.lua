return {
	'project.nvim',
	after = function()
		local project = require('project_nvim')
		return project.setup {
			exclude_dirs = {
				'*//*',
			},
			detection_methods = {
				'pattern',
			},
			patterns = {
				'.git',
			},
		}
	end,
}
