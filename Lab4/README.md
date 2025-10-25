# Prolog Lab 4: AI Logic Playground – Intelligent Maze Advisor - Step-by-Step Queries and  Responses
This    lab brings    together    the main    Prolog    concepts    learned so    far:    facts,    rules,    recursion,    lists,
graph   traversal,  and reasoning.  The objective   is  to  build   an  intelligent system  that    can
navigate    a   maze,   find    a   path,   and explain its reasoning   in  human-readable  form.

## Loading the Program
Start the `SWI-Prolog interpreter`:
```bash
swipl
```
````prolog
?- [maze_advisor].
true.
````

## Results of PART 1 - Test with queries like:
These queries test the basic `can_move/2` reasoning rule to confirm our facts (edge/2, blocked/2) and logic are correct.

```prolog
?- can_move(a,b).
true.

?- can_move(a,c).
false.
```
`Observation:` The system correctly identifies that `a` to `b` is open and `a` to `c` is not (because it's blocked)

```prolog
?- reason(a, c, R).
R = 'path is blocked' .
```

## Results of PART 3 - Test your implementation with various start and end nodes

These queries test the `move/4` recursive predicate directly. The resulting Path will be in reverse order.

### Test 1: Main Path (entrance to exit)

```prolog
?- move(entrance, exit, [entrance], Path).
Exploring from entrance to a...
Exploring from a to b...
Moving from b to exit.
Path = [exit, b, a, entrance] .
```

### Test 2: Sub-Path (a to exit)

```prolog
?- move(a, exit, [a], Path).
Exploring from a to b...
Moving from b to exit.
Path = [exit, b, a] .
```

### Test 3: Alternative Path (c to exit)
```prolog
?- move(c, exit, [c], Path).
Exploring from c to b...
Moving from b to exit.
Path = [exit, b, c] .
```

### Test 4: Blocked/Unreachable Path (a to c)
This tests the agent's behavior when a dirct path is blocked.
```prolog
?- move(a, c, [a], Path).
Exploring from a to b...
Exploring from b to exit...
false.
```
`Observation:` The agent correctly sees `can_move(a,c)` is `false`. It then backtracks and tries and alternative path via `a` to `b`. From `b`, it explores to `exit`. Since `exit` is not the target `c`, that path also fails. The program concludes with `false`.

## Results of PART 4 - Putting it All Together
This is the final test using the main `find_path/3` predicate, which class `move/4` and then reverses the result for a clean readable path.

```prolog
?- find_path(entrance, exit, Path).
Exploring from entrance to a...
Exploring from a to b...
Moving from b to exit.
Path = [entrance, a, b, exit] .
```

## Results of PART 5 - Optional Extensions
Testing the optional extensions added to the program.

### Test 5.1: why/2 Predicate
This predicate explains the reasoning for a potential move without executing it.

```prolog
?- why(a, b).
Reason for a -> b: path is open.
true.

?- why(a, c).
Reason for a -> c: path is blocked.
true.

?- why(b, a).
Reason for b -> a: No path exists.
true.
```

## Test 5.2: find_path_steps/4 Predicate
This predicate finds the path and also returns the total number of steps taken.

```prolog
?- find_path_steps(entrance, exit, Path, Steps).
Exploring from entrance to a...
Exploring from a to b...
Moving from b to exit.

Total steps taken: 3
Path = [entrance, a, b, exit],
Steps = 3.
```

## Implementation Summary
Reasoning was implemented using Prolog's built-in logical rules and recursion. The system's knowledge is defined by `edge/2` facts (paths) and `blocked/2` facts (obstacles). The core reasoning logic is in `can_move/2`, which infers a valid move by checking if a path exists and is not blocked. The `move/4` predicate uses this rule to recursively traverse the graph, printing its reasoning with `format/2` at each step, while a `Visited` list prevents infinite loops. This was extended with a `why/2` predicate to explicitly query the reason for a move and `move_steps/6` to track performance by counting steps.


