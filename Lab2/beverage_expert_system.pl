% =============================================
% COFFEE EXPERT SYSTEM - YACHAY TECH UNIVERSITY
% Mathematical and Computational Logic
% Prolog Lab 2: Building a Simple Expert System
% =============================================

% Step 1: Knowledge Base (facts about coffee beverages) - AT LEAST 10 ITEMS
contains_coffee(espresso).
contains_coffee(americano).
contains_coffee(cappuccino).
contains_coffee(latte).
contains_coffee(mocha).
contains_coffee(macchiato).
contains_coffee(flat_white).
contains_coffee(affogato).
contains_coffee(red_eye).
contains_coffee(vienna_coffee).
contains_coffee(irish_coffee).
contains_coffee(cortado).

has_steamed_milk(cappuccino).
has_steamed_milk(latte).
has_steamed_milk(mocha).
has_steamed_milk(flat_white).
has_steamed_milk(macchiato).
has_steamed_milk(cortado).

has_milk_foam(cappuccino).
has_milk_foam(latte).
has_milk_foam(macchiato).
has_milk_foam(flat_white).

has_chocolate(mocha).
has_whipped_cream(vienna_coffee).
has_ice_cream(affogato).
has_alcohol(irish_coffee).

is_iced(affogato).
is_strong(espresso).
is_strong(red_eye).
has_extra_espresso(red_eye).

% Non-coffee beverages for ambiguity demonstration
contains_tea(tea).
contains_tea(chai_latte).

% Step 2: Rules for Classification
is_espresso_based(X) :- contains_coffee(X), not(has_steamed_milk(X)), not(is_iced(X)).
is_milk_based(X) :- contains_coffee(X), has_steamed_milk(X).  % Fixed: contains_coffee instead of contains_caffeine
is_specialty(X) :- has_chocolate(X); has_ice_cream(X); has_whipped_cream(X); has_alcohol(X).

has_high_milk_ratio(latte).
has_balanced_ratio(cappuccino).
has_low_milk_ratio(macchiato).
has_low_milk_ratio(cortado).

% Challenge #5: Ancestor-type reasoning (classification tree)
is_hot_beverage(X) :- contains_coffee(X), not(is_iced(X)).
is_cold_beverage(X) :- is_iced(X).
is_alcoholic_beverage(X) :- has_alcohol(X).

beverage_category(X, espresso_based) :- is_espresso_based(X).
beverage_category(X, milk_based) :- is_milk_based(X).
beverage_category(X, specialty) :- is_specialty(X).

% Step 3: Interactive Questions
ask(Question, Answer) :-
    write(Question),
    write(' (yes/no): '),
    read(Answer),
    nl.

ask_multiple(Question, Options, Answer) :-
    write(Question), nl,
    write('Options: '), write(Options), nl,
    write('Your answer: '),
    read(Answer),
    nl.

% Step 4: Inference Engine

identify_beverage(Beverage) :-
    ask('Does it contain coffee?', CoffeeAnswer),
    (CoffeeAnswer == yes ->
        identify_coffee_beverage(Beverage)
    ;
        identify_non_coffee_beverage(Beverage)
    ),
    format('I think the beverage is: ~w', [Beverage]), nl.

identify_coffee_beverage(Beverage) :-
    ask('Does it have steamed milk?', MilkAnswer),
    (MilkAnswer == yes ->
        identify_milk_based_beverage(Beverage)
    ;
        identify_black_coffee(Beverage)
    ).

identify_milk_based_beverage(Beverage) :-
    ask('Does it have chocolate?', ChocolateAnswer),
    (ChocolateAnswer == yes ->
        Beverage = mocha
    ;
        ask_multiple('What is the milk-to-coffee ratio?', [high, balanced, low], RatioAnswer), 
        (RatioAnswer == high -> Beverage = latte
        ; RatioAnswer == balanced -> Beverage = cappuccino
        ; RatioAnswer == low ->
            (ask('Is it served in a small glass?', GlassAnswer),
             (GlassAnswer == yes -> Beverage = macchiato
             ; Beverage = cortado))
        ; Beverage = flat_white)
    ).

identify_black_coffee(Beverage) :-
    ask('Is it just espresso?', EspressoAnswer),
    (EspressoAnswer == yes ->
        Beverage = espresso
    ;
        ask('Does it have extra espresso shots?', ExtraAnswer),
        (ExtraAnswer == yes -> Beverage = red_eye
        ; Beverage = americano)
    ).

identify_non_coffee_beverage(Beverage) :-
    ask('Does it contain tea?', TeaAnswer),
    (TeaAnswer == yes -> Beverage = tea
    ; Beverage = unknown).

% Step 5: Extend the System

% Store user responses dynamically
:- dynamic user_response/2.

remember(Question, Answer) :-
    assertz(user_response(Question, Answer)).

% Working ambiguity handling
find_possible_beverages(BeverageList) :-
    findall(Beverage, (
        contains_coffee(Beverage),
        matches_all_characteristics(Beverage)
    ), BeverageList).

matches_all_characteristics(Beverage) :-
    forall(
        user_response(Characteristic, Answer),
        matches_characteristic(Beverage, Characteristic, Answer)
    ).

matches_characteristic(Beverage, contains_coffee, yes) :- contains_coffee(Beverage).
matches_characteristic(Beverage, contains_coffee, no) :- not(contains_coffee(Beverage)).
matches_characteristic(Beverage, has_steamed_milk, yes) :- has_steamed_milk(Beverage).
matches_characteristic(Beverage, has_steamed_milk, no) :- not(has_steamed_milk(Beverage)).
matches_characteristic(Beverage, has_milk_foam, yes) :- has_milk_foam(Beverage).
matches_characteristic(Beverage, has_milk_foam, no) :- not(has_milk_foam(Beverage)).
matches_characteristic(Beverage, is_hot, yes) :- not(is_iced(Beverage)).
matches_characteristic(Beverage, is_hot, no) :- is_iced(Beverage).

identify_beverage_advanced :-
    write('Welcome to the Coffee Expert System!'), nl,
    write('I will help you identify your coffee beverage.'), nl, nl,

    % Clear previous responses
    retractall(user_response(_, _)),

    % Collect characteristics
    ask('Does it contain coffee?', Q1), remember(contains_coffee, Q1),
    ask('Does it have steamed milk?', Q2), remember(has_steamed_milk, Q2),
    ask('Does it have milk foam?', Q3), remember(has_milk_foam, Q3),
    ask('Is it served hot?', Q4), remember(is_hot, Q4),

    % Find matches
    find_possible_beverages(Matches),
    display_results(Matches).

display_results([]) :-
    write('No beverages match your description. Maybe it is a custom drink!'), nl.

display_results([Single]) :-
    write('The beverage is: '), write(Single), nl,
    describe_beverage(Single).

display_results(Matches) :-
    length(Matches, Count), Count > 1,
    write('Multiple beverages match your description: '), nl,
    list_matches(Matches).

list_matches([]).
list_matches([H|T]) :-
    write('- '), write(H), nl,
    list_matches(T).

% Beverage descriptions
describe_beverage(espresso) :-
    write('A strong, concentrated coffee served in small shots.'), nl.

describe_beverage(latte) :-
    write('Coffee with steamed milk and a small amount of foam.'), nl.

describe_beverage(cappuccino) :-
    write('Equal parts espresso, steamed milk, and milk foam.'), nl.

describe_beverage(mocha) :-
    write('Coffee with chocolate and steamed milk.'), nl.

describe_beverage(americano) :-
    write('Espresso diluted with hot water.'), nl.

% Main interface
start :-
    write('=== Coffee Beverage Expert System ==='), nl,
    write('Choose an option:'), nl,
    write('1. Identify a single beverage'), nl,
    write('2. Get multiple suggestions (ambiguity handling)'), nl,
    write('3. Test all beverages'), nl,
    write('4. Test ancestor reasoning'), nl,
    write('Your choice (1/2/3/4): '),
    read(Choice),
    nl,
    execute_choice(Choice).

execute_choice(1) :-
    identify_beverage(Beverage),
    describe_beverage(Beverage).

execute_choice(2) :-
    identify_beverage_advanced.

execute_choice(3) :-
    test_all_beverages.

execute_choice(4) :-
    test_ancestor_reasoning.

% Test all beverages

test_all_beverages :-
    findall(Bev, contains_coffee(Bev), Beverages),
    length(Beverages, Count),
    format('Testing all ~w coffee beverages:~n~n', [Count]),
    test_beverages_correct(Beverages).

test_beverages_correct([]) :-
    write('=== End of beverage list ==='), nl, nl.
test_beverages_correct([Beverage|Rest]) :-
    format('Beverage: ~w~nCharacteristics: ', [Beverage]),
    (contains_coffee(Beverage) -> write('contains_coffee, ') ; true),
    (has_steamed_milk(Beverage) -> write('has_steamed_milk, ') ; true),
    (has_milk_foam(Beverage) -> write('has_milk_foam, ') ; true),
    (has_chocolate(Beverage) -> write('has_chocolate, ') ; true),
    (has_whipped_cream(Beverage) -> write('has_whipped_cream, ') ; true),
    (has_alcohol(Beverage) -> write('has_alcohol, ') ; true),
    nl, nl,
    test_beverages_correct(Rest).


% Test ancestor reasoning
test_ancestor_reasoning :-
    write('=== Testing Ancestor Reasoning ==='), nl,
    findall(Bev, contains_coffee(Bev), Beverages),
    test_categories_correct(Beverages).

test_categories_correct([]) :-
    write('=== End of category testing ==='), nl, nl.

test_categories_correct([Beverage|Rest]) :-
    format('~w: ', [Beverage]),
    (is_hot_beverage(Beverage) -> write('hot_beverage, ') ; true),
    (is_espresso_based(Beverage) -> write('espresso_based, ') ; true),
    (is_milk_based(Beverage) -> write('milk_based, ') ; true),
    (is_specialty(Beverage) -> write('specialty') ; true),
    nl,
    test_categories_correct(Rest).

% Clear dynamic predicates on start
:- retractall(user_response(_, _)).

% Initialization message
:- initialization((
    write('Coffee Expert System loaded. Type "start." to begin.'),
    nl
)).
