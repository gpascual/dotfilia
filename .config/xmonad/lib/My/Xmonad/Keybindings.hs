module My.Xmonad.Keybindings (myKeys, myMouseBindings)
  where
import XMonad
import System.Exit (exitWith, ExitCode(ExitSuccess))
import XMonad.Hooks.ManageDocks (ToggleStruts(ToggleStruts))
import XMonad.Layout.ResizableTile (MirrorResize(MirrorShrink, MirrorExpand))
import XMonad.Util.EZConfig (mkKeymap)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myKeys = \conf -> mkKeymap conf $

  -- launch a terminal
  [ ("M-S-<Return>", spawn $ XMonad.terminal conf)

  -- launch dmenu
  , ("M-p", spawn "dmenu-xdg_menu")

  -- launch dmenu to choose a XDG appliaction
  , ("M-S-p r", spawn "eval \"dmenu_run $DMENU_OPTIONS\"")

  -- launch dmenu to choose a kaomoji
  , ("M-S-p k", spawn "dmenu-kaomoji")

  -- close focused window
  , ("M-S-c", kill)

  -- Rotate through the available layout algorithms
  , ("M-<Space>", sendMessage NextLayout)

  -- Reset the layouts on the current workspace to default
  , ("M-S-<Space>", setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size
  , ("M-n", refresh)

  -- Move focus to the next window
  , ("M-<Tab>", windows W.focusDown)

  -- Move focus to the next window
  , ("M-j", windows W.focusDown)

  -- Move focus to the previous window
  , ("M-k", windows W.focusUp  )

  -- Move focus to the master window
  , ("M-m", windows W.focusMaster  )

  -- Swap the focused window and the master window
  , ("M-<Return>", windows W.swapMaster)

  -- Swap the focused window with the next window
  , ("M-S-j", windows W.swapDown  )

  -- Swap the focused window with the previous window
  , ("M-S-k", windows W.swapUp    )

  -- Shrink the master area
  , ("M-h", sendMessage Shrink)

  -- Expand the master area
  , ("M-l", sendMessage Expand)

  -- Shrink resizable slave
  , ("M-S-h", sendMessage MirrorShrink)

  -- Expand resizable slave
  , ("M-S-l", sendMessage MirrorExpand)

  -- Push window back into tiling
  , ("M-t", withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area
  , ("M-,", sendMessage (IncMasterN 1))

  -- Deincrement the number of windows in the master area
  , ("M-.", sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap
  -- Use this binding with avoidStruts from Hooks.ManageDocks.
  -- See also the statusBar function from Hooks.DynamicLog.
  --
  , ("M-b", sendMessage ToggleStruts)

  -- Lock session
  , ("M-M1-l", spawn "slock physlock -dl; physlock -dL")

  -- Quit xmonad
  , ("M-S-q", io (exitWith ExitSuccess))

  -- Recompile xmonad
  , ("M-C-q", spawn "xmonad --recompile")

  -- Restart xmonad
  , ("M-q", spawn "xmonad --recompile; xmonad --restart")

  -- Run xmessage with a summary of the default keybindings (useful for beginners)
  , ("M-s", spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
  ]

  ++

  --
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  --
  [ ("M-" ++ m ++ [k], windows $ f i) | (i, k) <- zip (XMonad.workspaces conf) ['1' .. '9']
  , (f, m) <- [(W.greedyView, ""), (W.shift, "S-")]]

  ++

  --
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  --
  [ ("M-" ++ m ++ [key], screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip ['w', 'e', 'r'] [0..]
      , (f, m) <- [(W.view, ""), (W.shift, "S-")]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

  -- mod-button1, Set the window to floating mode and move by dragging
  [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))

  -- mod-button2, Raise the window to the top of the stack
  , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

  -- mod-button3, Set the window to floating mode and resize by dragging
  , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))

  -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p r          Launch dmenu",
    "mod-p p          Launch XDG application",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-LeftAlt-l  Lock session",
    "mod-Shift-q    Quit xmonad",
    "mod-Ctrl-q     Recompile xmonad",
    "mod-q          Restart xmonad",
    "mod-[1..9]     Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]

