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
