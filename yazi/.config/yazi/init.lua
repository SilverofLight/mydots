require("git"):setup()
require("full-border"):setup()

require("githead"):setup({
  show_branch = true,
  branch_prefix = "on",
  branch_color = "blue",
  branch_symbol = "",
  branch_borders = "()",

  commit_color = "bright magenta",
  commit_symbol = "@",

  show_behind_ahead = true,
  behind_color = "bright magenta",
  behind_symbol = "⇣",
  ahead_color = "bright magenta",
  ahead_symbol = "⇡",

  show_stashes = true,
  stashes_color = "bright magenta",
  stashes_symbol = "$",

  show_state = true,
  show_state_prefix = true,
  state_color = "red",
  state_symbol = "~",

  show_staged = true,
  staged_color = "bright yellow",
  staged_symbol = "+",

  show_unstaged = true,
  unstaged_color = "bright yellow",
  unstaged_symbol = "!",

  show_untracked = true,
  untracked_color = "blue",
  untracked_symbol = "?",
})
