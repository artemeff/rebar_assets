-module(rebar_assets).
-define(node(Bin), "node_modules/.bin/"++Bin).
-export([ 'assets'/2
        , 'assets-watch'/2
        ]).

'assets'(Config, _AppFile) ->
    prepare(Config, fun(Spec) ->
        Files = proplists:get_value(files, Spec, []),
        Exec  = join([?node("mincer-erl-compile"), join(Files)]),
        cmd(Exec)
    end).

'assets-watch'(Config, _AppFile) ->
    prepare(Config, fun(Spec) ->
        Files = proplists:get_value(files, Spec, []),
        Exec  = join([?node("mincer-erl-watch"), join(Files)]),
        cmd(Exec)
    end).

'assets-serve'(Config, _AppFile) ->
    prepare(Config, fun(Spec) ->
        Port    = proplists:get_value(assets_port, Spec, 3000),
        PortArg = "-p " ++ integer_to_list(Port),
        Exec    = join([?node("mincer-erl-serve"), PortArg]),
        cmd(Exec)
    end).

%%
%% Helpers
%%

prepare(Config, Fun) ->
    case rebar_utils:processing_base_dir(Config) of
        true ->
            case rebar_config:get(Config, static, undefined) of
                undefined -> skip;
                Spec -> install_deps(), Fun(Spec)
            end;
        _ -> ok
    end.

install_deps() ->
    case filelib:is_dir("node_modules/mincer-erl") of
        true -> ok;
        _ -> cmd("npm install mincer-erl")
    end.

cmd(Cmd) ->
    Opt = [return_on_error,{use_stdout,false}],
    Res = rebar_utils:sh(Cmd, Opt),
    case Res of
        {ok, _} -> ok;
        {error, {_,Err}} -> rebar_utils:abort(Err, []);
        _ -> rebar_utils:abort()
    end.

join(List) ->
    string:join(List, " ").
