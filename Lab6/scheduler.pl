:- use_module(library(clpfd)).



schedule(Starts, Ends, Makespan) :-

    Starts = [S1, S2, S3], Ends = [E1, E2, E3],
    Starts ins 0..10,

    % 1. Restricción de Duración (End #= Start + Duration)
    E1#= S1+ 3,
    E2 #= S2 + 2,
    E3 #= S3 + 4,

    S1 + 3  #=< S2,
    E1#=< S3,

    %labeling([min(Makespan)], Starts),


    Tasks = [task(S1, 3, E1, 1, _), task(S2, 2, E2, 1, _), task(S3, 4, E3, 1, _)],

    disjoint2(Tasks),
    (E2 #=< S3) #\/ (E3 #=< S2),


    %Makespan #= max(E1, max(E2, E3)),
    maximum(Makespan, [E1, E2, E3]),
    Makespan in 0..20,
    % labeling/2
    labeling([min(Makespan)], [S1, S2, S3, E1, E2, E3, Makespan]).















