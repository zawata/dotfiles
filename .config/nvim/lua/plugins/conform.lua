return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            sh = { "shfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            python = { "black" },
            -- JS/TS family + the rest: dprint (config from the project's dprint.json).
            javascript = { "dprint" },
            javascriptreact = { "dprint" },
            typescript = { "dprint" },
            typescriptreact = { "dprint" },
            json = { "dprint" },
            jsonc = { "dprint" },
            css = { "dprint" },
            html = { "dprint" },
            markdown = { "dprint" },
        },
        formatters = {
            clang_format = {
                prepend_args = { "--style=file", "--fallback-style=LLVM" },
            },
            dprint = {
                -- Resolve the project-local dprint (pnpm node_modules/.bin), else PATH.
                command = function(_, ctx)
                    local local_bin = vim.fs.find("node_modules/.bin/dprint", {
                        upward = true,
                        path = ctx.dirname,
                    })[1]
                    return local_bin or "dprint"
                end,
                -- Only format when the project actually has a dprint config.
                condition = function(_, ctx)
                    return vim.fs.find({ "dprint.json", ".dprint.json", "dprint.jsonc" }, {
                        upward = true,
                        path = ctx.dirname,
                    })[1] ~= nil
                end,
            },
        },
    },
}