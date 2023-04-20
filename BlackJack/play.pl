/*                                          REGLAS Y MAZO                      */

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







/*ESTRATEGIA JUGADOR*/
stand_jugador():
  print('Me Planto').

hit_jugador():
  print('Pido Otra Carta').  


/*¿que hago aca?*/
igual19(Hand,ValorMano):-
     contar_aces(Hand,CantidadAces),
     CantidadAces is 0,
     hand(Hand,ValorMano),ValorMano>=19.

igual19_con_as(Hand,ValorMano):-
  contar_aces(Hand,CantidadAces),
  CantidadAces is 1,contar_cartas(Hand,CantidadCartas),CantidadCartas is 2,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11 >= 19,stand_jugador().

igual19_sin_as(Hand,ValorMano):-
  contar_aces(Hand,CantidadAces),
  CantidadAces is 0,contar_cartas(Hand,CantidadCartas),CantidadCartas is 2,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11 >= 19,stand_jugador().


menor19_con_as(Hand,ValorMano):-
 contar_aces(Hand,CantidadAces),
 CantidadAces is 1,contar_cartas(Hand,CantidadCartas),CantidadCartas is 2,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11 < 19,hit_jugador().


menor19_sin_as(Hand,ValorMano):-
 contar_aces(Hand,CantidadAces),
 CantidadAces is 0,contar_cartas(Hand,CantidadCartas),CantidadCartas is 2,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11 < 19,hit_jugador().


/*ESTRATREGIA CRUPIER*/

/*Cuento Los As*/

contar_aces([], 0).

contar_aces([card(a,_) | Resto], N) :-
    contar_aces(Resto, N1),
    N is N1 + 1.

contar_aces([card(_,_) | Resto], N) :-
    contar_aces(Resto, N).



valor_mano_con_todas_las_combinaciones(Hand, CantidadAcesRestantes, ValorFinal) :-
    valor_mano_con_todas_las_combinaciones_aux(Hand, CantidadAcesRestantes, 0, ValorFinal).

valor_mano_con_todas_las_combinaciones_aux(Hand, 0, ValorActual, ValorFinal) :-
    /* Si no hay más ases por comprobar, calculo el valor final de la mano */
    hand(Hand, ValorMano),
    ValorFinal is ValorActual + ValorMano.

valor_mano_con_todas_las_combinaciones_aux(Hand, CantidadAcesRestantes, ValorActual, ValorFinal) :-
    /* Si todavía hay ases por comprobar, pruebo con el valor 1 y luego con el valor 11 */
    CantidadAcesRestantes > 0,
    NewCantidadAcesRestantes is CantidadAcesRestantes - 1,
    valor_mano_con_todas_las_combinaciones_aux(Hand, NewCantidadAcesRestantes, ValorActual + 1, ValorFinal),
    valor_mano_con_todas_las_combinaciones_aux(Hand, NewCantidadAcesRestantes, ValorActual + 11, ValorFinal).


/*                                   JUGADOR                                                       */

/*tambien deberia de poder comprobar si con el valor de la mano tengo un over y cuando sumo 21 para decier quien gano eso no se como hacerlo*/

juega_jugador(Cartas):-
(
  igual19_sin_as(Hand,ValorMano)->
  print('Se Ejecuto igual 19 sin as')
; 
  igual19_con_as(Hand,ValorMano)->
  print('Se Ejecuto iugal a 19 con as')
; 
  menor19_sin_as(Hand,ValorMano)->
  print('Se Ejecuto menor 19 sin as')
; 
  menor19_con_as(Hand,ValorMano)->
  print('Se Ejecuto menor 19 con as')
).


/*                                   CRUPIER                                                       */

/*tambien deberia de poder comprobar si con el valor de la mano tengo un over y cuando sumo 21 para decier quien gano eso no se como hacerlo*/

juega_crupier(Cartas):-
  contar_aces(Hand,CantidadAces),
  /*Si No Tengo aces y la mano es mayor a 17 me planto*/
  (CantidadAces is 0, hand(Hand,ValorMano), ValorMano > 17 ->
    print('Soy El Crupier Me Planto')
  ;
    /*Si Tengo un as y tanto valiendo 1 como valiendo 11, el valor total de la mano es mayor a 17 me  planto*/ 
    CantidadAces is 1, valor_mano_con_as1(Hand,ValorConAs1), ValorConAs1 > 17, valor_mano_con_as11(Hand,ValorConAs11), ValorConAs11 > 17 ->
    print('Soy El Crupier Me Planto Teniendo un As')
  ;
  /*Si tengo mas de 1 As veo las comobinaciones posibles a ver si me paso de 17 si es asi me planto,¿no se si debo ver que el primer as valga 11 y el resto uno en teoria no por que solo me interesa saber si me planto o sigo ?/
    CantidadAces >= 2,valor_mano_con_todas_las_combinaciones(Hand,CantidadAces,ValorMano),ValorMano>17 ->print('Soy El Crupier me planto teniendo mas de un as')

  ;
    /*Si no tengo un as y el valor de la mano es 17 entonces me planto*/
  CantidadAces is 0,hand(Hand,ValorMano),ValorMano is 17->print('Soy El Crupiero Me planto no tengo un as')
  ;
   /*Si no tengo aces y la mano es menor o igual a 16  sigo jugando*/
   CantidadAces is 0,hand(Hand,ValorMano),ValorMano =< 16 -> print('Soy el crupiero sigo jugado')
  ;
  /*Si tengo un as y tanto valindo 1 como valiendo 11 el valor total de la mano es menor o igual a 16 sigo jugando1*/
  CantidadAces is 1,valor_mano_con_as1(Hand,ValorConAs1),ValorConAs1 =< 16,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11 =< 16-> print('Soy el crupier sigo jugnado con un as')
  ;
  /*Si tengo mas de un as veo las combinaciones posibles  a ver si tengo 16 o menos su es asi sigo jugando*/
  CantidadAces >= 2,valor_mano_con_todas_las_combinaciones(Hand,CantidadAces,ValorMano),ValorMano=<16->print('Soy el crupier sigo jugando con mas de un as')
  ;

  /*Tengo que ver cuando tengo un as y con el as valiendo  y el valor de la mano es exactamente 17*/
  /*¿con que politica juego hard y con cual soft?*/
  CantidadAces is 1,valor_mano_con_as11(Hand,ValorConAs11),ValorConAs11 is 17->print('Tengo 17 con un as entro en soft o hard')
  /*¿que hago si tengo mas de un as y el valor de la mano es exactamente 17 ?,eso hay que definirlo*/
  ).


/*¿ESTO HARIA FALTA, ENTIENDO QUE NO POR QUE EL PROGRAMA SOLO DEBE DETERMINAR SI EL CRUPIER O EL JUGADOR SE PLANTA O SIGUE?*/
/*queda ver luego de que juegen el crupie o jugador pedir que se ingrese  la mano del adversarario y determinar ganado*/

juega_crupier(Hand):-
  
/*Verifico que le argumento sea jugador o crupier*/
play(Argumento, Cartas) :-
  (Argumento = 'Jugador' ->
    juega_jugador(Cartas)
  ;
  Argumento = 'Crupier' ->
    juega_crupier(Cartas)
  ;
    write('Error: el argumento debe ser "Jugador" o "Crupier".')
    /*¿se deberia agregar un comando crupier hard y un comanfo crupier soft?*/
  ).
