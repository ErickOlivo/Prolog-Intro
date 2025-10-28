% Solving Sudoku with Constraint Logic Programming over Finite Domains (CLPFD)


% Base Code for Sudoku Solver
:- use_module(libary(clpfd)).

sudoku(Rows) :-
    append(Rows, Vars), Vars ins 1..9,
    maplist(all_different, Rows),
    transpose(Rows, Columns), maplist(all_different, Columns),
    blocks(Rows), maplist(label, Rows).
