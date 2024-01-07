generator3(N) :-
    between(32, 1000, Root),
    N is Root * Root,
    N >= 1000,
    N =< 1000000.

tester3(N) :-
    number_codes(N, Digits),
    length(Digits, Length),
    last(Digits, LastDigitCode),
    LastDigit is LastDigitCode - 48,
    Length == LastDigit,
    PenultimateIndex is Length - 2,
    nth0(PenultimateIndex, Digits, PenultimateCode),
    Penultimate is PenultimateCode - 48,
    Penultimate mod 2 =:= 1,
    nth0(0, Digits, FirstDigitCode),
    FirstDigit is FirstDigitCode - 48,
    nth0(1, Digits, SecondDigitCode),
    SecondDigit is SecondDigitCode - 48,
    SecondDigit mod FirstDigit =:= 0,
    SecondDigit \= 0,
    nth0(2, Digits, ThirdDigitCode),
    ThirdDigit is ThirdDigitCode - 48,
    ThirdDigit mod FirstDigit =:= 0,
    ThirdDigit \= 0,
    Penultimate mod FirstDigit =:= 0,
    Penultimate \= 0,
    memberchk(48, Digits),
    all_different(Digits).

all_different([]).
all_different([Head|Tail]) :-
    \+ memberchk(Head, Tail),
    all_different(Tail).