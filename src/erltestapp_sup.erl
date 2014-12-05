-module(erltestapp_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    timer:sleep ( 15000 ),
    io:format("lib path: ~p~n", [code:get_path()]),
    test_print(),
    {ok, { {one_for_one, 5, 10}, []} }.


test_print() ->
    print(12, 15).


print(0, _) ->
    void;
print(NrTimes, Delay) ->
    timer:sleep( timer:seconds(Delay) ),
    lager:debug("Testing debug ~p ...~n", [NrTimes]),
    lager:info("Testing info ~p ...~n", [NrTimes]),
    lager:notice("Testing notice ~p ...~n", [NrTimes]),
    lager:warning("Testing warning ~p ...~n", [NrTimes]),
    lager:error("Testing error ~p ...~n", [NrTimes]),
    lager:critical("Testing critical ~p ...~n", [NrTimes]),
    lager:alert("Testing alert ~p ...~n", [NrTimes]),
    lager:emergency("Testing emergency ~p ...~n", [NrTimes]).
