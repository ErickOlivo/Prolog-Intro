# Coffee Expert System - Prolog Lab 2

## 1. Manual Loading

```bash
# Start SWI-Prolog
swipl
```

```prolog

% Load the expert system
?- [beverage_expert_system].

% Start the interactive system
?- start.
```

## Example 1: Basic Beverage Identification

=== Coffee Beverage Expert System ===
Choose an option:
1. Identify a single beverage
2. Get multiple suggestions (ambiguity handling)
3. Test all beverages
4. Test ancestor reasoning
Your choice (1/2/3/4): 1.

Does it contain coffee? (yes/no): |: yes.

Does it have steamed milk? (yes/no): |: yes.

Does it have chocolate? (yes/no): |: no.

What is the milk-to-coffee ratio?
Options: [high,balanced,low]
Your answer: |: balanced.

I think the beverage is: cappuccino
Equal parts espresso, steamed milk, and milk foam.
true.


## Example 2: Ambiguity Handling

?- start.
Your choice (1/2/3/4): 2.


Welcome to the Coffee Expert System!
I will help you identify your coffee beverage.

Does it contain coffee? (yes/no): |: yes.

Does it have steamed milk? (yes/no): |: yes.

Does it have milk foam? (yes/no): |: yes.

Is it served hot? (yes/no): |: yes.

Multiple beverages match your description:
- cappuccino
- latte
- macchiato
- flat_white
true.


## Example 3: Test all beverages

?- start.
Your choice (1/2/3/4): 3.


Testing all 12 coffee beverages:

Beverage: espresso
Characteristics: contains_coffee,

Beverage: americano
Characteristics: contains_coffee,

Beverage: cappuccino
Characteristics: contains_coffee, has_steamed_milk, has_milk_foam,

Beverage: latte
Characteristics: contains_coffee, has_steamed_milk, has_milk_foam,

Beverage: mocha
Characteristics: contains_coffee, has_steamed_milk, has_chocolate,

Beverage: macchiato
Characteristics: contains_coffee, has_steamed_milk, has_milk_foam,

Beverage: flat_white
Characteristics: contains_coffee, has_steamed_milk, has_milk_foam,

Beverage: affogato
Characteristics: contains_coffee,

Beverage: red_eye
Characteristics: contains_coffee,

Beverage: vienna_coffee
Characteristics: contains_coffee, has_whipped_cream,

Beverage: irish_coffee
Characteristics: contains_coffee, has_alcohol,

Beverage: cortado
Characteristics: contains_coffee, has_steamed_milk,

=== End of beverage list ===

true.


## Example 4: Test ancestor reasoning

?- start.
Your choice (1/2/3/4): 4.

=== Testing Ancestor Reasoning ===
espresso: hot_beverage, espresso_based,
americano: hot_beverage, espresso_based,
cappuccino: hot_beverage, milk_based,
latte: hot_beverage, milk_based,
mocha: hot_beverage, milk_based, specialty
macchiato: hot_beverage, milk_based,
flat_white: hot_beverage, milk_based,
affogato: specialty
red_eye: hot_beverage, espresso_based,
vienna_coffee: hot_beverage, espresso_based, specialty
irish_coffee: hot_beverage, espresso_based, specialty
cortado: hot_beverage, milk_based,
=== End of category testing ===

true.
