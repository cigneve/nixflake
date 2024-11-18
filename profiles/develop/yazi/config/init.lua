local git_theme = {
  modified_sign = "MOD",
  added_sign = "ADD",
  untracked_sign = "UT",
  ignored_sign = "IGN",
  deleted_sign = "DEL",
  updated_sign = "UPD",
}

THEME.git = git_theme
pcall(function() require("git"):setup() end)
