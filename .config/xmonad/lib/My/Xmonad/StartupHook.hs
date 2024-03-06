module My.Xmonad.StartupHook (myStartupHook)
  where
import Control.Monad (join, when)
import Data.Maybe (maybeToList)
import XMonad (Atom, X, asks, changeProperty32, getAtom, getWindowProperty32, liftIO, propModeAppend, spawn, theRoot, withDisplay)
import XMonad.Util.SpawnOnce (spawnOnce, spawnOnOnce)
import My.Xmonad.Workspaces (getWs)

-- the sxiv app, firefox (and maybe others) believes that fullscreen is not supported,
-- so this fixes that.
-- see: https://mail.haskell.org/pipermail/xmonad/2017-March/015224.html
-- and: https://github.com/xmonad/xmonad-contrib/pull/109
addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
  r               <- asks theRoot
  a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
  a               <- getAtom "ATOM"
  liftIO $ do
    sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
    when (fromIntegral x `notElem` sup) $ changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen = do
  wms <- getAtom "_NET_WM_STATE"
  wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
  mapM_ addNETSupported [wms, wfs]

myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawn "~/.config/xmonad/autorun.sh"
  spawnOnOnce (getWs "shell") "kitty"
  addEWMHFullscreen 
 
