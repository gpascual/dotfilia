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
import My.Xmonad.Workspaces (myWorkspaces)

windowRules = 
  [ (className =? "firefox" <&&> stringProperty "WM_WINDOW_ROLE" =? "Dialog") --> doFloat       -- float Firefox Dialog
  , className =? "jetbrains-toolbox"    --> doFloat                     -- float Jetbrains Toolbox
  , className =? "jetbrains-datagrip"   --> doShift (myWorkspaces !! 3) -- send DataGrip to "data" workspace at position 3 (positions start at 0)
  , className =? "jetbrains-phpstorm"   --> doShift (myWorkspaces !! 0) -- send PhpStorm to "code" workspace
  , className =? "Slack"                --> doShift (myWorkspaces !! 1) -- send Slack to "chat" workspace
  , className =? "Lutris"               --> doShift (myWorkspaces !! 4) -- send Lutris to "misc" workspace
  ]

myManageHook = composeAll $
  [ manageDocks
  , isFullscreen --> doFullFloat
  ] ++ windowRules

