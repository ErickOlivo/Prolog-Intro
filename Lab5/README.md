# Prolog Lab 5: Solving Sudoku with CLPFD

## Introduction
This lab introduces Constraint Logic Programming over Finite Domains (CLPFD) in Prolog. Unlike standard logic programming, CLPFD allows you to define numerical domains and constraints, making it powerful for solving problems like scheduling, optimization, and puzzles such as Sudoku.

###  What is CLPFD?

Instead of writing a complex, step-by-step "how-to" algorithm (an *imperative* approach), this program uses a *declarative* approach. We simply:
1.  **Define the Domain:** State that all 81 cells must be integers from 1 to 9.
2.  **Define the Constraints:** State the rules of Sudoku (rows, columns, and blocks must all have unique values).
3.  **Label:** Ask Prolog's CLPFD solver to find a valid assignment of values that satisfies all constraints.

The solver handles the complex search and "backtracking" automatically, making the code incredibly short and readable.


## How to Run
1.  **Start SWI-Prolog:
    ```prolog
    swipl
    ```
2.  **Load the program** in SWI-Prolog:
    ```prolog
    ?- [sudoku].
    true.
    ```

3.  **Run one the queries below.***

---

## Queries and Results
Here are the queries you can run and their expected output.

### 1. Solve the Default Puzzle

This uses the simple `solve/0` predicate defined in the file. Which automatically fetches puzzle/1, runs the solver and prints the result.

**Query:**
```prolog
?- solve.
```

Or you can run this querie to solve the same puzzle. This query manually fetches the puzzle/1 fact and passes it to the sudoku/1 solver.

```prolog
?- puzzle(Puzzle), sudoku(Puzzle), maplist(writeln, Puzzle).
```

In both cases the output is indentical.
The program will solve the built-in `puzzle/1` and print the completed grid:

```prolog
Solution:
[5,3,4,6,7,8,9,1,2]
[6,7,2,1,9,5,3,4,8]
[1,9,8,3,4,2,5,6,7]
[8,5,9,7,6,1,4,2,3]
[4,2,6,8,5,3,7,9,1]
[7,1,3,9,2,4,8,5,6]
[9,6,1,5,3,7,2,8,4]
[2,8,7,4,1,9,6,3,5]
[3,4,5,2,8,6,1,7,9]
true.
```

### 2. Solve the "Al Escargot" (Hard) Puzzle

This query manually fetches the `puzzle_hard/1` fact and passes it to the `sudoku/1` solver.

**Query:**
```prolog
?- puzzle_hard(Puzzle), sudoku(Puzzle), maplist(writeln, Puzzle).
```

```prolog
[9,8,7,6,5,4,3,2,1]
[2,4,6,1,7,3,9,8,5]
[3,5,1,9,2,8,7,4,6]
[1,2,8,5,3,7,6,9,4]
[6,3,4,8,9,2,1,5,7]
[7,9,5,4,6,1,8,3,2]
[5,1,9,2,8,6,4,7,3]
[4,7,2,3,1,9,5,6,8]
[8,6,3,7,4,5,2,1,9]
```

### . Solve a Puzzle "In-line" (Manual Hard Way)

This query shows how to solve a puzzle by defining the grid directly in the query, without using a pre-defined fact

```prolog
?- Puzzle = [
    [_,_,_,_,_,_,_,_,_],
    [_,1,_,4,_,2,_,3,_],
    [_,_,2,_,_,8,_,_,_],
    [_,_,_,6,_,5,8,_,_],
    [_,4,_,_,_,_,_,1,_],
    [_,_,6,9,_,7,_,_,_],
    [_,_,_,_,_,1,_,_,6],
    [_,2,_,3,_,9,_,5,_],
    [_,_,_,_,_,_,_,_,_]
],
sudoku(Puzzle),
maplist(writeln, Puzzle).
```

**Result:**
```prolog
[3,5,4,1,7,6,2,8,9]
[6,1,8,4,9,2,7,3,5]
[7,9,2,5,3,8,1,6,4]
[1,7,3,6,4,5,8,9,2]
[5,4,9,2,8,3,6,1,7]
[2,8,6,9,1,7,5,4,3]
[4,3,5,8,2,1,9,7,6]
[8,2,7,3,6,9,4,5,1]
[9,6,1,7,5,4,3,2,8]
```


## Summary
This lab used the `clpfd` library to define variable domains and apply `all_different`constraints. It demonstrates how constraint propagation and labeling can solve complex problems declaratively like Sudoku, avoiding a manual brute-force search.
