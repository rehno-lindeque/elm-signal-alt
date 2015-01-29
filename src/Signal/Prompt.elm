module Signal.Prompt where
{-| Prompt signals

@docs Signal
@docs foldl

-}

import Signal as Core
import Signal ((<~))
import Maybe

type alias Signal a = Core.Signal a

{-| An alternative to `foldp` for signals that builds on the intuition carried over from `List.foldl` and `Array.foldl`.
This function differs from `foldp` in that the starting value is a seed as is conventional in `foldl` and `foldr`
rather than being an initialization value as in `foldp`.
-}
foldl : (a -> b -> b) -> b -> Signal a -> Signal b
foldl f seed =
  let zip : Signal a' -> Signal b' -> Signal (a',b')
      zip = Core.map2 (,)

      initSignal : Signal a' -> Signal a'
      initSignal s = Core.sampleOn (Core.constant ()) s

      foldp' : (a' -> b' -> b') -> (a' -> b') -> Signal a' -> Signal b'
      foldp' f initf sig =
        let -- initial has no events, only the initial value is used
            initial = initf <~ initSignal sig
            -- both the initial value and the normal sig are given to f'
            rest = Core.foldp f' Nothing (zip sig initial)
            -- when mb is Nothing, sig had its first event to use ini
            -- otherwise use the b from Just
            f' (inp, ini) mb = Maybe.withDefault ini mb
                               |> f inp |> Just
            fromJust (Just a) = a
        in  fromJust <~ Core.merge (Just <~ initial) rest
  in foldp' f (flip f seed)
