module My.Xmonad.Workspaces (myWorkspaces)
  where

xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

names :: [String]
names = ["code","chat", "web", "data", "misc"]

icons :: [String]
icons = ["\xe7c5", "\xfa00", "\xfa9e", "\xe706", "\xf8d5"]

myWorkspaces = clickable . (map xmobarEscape) $ names where                                                                      
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ "><fn=1>"++ icon ++ "</fn> " ++ ws ++"</action>" |
                      (i,ws, icon) <- zip3 [1..5] l icons,                                        
                      let n = i]

