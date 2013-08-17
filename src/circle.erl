-module(circle).
-export([
  start/2
]).

start(Browser, Ref) ->
  running(Browser, Ref, 200, 200).

running(Browser, Ref, X, Y) ->
  receive
  after 100 ->
      %io:format("Drawing circle at (~p,~p)~n", [X, Y]),
      draw(Browser, Ref, X, Y)
  end,
  running(Browser, Ref, X + 1, Y + 1).

draw(Browser, Ref, X, Y) ->
  Browser ! [
    {cmd, remove_svg_thing},
    {type, circle},
    {id, Ref}
  ],
  Browser ! [
    {cmd, add_svg_thing},
    {id, Ref},
    {cx, X},
    {cy, Y},
    {r, 10},
    {type, circle}
  ].
