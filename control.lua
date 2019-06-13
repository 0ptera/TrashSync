
local function OnGuiClosed(event)
  if not event or not game then return end

  local player = game.players[event.player_index]
  if player and global.trash_slots[player.name] and event.gui_type == defines.gui_type.controller then
    local character = player.character
    if character then
      -- reset existing filters to stored filters
      player.auto_trash_filters = global.trash_slots[player.name]

      -- add requests to trash filters
      local filters = player.auto_trash_filters
      for i = 1, character.request_slot_count do
        local request = character.get_request_slot(i)
        if request then
          filters[request.name] = request.count
          player.auto_trash_filters = filters
        end
      end

    end
  end
end

-- toggle syncing Auto Trash with Requests on and off
function OnTrashSyncToggle(event)
  local player = game.players[event.player_index]
  local character = player.character
  if character then
    local show_text = player.mod_settings["trash-sync-flying-text"].value
    if global.trash_slots[player.name] then
      -- restore saved trash settings
      if show_text then
        player.surface.create_entity{name="flying-text", position=player.position, text="Trash sync off", color={r=1,g=0,b=0}}
      end
      player.set_shortcut_toggled("trash-sync-toggle-shortcut", false)

      player.auto_trash_filters = global.trash_slots[player.name]
      -- log(serpent.block(player.auto_trash_filters) )
      global.trash_slots[player.name] = nil
    else
      -- save current trash slots and sync
      if show_text then
        player.surface.create_entity{name="flying-text", position=player.position, text="Trash sync on", color={r=0,g=1,b=0}}
      end
      player.set_shortcut_toggled("trash-sync-toggle-shortcut", true)

      global.trash_slots[player.name] = {}
      if character.auto_trash_filters then -- returns nil instead of {}
        global.trash_slots[player.name] = character.auto_trash_filters
      end

      local filters = character.auto_trash_filters
      for i = 1, character.request_slot_count do
        local request = character.get_request_slot(i)
        if request then
          filters[request.name] = request.count
          player.auto_trash_filters = filters
          -- log(serpent.block(player.auto_trash_filters) )
        end
      end

    end
  end
end


---- INIT ----
do
local function register_events()
  -- script.on_event(defines.events.on_gui_opened, OnGuiOpened)
  script.on_event(defines.events.on_gui_closed, OnGuiClosed)
  script.on_event("trash-sync-toggle-hotkey", OnTrashSyncToggle)
  script.on_event(
    defines.events.on_lua_shortcut,
      function(event)
        if event.prototype_name == "trash-sync-toggle-shortcut" then
          OnTrashSyncToggle(event)
        end
      end
  )
end

script.on_load(function(event)
	register_events()
end)

script.on_init(function(event)
  global.trash_slots = {}
	register_events()
end)

script.on_configuration_changed(function(event)
  global.trash_slots = global.trash_slots or {}
  -- ensure shortcut is toggled correctly
  for _,player in pairs(game.players) do
    if global.trash_slots[player.name] then
      player.set_shortcut_toggled("trash-sync-toggle-shortcut", true)
    else
      player.set_shortcut_toggled("trash-sync-toggle-shortcut", false)
    end
  end
  register_events()
end)
end