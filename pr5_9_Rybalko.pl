
%ЗАДАЧА 9
% примечание - пустые строки не учитываются и на выполнение программы не
% влияют
pr5_9:-
    see('c:/Users/alexm/Documents/Prolog/pr5_9_Rybalko.txt'),
    read_list_str(OutList),
    seen,
    task_9(OutList,Word,Max),
    write("Самое частое слово:"),write(Word),nl,
    write("Частота:"),write(Max),nl.


%              tell('c:/Users/alexm/Documents/Prolog/111.txt'),
%              write_list_str(NewList),told.

task_9(InputList,Word,Max):-
    beau_list(InputList,[],NewList),% удаляем enter's
    all_make_list_words(NewList,[],OutWord), % удаляем пробелы и составляем список слов
    count_one_word(OutWord,[],[],WordList,FrequencyList), %Составляем список слов и этому списку - список частоты встречаемости соответственно
    max_num(Max, 0, FrequencyList, 0, 0,Index), % максимальная частота
    index_word(Index,WordList,0,[],Word). % по индексу слова максимальной частоты находим это слово в списке слов

make_list_barel(OutList,OutList):-!.

make_list_words([],Word,InitList,OutList):-
    append(InitList,[Word],NewList),
    make_list_barel(NewList,OutList),!.


make_list_words([H|T],Word,InitList,OutList):-
    H > 64,H < 91,
    append(Word,[H],NewWord),
    make_list_words(T,NewWord,InitList,OutList),!.

make_list_words([H|T],Word,InitList,OutList):-
    H > 96,H < 123,
    append(Word,[H],NewWord),
    make_list_words(T,NewWord,InitList,OutList),!.


make_list_words([_|T],Word,InitList,OutList):-
    append(InitList,[Word],NewList),
    make_list_words(T,[],NewList,OutList),!.

all_make_list_words([],OutList,OutList):-!.
all_make_list_words([H|T],InitList,OutList):-
    make_list_words(H,[],[],NewList),
    beau_list(NewList,[],NewBeauList),
    append(InitList,NewBeauList,NewInitList),
    all_make_list_words(T,NewInitList,OutList).



count_one_word([],WordList,FrequencyList,WordList,FrequencyList):-!.
count_one_word([H|T],InitWordList,InitFrequencyList,WordList,FrequencyList):-
    check_list_word(InitWordList,H,0,Flag),
    Flag = 1,
    index_list(InitWordList,H,0,Index),
    update_elem_list(Index,0,InitFrequencyList,[],UpdatedList),
    count_one_word(T,InitWordList,UpdatedList,WordList,FrequencyList),
    !
    ;
    append(InitWordList,[H],UpdatedWordList),
    append(InitFrequencyList,[1],UpdatedFrequencyList),
    count_one_word(T,UpdatedWordList,UpdatedFrequencyList,WordList,FrequencyList).


max_num(Max,Max,[],_,Index,Index):-!.
max_num(Max,InitMax,[H|T],InitIndex,Index,IndexOut):-
    H > InitMax,
    NewMax is H,
    NewInitIndex is InitIndex,
    NewIndex is InitIndex + 1,
    max_num(Max,NewMax,T,NewIndex,NewInitIndex,IndexOut),
    !
    ;
    NewIndex is InitIndex + 1,
    max_num(Max,InitMax,T,NewIndex,Index,IndexOut).


index_list([],_,Index,Index):-!.
index_list([H|T],Word,InitIndex,Index):-
    check_lists(H,Word),
    index_list([],_,InitIndex,Index),
    !
    ;
    NewIndex is InitIndex + 1,
    index_list(T,Word,NewIndex,Index).

index_word(_,[],_,Word,Word):-!.
index_word(N,[H|_],N,_,InitWord):-
    index_word(N,[],N,H,InitWord),!.
index_word(N,[_|T],InitN,Word,InitWord):-
    NewN is InitN + 1,
    index_word(N,T,NewN,Word,InitWord),!.


check_list_word([],_,Flag,Flag):-!.
check_list_word([H|T],Word,Flag,InitFlag):-
    check_lists(H,Word),
    NewFlag is 1,
    check_list_word([],Word,NewFlag,InitFlag),
    !
    ;
    check_list_word(T,Word,Flag,InitFlag),!.

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



%ñðàâíèâàåì ýëåìåíòû â ñïèñêàõ íà ðàâíûõ ïîçèöèÿõ
check_lists([],[]):-!.
check_lists([H1|T1],[H2|T2]):-
    H1 = H2,
    check_lists(T1,T2).


%äëèíà ñïèñêà
len_list([],OutNum,OutNum):-!.
len_list([_|T],OutNum,InitNum):-
    NewNum is OutNum + 1,
    len_list(T,NewNum,InitNum).


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

%âûâîä ñïèñêà
write_list([X|Y]):- writeln(X), write_list(Y).
write_list([]).




%make_beautiful_list_without_enters äà äà êðàñèâûé ñïèñîê!!!
beau_list([],OutList,OutList):-!.
beau_list([H|T],OutList,InitList):-
    len_list(H,0,OutNum),
    OutNum > 0,
    append(OutList,[H],NewList),
    beau_list(T,NewList,InitList),!
    ;
    beau_list(T,OutList,InitList),!.




