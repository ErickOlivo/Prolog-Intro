# Prolog Lab 3: Graph Traversal - Step-by-Step Queries and  Responses
This lab implements graph traversal algorithms in Prolog, including cycle handling and maze navigation.

## Loading the Program
```bash
swipl
```
````prolog
?- [graph_traversal].
true.
````

# PART 1 - Basics (Without Cycle):
## Query: Is there a path from a to c? From b to a?

### Step 1.1: To check this, make sure edge(c, a) is commented out for Part 1 testing

### Step 1.2: Query 1 - Path from a to c

```prolog
?- path_basic(a, c).
true ;
true ;
false.
```

#### Explanation:

- The first true corresponds to path: a → b → c

- The second true corresponds to path: a → d → c

- false indicates no more paths exist

### Step 1.3: Query 2 - Path from b to a

```prolog
?- path_basic(b, a).
false.
```

#### Explanation:
- No path exists from b to a in the original graph without cycles.



# PART 2 - Using naive recursion and cycle handling (keeping a list of visited nodes) - Cycles (Add edge(c, a)):
## Run ?- path(a, c).
## Observe infinite recursion.

### Step 2.1: To check this, make sure edge(c, a) is uncommented out for Part 2 testing

### Step 2.2: Add a cycle: edge(c, a)

### Step 2.3: Run naive recursion (without cycle handling)

#### This creates a cycle: a -> b -> c -> a


```prolog
?- path_basic(a, c).
true ;
true ;
true ;
true ;
true ;
true ;
.
.
.
true
```
#### Explanation:
- We can observe the infinite recursion. It continues indefinitely or until stack overflow

- The naive path_basic/2 enters infinite recursion because it keeps finding new paths through the cycle (a → b → c → a → b → c → ...) without tracking visited nodes.

- The query never terminates and keeps producing true responses. This demonstrates why cycle handling is necessary in graph traversal algorithms.


## If we keep a list of visited nodes, we can prevent that the recursion loop forever. Using the fix we get:

### Step 2.4: Test the cycle-safe predicate (Fix using visited list approach)

```prolog
?- path(a, c).
true ;
true ;
false.
```
#### Explanation:

- First true: Path a → b → c

- Second true: Path a → d → c

- The cycle-safe algorithm prevents infinite loops while finding valid paths

# PART 3 - Listing All Paths:

### Step 3.1: Get all paths between a and c
```prolog
?- all_paths(a, c).
All paths from a to c:
  [a,b,c]
  [a,d,c]
true.
```
#### Explanation:
- The algorithm finds all possible paths from a to c, including paths that leverage the cycle but maintain valid node sequences without immediate repetitions.

# PART 4 - Student Extension:

### Step 4.1: Checking if there's a path in maze

```prolog
?- maze_path(entrance, exit).
true ;
true ;
true ;
true ;
false.
```

#### Explanation:
- Confirms that 4 distinct paths exist from entrance to exit in the maze.





### Step 4.2: Get individual maze paths.

```prolog
?- maze_path_with_list(entrance, exit, Path).
Path = [entrance, hall1, room1, hall2, room3, exit] ;
Path = [entrance, hall1, room1, hall2, room4, exit] ;
Path = [entrance, hall1, room2, hall2, room3, exit] ;
Path = [entrance, hall1, room2, hall2, room4, exit] ;
false.
```

#### Explanation:
- Returns each of the 4 possible paths through the maze one by one.



### Step 4.3: Display all maze paths at once

```prolog
?- all_maze_paths.
All paths through the maze:
  [entrance,hall1,room1,hall2,room3,exit]
  [entrance,hall1,room1,hall2,room4,exit]
  [entrance,hall1,room2,hall2,room3,exit]
  [entrance,hall1,room2,hall2,room4,exit]
true.
```

#### Explanation:
- Prints all valid paths from entrance to exit in the maze configuration.

