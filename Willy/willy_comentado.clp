(defglobal ?*pasos* = 0);Pasos que va dando willy
(defglobal ?*x* = 0);Variable para mantener guardada la posición vertical de willy
(defglobal ?*y* = 0);Variable para mantener guardada la posición horizontal de willy

(deftemplate casilla 
        (slot estado) 
	(slot fila)
	(slot columna)
     )                                                  ;Plantilla para guardar las casillas, tres slots:fila,columna y estado
	
(deffacts inicio                                        ;Hechos definidos al inicio
(last_move west)                                        ;Ultimo movimiento(Uno aleatorio debido a que no importa)
(casilla (fila 0) (columna 0) (estado ok)))             ;Casilla origen		




(defrule fireWillyLeft                                        ;Funcion para que willy dispare a la derecha
       (declare (salience 100))
	(hasLaser)
    (casilla (fila ?f) (columna ?c) (estado alien))
    (test (eq ?c ?*y*)) (test (< ?f ?*x*))                    ;Busca que haya un alien a la izquierda
        =>
	(bind ?*pasos* (+ ?*pasos* 1))                            ;suma 1 al numero de pasos
	(fireLaser west);dispara
	)



(defrule fireWillyRight                                      ;Funcion para que willy dispare a la derecha
       (declare (salience 100))
	(hasLaser)
       (casilla (fila ?f) (columna ?c) (estado alien))
        (test (eq ?c ?*y*)) (test (> ?f ?*x*))               ;Busca que haya un alien a la derecha
        =>
	(bind ?*pasos* (+ ?*pasos* 1))                           ;suma 1 al numero de pasos
	(fireLaser east);dispara
	)

(defrule fireWillyUp                                         ;Funcion para que willy dispare arriba
       (declare (salience 100))
	(hasLaser)
        (casilla (fila ?f) (columna ?c) (estado alien))      ;Busca que haya un alien por encima de él
        (test (eq ?f ?*x*)) (test (> ?c ?*y*))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))                           ;suma 1 al numero de pasos
	(fireLaser north);dispara
	)


(defrule fireWillyDown                                       ;Funcion para que willy dispare abajo
       (declare (salience 100))
	(hasLaser)
       (casilla (fila ?f) (columna ?c) (estado alien))       ;Busca que haya un alien bajo él
      (test (eq ?f ?*x*)) (test (< ?c ?*y*))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))                           ;suma 1 al numero de pasos
	(fireLaser south);dispara
	)



(defrule moveWillyLeft                                       ;Mueve a willy a la izquierda siempre que a la izquierda haya una casilla que no ha visitado
  ?h1<-(last_move ?ers)
  (directions $? west $?)
  (test (> 999 ?*pasos*))                                    ;Busca que los pasos sean menos de 999 
  (not(percepts $? Pull $?))                                 ;si el agujero negro tira de willy no se activa esta regla
  (not(percepts $? Noise $?))                                ;si hay ruido no se activa esta regla
  (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f (- ?*x* 1))) (test (eq ?c ?*y*))))) ;si la casilla ya fué visitada no se activa esta regla
  =>
  (retract ?h1)
   (assert (last_move west))                                 ;Dice que el ultimo movimiento fue hacia el oeste
  (moveWilly west)                                           ;Mueve a willy al oeste
  (bind ?*x* (- ?*x* 1))                                     ;Baja 1 el valor de x
  (bind ?*pasos* (+ ?*pasos* 1))                             ;suma 1 al numero de pasos
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))    ; introduce la nueva casilla como una regla




(defrule moveWillyRight                                       ;Mueve a willy a la derecha siempre que a la derecha haya una casilla que no ha visitado
  ?h1<-(last_move ?ers)
  (directions $? east $?)
  (test (> 999 ?*pasos*))                                     ;Busca que los pasos sean menos de 999
  (not(percepts $? Pull $?))                                  ;si el agujero negro tira de willy no se activa esta regla
  (not(percepts $? Noise $?))                                 ;si hay ruido no se activa esta regla
   (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f (+ ?*x* 1))) (test (eq ?c ?*y*)))))  ;si la casilla ya fué visitada no se activa esta regla
  =>
   (retract ?h1)
    (assert (last_move east))                                  ;Dice que el ultimo movimiento fue hacia el este
   (moveWilly east)                                            ;Mueve a willy al este
   (bind ?*pasos* (+ ?*pasos* 1))                              ;suma 1 al numero de pasos
   (bind ?*x* (+ 1 ?*x*))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))      ;introduce la nueva casilla como una regla




(defrule moveWillyUp                                           ;Mueve a willy hacia arriba siempre que a la sobre el haya una casilla que no ha visitado
  ?h1<-(last_move ?ers)
  (directions $? north $?)
  (test (> 999 ?*pasos*))                                      ;Busca que los pasos sean menos de 999
  (not(percepts $? Pull $?))                                   ;si el agujero negro tira de willy no se activa esta regla
  (not(percepts $? Noise $?))                                  ;si hay ruido no se activa esta regla
    (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f  ?*x* )) (test (eq ?c (+ 1 ?*y*)))))) ;si la casilla ya fué visitada no se activa esta regla
  =>
  (retract ?h1)
    (assert (last_move north))                                 ;Dice que el ultimo movimiento fue hacia el norte  
   (moveWilly north)                                           ;Mueve a willy al norte
   (bind ?*pasos* (+ ?*pasos* 1))                              ;suma 1 al numero de pasos
      (bind ?*y* (+ 1 ?*y*))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))      ;introduce la nueva casilla como una regla



(defrule moveWillyDown                                         ;Mueve a willy hacia abajo siempre que a la debajo de el haya una casilla que no ha visitado
  ?h1<-(last_move ?ers)
  (directions $? south $?)
  (test (> 999 ?*pasos*))                                      ;Busca que los pasos sean menos de 999
  (not(percepts $? Pull $?))                                   ;si el agujero negro tira de willy no se activa esta regla
  (not(percepts $? Noise $?))                                  ;si hay ruido no se activa esta regla
    (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f ?*x*)) (test (eq ?c (- ?*y* 1))))))   ;si la casilla ya fué visitada no se activa esta regla
  =>
  (retract ?h1)
    (assert (last_move south))                                 ;Dice que el ultimo movimiento fue hacia el sur
   (moveWilly south)                                           ;Mueve a willy al sur
   (bind ?*pasos* (+ ?*pasos* 1))                              ;suma 1 al numero de pasos
   (bind ?*y* (- ?*y* 1))                                      ;Baja 1 el valor de y
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))      ;introduce la nueva casilla como una regla

  
  
  

(defrule blackHoleMoveLeft                                   ;Mueve a la izquierda a willy en caso de que encuentre ruido o tire de él un agujero negro  
   ?h1<-(last_move ?ers) 
  (percepts $? ?p $?)                                        ;Busca que willy perciba algo
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (- ?*x* 1))) (test (eq ?c ?*y*))))  ;Busca que exista a la izquierda de él una casilla con estado ok
  (test (> 999 ?*pasos*))                                    ;Busca que los pasos sean menos de 999
  =>
  (retract ?h1)                                             
   (assert (last_move west))                                 ;Dice que el ultimo movimiento fue hacia el oeste
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))      ;Pone el estado de la casilla con ruido o pull 
  (bind ?*pasos* (+ ?*pasos* 1))                             ;suma 1 al numero de pasos
  (bind ?*x* (- ?*x* 1))                                     ;Baja 1 el valor de x
  (moveWilly west)                                           ;Mueve a willy al oeste
  )  

  
  
  
(defrule blackHoleMoveRight                                  ;Mueve a la derecha a willy en caso de que encuentre ruido o tire de él un agujero negro  
   ?h1<-(last_move ?ers) 
  (percepts $? ?p $?)                                        ;Busca que willy perciba algo
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (+ ?*x* 1))) (test (eq ?c ?*y*))))  ;Busca que exista a la derecha de él una casilla con estado ok
  (test (> 999 ?*pasos*))                                    ;Busca que los pasos sean menos de 999
  =>
    (retract ?h1)
   (assert (last_move east))                                 ;Dice que el ultimo movimiento fue hacia el este
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))      ;Pone el estado de la casilla con ruido o pull
  (bind ?*pasos* (+ ?*pasos* 1))                             ;suma 1 al numero de pasos
  (bind ?*x* (+ ?*x* 1))                                     ;Sube 1 el valor de x
  (moveWilly east)                                           ;Mueve a willy al este
  )    
  
  
  
  
  (defrule blackHoleMoveUp                                   ;Mueve hacia arriba a willy en caso de que encuentre ruido o tire de él un agujero negro
     ?h1<-(last_move ?ers) 
  (percepts $? ?p $?)                                        ;Busca que willy perciba algo
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (+ 1 ?*y*))))) ;Busca que exista sobre willy una casilla con estado ok
  (test (> 999 ?*pasos*))                                    ;Busca que los pasos sean menos de 999
  =>
    (retract ?h1)
    (assert (last_move north))                               ;Dice que el ultimo movimiento fue hacia el norte
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))      ;Pone el estado de la casilla con ruido o pull
  (bind ?*pasos* (+ ?*pasos* 1))                             ;suma 1 al numero de pasos
  (bind ?*y* (- ?*y* 1))                                     ;Sube 1 el valor de y
  (moveWilly north)                                          ;Mueve a willy al norte 
  )    
  
  
  
  (defrule blackHoleMoveDown                                 ;Mueve hacia abajo a willy en caso de que encuentre ruido o tire de él un agujero negro
     ?h1<-(last_move ?ers) 
  (percepts $? ?p $?)                                        ;Busca que willy perciba algo
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (- ?*y* 1))))) ;Busca que exista bajo willy una casilla con estado ok
  (test (> 999 ?*pasos*))                                    ;Busca que los pasos sean menos de 999
  =>
  (retract ?h1)
    (assert (last_move south))                               ;Dice que el ultimo movimiento fue hacia el sur
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))                             ;suma 1 al numero de pasos
  (bind ?*y* (- ?*y* 1))                                     ;Baja 1 el valor de y
  (moveWilly south)                                          ;Mueve a willy al sur
  )    



  (defrule clear                                              ;Si existen dos casillas, una con ruido/pull y otra ok, borra la ok
    (declare (salience 13))
     ?h1<-(casilla (fila ?x) (columna ?y) (estado ok))
    (or (casilla (fila ?x) (columna ?y) (estado Pull)) 
     (casilla (fila ?x) (columna ?y) (estado Noise)))
	 =>
	 (retract ?h1))
  

(defrule detect_alien_same_row                                 ;Detecta a un alien en caso de detectar dos ruidos alineados verticalmente y una casilla en medio
    (declare (salience 11))
    (and(casilla (fila ?f) (columna ?c)(estado Noise))
    (and(casilla (fila ?f) (columna ?x)(estado Noise))
    (test (eq ?x (- ?c 2)))))
    =>
    (assert (casilla (fila ?f)(columna (+ ?x 1))(estado alien)));Existe un alien en esa casilla
)


(defrule detect_alien_same_column                              ;Detecta a un alien en caso de detectar dos ruidos alineados horizontalmente y una casilla en medio
    (declare (salience 11))
    (and(casilla (fila ?f) (columna ?c)(estado Noise))
    (and(casilla (fila ?x) (columna ?c)(estado Noise))
    (test (eq ?x (- ?f 2)))))
    =>
    (assert (casilla (fila (+ ?x 1))(columna ?c)(estado alien)));Existe un alien en esa casilla
)


(defrule detect_alien_L_1                                    ;Detecta a un alien en caso de detectar dos ruidos y una casilla ok entre ambos
    (declare (salience 11))
	(and (casilla (fila ?f) (columna ?c) (estado ok))
	(and (casilla (fila ?x) (columna ?c) (estado Noise))
	(and (casilla (fila ?f) (columna ?y) (estado Noise))
	(and (test (eq ?f (- ?x 1))) (test (eq ?c (- ?y 1))))))) ;En este caso, detecta la esquina inferior izquierda
	=>
	(assert (casilla (fila ?x) (columna ?y) (estado alien))));Existe un alien en esa casilla
	
(defrule detect_alien_L_2                                    ;Detecta a un alien en caso de detectar dos ruidos y una casilla ok entre ambos
    (declare (salience 11))
	(and (casilla (fila ?f) (columna ?c) (estado ok))
	(and (casilla (fila ?x) (columna ?c) (estado Noise))
	(and (casilla (fila ?f) (columna ?y) (estado Noise))
	(and (test (eq ?f (+ ?x 1))) (test (eq ?c (- ?y 1))))))) ;En este caso, detecta la esquina superior izquierda
	=>
	(assert (casilla (fila ?x) (columna ?y) (estado alien))));Existe un alien en esa casilla	

(defrule detect_alien_L_3                                    ;Detecta a un alien en caso de detectar dos ruidos y una casilla ok entre ambos
    (declare (salience 11))
	(and (casilla (fila ?f) (columna ?c) (estado ok))
	(and (casilla (fila ?x) (columna ?c) (estado Noise))
	(and (casilla (fila ?f) (columna ?y) (estado Noise))
	(and (test (eq ?f (- ?x 1))) (test (eq ?c (+ ?y 1))))))) ;En este caso, detecta la esquina inferior derecha
	=>
	(assert (casilla (fila ?x) (columna ?y) (estado alien))));Existe un alien en esa casilla	

(defrule detect_alien_L_4                                    ;Detecta a un alien en caso de detectar dos ruidos y una casilla ok entre ambos
    (declare (salience 11))
	(and (casilla (fila ?f) (columna ?c) (estado ok))        
	(and (casilla (fila ?x) (columna ?c) (estado Noise))
	(and (casilla (fila ?f) (columna ?y) (estado Noise))
	(and (test (eq ?f (+ ?x 1))) (test (eq ?c (+ ?y 1))))))) ;En este caso, detecta la esquina superior derecha
	=>
	(assert (casilla (fila ?x) (columna ?y) (estado alien))));Existe un alien en esa casilla
	
	
(defrule moveWillyLeftIfThereAreNoPlace                      ;Mueve a willy hacia la izquierda si no encuentra ninguna casilla sin visitar cerca
   (declare (salience -10))                                  ;Menor prioridad
   ?h1<-(last_move ?ers)  
   (not (last_move east))                                    ;Para evitar vueltas innecesarias, willy evita usar esta regla si el ultimo movimiento fue hacia el este
   (directions $? west $?)
   (test (> 999 ?*pasos*))                                   ;Busca que los pasos sean menos de 999

  =>
    (retract ?h1)
     (assert (last_move west))                               ;Dice que el ultimo movimiento fue hacia el oeste
     (bind ?*pasos* (+ ?*pasos* 1))                          ;suma 1 al numero de pasos
	  (bind ?*x* (- ?*x* 1))                                 ;Baja 1 el valor de x
  (moveWilly west)                                           ;Mueve a willy al oeste
   )
     
   
   
(defrule moveWillyRightIfThereAreNoPlace                     ;Mueve a willy hacia la derecha si no encuentra ninguna casilla sin visitar cerca
   (declare (salience -10))                                  ;Menor prioridad
   ?h1<-(last_move ?ers)  
   (not (last_move west))                                    ;Para evitar vueltas innecesarias, willy evita usar esta regla si el ultimo movimiento fue hacia el oeste
   (directions $? east $?)
   (test (> 999 ?*pasos*))                                   ;Busca que los pasos sean menos de 999

  =>
    (retract ?h1)
     (assert (last_move east))                               ;Dice que el ultimo movimiento fue hacia el este
     (bind ?*pasos* (+ ?*pasos* 1))                          ;suma 1 al numero de pasos
	  (bind ?*x* (+ ?*x* 1))                                 ;Sube 1 el valor de x
  (moveWilly east)                                           ;Mueve a willy al este
   )
   
   
(defrule moveWillyUpIfThereAreNoPlace
   (declare (salience -10))                                  ;Menor prioridad
   ?h1<-(last_move ?ers)  
   (not (last_move south))                                   ;Para evitar vueltas innecesarias, willy evita usar esta regla si el ultimo movimiento fue hacia el sur
   (directions $? north $?)
   (test (> 999 ?*pasos*))                                   ;Busca que los pasos sean menos de 999
  =>
   (retract ?h1)
      (assert (last_move north))                             ;Dice que el ultimo movimiento fue hacia el norte
   (bind ?*pasos* (+ ?*pasos* 1))                            ;suma 1 al numero de pasos
	  (bind ?*y* (- ?*y* 1))                                 ;Sube 1 el valor de y
  (moveWilly north)                                          ;Mueve a willy al norte
   )
  
(defrule moveWillyDownIfThereAreNoPlace
   (declare (salience -10))                                  ;Menor prioridad
   ?h1<-(last_move ?ers)  
   (not (last_move north))                                   ;Para evitar vueltas innecesarias, willy evita usar esta regla si el ultimo movimiento fue hacia el norte
   (directions $? south $?)
   (test (> 999 ?*pasos*))                                   ;Busca que los pasos sean menos de 999
  =>
   (retract ?h1)
     (assert (last_move south))                              ;Dice que el ultimo movimiento fue hacia el sur
   (bind ?*pasos* (+ ?*pasos* 1))                            ;suma 1 al numero de pasos
	  (bind ?*y* (- ?*y* 1))                                 ;Baja 1 el valor de y
  (moveWilly south)                                          ;Mueve a willy al sur
   )
