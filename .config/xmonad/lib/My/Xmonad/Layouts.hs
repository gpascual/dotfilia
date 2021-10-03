module My.Xmonad.Layouts (myLayouts, shellLayouts, chatLayouts, codeLayouts, dataLayouts)
  where
import Data.Maybe
import XMonad
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Layout.Accordion
import XMonad.Layout (Mirror(..), Full(..))
import XMonad.Layout.CenteredMaster (centerMaster)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.Spacing (spacingRaw, Border(..))

addSpace = spacingRaw True (Border 0 0 0 0) False (Border 8 4 4 4) True

-- default tiling algorithm partitions the screen into two panes
-- mirrored tiled
-- The default number of windows in the master pane
nmaster = 1

-- Default proportion of screen occupied by master pane
ratio = 5/7

-- Mirrored ratio
mirrorRatio = 3/5

-- ThreeCol ratio
threeColRatio = 7/11

-- Percent of screen to increment by when resizing panes
delta = 3/100

tall = renamed [Replace "tall"] $ addSpace (ResizableTall nmaster delta ratio [])

center = renamed [Replace "center"] $ addSpace (centerMaster Grid)

wide = renamed [Replace "wide"] $ addSpace (Mirror $ Tall nmaster delta mirrorRatio)

full = renamed [Replace "full"] Full

tallAccordion = renamed [Replace "y-accordion"] $ addSpace Accordion

wideAccordion = renamed [Replace "x-accordion"] $ addSpace $ Mirror Accordion

shellLayouts = tallAccordion ||| full

chatLayouts = full ||| center

codeLayouts = wideAccordion ||| full

dataLayouts = full

myLayouts =
  (   tall
  ||| center
  ||| wide
  ||| full
  )

