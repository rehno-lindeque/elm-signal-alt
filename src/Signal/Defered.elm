module Signal.Defered where
{-| Defered signals

@docs foldl, prompt, defer
-}

import Signal as Core
import Signal.Prompt as Prompt
import Signal.Alt.Internal (DeferedSignal (..))
import Debug

type alias Signal a = DeferedSignal a

{-| Fold from the past, starting with an empty (defered) signal
**TODO: This is not yet implemented, please don't use it.**
-}
foldl : (a -> b -> b) -> b -> Signal a -> Signal b
foldl f = Debug.crash "Defered.foldl is not yet implemented"

--foldl f seed (Defered sig) = Defered (Core.foldp f (flip f seed) sig)

{-| Activate a defered signal to produce a regular (prompt) signal
-}
prompt : a -> Signal a -> Prompt.Signal a
prompt initial (Defered sig) = Core.foldp (flip always) initial sig

{-| Defer a prompt signal, discarding the initialized value
-}
defer : Prompt.Signal a -> Signal a
defer = Defered
