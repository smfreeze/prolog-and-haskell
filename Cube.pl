is_prime(2).
is_prime(A) :-
    A > 2,
    A < 10000,
    A mod 2 =\= 0,
    MaxDivisor is floor(sqrt(A)),
    \+ has_factor(A, 3, MaxDivisor).

has_factor(N, Factor, MaxDivisor) :-
    (Factor > MaxDivisor -> false;
     N mod Factor =:= 0 -> true;
     NextFactor is Factor + 2,
     has_factor(N, NextFactor, MaxDivisor)).

list_to_number(List, Number) :-
    list_to_number(List, 0, Number).

list_to_number([], Acc, Acc).
list_to_number([H|T], Acc, Number) :-
    NewAcc is Acc * 10 + H,
    list_to_number(T, NewAcc, Number).

generate_primes([], []).
generate_primes([H|T], [P | R]) :-
    generate_primes_prefix([H|T], P),
    append(P, Suffix, [H|T]),
    list_to_number(P, Number),
    is_prime(Number),
    generate_primes(Suffix, R).

generate_primes_prefix(Digits, Prefix) :-
    append(Prefix, _, Digits),
    length(Prefix, L),
    L > 0,
    L =< 4,
    Prefix \= [0|_].

generator4(PrimesList) :-
    Digits = [9,8,7,6,5,4,3,2,1,0],
    permutation(Digits, Perm),
    generate_primes(Perm, PrimesList).

combine([], 0).
combine([H|T], N) :-
    combine(T, NT),
    length(T, Len),
    Pow is 10^Len,
    N is H * Pow + NT.

remove_smallest_prime([H|T], Result) :-
    findall(
        Value,
        (member(List, [H|T]), combine(List, Value), is_prime(Value)),
        Values
    ),
    min_member(Min, Values),
    select(List, [H|T], Rest),
    combine(List, Min),
    (is_prime(Min) -> Result = Rest; Result = [H|T]),
    !.

is_cube(0).
is_cube(N) :-
    N > 0,
    Root is round(N ** (1/3)),
    N =:= Root * Root * Root.

split_into_cubes([]).

split_into_cubes([H|T]) :-
    extend_cube(H, T, RemainingList),
    split_into_cubes(RemainingList).

extend_cube(Cube, List, Remaining) :-
    is_cube(Cube),
    List = Remaining.
extend_cube(Acc, [H|T], Remaining) :-
    NewAcc is Acc * 10 + H,
    extend_cube(NewAcc, T, Remaining).

can_be_cubics(Lists) :-
    flatten(Lists, FlatList),
	split_into_cubes(FlatList).

sort_lists_by_combined_number(Lists, Sorted) :-
    map_list_to_pairs(combine, Lists, Paired),
    keysort(Paired, SortedPaired),
    reverse(SortedPaired, DescendingPaired),
    pairs_values(DescendingPaired, Sorted).

tester4(PrimesList) :-
    remove_smallest_prime(PrimesList, PrimesWithoutSmallest),
	sort_lists_by_combined_number(PrimesWithoutSmallest, SortedList),
    can_be_cubics(SortedList).