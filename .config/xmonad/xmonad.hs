import XMonad
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, docks)
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)
import My.MaterialTheme.Colors (primaryLightColor, secondaryColor)
import My.Xmonad.Keybindings (myKeys, myMouseBindings)
import My.Xmonad.Layouts (myLayouts, shellLayouts, chatLayouts, codeLayouts, dataLayouts)
import My.Xmonad.ManageHook (myManageHook)
import My.Xmonad.StartupHook (myStartupHook)
import My.Xmonad.Workspaces (myWorkspaces, getWs)
import My.Xmobar (myXmobars)

main = do
  -- start status bars and save their process handlers
  xmproc0nw <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc0nw"
  xmproc0ne <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc0ne"
  let
    stdInXmobars = [xmproc0nw]
    noStdInXmobars = [xmproc0ne]
  xmonad $ ewmhFullscreen . ewmh $ fullscreenSupport $ docks $ desktopConfig
    -- simple stuff
    { terminal           = "kitty"
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , borderWidth        = 2
    , modMask            = mod4Mask
    , workspaces         = myWorkspaces
    , normalBorderColor  = primaryLightColor
    , focusedBorderColor = secondaryColor
  
    -- key bindings
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
         
    -- hooks, layouts
    , layoutHook         = -- smartBorders $ fullscreenFull $ avoidStruts $
                           onWorkspace (getWs "shell") (smartBorders $ avoidStruts shellLayouts) $
                           onWorkspace (getWs "code") (smartBorders $ avoidStruts codeLayouts) $
                           onWorkspace (getWs "chat") (smartBorders $ avoidStruts chatLayouts) $
                           onWorkspace (getWs "data") (smartBorders $ avoidStruts dataLayouts) $
                           (smartBorders $ avoidStruts myLayouts)
    , manageHook         = myManageHook
    , startupHook        = myStartupHook
    , logHook            = dynamicLogWithPP $ myXmobars stdInXmobars noStdInXmobars
    }

