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

color_names([1-red, 2-green, 3-blue, 4-yellow]).

map_color(K, Regions, Edges, Vars) :-
    length(Regions, N),
    length(Vars, N),
    Vars ins 1..K,
    apply_constraints(Edges, Regions, Vars),
    labeling([], Vars).

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

solve_au(K) :-
    regions_au(Regions),
    edges_au(Edges),
    map_color(K, Regions, Edges, Vars),
    color_names(ColorMap),
    pretty_print(Regions, Vars, ColorMap).


% PART B: South America
