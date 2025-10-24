
% PART 1 - Maze Representation

% Representing a maze as a graph where rooms are nodes and doors are edges.
% edge(NodeA, NodeB)

edge(entrance, a).
edge(a, b).
edge(a, c).
edge(b, exit).
edge(c, b).


blocked(a, c). % Door is blocked from a to c

