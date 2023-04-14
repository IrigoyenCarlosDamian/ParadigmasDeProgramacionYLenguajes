
/*-------------------------------------------------REGLAS DE JUEGO---------------------------------------------*/

/* CARTAS*/

card(a,c).
card(2,c).
card(3,c).
card(4,c).
card(5,c).
card(6,c).
card(7,c).
card(8,c).
card(9,c).
card(10,c).
card(j,c).
card(q,c).
card(k,c).

card(a,p).
card(2,p).
card(3,p).
card(4,p).
card(5,p).
card(6,p).
card(7,p).
card(8,p).
card(9,p).
card(10,p).
card(j,p).
card(q,p).
card(k,p).

card(a,t).
card(2,t).
card(3,t).
card(4,t).
card(5,t).
card(6,t).
card(7,t).
card(8,t).
card(9,t).
card(10,t).
card(j,t).
card(q,t).
card(k,t).

card(a,d).
card(2,d).
card(3,d).
card(4,d).
card(5,d).
card(6,d).
card(7,d).
card(8,d).
card(9,d).
card(10,d).
card(j,d).
card(q,d).
card(k,d).

/*VALUE*/

value(card(a,_), 1).
value(card(a,_), 10).
value(card(k,_), 10).
value(card(j,_), 10).
value(card(q,_), 10).
value(card(N,_), N).

/* VALOR CARTA */

valorCarta(2,2).
valorCarta(3,3).
valorCarta(4,4).
valorCarta(5,5).
valorCarta(6,6).
valorCarta(7,7).
valorCarta(8,8).
valorCarta(9,9).
valorCarta(10,10).
valorCarta(j,10).
valorCarta(q,10).
valorCarta(k,10).
valorCarta(a,11).
valorCarta(a,1).

/*value(carta(Numero,Palo),ValorRetorno)*/

value(c(N,_),Valor):-
  valorCarta(N,Valor).


/*HAND*/

/*SUMA LOS ELEMENTOS DE UNA LISTA*/

suma([], 0).

suma([Elemento| Resto], Suma):-
    suma(Resto, SumaAux),
    Suma is Elemento + SumaAux.


/*LISTA CON EL VALOR DE LA CARTA*/
lista_aux(ValorCartita,[ValorCartita]).


/*CONCATENO LAS LISTAS_AUX */

concatenar([Elemento], Lista, [Elemento|Lista]):-!.

concatenar([Elemento|Resto], Lista, [Elemento|ResultadoAux]):-
    concatenar(Resto, Lista, ResultadoAux).

/* DADA UNA MANO INDICA EL VALOR O VALORES DE LA MANO*/

hand([],0).

hand([Hand|RestoHand],ValorManoTotal):-
  hand(RestoHand,ValorManoAux),
  value(Hand,ValorCarta),
  lista_aux(ValorCarta,Lista),
  concatenar(Lista,[],ListaAux),
  suma(ListaAux,ValorMano),
  ValorManoTotal is ValorMano + ValorManoAux.


/*VEINTIUNO*/
/*INDICA SI LA MANO SUMA EXACTAMENTE 21*/

twentyone(Hand):-
    hand(Hand,Valor),
    21 is Valor.

/*OVER*/

/*INDICA SI LA MANO SE PASO DE 21*/

over(Hand):-
   hand(Hand,Valor),
   21<X.

/*LONGITUD*/

/*DA LA LONGITUD DE UNA LISTA*/

longitud_aux([],Cuneta,Cuenta).

loongitud_aux([_|Resto],CuentaParcial,Resultado):-
    NuevaCuentaParcial is CuentaParcial+1,
    longitud_aux(Resto,NuevaCuentaParcial,Resultado).

longitud(Lista,Resultado):- longitud_aux(Lista,0,Resultado).

/*BLACKJACK*/

/*INDICA SI LA MANO ES UN BLACKJACK, O SEA , SI SUMA 21 CON SOLO 2 CARTAS*/

blackjack(Hand):-
  longitud(Hand,CantidadCartas),
  CantidadCartas is 2,
  twentyone(Hand).

/*Veo si la mano es igual o menor a 16*/

menorA16(Hand):-
  hand(Hand,X),
  16 >= X.

/*Veo si la mano es igual o mayor a 17*/

mayorA17(Hand):-
  hand(Hand,X),
  17 =< X.


/*Veo si la mano es menor a 17*/
menorA17(Hand):-
  hand(Hand,X),
  17 > X.


/*................................CRUPIER.....................................*/

/*soft_dealer : Se planta con una mano de 17 suave. Esto es, el As valiendo 11.*/

soft_dealer(Hand):- menorA17(Hand).

/*hard_dealer : Sigue jugando con una mano de 17 suave.*/

hard_dealer(Hand):-mayorA17(Hand).

/*----------------------------------------JUGADOR------------------------------------*/