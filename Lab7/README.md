# Prolog Lab 6: Map Coloring with CLPFD

This lab uses Constraint Logic Programming over Finite Domains (CLPFD) to solve the map coloring problem. The goal is to assign a color to each region of a map such that no two adjacent regions share the same color.

The core logic is in the `map_color/4` predicate, which:
1.  Takes a number of colors (K), a list of regions, and a list of edges (adjacencies).
2.  Assigns a domain `1..K` to a variable for each region.
3.  Applies the `C1 #\= C2` constraint for every edge.
4.  Uses `labeling/2` to find a valid solution.

## How to Run

1.  **Load the program** in SWI-Prolog:
    ```prolog
    ?- [map_coloring].
    true.
    ```

2.  **Run the solver** for the desired map and number of colors (K).

## Part A: Australia
Test queries for the Australian map.

### Australia with K=3 Colors
```prolog
?- solve_au(3).

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

### Australia with K=4 Colors
```prolog
?- solve_au(4).

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

## Part B: South America
Test queries for the South American map.

### South America with K=3 Colors
The solver proves no solution exists.

```prolog
?- solve_sa(3).
false.
```

### South America with K=4 Colors
The solver finds a valid 4-coloring.

```prolog
?- solve_sa(4).

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
