---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "nemo"
local menu        = "wofi-xdg_menu"
local runner      = "wofi --show run"
local lock        = "hyprlock"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local smw = hl.plugin.split_monitor_workspaces

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + SHIFT + P", hl.dsp.submap("runners"))
hl.define_submap("runners", function ()

  hl.bind("R", function ()
    hl.dispatch(hl.dsp.exec_cmd(runner))
    hl.dispatch(hl.dsp.submap("reset"))
  end)

  hl.bind("K", function ()
    hl.dispatch(hl.dsp.exec_cmd("wofi-kaomoji"))
    hl.dispatch(hl.dsp.submap("reset"))
  end)

  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

local layoutsList = {
  "dwindle",
  "master",
  "monocle",
  "scrolling"
}

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(lock))

-- Move focus with mainMod + VIM-like arrow keys

hl.bind(mainMod .. " + H", function ()
  local currentLayout = hl.get_active_workspace().tiled_layout

  -- Monocle layout
  if "monocle" == currentLayout then
    hl.dispatch(hl.dsp.layout("cycleprev"))

  else
    hl.dispatch(hl.dsp.focus({ direction = "left" }))

  end
end)

hl.bind(mainMod .. " + L", function () 
  local currentLayout = hl.get_active_workspace().tiled_layout

  -- Monocle layout
  if "monocle" == currentLayout then
    hl.dispatch(hl.dsp.layout("cyclenext"))

  else
    hl.dispatch(hl.dsp.focus({ direction = "right" }))

  end
end)

hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Swap window with mainMod + VIM-like arrow keys
hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",  hl.dsp.window.swap({ direction = "down" }))

hl.bind(mainMod .. " + RETURN", function ()
  local currentLayout = hl.get_active_workspace().tiled_layout

  -- Dwindle
  if "dwindle" == currentLayout then
    hl.dispatch(hl.dsp.layout("movetoroot active unstable"))

  -- Master layout
  elseif "master" == currentLayout then
    hl.dispatch(hl.dsp.layout("swapwithmaster master"))

  end
end)

-- Cycle layouts
hl.bind(mainMod .. " + SPACE", function ()
  local currentWs = hl.get_active_workspace()
  local currentLayout = currentWs.tiled_layout
  for i, layout in pairs(layoutsList) do
    if currentLayout == layout then
      local newLayout = layoutsList[i % 4 + 1]
      hl.notification.create({ text = newLayout .. " selected", duration = 2000, icon = "info" })
      hl.workspace_rule({ workspace = currentWs.id, layout = newLayout })
      return
    end
  end
end)

hl.bind(mainMod .. " + SHIFT + SPACE", function ()
  local currentWs = hl.get_active_workspace()
  local currentLayout = currentWs.tiled_layout
  for i, layout in pairs(layoutsList) do
    if currentLayout == layout then
      local newLayout = layoutsList[(i - 2) % 4 + 1]
      hl.notification.create({ text = newLayout .. " selected", duration = 2000, icon = "info" })
      hl.workspace_rule({ workspace = currentWs.id, layout = newLayout })
      return
    end
  end
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 8 do
    local key = tostring(i)
    hl.bind(mainMod .. " + " .. key, function () return smw.workspace(i) end)
    hl.bind(mainMod .. " + SHIFT + " .. key, function () return smw.move_to_workspace_silent(i) end)
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Monitors
hl.bind(mainMod .. " + W", hl.dsp.focus({ monitor = 0 }))
hl.bind(mainMod .. " + E", hl.dsp.focus({ monitor = 1 }))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({ monitor = 0 }))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.window.move({ monitor = 1 }))

-- Other
hl.bind("CTRL + ALT + H", hl.dsp.exec_cmd("cliphist list | wofi --dmenu --pre-display-cmd \"echo '%s' | cut -f 2\" | cliphist decode | wl-copy"))

