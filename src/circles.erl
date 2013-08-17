-module(circles).
-export([
  start/1
]).

start(Browser) ->
  ObjCount = 0,
  io:format("New connection from ~p~n", [Browser]),
  %io:format("SVG STATE: ~p~n", [svg_state:start_link()]),
  {ok, SvgState} = svg_state:start_link(Browser),
  Browser ! [{cmd, fill_div}, {id, status}, {txt, <<"Connected to server.">>}],
  Browser ! [{cmd, add_canvas}, {width, 400}, {height, 400}, {tag, svg}],
  running(Browser, SvgState, ObjCount).

running(Browser, SvgState, ObjCount) ->
  receive
    {Browser, {struct, [{clicked, <<"New Circle">>}]}} ->
      spawn(fun () -> circle:start(Browser, ObjCount) end ),
      ObjCount1 = ObjCount + 1,
      io:format("started circle~n");
    A ->
      io:format("Got: ~p~n", [A]),
      ObjCount1 = ObjCount
  %after 250 ->
      %gen_server:cast(SvgState, draw_frame)
  end,
  running(Browser, SvgState, ObjCount1).
