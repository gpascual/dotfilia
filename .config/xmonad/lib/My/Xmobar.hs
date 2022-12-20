module My.Xmobar (myXmobars)
  where
import Control.Monad.State (gets)
import Data.Foldable (for_)
import My.MaterialTheme.Colors(primaryLightColor, secondaryColor, secondaryLightColor, alertColor)
import XMonad (XState(windowset))
import XMonad.Hooks.DynamicLog (wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Util.Run (spawnPipe)
import System.IO (hPutStrLn)

import qualified XMonad.StackSet as W

printLnToXmprocs xmprocs x = do
  for_ xmprocs $ \xmproc -> do 
    hPutStrLn xmproc x

windowCount = gets $ Just . formatWindowCount . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
  where
    formatWindowCount count = "<fn=1>\xfab2 </fn>: " ++ count

myXmobars xmprocs xmprocsWithoutStdIn = xmobarPP
  { ppOutput = \x -> (printLnToXmprocs xmprocs x) >> (printLnToXmprocs xmprocsWithoutStdIn "\n") 
    , ppCurrent = xmobarColor secondaryLightColor "" . wrap "[" "]"                   -- Current workspace in xmobar
    , ppVisible = xmobarColor secondaryLightColor ""                                  -- Visible but not current workspace
    -- , ppHidden = xmobarColor secondaryLightColor ""                                -- Hidden workspaces in xmobar
    , ppHiddenNoWindows = xmobarColor primaryLightColor ""                            -- Hidden workspaces (no windows)
    , ppWsSep = " / "                                                                 -- Workspace separators
    , ppTitle = shorten 80 . wrap "<fn=1>\xfb13 </fn>: " ""                           -- Title of active window in xmobar
    , ppLayout = wrap "<fn=1>\xfc56 </fn>: " ""                                       -- Title of active window in xmobar
    , ppSep =  "<fc="++primaryLightColor++"> | </fc>"                                 -- Separators in xmobar
    , ppUrgent = xmobarColor alertColor "" . wrap "<fn=1>\xf525 </fn>" ""             -- Urgent workspace
    , ppExtras  = [ windowCount ]                                                     -- # of windows current workspace
    , ppOrder  = \(ws:l:t:ex) -> ["<fc="++secondaryColor++"><fn=2>\xe61f </fn></fc>"]++[ws,l]++ex++[t]
  }

