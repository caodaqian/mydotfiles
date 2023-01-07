local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = { {
		name = "DiagnosticSignError",
		text = ""
	}, {
		name = "DiagnosticSignWarn",
		text = ""
	}, {
		name = "DiagnosticSignHint",
		text = ""
	}, {
		name = "DiagnosticSignInfo",
		text = ""
	} }

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, {
			texthl = sign.name,
			text = sign.text,
			numhl = ""
		})
	end

	local config = {
		-- disable virtual text
		virtual_text = true,
		-- show signs
		signs = {
			active = signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = ""
		}
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded"
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded"
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
	end
end

-- require lsp
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = false }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "=", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "v", "=", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dj", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>',
		opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dk", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<cr>',
		opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>Q', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>E', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
end

M.on_attach = function(client, bufnr)
	-- if client.name == "tsserver" or client.name == "clangd" then
	-- client.resolved_capabilities.document_formatting = false
	-- end
	lsp_keymaps(bufnr)
	-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
	-- lsp_highlight_document(client)

	-- add outline support for evey lanuage
	-- require("aerial").on_attach(client, bufnr)
	require "lsp_signature".on_attach()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
return M
