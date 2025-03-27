# codeowners.nvim

A plugin for working with .github/CODEOWNERS.

The plugin has the following methods:

- `require("codeowners").get_buf_owner()` returns the codeowner of the current buffer.
- `require("codeowners").get_owner(fullpath)` returns the codeowner of the file path.
- `require("codeowners").reset()` resets the cache.

A user command `:CodeownersReset` can be used to reset the codeowners cache.

Example for adding current buffers codeowner to lualine.nvim:

```lua
-- lazy.nvim
{
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, 1, {
      function()
        return require("codeowners").get_buf_owner()
      end,
    })
  end,
}
```

## Installation

```lua
-- lazy.nvim
{
  "sim-maz/codeowners.nvim",
  config = function()
    require("codeowners").setup()
  end,
}
```
