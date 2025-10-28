% Solving Sudoku with Constraint Logic Programming over Finite Domains (CLPFD)


% Base Code for Sudoku Solver
:- use_module(libary(clpfd)).

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

Puzzle = [
    [5,3,_,_,7,_,_,_,_],
    [6,_,_,1,9,5,_,_,_],
    [_,9,8,_,_,_,_,6,_],
    [8,_,_,_,6,_,_,_,3],
    [4,_,_,8,_,3,_,_,1],
    [7,_,_,_,2,_,_,_,6],
    [_,6,_,_,_,_,2,8,_],
    [_,_,_,4,1,9,_,_,5],
    [_,_,_,_,8,_,_,7,9]
].

% Helper predicate to solve and print
solve :-
    puzzle(Rows),
    sudoku(Rows),
    maplist(writeln, Rows).
