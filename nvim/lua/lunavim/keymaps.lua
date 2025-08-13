vim.api.nvim_set_keymap('t', '<leader><Esc>', [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', { desc = '[S]ource [V]imrc', noremap = true })

vim.keymap.set('n', '<leader>fd', function()
	vim.diagnostic.open_float()
end, { desc = 'open [f]loating [d]iagnostics window' })
