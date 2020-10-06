/*Pandigital*/

pandigital(N,PanNum):-
    all_numbers(N,L),
    eSieve(L,PrimeList),
    cut_list(N,PrimeList,OutList),
    pan(N,OutList,0,PanNum).

%PANDIGITAL ENGINE
pan(_,[],OutNum,OutNum):-!.
pan(N,[H|T],InitNum,OutNum):-
    NewNum is H,
    generate_list(N,[],RandList),
    make_num_list(H,NumList,[]),
    bubble_sort(NumList,SortList),
    check_lists(SortList,RandList),
    pan(N,T,NewNum,OutNum),!
    ;
    pan(N,T,InitNum,OutNum).

%����������� ����� � ������
make_num_list(0,L,L):-!.
make_num_list(InNumber,L,OutList):-
    Rest is InNumber mod 10,
    append([Rest],OutList,NewList),
    NewNumber is InNumber div 10,
    make_num_list(NewNumber,L,NewList).

%������ ����������
eSieve(L,PrimeList):-do_sieve(L,PrimeList,[]).

%��������� �������
do_sieve([],L,L):-!.
do_sieve([H|T],PrimeList,EList):-
    append(EList,[H],NewPrimeList),
    del_num(H,T,NewList,[]),
    do_sieve(NewList,PrimeList,NewPrimeList),!.

%������� �� �����, ������� ������� �� Num
del_num(_,[],L,L):-!.
del_num(Num,[H|T],L,InList):-
    H mod Num > 0,
    append(InList,[H],NewList),
    del_num(Num,T,L,NewList),!
    ;
    del_num(Num,T,L,InList),!.

%��� �����
all_numbers(N,L):-
    X is **(10,N),
    generate_numbers(2,X,L,[]).

%���������� ��� ����� �� 2 �� N
generate_numbers(N,N,L,L):-!.
generate_numbers(X,N,L,El):-
    append(El,[X],NewL),
    NewX is X + 1,
    generate_numbers(NewX,N,L,NewL).

%���������� ������ � n ���������� ������� �� ������ �� n
generate_list(0,L,L):-!.
generate_list(N,InList,OutList):-
    append([N],InList,NewList),
    Z is N - 1,
    generate_list(Z,NewList,OutList).

%�������� ��� ����� � ������, ���������� ����������� ������� < N
cut_list(N,InputList,OutList):-cut_list_N(N,InputList,[],OutList).

cut_list_N(_,[],OutList,OutList):-!.
cut_list_N(N,[H|T],InitList,OutList):-
    cut_N(H,0,Num),
    Num = N,
    append(InitList,[H],NewList),
    cut_list_N(N,T,NewList,OutList),!
    ;
    cut_list_N(N,T,InitList,OutList),!.


%������� ����������� �����
cut_N(0,OutNum,OutNum):-!.
cut_N(InNum,InitNum,OutNum):-
    NewOut is InitNum + 1,
    NewNum is InNum div 10,
    cut_N(NewNum,NewOut,OutNum).

%���������� �������� � ������� �� ������ ��������
check_lists([],[]):-!.
check_lists([H1|T1],[H2|T2]):-
    H1 = H2,
    check_lists(T1,T2).


%����� ������
write_list([X|Y]):- writeln(X), write_list(Y).
write_list([]).

%������������ ������� � �����
move_max_to_end([], []):-!.
move_max_to_end([Head], [Head]):-!.
move_max_to_end([First, Second|Tail], [Second|ListWithMaxEnd]):-
  First > Second, !,
  move_max_to_end([First|Tail], ListWithMaxEnd).
move_max_to_end([First, Second|Tail], [First|ListWithMaxEnd]):-
  move_max_to_end([Second|Tail], ListWithMaxEnd).

%���������� ���������
bubble_sort(SortedList, SortedList):-
  move_max_to_end(SortedList, DoubleSortedList),
  SortedList = DoubleSortedList, !.
bubble_sort(List, SortedList):-
  move_max_to_end(List, SortedPart),
  bubble_sort(SortedPart, SortedList).











































































































