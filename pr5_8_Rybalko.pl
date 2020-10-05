
%ЗАДАЧА 8
% примечание - пустые строки не учитываются и на выполнение программы не
% влияют
pr5_8:-
    see('c:/Users/alexm/Documents/Prolog/Новый текстовый документ.txt'),
    read_list_str(OutList),
    seen,
    write_list(OutList),
    task_8(OutList, NewList),
    write_list(NewList).


%              tell('c:/Users/alexm/Documents/Prolog/111.txt'),
%              write_list_str(NewList),told.

%считает количество символов A в строке
count_A([],OutNumber,OutNumber):-!.

count_A([65|T],OutNumber,InitNumber):-
    NewNumber is OutNumber + 1,
    count_A(T,NewNumber,InitNumber),!.

count_A([_|T],OutNumber,InitNumber):-
    count_A(T,OutNumber,InitNumber),!.

%создаёт список из количеств символов А
list_count_A([],OutList,OutList):-!.
list_count_A([H|T],InitList,OutList):-
    count_A(H,0,OutNumber_A),
    append(InitList,[OutNumber_A],NewList),
    list_count_A(T,NewList,OutList).

%сумма элементов списка
list_sum([],OutNum,OutNum):-!.
list_sum([H|T],InitNum,OutNum):-
    NewNum is H + InitNum,
    list_sum(T,NewNum,OutNum).

%длина списка
len_list([],OutNum,OutNum):-!.
len_list([_|T],OutNum,InitNum):-
    NewNum is OutNum + 1,
    len_list(T,NewNum,InitNum).


task_8(InputList,YourList):-
    beau_list(InputList,[],NewList),
    list_count_A(NewList,[],OutList_A),
    list_sum(OutList_A,0,Num_A),
    len_list(OutList_A,0,Num_list),
    Average_A is Num_A/Num_list,
    sum_str_A(NewList,OutList_A,[],YourList,Average_A).

%Создаёт список из строк, в которых символов А больше среднего.
sum_str_A([],[],OutList,OutList,_):-!.
sum_str_A([H|T],[H1|T1],InitList,OutList,Average_A):-
    H1 > Average_A,
    append(InitList,[H],NewList),
    sum_str_A(T,T1,NewList,OutList,Average_A),!
    ;
    sum_str_A(T,T1,InitList,OutList,Average_A),!.

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

