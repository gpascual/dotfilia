import XMonad
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhDesktopsEventHook, fullscreenEventHook)
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, docks)
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Util.Run (spawnPipe)
import My.MaterialTheme.Colors (primaryLightColor, secondaryColor)
import My.Xmonad.Keybindings (myKeys, myMouseBindings)
import My.Xmonad.Layouts (myLayouts, chatLayouts, codeLayouts, dataLayouts)
import My.Xmonad.ManageHook (myManageHook)
import My.Xmonad.StartupHook (myStartupHook)
import My.Xmonad.Workspaces (myWorkspaces)
import My.Xmobar (myXmobars)

main = do
  -- start status bars and save their process handlers
  xmproc0nw <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc0nw"
  xmproc0ne <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc0ne"
  let
    stdInXmobars = [xmproc0nw]
    noStdInXmobars = [xmproc0ne]
  xmonad $ ewmh $ fullscreenSupport $ docks $ desktopConfig
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
                           onWorkspace (myWorkspaces !! 0) (smartBorders $ avoidStruts codeLayouts) $
			   onWorkspace (myWorkspaces !! 1) (smartBorders $ avoidStruts chatLayouts) $
			   onWorkspace (myWorkspaces !! 3) (smartBorders $ avoidStruts dataLayouts) $
			   (smartBorders $ avoidStruts myLayouts)
    , manageHook         = myManageHook
    , handleEventHook    = ewmhDesktopsEventHook <+> fullscreenEventHook <+> docksEventHook
    , startupHook        = myStartupHook
    , logHook = dynamicLogWithPP $ myXmobars stdInXmobars noStdInXmobars
    }

