% Yachay Tech - Mathematical and Comutacional Logic Lab 3
% Erick Olivo
% Graph Traversal


% Allow edge/2 predicates to be defined in different parts of the file
:- discontiguous edge/2.

% ==========================================
% Part 1 – Basics (Without Cycle)
% ==========================================

% 1.1. Define edges for this graph: a -> b -> c, a -> d -> c.

edge(a, b).
edge(b, c).
edge(a, d).
edge(d, c).

% 1.2. Test reachability using path/2
path_basic(X, Y) :- edge(X, Y).
path_basic(X, Y) :- edge(X, Z), path_basic(Z, Y).


% ==========================================
% Part 2 – Cycles
% ==========================================

% 2.1. Add a cycle: edge(c, a).

% Make sure edge(c, a) is commented out for Part 1 testing
% Uncomment edge(c, a) for Part 2 testing

edge(c, a). % Naive recursion may loop forever.

% 2.2. Fix it using the visited list approach
% We prevent this by keeping a list of visited nodes:
path(X, Y) :- path(X, Y, []).

path(X, Y, _) :- edge(X, Y).
path(X, Y, Visited) :-
    edge(X, Z),
    \+ member(Z, Visited),
    path(Z, Y, [X|Visited]).


% ==========================================
% Part 3 – Listing All Paths
% ==========================================

% 3.1. Use findall/3 to get all possible paths between a and c

path_with_list(Start, End, Path) :-
    path_with_list(Start, End, [Start], Path).

path_with_list(End, End, Visited, Path) :-
    reverse(Visited, Path).

path_with_list(Start, End, Visited, Path) :-
    edge(Start, Next),
    \+ member(Next, Visited),
    path_with_list(Next, End, [Next|Visited], Path).

% 3.2. Print the result

all_paths(Start, End) :-
    findall(Path, path_with_list(Start, End, Path), Paths),
    write('All paths from '), write(Start), write(' to '), write(End), write(':'), nl,
    print_paths(Paths).

print_paths([]).
print_paths([Path|Rest]) :-
    write('  '), write(Path), nl,
    print_paths(Rest).



% ==========================================
% Part 4 – Student Extension
% ==========================================

% 4.1. Create a graph representing a maze (rooms connected by doors)
door(entrance, hall1).
door(hall1, room1).
door(hall1, room2).
door(room1, hall2).
door(room2, hall2).
door(hall2, room3).
door(hall2, room4).
door(room3, exit).
door(room4, exit).

% 4.2. Write rules to find a path from entrance to exit
maze_path(Start, End) :- maze_path(Start, End, []).

maze_path(Start, End, _) :- door(Start, End).
maze_path(Start, End, Visited) :-
    door(Start, Next),
    \+ member(Next, Visited),
    maze_path(Next, End, [Start|Visited]).

% 4.3. Extend the program to print the actual path (list of nodes)
maze_path_with_list(Start, End, Path) :-
    maze_path_with_list(Start, End, [Start], Path).

maze_path_with_list(End, End, Visited, Path) :-
    reverse(Visited, Path).

maze_path_with_list(Start, End, Visited, Path) :-
    door(Start, Next),
    \+ member(Next, Visited),
    maze_path_with_list(Next, End, [Next|Visited], Path).

% Predicate to show all the paths at the maze.
all_maze_paths :-
    findall(Path, maze_path_with_list(entrance, exit, Path), Paths),
    write('All paths through the maze:'), nl,
    print_paths(Paths).
