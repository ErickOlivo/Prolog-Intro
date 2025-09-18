

?- [lab].
true.
Consultas del laboratorio:
Ancestros de una persona específica:

prolog
?- ancestor(X, alice).
X = bob ;
X = john ;
X = mary ;
false.
Hermanos en el árbol genealógico:

prolog
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
Amigos por comida (food friends):

prolog
?- food_friend(X, Y).
X = john, Y = mary ;  % Ambos les gusta pizza
X = john, Y = bob ;   % Ambos les gusta pizza
X = mary, Y = ann ;   % Ambos les gusta sushi
X = mary, Y = sam ;   % Ambos les gusta sushi
% ... y más combinaciones
Factorial de 6:

prolog
?- factorial(6, Result).
Result = 720.
Suma de [2,4,6,8]:

prolog
?- sum_list([2,4,6,8], Sum).
Sum = 20.
Longitud de [a,b,c,d]:

prolog
?- length_list([a,b,c,d], Length).
Length = 4.
Concatenar [1,2] y [3,4]:

prolog
?- append_list([1,2], [3,4], Result).
Result = [1, 2, 3, 4].
🔍 Consultas adicionales sugeridas
prolog
% Todos los abuelos y sus nietos
?- grandparent(X, Y).

% Personas a las que les gusta la pizza
?- likes(X, pizza).

% Factoriales del 1 al 5
?- between(1, 5, N), factorial(N, F).

% Sumas de varias listas
?- sum_list([1,2,3], S1), sum_list([10,20,30], S2), Total is S1 + S2.
📋 Notas importantes
Recursividad: Las reglas ancestor/2, factorial/2, sum_list/2, length_list/2 y append_list/3 son recursivas.

Backtracking: Prolog encontrará todas las soluciones posibles cuando uses ;.

Operador de corte: Puedes usar ! para evitar backtracking innecesario si lo deseas.

Eficiencia: Para listas muy grandes, considera usar acumuladores para mejorar la eficiencia.
