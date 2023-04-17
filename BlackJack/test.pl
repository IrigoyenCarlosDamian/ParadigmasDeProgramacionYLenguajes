/*CARTAS CON NUMERO Y PALO*/
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

/*VALOR DE LA CARTA */

value(card(a,_), 1).
value(card(a,_), 11).
value(card(k,_), 10).
value(card(j,_), 10).
value(card(q,_), 10).
value(card(2,_),2).
value(card(3,_),3).
value(card(4,_),4).
value(card(5,_),5).
value(card(6,_),6).
value(card(7,_),7).
value(card(8,_),8).
value(card(9,_),9).
value(card(10,_),10).

/*VALORES POSIBLES DE LAS CARTAS*/

valor_carta(2,2).
valor_carta(3,3).
valor_carta(4,4).
valor_carta(5,5).
valor_carta(6,6).
valor_carta(7,7).
valor_carta(8,8).
valor_carta(9,9).
valor_carta(10,10).
valor_carta(j,10).
valor_carta(q,10).
valor_carta(k,10).
valor_carta(a,11).
valor_carta(a,1).




/*value(carta(Numero,Palo),ValorRetorno)*/

value(c(N,_),Valor):-
  valorCarta(N,Valor).


/*Cuento Los As*/

contar_aces([], 0).

contar_aces([card(a,_) | Resto], N) :-
    contar_aces(Resto, N1),
    N is N1 + 1.

contar_aces([card(_,_) | Resto], N) :-
    contar_aces(Resto, N).

/*HAND*/
hand([], 0).
hand([Carta | Resto], ValorTotal) :- hand(Resto, ValorAuxiliar),value(Carta, ValorCarta),

 ValorTotal is ValorAuxiliar + ValorCarta.


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

longitud([],0).

longitud([_|Resto],LongitudLista) :- longitud(Resto,N) , LongitudLista is N+1 .
/*BLACKJACK*/

/*INDICA SI LA MANO ES UN BLACKJACK, O SEA , SI SUMA 21 CON SOLO 2 CARTAS*/

blackjack(Hand):-
  longitud(Hand,CantidadCartas),
  CantidadCartas is 2,
  twentyone(Hand),print('Ganaste Capo').


/*Valor De La Mano Con As igual 1*/

/*Cuento el valor de las cartas sin tener en cuenta el as ya que se que vale 1 y 
la regla se llama cuando la cantidad de as es 1 entonces al valor total de la mano sin as le sumo 1 y 
tengo el valor de la mano asumiendo el valor del as como 1  */

valor_mano_con_as1([], 0).
valor_mano_con_as1([c(N,_)|Resto], ValorTotal) :-
    N \= a,
    valor_carta(N, ValorCarta),
    valor_mano_con_as1(Resto, ValorResto),
    ValorTotal is ValorCarta + ValorResto + 1.

/*Valor De La Mano Con As igual 11*/

/*Cuento el valor de las cartas sin tener en cuenta el as ya que se que vale 11 y 
la regla se llama cuando la cantidad de as es 1 entonces al valor total de la mano sin as le sumo 11 y 
tengo el valor de la mano asumiendo el valor del as como 11  */

valor_mano_con_as11([], 0).
valor_mano_con_as11([c(N,_)|Resto], ValorTotal) :-
    N \= a,
    valor_carta(N, ValorCarta),
    valor_mano_con_as11(Resto, ValorResto),
    ValorTotal is ValorCarta + ValorResto + 11.


/*-*/

valor_mano_sin_as([], 0).
valor_mano_sin_as([c(N,_)|Resto], ValorTotal) :-
    N \= a,
    valor_carta(N, ValorCarta),
    valor_mano_sin_as(Resto, ValorResto),
    ValorTotal is ValorCarta + ValorResto.


/*CRUPIER*/
/*Si No Tengo aces y tengo una mano de menos de 16 sigo jugando */

/*Tengo que ver el caso en el que no tenga aces */
/*Si La Cantidad de aces es 0 entonces el valor de la mano lo determino con Hand*/

crupier_play(Hand):-
  contar_aces(Hand,CantidadAces),
  CantidadAces is 0,
  hand(Hand,ValorMano),ValorMano=< 16.

/*Si tengo  1 as tengo que ver que el valor de la mano sea 16 o menos con as valiendo 1 y con as valiendo 11 */
crupier_play(Hand):-
  contar_aces(Hand,CantidadAces),
  CantidadAces is 1,valor_mano_con_as1(Hand,ValorConAs1),ValorConAs1=<16,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11=<16.


/*Si tengo mas de 1 as tengo que ver el valor de la mano sin los aces para ver que valor me conviene que tomen los aces*/

soft_deler(Hand):-
  print('Me Planto Con 17 Suave').


har_deler(Hand):-
  print('Sigo Jugando').

/*Si no tengo aces y la mano vale mas de  17 me planto*/
crupier_play(Hand):-
  contar_aces(Hand,CantidadAces),
  CantidadAces is 0,
  hand(Hand,ValorMano),ValorMano> 17.


contar_cartas([], 0).

contar_cartas([_ | Resto], N) :-
    contar_cartas(Resto, N1),
    N is N1 + 1.
/*si tengo un solo as y la mano con el as valiendo 1 y valiendo 11 el valor total de la mano es mayor a 17 me planto*/
crupier_play(Hand):-
  contar_aces(Hand,CantidadAces),
  CantidadAces is 1,valor_mano_con_as1(Hand,ValorConAs1),ValorConAs1 >17,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11>17.

/*Si Tengo un solo as y vale 11 tengo que ver si con el resto de la mano obtengo exactamente 17 estoy en presencia de un 17 suave */

crupier_play(Hand):-
  contar_aces(Hand,CantidadAces),
  CantidadAces is 1,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11 is 17,contar_cartas(Hand,CantidadCartas),CantidadCartas is 2,soft_deler(Hand).

crupier_play(Hand):-
  contar_aces(Hand,CantidadAces),
  CantidadAces is 1,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11 is 17,contar_cartas(Handa,CantidadCartas),CantidadCartas>2,har_deler(Hand).


/*si tengo mas de 1 as tengo que ver el valor de la mano sin el as para ver que  valor me conviene que  tomo el as*/

