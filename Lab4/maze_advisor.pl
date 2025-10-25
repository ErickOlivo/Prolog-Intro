
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

% reason/3 rules
reason(X, Y, 'path is open') :-
    can_move(X, Y).

reason(X, Y, 'path is blocked') :-
    blocked(X, Y).

% Extending reason/3
reason(_X, Y, 'destination reached') :-
    Y == exit.



% PART 3 - Recursive Traversal

% move(Current, Destination, Visited, FinalPath)

% Base Case: We have arrived. If we can move from X (current) to Y (destination).

move(X, Y, Visited, [Y|Visited]) :-
    can_move(X, Y),
    format('Moving from ~w to ~w.~n', [X, Y]).

% Recursive Case: We take a step and keep searching. To get from X to Y (destination)

move(X, Y, Visited, Path) :-
    can_move(X, Z),                                     % 1. We can move to an intermediate node Z
    \+ member(Z, Visited),                              % 2. And we have not visited Z before (prevents loops)
    format('Exploring from ~w to ~w...~n', [X, Z]),     % 3. Print the exploration
    move(Z, Y, [Z|Visited], Path).                      % 4. Recursively search from Z to Y



% PART 4: Putting It All Together

find_path(X, Y, Path) :-
    move(X, Y, [X], RevPath),                           % Call move, starting with X in the visited list
    reverse(RevPath, Path).                             % Reverse the path for the correct order



% PART 5 - Extensions (Optional)

% 5.1: Path Preference (e.g., prefer left paths)

% This is implemented implicitly by Prolog's top-down search.
% In PART 1, 'edge(a, b).' is defined BEFORE 'edge(a, c).'.
% Therefore, the 'move/4' predicate will always try to move to 'b'
% before it tries to move to 'c'.


% 5.2: why(X, Y) Predicate


% Case 1: A specific reason (open, blocked, reached) is found.
why(X, Y) :-
    reason(X, Y, Reason), !,                            % The '!' stops Prolog from looking for other rules.
    format('Reason for ~w -> ~w: ~w.~n', [X, Y, Reason]).

% Case 2: No edge exists at all.
why(X, Y) :-
    \+ edge(X, Y), !,
    format('Reason for ~w -> ~w: No path exists.~n', [X, Y]).

% Case 3: Edge exists but has no other reason.
why(X, Y) :-
    format('Reason for ~w -> ~w: Path exists but is not currently viable.~n', [X, Y]).


% 5.3: Performance Tracking (Steps)

% find_path_steps(Start, End, Path, Steps)
find_path_steps(X, Y, Path, Steps) :-
    move_steps(X, Y, [X], RevPath, 0, Steps),           % Start count at 0
    reverse(RevPath, Path),
    format('~n Total steps taken: ~w~n', [Steps]).

% move_steps(Current, Dest, Visited, Path, StepsIn, StepsOut)

% Base Case: Arrived. (Counts as the final step)

move_steps(X, Y, Visited, [Y|Visited], StepsIn, StepsOut) :-
    can_move(X, Y),
    format('Moving from ~w to ~w.~n', [X, Y]),
    StepsOut is StepsIn + 1.                            % Final step


% Recursive Case: Exploring.

move_steps(X, Y, Visited, Path, StepsIn, StepsOut) :-
    can_move(X, Z),
    \+ member(Z, Visited),
    format('Exploring from ~w to ~w...~n', [X, Z]),
    StepsNew is StepsIn + 1, % Increment step count
    move_steps(Z, Y, [Z|Visited], Path, StepsNew, StepsOut).



%  Implementation Summary

% Reasoning was implemented using Prolog's built-in logical rules and recursion.
% The system's knowledge is defined by 'edge/2' facts (paths) and 'blocked/2'
% facts (obstacles). The core reasoning logic is in 'can_move/2', which
% infers a valid move by checking if a path exists and is NOT blocked.
% The 'move/4' predicate uses this rule to recursively traverse the graph,
% printing its reasoning with 'format/2', while a 'Visited'
% list prevents infinite loops. This was extended with a 'why/2'
% predicate to explicitly query the reason for a move and 'move_steps/6'
% to track performance by counting steps.
