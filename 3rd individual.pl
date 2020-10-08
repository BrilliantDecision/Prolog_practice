
% 3 ИНДИВИДУАЛКА 10 ЗАДАНИЕ

%Зашифровывает текст
third_individual_shifr:-
    see('c:/Users/alexm/Documents/Prolog/third_individual_text.txt'),
    read_list_str(OutList),
    seen,
    see('c:/Users/alexm/Documents/Prolog/third_individual_key.txt'),
    read_list_str(Key),
    seen,
    make_one_list(Key,_,NewKey),
    shifr_text(OutList,NewKey,ShifrText),
    tell('c:/Users/alexm/Documents/Prolog/third_individual_shifr.txt'),
    write_list_str(ShifrText),
    told.

%Расшифровывает текст
third_individual_deshifr:-
    see('c:/Users/alexm/Documents/Prolog/third_individual_shifr.txt'),
    read_list_str(OutList),
    seen,
    see('c:/Users/alexm/Documents/Prolog/third_individual_key.txt'),
    read_list_str(Key),
    seen,
    make_one_list(Key,_,NewKey),
    deshifr_text(OutList,NewKey,DeshifrText),
    tell('c:/Users/alexm/Documents/Prolog/third_individual_deshifr.txt'),
    write_list_str(DeshifrText),
    told.

%Шифрует весь текст
shifr_text(InList,Key,OutList):-
    beau_list(InList,[],NewInList),
    generate_list_str(97,[],VizinerTable),
    create_keys_str(NewInList,Key,[],KeysList),
    generate_elems(97,123,[],ElemsList),
    shifr_all(NewInList,KeysList,ElemsList,VizinerTable,[],OutList).

%Деифрует весь текст
deshifr_text(InList,Key,OutList):-
    beau_list(InList,[],NewInList),
    generate_list_str(97,[],VizinerTable),
    create_keys_str(NewInList,Key,[],KeysList),
    generate_elems(97,123,[],ElemsList),
    deshifr_all(NewInList,KeysList,ElemsList,VizinerTable,[],OutList).

%Шифрует строки
shifr_all([],[],_,_,OutList,OutList):-!.
shifr_all([H|T],[H1|T1],ElemsList,VizinerTable,InitList,OutList):-
    shifr(H,H1,ElemsList,VizinerTable,[],NewList),
    append(InitList,[NewList],NewStr),
    shifr_all(T,T1,ElemsList,VizinerTable,NewStr,OutList).

%Дешифрует строки
deshifr_all([],[],_,_,OutList,OutList):-!.
deshifr_all([H|T],[H1|T1],ElemsList,VizinerTable,InitList,OutList):-
    deshifr(H,H1,ElemsList,VizinerTable,[],NewList),
    append(InitList,[NewList],NewStr),
    deshifr_all(T,T1,ElemsList,VizinerTable,NewStr,OutList).


%Шифрует строку
shifr([],[],_,_,OutList,OutList):-!.
shifr([H|T],[H1|T1],ElemsList,VizinerTable,InitList,OutList):-
    H > 96, H < 123,
    index_elem(ElemsList,H,0,IndexElem),
    index_elem(ElemsList,H1,0,IndexKey),
    viziner_elem(VizinerTable,IndexElem,IndexKey,Elem),
    append(InitList,[Elem],NewList),
    shifr(T,T1,ElemsList,VizinerTable,NewList,OutList),
    !;
    append(InitList,[H],NewList),
    shifr(T,T1,ElemsList,VizinerTable,NewList,OutList).

%Дешифрует строку
deshifr([],[],_,_,OutList,OutList):-!.
deshifr([H|T],[H1|T1],ElemsList,VizinerTable,InitList,OutList):-
    H > 96, H < 123,
    index_elem(ElemsList,H1,0,IndexKey),
    viziner_str(VizinerTable,0,IndexKey,[],NewVizList),
    index_elem(NewVizList,H,0,IndexElem),
    get_elem(ElemsList,0,IndexElem,0,Elem),
    append(InitList,[Elem],NewList),
    deshifr(T,T1,ElemsList,VizinerTable,NewList,OutList),
    !;
    append(InitList,[H],NewList),
    deshifr(T,T1,ElemsList,VizinerTable,NewList,OutList).


%Определяет элемент в таблице Вижинера
viziner_elem(VizinerTable,IndexElem,IndexKey,Elem):-
    viziner_str(VizinerTable,0,IndexKey,[],OutList),
    viziner_str(OutList,0,IndexElem,[],Elem).

% Определяет элемент по индексу
viziner_str([],_,_,OutList,OutList):-!.
viziner_str([H|_],IndexKey,IndexKey,_,OutList):-
    viziner_str([],IndexKey,IndexKey,H,OutList),!.
viziner_str([_|T],InitIndex,IndexKey,InitList,OutList):-
    NewIndex is InitIndex + 1,
    viziner_str(T,NewIndex,IndexKey,InitList,OutList).




% Делает список ключей для каждой строки
create_keys_str([],_,OutList,OutList):-!.
create_keys_str([H|T],Key,InitList, OutList):-
    create_key(H,Key,Key,0,[],NewList),
    append(InitList,[NewList],NewStrList),
    create_keys_str(T,Key,NewStrList,OutList).


% генерирует ключ для строки символов с учётом только латиницы
create_key([],_,_,_,OutListKey,OutListKey):-!.
create_key(InputList,[],KeyList,_,InitListKey,OutListKey):-
    create_key(InputList,KeyList,KeyList,0,InitListKey,OutListKey),!.

create_key([H|T],[K|TK],KeyList,Index_key_list,InitListKey,OutListKey):-
    H > 96, H < 123,
    append(InitListKey, [K], NewList),
    NewIndex is Index_key_list + 1,
    create_key(T,TK,KeyList,NewIndex,NewList,OutListKey),
    !
    ;
    append(InitListKey, [H], NewList),
    append([K],TK, NewListTK),
    create_key(T,NewListTK,KeyList,Index_key_list,NewList,OutListKey),!.



% Генерирует таблицу Вижинера
generate_list_str(123,OutList,OutList):-!.
generate_list_str(InitNum,InitList,OutList):-
    generate_str(InitNum,0,[],OutListLatinica),
    append(InitList,[OutListLatinica],NewList),
    NewNum is InitNum + 1,
    generate_list_str(NewNum,NewList,OutList).



% Генерирует строку из кодов символов строчных букв латиницы со сдвигом
% InitNum влево
generate_str(_,26,OutList,OutList):-!.
generate_str(InitNum,Counter,InitList,OutList):-
    InitNum > 122,
    NewNum is 97,
    append(InitList,[NewNum],NewList),
    NewNumOne is NewNum + 1,
    NewCounter is Counter + 1,
    generate_str(NewNumOne,NewCounter,NewList,OutList),
    !
    ;
    append(InitList,[InitNum],NewList),
    NewNum is InitNum + 1,
    NewCounter is Counter + 1,
    generate_str(NewNum,NewCounter,NewList,OutList).



write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

write_str([]):-!.
write_str([H|Tail]):-put(H),write_str(Tail).

read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1,Flag).

read_list_str(List):-read_str(A,N,Flag),read_list_str([A],List,Flag).
read_list_str(List,List,1):-!.
read_list_str(Cur_list,List,0):-
	read_str(A,N,Flag),append(Cur_list,[A],C_l),read_list_str(C_l,List,Flag).


%вывод списка
write_list([X|Y]):- writeln(X), write_list(Y).
write_list([]).


%make_beautiful_list_without_enters да да красивый список!!!
beau_list([],OutList,OutList):-!.
beau_list([H|T],OutList,InitList):-
    len_list(H,0,OutNum),
    OutNum > 0,
    append(OutList,[H],NewList),
    beau_list(T,NewList,InitList),!
    ;
    beau_list(T,OutList,InitList),!.


%длина списка
len_list([],OutNum,OutNum):-!.
len_list([_|T],OutNum,InitNum):-
    NewNum is OutNum + 1,
    len_list(T,NewNum,InitNum).


%генерирует список чисел от n1 до n2
generate_elems(N,N,OutList,OutList):-!.
generate_elems(N1,N2,InitList,OutList):-
    append(InitList,[N1],NewList),
    NewN is N1 + 1,
    generate_elems(NewN,N2,NewList,OutList).


%Определяет индекс элемента в списке
index_elem([],_,Index,Index):-!.
index_elem([Elem|_],Elem,InitIndex,Index):-
    index_elem([],Elem,InitIndex,Index),!.
index_elem([_|T],Elem,InitIndex,Index):-
    NewIndex is InitIndex + 1,
    index_elem(T,Elem,NewIndex,Index).

%из списка списков с одним элементом делает список
make_one_list([],OutList,OutList):-!.
make_one_list([H|T],_,OutList):-
    append([],H,NewList),
    make_one_list(T,NewList,OutList).

%Получить элемент по индексу
get_elem([],_,_,Elem,Elem):-!.
get_elem([H|T],InitNum,Num,InitElem,Elem):-
    InitNum = Num,
    get_elem([],InitNum,Num,H,Elem),
    !;
    NewNum is InitNum + 1,
    get_elem(T,NewNum,Num,InitElem,Elem).








