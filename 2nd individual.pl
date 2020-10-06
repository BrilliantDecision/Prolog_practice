
% 2 »Ќƒ»¬»ƒ”јЋ ј
second_individual(InList,OutList):-
    count_frequency_elems(InList,[],[],ElemList,FrequencyList),
    make_frequency_list(ElemList,FrequencyList,[],OutList).


% список элементов, встречающихс€ в исходном более трЄх раз(превый
% аргумент - список уникальных элементов, второй аргумент - список
% частоты встречаемости этих элементов в исходном списке)
make_frequency_list([],[],OutList,OutList):-!.
make_frequency_list([H1|T1],[H2|T2], InitList, OutList):-
    H2 > 3,
    append(InitList,[H1],NewList),
    make_frequency_list(T1, T2, NewList, OutList),
    !
    ;
    make_frequency_list(T1, T2, InitList, OutList).


% формирует список частоты встречаемости элементов и список самих
% элементов (список уникальных элементов)
count_frequency_elems([],ElemList,FrequencyList,ElemList,FrequencyList):-!.
count_frequency_elems([H|T],InitElemList,InitFrequencyList,ElemList,FrequencyList):-
    check_list_elem(InitElemList,H),
    index_elem(InitElemList,H,0,Index),
    update_elem_list(Index,0,InitFrequencyList,[],UpdatedList),
    count_frequency_elems(T,InitElemList,UpdatedList,ElemList,FrequencyList),
    !
    ;
    append(InitElemList,[H],UpdatedElemList),
    append(InitFrequencyList,[1],UpdatedFrequencyList),
    count_frequency_elems(T,UpdatedElemList,UpdatedFrequencyList,ElemList,FrequencyList).

%ќпредел€ет индекс элемента в списке
index_elem([],_,Index,Index):-!.
index_elem([H|T],Elem,InitIndex,Index):-
    check_elems(H,Elem),
    index_elem([],_,InitIndex,Index),
    !
    ;
    NewIndex is InitIndex + 1,
    index_elem(T,Elem,NewIndex,Index).

% ”величивает элемент, сто€щий на N позиции на 1.
update_elem_list(_,_,[],OutList,OutList):-!.
update_elem_list(N,InitNum,[H|T],InitList,OutList):-
    InitNum = N,
    NewElem is H + 1,
    append(InitList,[NewElem],NewList),
    NewNum is InitNum + 1,
    update_elem_list(N,NewNum,T,NewList,OutList),
    !
    ;
    append(InitList,[H],NewList),
    NewNum is InitNum + 1,
    update_elem_list(N,NewNum,T,NewList,OutList),!.


% сравниваем 2 элемента
check_elems(N1,N2):-
    N1 = N2, ! ; fail.

% провер€ет, есть ли элемент в списке
check_list_elem([],_):-fail.
check_list_elem([H|T],Elem):-
    check_elems(H,Elem),
    !
    ;
    check_list_elem(T,Elem).


