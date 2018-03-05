% Author: Abdulmalik Ben Ali
% Date: 5/24/2017


% Facts :-
% person( name )                   شخص  //
% male(name)        m              ذكر   //
% female( name )      f           انثى  //
% parent(m|f , m|f)              الوالدان //
% husband(male(),female())         الزوج //
% sibling_re(m|f , m|f)   الاخوة من الرضاعة  //

% Rules :-
% father(male(), m|f )            الاب //
% mother(female(),m|f)            الام //
% wife(female(),male())           الزوجة //
% grandfather(male(), m|f))       الجد //
% grandmother(female(), m|f))    الجدة //
% brother(male(), m|f)            الاخ //
% sister(female(),m|f)          الاخت //
% sibling(m|f , m|f)           الاخوة //
% ancestor(ancestor , parent) السلف //
% descendent(descendent,child) النسل  //
% uncle_am(male(), m|f)        العم   //
% aunt_am(female(),m|f)        العمة  //
% uncle_ha(male(), m|f)         الخال //
% aunt_ha(female(),m|f)       الخالة //
% descendent_sibling(descendent, child)  النسل الاشقاء //
% hamo(m|f, male)               الحمو //

/* Database  25 Person( name ) */
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
%cat(...).

% start Fact male( name ) 12
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

% start Fact female( name ) 13
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

% start Fact parent( child , parent)  34
parent(fathi,ali).
parent(naser,ali).
parent(najwa,ali).
parent(taha,anwar).
parent(wahead,anwar).
parent(bilal,anwar).
parent(naserdean,fathi).
parent(jamal,fathi).
parent(eman,taha).
parent(sondos,taha).
parent(warda,wahead).
parent(wajdi,wahead).
parent(wesam,wahead).
parent(jamela,naserdean).
parent(ahmed,jamal).
parent(mohammed,jamal).
parent(salsabel,wajdi).
parent(fathi,zohra).%f
parent(naser,zohra).
parent(najwa,fatama).
parent(taha,amal).
parent(wahead,amal).
parent(bilal,amal).
parent(naserdean,suad).
parent(jamal,suad).
parent(eman,najwa).
parent(sondos,najwa).
parent(warda,wedad).
parent(wajdi,wedad).
parent(wesam,wedad).
parent(jamela,eman).
parent(ahmed,warda).
parent(mohammed,warda).
parent(salsabel,busra).
% end fact parent

% start Fact husband(male,female)  9
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

% start Fact sibling_re(m|f , m|f)  4
sibling_re(wesam,jamela).
sibling_re(ahmed,salsabel).
sibling_re(salsabel,ahmed).% f
sibling_re(jamela,wesam).
% end fact sibling_re

/********* Rules *************/

% start Rule father(father ,child)
father(F,Child):- parent(Child,F),male(F).
% end fact father

% start Rule mother(mother , child)
mother(M,Child):- parent(Child,M),female(M).
% end fact mother

% start Rule wife(female , male)
wife(X,Y):- husband(Y,X).
% end Rule wife

% start Rule grandfather(grandfather , child)
grandfather(X,Y):- father(X,Z),father(Z,Y).
% end Rule grandfather

% start Rule grandmother(grandmother , child)
grandmother(X,Y):- mother(X,Z),father(Z,Y).
% end Rule grandmother

% start Rule brother(male ,m|f) % m|f خو male
brother(X,Y):- male(X),
               (
                  (
                     father(Z,X),father(Z,Y)
                   );
                   (
                     sibling_re(X,Y)
                   )
               ),
               X \= Y. % هوا ليس خو نفسه //
% end Rule brother

% start Rule sister(female , m|f)
% female = اخت //
% m|f = اخ او اخت //
sister(X,Y):- female(X),
               (
                  (
                     father(Z,X),father(Z,Y)
                   );
                   (
                     sibling_re(X,Y)
                   )
               ),
               X \= Y. % هيا ليست اخت نفسها //
% end Rule sister

% start Rule sibling(m|f , m|f)
sibling(X,Y):- (% start sibling // X خو Y
                 (% start sibling in father
                    father(Z,X),father(Z,Y)
                 );% end sibling in father
                 (% start sibling in mother not sibling in father
                    mother(K,X),mother(K,Y),father(S,Y),not(father(S,X))
                 );% end sibling in mother
                 (
                     sibling_re(X,Y)
                 )
               ),% end sibling
                X\=Y.% هوا ليس خو نفسه //
% end Rule sibling

% start Rule ancestor(ancestor , parent) السلف //
% ancestor = الابن  //
% parent =   الاباء والاجداد //
ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):- parent(X,Z),ancestor(Z,Y).
% end Rule ancestor

% start Rule descendent(descendent , child)  النسل  //
% descendent = الاب//
% child = الابناء والاحفاد //
descendent(X,Y):- parent(Y,X).
descendent(X,Y):- parent(Y,Z),descendent(X,Z).
% end Rule descendent

% start Rule uncle_am(am , child)
% child = الطفل //
% am = عم الطفل //
uncle_am(X,Y):- male(X),brother(Z,X),father(Z,Y).
% end Rule uncle_am

% start Rule aunt_am(am , child)
% child = الطفل //
% am = عمة الطفل //
aunt_am(X,Y):- female(X),brother(Z,X),father(Z,Y).
% end Rule aunt_am

% start Rule uncle_ha(ha , child)
% child = الطفل //
% ha = خال الطفل //
uncle_ha(X,Y):- male(X),sister(Z,X),mother(Z,Y).
% end Rule uncle_ha

% start Rule aunt_ha(ha , child)
% child = الطفل //
% ha = خالة الطفل //
aunt_ha(X,Y):- female(X),sister(Z,X),mother(Z,Y).
% end Rule aunt_ha

% start Rule descendent_sibling(descendent, child)
% descendent = الشخص  //
% child =     ابناء واحفاد شقيق الشخص //
descendent_sibling(X,Y):- sibling(X,Z),descendent(Z,Y).
% end Rule descendent_sibling

% start Rule hamo(m|f, m|f)
% 1.m|f = الشخص  //
% 2.m|f =     الحمو للشخص //
hamofemale(X,Y):- wife(X,Z),
                  (% start hamo
                     (% start father
                         father(Y,Z)
                     );% end father
                     (%  start father wife \= X
                         husband(Z,S),
                         S \= X, % زوجة الرجل زوجة اخرى //
                         father(Y,S)
                     )% end father wife \= X
                  ).% end hamo

hamo(X,Y):- (
               female(X) , hamofemale(X,Y)
            );
            (
               male(X), husband(X,Z), mother(Y,Z)
            ).
% end Rule hamo



/*-----------Start mohram ---------------*/
mohram_male(X,Y):- (
                       husband(X,Y);
                       ancestor(X,Y);
                       descendent(X,Y);
                       hamo(X,Y);
                       sister(Y,X);
                       aunt_am(Y,X);
                       aunt_ha(Y,X);
                       descendent_sibling(X,Y)
                   ),
                   female(Y).
                   
mohram_female(X,Y):- (
                       wife(X,Y);
                       ancestor(X,Y);
                       descendent(X,Y);
                       hamofemale(X,Y);
                       brother(Y,X);
                       uncle_ha(Y,X);
                       uncle_am(Y,X);
                       descendent_sibling(X,Y)
                   ),
                   male(Y).
                   
mohram(X,Y):-
             (
               female(X),mohram_female(X,Y)
             );
             (
                male(X),mohram_male(X,Y)
             ).
/*-----------End mohram ---------------*/

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