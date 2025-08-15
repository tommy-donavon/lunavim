return {
	'lazydev',
	ft = 'lua',
	after = function()
		local lazydev = require('lazydev')
		lazydev.setup()
	end,
}
