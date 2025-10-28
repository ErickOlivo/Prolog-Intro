% Solving Sudoku with Constraint Logic Programming over Finite Domains (CLPFD)


% Base Code for Sudoku Solver
:- use_module(library(clpfd)).

sudoku(Rows) :-
    append(Rows, Vars), Vars ins 1..9,

    maplist(all_different, Rows),

    transpose(Rows, Columns),
    maplist(all_different, Columns),

    blocks(Rows),
    maplist(label, Rows).

% Defining 3x3 Block Constrains

blocks([]).
blocks([A,B,C|Rest]) :-
    blocks3(A, B, C),
    blocks(Rest).

blocks3([], [], []).
blocks3([A1,A2,A3|R1], [B1,B2,B3|R2], [C1,C2,C3|R3]) :-
    all_different([A1,A2,A3,B1,B2,B3,C1,C2,C3]),
    blocks3(R1, R2, R3).

% Example Puzzle

% Defines the puzzle board as a Prolog fact.
% Using a fact makes the code easier to test with different boards.
% e.g. ?- puzzle(Puzzle), sudoku(Puzzle), maplist(writeln, Puzzle).


puzzle([
    [5,3,_, _,7,_, _,_,_],
    [6,_,_, 1,9,5, _,_,_],
    [_,9,8, _,_,_, _,6,_],
    [8,_,_, _,6,_, _,_,3],
    [4,_,_, 8,_,3, _,_,1],
    [7,_,_, _,2,_, _,_,6],
    [_,6,_, _,_,_, 2,8,_],
    [_,_,_, 4,1,9, _,_,5],
    [_,_,_, _,8,_, _,7,9]
]).


% A famously difficult puzzle, called "Al Escargot".

% e.g. ?- puzzle_hard(Puzzle), sudoku(Puzzle), maplist(writeln, Puzzle).

puzzle_hard([
    [_,_,_, _,_,_, _,_,_],
    [_,_,_, _,_,3, _,8,5],
    [_,_,1, _,2,_, _,_,_],
    [_,_,_, 5,_,7, _,_,_],
    [_,_,4, _,_,_, 1,_,_],
    [_,9,_, _,_,_, _,_,_],
    [5,_,_, _,_,_, _,7,3],
    [_,_,2, _,1,_, _,_,_],
    [_,_,_, _,4,_, _,_,9]
]).

% Helper predicate to solve and print
% A simple predicate to run the default puzzle.
% Query: ?- solve.

solve :-
    puzzle(Rows),
    sudoku(Rows),
    write('Solution: '), nl,
    maplist(writeln, Rows).


