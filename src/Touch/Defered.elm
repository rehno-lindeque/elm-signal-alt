module Touch.Defered where
{-| Defered signals for the `Touch` module.

@docs Touch
@docs touches, taps
-}
import Signal.Defered as Defered
import Signal.Defered (defer)
import Touch

type alias Touch = Touch.Touch

touches : Signal (List Touch)
touches = Touch.touches

taps : Defered.Signal { x:Int, y:Int }
taps = defer Touch.taps
