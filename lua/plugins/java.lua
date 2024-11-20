return {
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" }, -- Load only for Java files
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local jdtls = require("jdtls")

            -- Path to jdtls binary installed by Mason
            local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls"

            -- Set JAVA_HOME from the environment
            local java_home = vim.fn.getenv("JAVA_HOME")
            if not java_home or java_home == "" then
                vim.notify("JAVA_HOME is not set. Please set it in your shell configuration.", vim.log.levels.ERROR)
                return
            end

            -- Root directory for the project (searches for build files or `.git`)
            local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])

            -- Configuration for jdtls
            local config = {
                cmd = { jdtls_path },
                root_dir = root_dir,
                settings = {
                    java = {
                        home = java_home,
                    },
                },
            }

            -- Start or attach to the language server
            jdtls.start_or_attach(config)
        end,
    },
}

