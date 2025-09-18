% 1. ÁRBOL GENEALÓGICO
% hechos parent/2 (mínimo 10)
parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(mary, bob).
parent(tom, lucy).
parent(tom, sam).
parent(bob, alice).
parent(bob, david).
parent(ann, peter).
parent(ann, sarah).


% Reglas para relaciones familiares
% Abuelo
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% Hermano (comparten al menos un padre)
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% Ancestro (recursivo)
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% 2. PREFERENCIAS ALIMENTICIAS
% Hechos likes/2
likes(john, pizza).
likes(john, pasta).
likes(mary, sushi).
likes(marym pizza).
likes(tom, burgers).
likes(ann, sushi).
likes(bob, pizza).
likes(lucy, pasta).
likes(sam, sushi).
likes(alice, burgers).

% Regla food_friend/2
food_friend(X, Y) :-
    likes(X, Food),
    likes(Y, Food),
    X \= Y.

% 3. UTILIDADES MATEMÁTICAS
factorial(0, 1).
factorial(N, Result) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, R1),
    Result is N * R1.

% Suma de una lista
sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, TailSum),
    Sum is H + Tailsum.

% 4. PROCESAMIENTO DE LISTAS
% Longitud de una lista
length_list([], 0).
length_list([_|T], Length) :-
    length_list(T, TailLength),
    Length is 1 + TailLength.

% Concatenar dos listas
append_list([], L, L).
apped_list([H|T], L2, [H|Result]) :-
    append_list(T, L2, Result).
