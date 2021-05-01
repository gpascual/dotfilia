------------------------------------------------------------------------
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.

module My.Xmonad.ManageHook (myManageHook)
where

import XMonad (className, composeAll, doFloat, doShift, stringProperty, (=?), (-->), (<&&>))
import XMonad.Hooks.ManageDocks (manageDocks)
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import My.Xmonad.Workspaces (getWs)

windowRules = 
  [ (className =? "firefox" <&&> stringProperty "WM_WINDOW_ROLE" =? "Dialog") --> doFloat       -- float Firefox Dialog
  , className =? "jetbrains-toolbox"    --> doFloat                     -- float Jetbrains Toolbox
  , className =? "jetbrains-datagrip"   --> doShift (getWs "data")
  , className =? "jetbrains-phpstorm"   --> doShift (getWs "code")
  , className =? "Slack"                --> doShift (getWs "chat")
  , className =? "Lutris"               --> doShift (getWs "misc")
  ]

myManageHook = composeAll $
  [ manageDocks
  , isFullscreen --> doFullFloat
  ] ++ windowRules

