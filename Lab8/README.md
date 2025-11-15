# Prolog Lab 8: Map Coloring + Optimization

This project extends a previous map coloring lab. The original goal was to find a valid coloring for a map given a fixed number of colors (K).

This lab's objective is to determine the **minimum number of colors** (`MinK`) required to color a map so that no two adjacent regions share the same color. The solution uses Constraint Logic Programming over Finite Domains (CLP(FD)).

## 🧠 Core Logic: `min_colors/5`

Instead of encoding the optimization directly into the CLP(FD) model, this solution uses a "meta-level search" on the variable K.

The main logic is implemented in the `min_colors/5` predicate:

1. **`between(1, MaxK, K)`**: This predicate generates values for K, starting from 1 and incrementing up to `MaxK`.
2. **`color_map(Regions, Edges, K, Vars)`**: For each generated K, this existing predicate attempts to find a valid coloring.
3. **`MinK = K, !`**: The first time `color_map/4` succeeds, that K is the minimum possible value. The cut (`!`) is used to prevent Prolog from backtracking and searching for larger K values that would also be valid solutions.

## 🚀 How to Run

1.  **Load the program** in SWI-Prolog:

    ```prolog
    ?- [map_coloring_min_map].
    true.
    ```

2.  **Run the optimization solver**. The helper predicates `solve_min_au/2` and `solve_min_sa/2` are provided to run the optimization and pretty-print the result in one step. They take two arguments:

      * `MaxK`: An upper bound on the number of colors to try (e.g., 4 or 6).
      * `Strategy`: The `labeling` strategy to use (e.g., `[ffc]`, `[min]`, or `[]`).

-----

## Part A: Australia (Optimized)

Finds the minimum colors for the Australia map. The query uses `MaxK=4` and the `[ffc]` strategy.

### Query

```prolog
?- solve_min_au(4, [ffc]).
```

### Output

The solver successfully finds that the minimum number of colors (`MinK`) is **3**.

```prolog
?- solve_min_au(4, [ffc]).

 Australia (Optimized)
Minimum colors needed: 3

 Solution:
wa = blue
nt = green
sa = red
q = blue
nsw = green
v = blue
t = red
true .
```

-----

## Part B: South America (Optimized)

Finds the minimum colors for the South America map. The query uses `MaxK=6` and the `[ffc]` strategy.

### Query

```prolog
?- solve_min_sa(6, [ffc]).
```

### Output

The solver tries K=1 (fails), K=2 (fails), K=3 (fails), and finally succeeds at K=4. The minimum number of colors (`MinK`) is **4**.

```prolog
?- solve_min_sa(6, [ffc]).

 South America (Optimized)
Minimum colors needed: 4

 Solution:
ar = green
bo = blue
br = red
cl = red
co = blue
ec = red
gfr = blue
gy = blue
py = yellow
pe = green
su = green
uy = blue
ve = green
true .
```

-----

## Part C: Experimentation with different labeling strategies

This task involves experimenting with different `labeling` strategies to observe their impact.

### Australia: Strategy Comparison

#### Strategy: `[min]`

```prolog
?- solve_min_au(4, [min]).

 Australia (Optimized)
Minimum colors needed: 3

 Solution:
wa = red
nt = green
sa = blue
q = red
nsw = green
v = red
t = red
true .
```

#### Strategy: `[]` (Default)

```prolog
?- solve_min_au(4, []).

 Australia (Optimized)
Minimum colors needed: 3

 Solution:
wa = red
nt = green
sa = blue
q = red
nsw = green
v = red
t = red
true .
```

### South America: Strategy Comparison

#### Strategy: `[min]`

```prolog
?- solve_min_sa(6, [min]).

 South America (Optimized)
Minimum colors needed: 4

 Solution:
ar = red
bo = green
br = blue
cl = blue
co = red
ec = green
gfr = red
gy = red
py = yellow
pe = yellow
su = green
uy = green
ve = green
true .
```

#### Strategy: `[]` (Default)

```prolog
?- solve_min_sa(6, []).

 South America (Optimized)
Minimum colors needed: 4

 Solution:
ar = red
bo = green
br = blue
cl = blue
co = red
ec = green
gfr = red
gy = red
py = yellow
pe = yellow
su = green
uy = green
ve = green
true .
```

### Reflection

  * **Australia Minimum Colors**: 3
  * **South America Minimum Colors**: 4

For this specific problem, all three labeling strategies (`[ffc]`, `[min]`, and `[]`) found the same minimum K and produced the exact same coloring solution. While `ffc` is often faster on more complex problems, in this case, the search space was simple enough that the strategy did not change the first solution found.
