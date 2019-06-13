data:extend({
{
  type = "custom-input",
  name = "trash-sync-toggle-hotkey",
  key_sequence = "CONTROL + T",
  consuming = "game-only",
},
{
  type = "shortcut",
  name = "trash-sync-toggle-shortcut",
  order = "a[trash-sync-toggle-shortcut]",
  action = "lua",
  style = "default",
  toggleable = true,
  associated_control_input = "trash-sync-toggle-hotkey",
  icon =
  {
    filename = "__TrashSync__/icons/trash-sync.png",
    priority = "extra-high-no-scale",
    size = 32,
    scale = 1.2,
    flags = {"icon"}
  },
  disabled_icon =
  {
    filename = "__TrashSync__/icons/trash-sync-white.png",
    priority = "extra-high-no-scale",
    size = 32,
    scale = 1.2,
    flags = {"icon"}
  },
  small_icon =
  {
    filename = "__TrashSync__/icons/trash-sync.png",
    size = 32,
    scale = 0.75,
    flags = {"icon"}
  },
  disabled_small_icon =
  {
    filename = "__TrashSync__/icons/trash-sync-white.png",
    priority = "extra-high-no-scale",
    size = 32,
    scale = 0.75,
    flags = {"icon"}
  },
}
})
