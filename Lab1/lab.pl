% 1. ÁRBOL GENEALÓGICO
% 2. Define at least 10 parent/2 facts with multiple generations.
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


% 3. Add rules for:
% 3.1. granparent/2
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).


% 3.2. sibling/2 (comparten al menos un padre)
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.


% 3.3. (recursive)
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).


% 4.Food Preferences
% 5. Define facts likes/2
likes(john, pizza).
likes(john, pasta).
likes(mary, sushi).
likes(mary, pizza).
likes(tom, burgers).
likes(ann, sushi).
likes(bob, pizza).
likes(lucy, pasta).
likes(sam, sushi).
likes(alice, burgers).

% 6. Add rule food_friend/2 that is true if X and Y like the same food.
food_friend(X, Y) :-
    likes(X, Food),
    likes(Y, Food),
    X \= Y.

% 7. Math Utility
% 8. Define factorial recursively
factorial(0, 1).
factorial(N, Result) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, R1),
    Result is N * R1.


% 9. Define a rule_list(List, Sum) to compute the sum of a list.
sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, TailSum),
    Sum is H + TailSum.


% 10. List Processing
% 11. Implement length_list(List, Length).
length_list([], 0).
length_list([_|T], Length) :-
    length_list(T, TailLength),
    Length is 1 + TailLength.


% 12. Implement append_list
append_list([], L, L).
append_list([H|T], L2, [H|Result]) :-
    append_list(T, L2, Result).
