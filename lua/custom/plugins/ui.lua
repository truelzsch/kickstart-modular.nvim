-- Plugins: UI
-- https://github.com/rafi/vim-config

return {

	{
		'snacks.nvim',
		opts = {
			dashboard = { enabled = false },
			scroll = { enabled = false },
			terminal = {
				win = { style = 'terminal', wo = { winbar = '' } },
			},
			zen = {
				toggles = { git_signs = true },
				zoom = {
					show = { tabline = false },
					win = { backdrop = true },
				},
			},
		},
		keys = {
			{
				'<leader>N',
				desc = 'Neovim News',
				function()
					---@diagnostic disable-next-line: missing-fields
					Snacks.win({
						file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = 'yes',
							statuscolumn = ' ',
							conceallevel = 3,
						},
					})
				end,
			},
		},
	},
	{
		'folke/snacks.nvim',
		keys = function(_, keys)
			if LazyVim.pick.want() ~= 'snacks' then
				return
			end
			-- stylua: ignore
			local mappings = {
				{ '<leader><localleader>', function() Snacks.picker() end, mode = { 'n', 'x' }, desc = 'Pickers' },
				{
					'<localleader>z',
					mode = { 'n', 'x' },
					desc = 'Zoxide',
					function()
						Snacks.picker.zoxide({
							confirm = function(picker)
								picker:close()
								local item = picker:current()
								if item and item.file then
									vim.cmd.tcd(item.file)
								end
							end,
						})
					end,
				},
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = function(_, opts)
			if LazyVim.pick.want() ~= 'snacks' then
				return
			end
			return vim.tbl_deep_extend('force', opts or {}, {
				picker = {
					hidden = true,
					win = {
						input = {
							keys = {
								['jj'] = { '<esc>', expr = true, mode = 'i' },
								['<c-l>'] = { 'cycle_win', mode = { 'n', 'i' } },
								['sv'] = 'edit_split',
								['sg'] = 'edit_vsplit',
								['st'] = 'edit_tab',
								['.'] = 'toggle_hidden',
								[','] = 'toggle_ignored',
								['e'] = 'qflist',
								['E'] = 'loclist',
								['K'] = 'select_and_prev',
								['J'] = 'select_and_next',
								['*'] = 'select_all',
							},
						},
						list = {
							keys = {
								['<c-h>'] = { 'focus_input', mode = { 'n', 'i' } },
								['<c-l>'] = { 'cycle_win', mode = { 'n', 'i' } },
							},
						},
						preview = {
							keys = {
								['<c-h>'] = { 'focus_input', mode = { 'n', 'i' } },
								['<c-l>'] = { 'cycle_win', mode = { 'n', 'i' } },
							},
						},
					},
				},
			})
		end,
	},

  -----------------------------------------------------------------------------
  -- Hint and fix deviating indentation
  {
    'tenxsoydev/tabs-vs-spaces.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },

  -----------------------------------------------------------------------------
  -- Highlight words quickly
  {
    't9md/vim-quickhl',
		-- stylua: ignore
		keys = {
			{ '<leader>mt', '<Plug>(quickhl-manual-this)', mode = { 'n', 'x' }, desc = 'Highlight word' },
		},
  },
}
