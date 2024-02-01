return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" }, -- load when a buffer is opened or created
  build = ":TSUpdate",
  config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query", "json", "javascript",
        "typescript", "tsx", "yaml", "html", "css", "prisma",
        "markdown", "markdown_inline", "svelte", "http", "java", "php",
        "rust", "scss", "sql", "bash", "astro", "dockerfile",
        "gitignore"
    },
    sync_install = false,
    auto_install = true,
    indent = {enable = true},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {"markdown"}
    }
  })
  local treesitter_parser_config =
  require("nvim-treesitter.parsers").get_parser_configs()
  treesitter_parser_config.templ = {
    install_info = {
      url = "https://github.com/vrischmann/tree-sitter-templ.git",
      files = {"src/parser.c", "src/scanner.c"},
      branch = "master"
    }
  }
  vim.treesitter.language.register("templ", "templ")
  end
}
