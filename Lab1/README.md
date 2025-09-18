# 13. Queries to Run

?- [lab].
  true.

# 14. Who are the ancestor of a specific person?

?- ancestor(X, alice).

X = bob ;
X = john ;
X = mary ;
false.

# 15. Who are siblings in your family tree?

?- sibling(X, Y).

X = mary, Y = tom ;
X = tom, Y = mary ;
X = ann, Y = bob ;
X = bob, Y = ann ;
X = lucy, Y = sam ;
X = sam, Y = lucy ;
X = peter, Y = sarah ;
X = sarah, Y = peter ;
false.

# 16. Who are food friends?

?- food_friend(X, Y).

  X = john, Y = mary ;  % Ambos les gusta pizza
  X = john, Y = bob ;   % Ambos les gusta pizza
  X = mary, Y = ann ;   % Ambos les gusta sushi
  X = mary, Y = sam ;   % Ambos les gusta sushi


# 17. What is the factorial of 6?

?- factorial(6, Result).
  Result = 720.


# 18. What is the sum of [2,4,6,8]:

?- sum_list([2,4,6,8], Sum).

  Sum = 20.


# 19. What is the length of [a,b,c,d]:

?- length_list([a,b,c,d], Length).
  Length = 4.


# 20. Append [1,2] and [3,4]:


?- append_list([1,2], [3,4], Result).
  Result = [1, 2, 3, 4].



