import Graphics.X11.ExtraTypes.XF86
import System.Process (spawnCommand)
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing (smartSpacing, spacing)
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP)
import XMonad.Util.SpawnOnce

-- Config
myTerminal = "kitty"

myModMask = mod4Mask

myBorderWidth = 1

myBrowser = "firefox"

myLayout = avoidStruts $ smartBorders $ spacing 8 $ tiled ||| Mirror tiled ||| Full
  where
    tiled = Tall 1 (3 / 100) (1 / 2)

--
main :: IO ()
main = do
  xmonad $
    ewmh $
      docks $
        def
          { terminal = myTerminal,
            modMask = myModMask,
            borderWidth = myBorderWidth,
            startupHook = myStartupHook,
            layoutHook = myLayout,
            manageHook = manageDocks <+> manageHook def,
            logHook = dynamicLogString def >>= xmonadPropLog
          }
          `additionalKeysP` myKeys

myStartupHook = do
  spawnOnce "xsetroot -cursor_name left_ptr"
  spawnOnce "feh --bg-scale /home/swarnim/Pictures/walls/walls/japanese-art-fishes-in-lake.png ~/Pictures/walls/walls/[voyager]-rllbts-windmills.jpg"
  spawnOnce "~/.xmonad/display-setup.sh"
  spawnOnce "picom"
  spawnOnce "polybar"
  spawnOnce "blueman-applet"
  spawnOnce "numlockx"
  spawnOnce "pasystray"
  spawnOnce "nm-applet"

myKeys =
  [ ("M-<Return>", spawn myTerminal),
    ("M-b", spawn myBrowser),
    ("M-<Tab>", toggleWS),
    ("M-l", spawn "slock"),
    -- Volume control
    ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_SINK@ toggle"),
    ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_SINK@ 5%-"),
    ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_SINK@ 5%+"),
    -- Brightness Control
    ("<XF86MonBrightnessUp>", spawn "brightnessctl s +10%"),
    ("<XF86MonBrightnessDown>", spawn "brightnessctl s 10%-")
  ]
