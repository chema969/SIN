(defglobal ?*pasos* = 0)
(defglobal ?*x* = 0)
(defglobal ?*y* = 0)

(deftemplate casilla 
        (slot estado) 
	(slot fila)
	(slot columna)
     )
	
(deffacts inicio 
(last_move west)
(casilla (fila 0) (columna 0) (estado ok)))		

(defrule fireWillyLeft
       (declare (salience 100))
	(hasLaser)
    (casilla (fila ?f) (columna ?c) (estado alien))
    (test (eq ?c ?*y*)) (test (< ?f ?*x*))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser west)
	)



(defrule fireWillyRight
       (declare (salience 100))
	(hasLaser)
       (casilla (fila ?f) (columna ?c) (estado alien))
        (test (eq ?c ?*y*)) (test (> ?f ?*x*))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser east)
	)

(defrule fireWillyUp
       (declare (salience 100))
	(hasLaser)
        (casilla (fila ?f) (columna ?c) (estado alien))
        (test (eq ?f ?*x*)) (test (> ?c ?*y*))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser north)
	)


(defrule fireWillyDown
       (declare (salience 100))
	(hasLaser)
       (casilla (fila ?f) (columna ?c) (estado alien))
      (test (eq ?f ?*x*)) (test (< ?c ?*y*))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser south)
	)



(defrule moveWillyLeft
  ?h1<-(last_move ?ers)
  (directions $? west $?)
  (test (> 999 ?*pasos*))
  (not(percepts $? Pull $?))
  (not(percepts $? Noise $?))
  (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f (- ?*x* 1))) (test (eq ?c ?*y*)))))
  =>
  (retract ?h1)
  (assert (last_move west))
  (moveWilly west)
  (bind ?*x* (- ?*x* 1))
  (bind ?*pasos* (+ ?*pasos* 1))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))




(defrule moveWillyRight
  ?h1<-(last_move ?ers)
  (directions $? east $?)
  (test (> 999 ?*pasos*))
  (not(percepts $? Pull $?))
  (not(percepts $? Noise $?))
   (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f (+ ?*x* 1))) (test (eq ?c ?*y*)))))
  =>
   (retract ?h1)
   (assert (last_move east))
   (moveWilly east)
   (bind ?*pasos* (+ ?*pasos* 1))
   (bind ?*x* (+ 1 ?*x*))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))




(defrule moveWillyUp
  ?h1<-(last_move ?ers)
  (directions $? north $?)
  (test (> 999 ?*pasos*))
  (not(percepts $? Pull $?))
  (not(percepts $? Noise $?))
    (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f  ?*x* )) (test (eq ?c (+ 1 ?*y*))))))
  =>
  (retract ?h1)
  (assert (last_move north))
   (moveWilly north)
   (bind ?*pasos* (+ ?*pasos* 1))
      (bind ?*y* (+ 1 ?*y*))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))



(defrule moveWillyDown
  ?h1<-(last_move ?ers)
  (directions $? south $?)
  (test (> 999 ?*pasos*))
  (not(percepts $? Pull $?))
  (not(percepts $? Noise $?))
    (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f ?*x*)) (test (eq ?c (- ?*y* 1))))))
  =>
  (retract ?h1)
  (assert (last_move south))
   (moveWilly south)
   (bind ?*pasos* (+ ?*pasos* 1))
   (bind ?*y* (- ?*y* 1))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))

  
  
  

(defrule blackHoleMoveLeft
   ?h1<-(last_move ?ers) 
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (- ?*x* 1))) (test (eq ?c ?*y*))))
  (test (> 999 ?*pasos*))
  =>
  (retract ?h1)
  (assert (last_move west))
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*x* (- ?*x* 1))
  (moveWilly west)
  )  

  
  
  
(defrule blackHoleMoveRight
   ?h1<-(last_move ?ers) 
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (+ ?*x* 1))) (test (eq ?c ?*y*))))
  (test (> 999 ?*pasos*))
  =>
    (retract ?h1)
  (assert (last_move east))
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*x* (+ ?*x* 1))
  (moveWilly east)
  )    
  
  
  
  
  (defrule blackHoleMoveUp
     ?h1<-(last_move ?ers) 
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (+ 1 ?*y*)))))
  (test (> 999 ?*pasos*))
  =>
    (retract ?h1)
  (assert (last_move north))
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*y* (+ ?*y* 1))
  (moveWilly north)
  )    
  
  
  
  (defrule blackHoleMoveDown
     ?h1<-(last_move ?ers) 
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (- ?*y* 1)))))
  (test (> 999 ?*pasos*))
  =>
  (retract ?h1)
  (assert (last_move south))
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*y* (- ?*y* 1))
  (moveWilly south)
  )    



  (defrule clear
    (declare (salience 13))
     ?h1<-(casilla (fila ?x) (columna ?y) (estado ok))
    (or (casilla (fila ?x) (columna ?y) (estado Pull)) 
     (casilla (fila ?x) (columna ?y) (estado Noise)))
	 =>
	 (retract ?h1))
  

(defrule detect_alien_same_row 
    (declare (salience 11))
    (and(casilla (fila ?f) (columna ?c)(estado Noise))
    (and(casilla (fila ?f) (columna ?x)(estado Noise))
    (test (eq ?x (- ?c 2)))))
    =>
    (assert (casilla (fila ?f)(columna (+ ?x 1))(estado alien)))
)


(defrule detect_alien_same_column 
    (declare (salience 11))
    (and(casilla (fila ?f) (columna ?c)(estado Noise))
    (and(casilla (fila ?x) (columna ?c)(estado Noise))
    (test (eq ?x (- ?f 2)))))
    =>
    (assert (casilla (fila (+ ?x 1))(columna ?c)(estado alien)))
)


(defrule detect_alien_L_1
    (declare (salience 11))
	(and (casilla (fila ?f) (columna ?c) (estado ok))
	(and (casilla (fila ?x) (columna ?c) (estado Noise))
	(and (casilla (fila ?f) (columna ?y) (estado Noise))
	(and (test (eq ?f (- ?x 1))) (test (eq ?c (- ?y 1)))))))
	=>
	(assert (casilla (fila ?x) (columna ?y) (estado alien))))	
	
(defrule detect_alien_L_2
    (declare (salience 11))
	(and (casilla (fila ?f) (columna ?c) (estado ok))
	(and (casilla (fila ?x) (columna ?c) (estado Noise))
	(and (casilla (fila ?f) (columna ?y) (estado Noise))
	(and (test (eq ?f (+ ?x 1))) (test (eq ?c (- ?y 1)))))))
	=>
	(assert (casilla (fila ?x) (columna ?y) (estado alien))))	

(defrule detect_alien_L_3
    (declare (salience 11))
	(and (casilla (fila ?f) (columna ?c) (estado ok))
	(and (casilla (fila ?x) (columna ?c) (estado Noise))
	(and (casilla (fila ?f) (columna ?y) (estado Noise))
	(and (test (eq ?f (- ?x 1))) (test (eq ?c (+ ?y 1)))))))
	=>
	(assert (casilla (fila ?x) (columna ?y) (estado alien))))	

(defrule detect_alien_L_4
    (declare (salience 11))
	(and (casilla (fila ?f) (columna ?c) (estado ok))
	(and (casilla (fila ?x) (columna ?c) (estado Noise))
	(and (casilla (fila ?f) (columna ?y) (estado Noise))
	(and (test (eq ?f (+ ?x 1))) (test (eq ?c (+ ?y 1)))))))
	=>
	(assert (casilla (fila ?x) (columna ?y) (estado alien))))
	
	
(defrule moveWillyLeftIfThereAreNoPlace
   (declare (salience -10))
   ?h1<-(last_move ?ers)  
   (not (last_move east))
   (directions $? west $?)
   (test (> 999 ?*pasos*))

  =>
    (retract ?h1)
    (assert (last_move west))
     (bind ?*pasos* (+ ?*pasos* 1))
	  (bind ?*x* (- ?*x* 1))
  (moveWilly west)
   )
   
   
   
   
(defrule moveWillyRightIfThereAreNoPlace
   (declare (salience -10))
   ?h1<-(last_move ?ers)  
   (not (last_move west))
   (directions $? east $?)
   (test (> 999 ?*pasos*))

  =>
    (retract ?h1)
    (assert (last_move east))
     (bind ?*pasos* (+ ?*pasos* 1))
	  (bind ?*x* (+ ?*x* 1))
  (moveWilly east)
   )
   
   
(defrule moveWillyUpIfThereAreNoPlace
   (declare (salience -10))
   ?h1<-(last_move ?ers)  
   (not (last_move south))
   (directions $? north $?)
   (test (> 999 ?*pasos*))
  =>
   (retract ?h1)
    (assert (last_move north))
   (bind ?*pasos* (+ ?*pasos* 1))
	  (bind ?*y* (+ ?*y* 1))
  (moveWilly north)
   )
  
(defrule moveWillyDownIfThereAreNoPlace
   (declare (salience -10))
   ?h1<-(last_move ?ers)  
   (not (last_move north))
   (directions $? south $?)
   (test (> 999 ?*pasos*))
  =>
   (retract ?h1)
   (assert (last_move south))
   (bind ?*pasos* (+ ?*pasos* 1))
	  (bind ?*y* (- ?*y* 1))
  (moveWilly south)
   )
