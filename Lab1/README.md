

?- [lab].
  true.

# Ancestros de una persona específica:

?- ancestor(X, alice).

X = bob ;
X = john ;
X = mary ;
false.

# Hermanos en el árbol genealógico:

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

# Amigos por comida (food friends):

?- food_friend(X, Y).

  X = john, Y = mary ;  % Ambos les gusta pizza
  X = john, Y = bob ;   % Ambos les gusta pizza
  X = mary, Y = ann ;   % Ambos les gusta sushi
  X = mary, Y = sam ;   % Ambos les gusta sushi


# Factorial de 6:

?- factorial(6, Result).
  Result = 720.


# Suma de [2,4,6,8]:

?- sum_list([2,4,6,8], Sum).

  Sum = 20.
  Longitud de [a,b,c,d]:


?- length_list([a,b,c,d], Length).
  Length = 4.

  
# Concatenar [1,2] y [3,4]:


?- append_list([1,2], [3,4], Result).
  Result = [1, 2, 3, 4].







# Todos los abuelos y sus nietos
?- grandparent(X, Y).

# Personas a las que les gusta la pizza
?- likes(X, pizza).

# Factoriales del 1 al 5
?- between(1, 5, N), factorial(N, F).

# Sumas de varias listas
?- sum_list([1,2,3], S1), sum_list([10,20,30], S2), Total is S1 + S2.


Backtracking: Prolog encontrará todas las soluciones posibles cuando uses ;.

Operador de corte: Puedes usar ! para evitar backtracking innecesario si lo deseas.

Eficiencia: Para listas muy grandes, considera usar acumuladores para mejorar la eficiencia.
