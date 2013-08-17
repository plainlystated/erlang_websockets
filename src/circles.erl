-module(circles).
-export([
  start/1
]).

start(Browser) ->
  ObjCount = 0,
  io:format("New connection from ~p~n", [Browser]),
  Browser ! [{cmd, fill_div}, {id, status}, {txt, <<"Connected to server.">>}],
  Browser ! [{cmd, add_canvas}, {width, 400}, {height, 400}, {tag, svg}],
  running(Browser, ObjCount).

running(Browser, ObjCount) ->
  receive
    {Browser, {struct, [{clicked, <<"New Circle">>}]}} ->
      spawn(fun () -> circle:start(Browser, ObjCount) end ),
      ObjCount1 = ObjCount + 1,
      io:format("started circle~n");
    A ->
      io:format("Got unhandled msg: ~p~n", [A]),
      ObjCount1 = ObjCount
  end,
  running(Browser, ObjCount1).
