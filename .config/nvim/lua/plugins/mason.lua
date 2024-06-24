return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        -- Mason must be loaded first
        "williamboman/mason.nvim",
    },
    config = function()
        -- Setup mason icons
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        -- Setup servers to auto install if missing
        require("mason-lspconfig").setup({
            ensure_installed = {
                "awk_ls",
                "bashls",
                "clangd",
                "cmake",
                "cssls",
                "html",
                "jsonls",
                "jdtls",
                "tsserver",
                "lua_ls",
                "autotools_ls",
                "markdown_oxide",
                "perlnavigator",
                "pyright",
                "lemminx",
                "yamlls",
            }
        })

    end,
}
