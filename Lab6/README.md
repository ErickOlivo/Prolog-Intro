# Prolog Lab 6: Constraint-Based Scheduler with CLPFD

This lab uses Prolog's Constraint Logic Programming over Finite Domains (CLPFD) library to solve a classic AI optimization problem: scheduling.

The goal is to assign start times to a list of tasks, each with a duration and a required resource, such that:
1. Tasks on the same resource do not overlap
2. Tasks with dependencies respect precedence (Task A must finish before Task B starts).
3.  The total project time (Makespan) is minimized.

## How to Run

1.  **Load the program** in SWI-Prolog:
    ```prolog
    ?- [scheduler].
    true.
    ```

2.  **Run the solver** using the `solve/0` helper predicate:
    ```prolog
    ?- solve.
    ```

## Example Solution
The program will solve for the hard-coded tasks, which include:
* `task(a,3,1)` and `task(b,2,1)`: Share **Resource 1**.
* `task(c,4,2)`: Is on **Resource 2**.
* **Non-overlap:** Implemented manually with `(Ea #=< Sb) #\/ (Eb #=< Sa)`, ensuring one task finishes before the other begins.
* **Precedence:** A custom constraint `Ea #=< Sb` was added, meaning **Task 'a' must finish before 'b' starts**.

The solver finds the optimal schedule that respects these rules.

### Optimized Result

```prolog
--- Optimal Schedule Found ---
Total Project Time (Makespan): 5
Task a (Res 1, Dur 3):   Start: 0, End: 3
Task b (Res 1, Dur 2):   Start: 3, End: 5
Task c (Res 2, Dur 4):   Start: 0, End: 4
true
```

This output is the deliverable: a printed schedule with the optimized makespan.
