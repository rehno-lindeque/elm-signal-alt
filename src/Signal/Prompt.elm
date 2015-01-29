module Signal.Prompt where
{-| Import this module as follows:

    import Signal.Alt as Signal
    import Signal.Alt (Signal)
    import Signal.Defered as Defered
    import Mouse.Defered as Mouse

    -- Produces a defered signal that looks like this: <1,2,3,4,5,...>
    clicksCounter : Defered.Signal Int
    clicksCounter = Defered.foldl (\c -> c + 1) 0 Mouse.clicks
    
    -- Produces a prompt signal that looks like this: <Nothing,Just "1",Just "2",Just "3",Just "4",Just "5",...>
    displayedClicks : Signal Int
    displayedClicks = Singal.prompt Nothing <| (Just << toString <~ clicksCounter)
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
