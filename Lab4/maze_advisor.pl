
% PART 1 - Maze Representation

% Representing a maze as a graph where rooms are nodes and doors are edges.
% edge(NodeA, NodeB)

edge(entrance, a).
edge(a, b).
edge(a, c).
edge(b, exit).
edge(c, b).


blocked(a, c). % Door is blocked from a to c


% PART 2 - Reasoning Rules

% We can move from X to Y if an 'edge' from X to Y exists AND (,) it is NOT (\+) blocked.

can_move(X, Y) :-
    edge(X, Y),
    \+ blocked(X, Y).


reason(X, Y, 'path is open') :-
    can_move(X, Y).

reason(X, Y, 'path is blocked') :-
    blocked(X, Y).

reason(_X, Y, 'destination reached') :-
    Y == exit.


