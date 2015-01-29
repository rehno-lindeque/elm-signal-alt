module Mouse.Defered where
{-| Defered signals for the `Mouse` module.

@docs position, x, y, isDown, clicks
-}
import Signal (Signal)
import Signal.Defered as Defered
import Signal.Defered (defer)
import Mouse

position : Signal (Int,Int)
position = Native.Mouse.position

x : Defered.Signal Int
x = defer Mouse.x

y : Defered.Signal Int
y = defer Mouse.y

isDown : Signal Bool
isDown = Mouse.isDown

clicks : Defered.Signal ()
clicks = defer Mouse.clicks
