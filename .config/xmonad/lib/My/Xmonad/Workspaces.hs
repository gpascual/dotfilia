module My.Xmonad.Workspaces (myWorkspaces, getWs)
  where
import Data.List (elemIndex)
import Data.Maybe (fromMaybe)

xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

names :: [String]
names = ["shell", "code", "docs", "chat", "tasks", "web", "data", "misc"]

icons :: [String]
icons = ["\xf120", "\xe796", "\xf05da", "\xe217", "\xf0135", "\xf059f", "\xf163a", "\xf03d6"]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ names where
        clickable names = [ "<action=xdotool key super+" ++ show index ++ "><fn=1>" ++ icon ++ "</fn> " ++ name ++ "</action>" |
                      (index, name, icon) <- zip3 [1..8] names icons]

getWs :: String -> String
getWs name = myWorkspaces !! indexOrDefault name
  where
        indexOrDefault name = fromMaybe 0 $ elemIndex name names

