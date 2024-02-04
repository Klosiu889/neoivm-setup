return {
    'folke/trouble.nvim',

    config = function()
        vim.keymap.set('n', '<leader>tt', '<cmd>TroubleToggle<cr>')
        vim.keymap.set('n', '<leader>[t', function () require('trouble').previous({skip_groups = true, jump = true}) end )
        vim.keymap.set('n', '<leader>]t', function () require('trouble').next({skip_groups = true, jump = true}) end )
    end,

}