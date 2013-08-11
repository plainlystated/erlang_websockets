-module(erlang_websockets).
-export([
  start/0,
  dispatch/1
]).

start() ->
  Port = 8080,
  io:format("Staring Erlang Websockets demo at: localhost:~p~n", [Port]),
  ezwebframe:start_link(fun dispatch/1, Port).

dispatch(Path) ->
  File = dispatch1(Path),
  io:format("Got request: ~p~n", [File]),
  File.

dispatch1("/ezwebframe/" ++ F) ->
    Dir = dir(2, code:which(ezwebframe)) ++ "/priv/",
    Dir ++ F;
dispatch1("/" ++ F) ->
    Dir = dir(2,code:which(?MODULE)) ++ "/",
    Dir ++ F.

dir(0, F) -> F;
dir(K, F) -> dir(K-1, filename:dirname(F)).

