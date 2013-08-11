-module(clock).
-export([
  start/1
]).

start(Browser) ->
  io:format("New connection from ~p~n", [Browser]),
  Browser ! [{cmd, fill_div}, {id, status}, {txt, <<"Connected to server.">>}],
  running(Browser).

running(Browser) ->
  receive
    A -> io:format("Got: ~p~n", [A])
  end,
  running(Browser).
