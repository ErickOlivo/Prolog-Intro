:- use_module(library(clpfd)).

solve :-
    schedule([Tasks, Starts, Ends, Makespan]),


    format('~n--- Optimal Schedule Found ---~n'),
    format('Total Project Time (Makespan): ~w~n', [Makespan]),

    print_schedule(Tasks, Starts, Ends).

print_schedule([], [], []).
print_schedule([task(Name,Dur,Res)|T], [S|Ss], [E|Es]) :-
    format('Task ~w (Res ~w, Dur ~w):   Start: ~w, End: ~w~n', [Name, Res, Dur, S, E]),
    print_schedule(T, Ss, Es).

    
schedule(Starts, Ends, Makespan) :-
    Tasks = [task(a,3,1), task(b,2,1), task(c,4,2)],
    Starts = [Sa, Sb, Sc], Ends = [Ea, Eb, Ec],

    % Temporal Constraints
    Starts ins 0..10,

    % The basic constraint: End #= Start + Duration
    Ea #= Sa+ 3,
    Eb #= Sb + 2,
    Ec #= Sc + 4,

    % Non-overlap constraints
    % task(StartTime, Duration, EndTime, ResourceID, _)
    disjoint1([task(Sa,3,Ea,1,_), task(Sb,2,Eb,1,_)]),

    % Precedence COnstraints
    Ea #=< Sb,

    % Optimization
    Makespan #= max(Ea, max(Eb, Ec)),

    % Minimize the makespan
    labeling([min(Makespan)], [Sa, Sb, Sc, Makespan]).


















