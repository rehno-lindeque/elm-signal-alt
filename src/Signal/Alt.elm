module Signal.Alt where
{-| See [Signal.Prompt](http://package.elm-lang.org/packages/rehno-lindeque/elm-signal-alt/latest/Signal/Prompt) and [Signal.Defered](http://package.elm-lang.org/packages/rehno-lindeque/elm-signal-alt/latest/Signal/Defered) for detailed documentation.

#  Re-export prompt signal interface
@docs Signal
@docs foldl

# Re-export defered signal conversion functions
@docs prompt, defer

# Re-export prompt signal interface from core
@docs Channel, Message
@docs constant, map, map2, map3, map4, map5, merge, mergeMany, keepIf, dropIf, keepWhen, dropWhen, dropRepeats, sampleOn, (<~), (~), channel, send, subscribe
-}

import Signal as Core
import Signal.Prompt as Prompt
import Signal.Defered as Defered
import Signal.Alt.Internal as Internal

-- Re-export prompt signal interface
type alias Signal a = Prompt.Signal a
foldl : (a -> b -> b) -> b -> Signal a -> Signal b
foldl = Prompt.foldl

-- Re-export defered signal conversion functions
prompt : a -> Defered.Signal a -> Signal a
prompt = Defered.prompt
defer : Signal a -> Defered.Signal a
defer = Defered.defer

-- Re-export prompt signal interface from core
type alias Channel a = Core.Channel a
type alias Message a = Core.Message a
constant : a -> Signal a
constant = Core.constant
map : (a -> result) -> Signal a -> Signal result
map = Core.map
map2 : (a -> b -> result) -> Signal a -> Signal b -> Signal result
map2 = Core.map2
map3 : (a -> b -> c -> result) -> Signal a -> Signal b -> Signal c -> Signal result
map3 = Core.map3
map4 : (a -> b -> c -> d -> result) -> Signal a -> Signal b -> Signal c -> Signal d -> Signal result
map4 = Core.map4
map5 : (a -> b -> c -> d -> e -> result) -> Signal a -> Signal b -> Signal c -> Signal d -> Signal e -> Signal result
map5 = Core.map5
merge : Signal a -> Signal a -> Signal a
merge = Core.merge
mergeMany : List (Signal a) -> Signal a
mergeMany = Core.mergeMany
keepIf : (a -> Bool) -> a -> Signal a -> Signal a
keepIf = Core.keepIf
dropIf : (a -> Bool) -> a -> Signal a -> Signal a
dropIf = Core.dropIf
keepWhen : Signal Bool -> a -> Signal a -> Signal a
keepWhen = Core.keepWhen
dropWhen : Signal Bool -> a -> Signal a -> Signal a
dropWhen = Core.dropWhen
dropRepeats : Signal a -> Signal a
dropRepeats = Core.dropRepeats
sampleOn : Signal a -> Signal b -> Signal b
sampleOn = Core.sampleOn
(<~) : (a -> b) -> Signal a -> Signal b
(<~) = Core.map
(~) : Signal (a -> b) -> Signal a -> Signal b
(~) = Internal.apply
channel : a -> Core.Channel a
channel = Core.channel
send : Core.Channel a -> a -> Core.Message
send = Core.send
subscribe : Core.Channel a -> Signal a
subscribe = Core.subscribe
