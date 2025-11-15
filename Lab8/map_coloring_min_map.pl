:- use_module(library(clpfd)).

% PART A: Australia

regions_au([wa, nt, sa, q, nsw, v, t]).

edges_au([
    wa-nt, wa-sa,
    nt-sa, nt-q,
    sa-q, sa-nsw, sa-v,
    q-nsw,
    nsw-v
]).

color_names([1-red, 2-green, 3-blue, 4-yellow, 5-orange, 6-purple]).

map_color(K, Regions, Edges, Vars, Strategy) :-
    length(Regions, N),
    length(Vars, N),
    Vars ins 1..K,
    apply_constraints(Edges, Regions, Vars),
    labeling(Strategy, Vars).

apply_constraints([], _, _).
apply_constraints([R1-R2 | Rest], Regions, Vars) :-
    nth1(Idx1, Regions, R1),
    nth1(Idx1, Vars, C1),
    nth1(Idx2, Regions, R2),
    nth1(Idx2, Vars, C2),
    C1 #\= C2,
    apply_constraints(Rest, Regions, Vars).

pretty_print(Regions, Vars, ColorMap) :-
    format('~n Solution: ~n'),
    pretty_color_by_region(Regions, Vars, ColorMap).

pretty_color_by_region([], [], _).
pretty_color_by_region([Region|Rs], [Var|Vs], ColorMap) :-
    member(Var-ColorName, ColorMap),
    format('~w = ~w~n', [Region, ColorName]),
    pretty_color_by_region(Rs, Vs, ColorMap).

solve_au(K, Strategy) :-
    regions_au(Regions),
    edges_au(Edges),
    map_color(K, Regions, Edges, Vars, Strategy),
    color_names(ColorMap),
    pretty_print(Regions, Vars, ColorMap).


% PART B: South America

regions_sa([ar, bo, br, cl, co, ec, gfr, gy, py, pe, su, uy, ve]).

edges_sa([
    ar-bo, ar-br, ar-cl, ar-py, ar-uy,
    bo-br, bo-cl, bo-py, bo-pe,
    br-co, br-gfr, br-gy, br-py, br-pe, br-su, br-uy, br-ve,
    cl-pe,
    co-ec, co-pe, co-ve,
    ec-pe,
    gfr-su,
    gy-su, gy-ve
]).

solve_sa(K, Strategy) :-
    regions_sa(Regions),
    edges_sa(Edges),
    map_color(K, Regions, Edges, Vars, Strategy),
    color_names(ColorMap),
    pretty_print(Regions, Vars, ColorMap).

% -----------------------------------------------------------
% --- Task A: Find min colors ---
% -----------------------------------------------------------

min_colors(Regions, Edges, MaxK, MinK, Vars, Strategy) :-
    between(1, MaxK, K),
    map_color(K, Regions, Edges, Vars, Strategy),
    MinK = K,
    !.

min_colors_au(MaxK, MinK, Vars, Strategy) :-
    regions_au(Rs),
    edges_au(Es),
    min_colors(Rs, Es, MaxK, MinK, Vars, Strategy).

min_colors_sa(MaxK, MinK, Vars, Strategy) :-
    regions_sa(Rs),
    edges_sa(Es),
    min_colors(Rs, Es, MaxK, MinK, Vars, Strategy).

% ---------------------------------------------------------
% --- Task B: Pretty Printing for the minimal coloring ---
% ---------------------------------------------------------

solve_min_au(MaxK, Strategy) :-
    min_colors_au(MaxK, MinK, Vars, Strategy),
    format('~n Australia (Optimized) ~n'),
    format('Minimum colors needed: ~w~n', [MinK]),
    regions_au(Regions),
    color_names(ColorMap),
    pretty_print(Regions, Vars, ColorMap).

solve_min_sa(MaxK, Strategy) :-
    min_colors_sa(MaxK, MinK, Vars, Strategy),
    format('~n South America (Optimized) ~n'),
    format('Minimum colors needed: ~w~n', [MinK]),
    regions_sa(Regions),
    color_names(ColorMap),
    pretty_print(Regions, Vars, ColorMap).

