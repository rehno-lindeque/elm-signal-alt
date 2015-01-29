module Signal.Alt.Internal where
{-| Internal types and functions. Don't import this unless you know what you're doing.s
-}

import Signal (Signal, (~))

type DeferedSignal a = Defered (Signal a)

apply : Signal (a -> b) -> Signal a -> Signal b
apply = (~)
