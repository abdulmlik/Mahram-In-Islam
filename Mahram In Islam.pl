% Author: Abdulmalik Ben Ali
% Date: 5/24/2017


% Facts :-
% male()                        ذكر    //
% female()                    انثى   //
% father(male(), m|f )        الاب //
% mother(female(),m|f)
% husband(male(),female())    الزوج //

% Rules :-
% wife(female(),male())           الزوجة //
% grandfather(male(), m|f))       الجد //
% brother(male(), m|f)            الاخ //
% sister(female(),m|f)          الاخت //
% uncle_am(male(), m|f)        العم   //
% aunt_am(female(),m|f)        العمة  //
% uncle_ha(male(), m|f)         الخال //
% aunt_ha(female(),m|f)       الخالة //

/* Database  25 Person */
person(zohra).
person(fatama).
person(ali).
person(anwar).
person(amal).
person(fathi).
person(naser).
person(najwa).
person(taha).
person(wahead).
person(bilal).
person(suad).
person(eman).
person(sondos).
person(wedad).
person(naserdean).
person(jamal).
person(warda).
person(wajdi).
person(wesam).
person(jamela).
person(ahmed).
person(mohammed).
person(salsabel).
person(busra).

% start Fact male 12
male(ali).
male(anwar).
male(bilal).
male(fathi).
male(taha).
male(wahead).
male(wesam).
male(naserdean).
male(jamal).
male(ahmed).
male(mohammed).
male(wajdi).
% end fact male

% start Fact female 13
female(zohra).
female(fatama).
female(naser).
female(amal).
female(suad).
female(najwa).
female(sondos).
female(wedad).
female(eman).
female(jamela).
female(warda).
female(busra).
female(salsabel).
% end fact female

% start Fact father  17
father(ali,fathi).
father(ali,naser).
father(ali,najwa).
father(anwar,taha).
father(anwar,wahead).
father(anwar,bilal).
father(fathi,naserdean).
father(fathi,jamal).
father(taha,eman).
father(taha,sondos).
father(wahead,warda).
father(wahead,wajdi).
father(wahead,wesam).
father(naserdean,jamela).
father(jamal,ahmed).
father(jamal,mohammed).
father(wajdi,salsabel).
% end fact father

% start Fact mother 17
mother(zohra,fathi).
mother(zohra,naser).
mother(fatama,najwa).
mother(amal,taha).
mother(amal,wahead).
mother(amal,bilal).
mother(suad,naserdean).
mother(suad,jamal).
mother(najwa,eman).
mother(najwa,sondos).
mother(wedad,warda).
mother(wedad,wajdi).
mother(wedad,wesam).
mother(eman,jamela).
mother(warda,ahmed).
mother(warda,mohammed).
mother(busra,salsabel).
% end fact mother

% start Fact husband  9
husband(ali,zohra).
husband(ali,fatama).
husband(anwar,amal).
husband(fathi,suad).
husband(taha,najwa).
husband(wahead,wedad).
husband(naserdean,eman).
husband(jamal,warda).
husband(wajdi,busra).
% end fact husband

/* Rules */

% start Rule wife
wife(X,Y):- husband(Y,X).
% end Rule wife

% start Rule grandfather
grandfather(X,Y):- father(X,Z),father(Z,Y).
% end Rule grandfather

% start Rule brother
brother(X,Y):- male(X),father(Z,X),father(Z,Y), X \= Y .
% end Rule brother

% start Rule sister
sister(X,Y):- female(X),father(Z,X),father(Z,Y), X \= Y.
% end Rule sister

% start Rule uncle_am
uncle_am(X,Y):- male(X),brother(Z,X),father(Z,Y).
% end Rule uncle_am

% start Rule aunt_am
aunt_am(X,Y):- female(X),brother(Z,X),father(Z,Y).
% end Rule aunt_am

% start Rule uncle_ha
uncle_ha(X,Y):- male(X),sister(Z,X),mother(Z,Y).
% end Rule uncle_ha

% start Rule aunt_ha
aunt_ha(X,Y):- female(X),sister(Z,X),mother(Z,Y).
% end Rule aunt_ha

/* End Database */




/* start Family relations

% start fame 1
male(ali).
female(zohra).
female(fatama).
% male(fathi).  // link fame 3
female(naser).% // link nun
% female(najwa).// link fame 4
husband(ali,zohra).
husband(ali,fatama).
father(ali,fathi).
father(ali,naser).
father(ali,najwa).
mother(zohra,fathi).
mother(zohra,naser).
mother(fatama,najwa).
% end fame 1

% strat fame 2
male(anwar).
female(amal).
% male(taha).   // link fame 4
% male(wahead). // link fame 5
male(bilal).  % // link nun
husband(anwar,amal).
father(anwar,taha).
father(anwar,wahead).
father(anwar,bilal).
mother(amal,taha).
mother(amal,wahead).
mother(amal,bilal).
% end fame 2

% start fame 3
male(fathi).
female(suad).
% male(naserdean). // link fame 6
% male(jamal).     // link fame 7
husband(fathi,suad).
father(fathi,naserdean).
father(fathi,jamal).
mother(suad,naserdean).
mother(suad,jamal).
% end fame 3

% start fame 4
male(taha).
female(najwa).
% female(eman).  // link fame 6
female(sondos). %// link nun
husband(taha,najwa).
father(taha,eman).
father(taha,sondos).
mother(najwa,eman).
mother(najwa,sondos).
% end fame 4

% start fame 5
male(wahead).
female(wedad).
% female(warda). link fame 7
% male(wajdi).   link fame 8
male(wesam). % //link nun
husband(wahead,wedad).
father(wahead,warda).
father(wahead,wajdi).
father(wahead,wesam).
mother(wedad,warda).
mother(wedad,wajdi).
mother(wedad,wesam).
% end fame 5

% start fame 6
male(naserdean).
female(eman).
female(jamela). % link nun
husband(naserdean,eman).
father(naserdean,jamela).
mother(eman,jamela).
% end fame 6

% start fame 7
male(jamal).
female(warda).
male(ahmed).   % // link nun
male(mohammed).% // link nun
husband(jamal,warda).
father(jamal,ahmed).
father(jamal,mohammed).
mother(warda,ahmed).
mother(warda,mohammed).
% end fame 7

% start fame 8
male(wajdi).
female(busra).
female(salsabel). % // link nun
husband(wajdi,busra).
father(wajdi,salsabel).
mother(busra,salsabel).
% end fame 8

 end Family relations */