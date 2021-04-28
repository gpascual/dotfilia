module My.Xmonad.Keybindings (myKeys, myMouseBindings)
  where
import XMonad
import System.Exit (exitWith, ExitCode(ExitSuccess))
import XMonad.Layout.ResizableTile (MirrorResize(MirrorShrink, MirrorExpand))

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ [

  -- launch a terminal
  ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

  -- launch dmenu
  , ((modm,               xK_r     ), spawn "dmenu_run -i -c -l 20 -h 16  -fn \"Noto Sans Medium-12\"")

  -- launch dmenu to choose a XDG appliaction
  , ((modm,               xK_p     ), spawn "dmenu-xdg_menu")

  -- close focused window
  , ((modm .|. shiftMask, xK_c     ), kill)

  -- Rotate through the available layout algorithms
  , ((modm,               xK_space ), sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default
  , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size
  , ((modm,               xK_n     ), refresh)

  -- Move focus to the next window
  , ((modm,               xK_Tab   ), windows W.focusDown)

  -- Move focus to the next window
  , ((modm,               xK_j     ), windows W.focusDown)

  -- Move focus to the previous window
  , ((modm,               xK_k     ), windows W.focusUp  )

  -- Move focus to the master window
  , ((modm,               xK_m     ), windows W.focusMaster  )

  -- Swap the focused window and the master window
  , ((modm,               xK_Return), windows W.swapMaster)

  -- Swap the focused window with the next window
  , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

  -- Swap the focused window with the previous window
  , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

  -- Shrink the master area
  , ((modm,               xK_h     ), sendMessage Shrink)

  -- Expand the master area
  , ((modm,               xK_l     ), sendMessage Expand)

  -- Shrink resizable slave
  , ((modm .|. shiftMask, xK_h     ), sendMessage MirrorShrink)

  -- Expand resizable slave
  , ((modm .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

  -- Push window back into tiling
  , ((modm,               xK_t     ), withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area
  , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

  -- Deincrement the number of windows in the master area
  , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap
  -- Use this binding with avoidStruts from Hooks.ManageDocks.
  -- See also the statusBar function from Hooks.DynamicLog.
  --
  -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

  -- Quit xmonad
  , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

  -- Recompile xmonad
  , ((modm .|. controlMask, xK_q     ), spawn "xmonad --recompile")

  -- Restart xmonad
  , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

  -- Run xmessage with a summary of the default keybindings (useful for beginners)
  , ((modm              , xK_s ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
  ]

  ++

  --
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  --
  [ ((m .|. modm, k), windows $ f i) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

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
    "mod-r            Launch dmenu",
    "mod-p            Launch XDG application",
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

