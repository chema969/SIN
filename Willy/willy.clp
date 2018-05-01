(defglobal ?*pasos* = 0)
(defglobal ?*x* = 0)
(defglobal ?*y* = 0)

(deftemplate casilla 
        (slot estado) 
	(slot fila)
	(slot columna)
     )

		
		

(defrule fireWilly
	(hasLaser)
	(directions $? ?direction $?)
	=>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser ?direction)
	)




(defrule moveWillyLeft
  (directions $? west $?)
  (test (> 999 ?*pasos*))
  (not(percepts $? Pull $?))
  (not(percepts $? Noise $?))
  (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f (- ?*x* 1))) (test (eq ?c ?*y*)))))
  =>
  (moveWilly west)
  (bind ?*x* (- ?*x* 1))
  (bind ?*pasos* (+ ?*pasos* 1))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))




(defrule moveWillyRight
  (directions $? east $?)
  (test (> 999 ?*pasos*))
  (not(percepts $? Pull $?))
  (not(percepts $? Noise $?))
   (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f (+ ?*x* 1))) (test (eq ?c ?*y*)))))
  =>
   (moveWilly east)
   (bind ?*pasos* (+ ?*pasos* 1))
   (bind ?*x* (+ 1 ?*x*))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))




(defrule moveWillyUp
  (directions $? north $?)
  (test (> 999 ?*pasos*))
  (not(percepts $? Pull $?))
  (not(percepts $? Noise $?))
    (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f  ?*x* )) (test (eq ?c (+ 1 ?*y*))))))
  =>
   (moveWilly north)
   (bind ?*pasos* (+ ?*pasos* 1))
      (bind ?*y* (+ 1 ?*y*))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))



(defrule moveWillyDown
  (directions $? south $?)
  (test (> 999 ?*pasos*))
  (not(percepts $? Pull $?))
  (not(percepts $? Noise $?))
    (not(and(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f ?*x*)) (test (eq ?c (- ?*y* 1))))))
  =>
   (moveWilly south)
   (bind ?*pasos* (+ ?*pasos* 1))
   (bind ?*y* (- ?*y* 1))
  (assert (casilla(fila ?*x*)(columna ?*y*)(estado ok))))

  
  
  

(defrule blackHoleMoveLeft
  (test (> 999 ?*pasos*))
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (- ?*x* 1))) (test (eq ?c ?*y*))))
  =>
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*x* (- ?*x* 1))
  (moveWilly west)
  )  

  
  
  
(defrule blackHoleMoveRight
  (test (> 999 ?*pasos*))
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (+ ?*x* 1))) (test (eq ?c ?*y*))))
  =>
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*x* (+ ?*x* 1))
  (moveWilly east)
  )    
  
  
  
  
  (defrule blackHoleMoveUp
  (test (> 999 ?*pasos*))
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (+ 1 ?*y*)))))
  =>
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*y* (+ ?*y* 1))
  (moveWilly north)
  )    
  
  
  
  (defrule blackHoleMoveDown
   (test (> 999 ?*pasos*))
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (- ?*y* 1)))))
  =>
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*y* (- ?*y* 1))
  (moveWilly south)
  )    



  (defrule clear
    (declare (salience 10))
     ?h1<-(casilla (fila ?x) (columna ?y) (estado ok))
    (or (casilla (fila ?x) (columna ?y) (estado pull)) 
     (casilla (fila ?x) (columna ?y) (estado noise)))
	 =>
	 (retract ?h1))
  
(defrule moveWillyLeftIfThereAreNoPlace
   (declare (salience -10))
   (directions $? west $?)
   (test (> 999 ?*pasos*))

  =>
     (bind ?*pasos* (+ ?*pasos* 1))
	  (bind ?*x* (- ?*x* 1))
  (moveWilly west)
   )
   
   
   
   
(defrule moveWillyRightIfThereAreNoPlace
   (declare (salience -10))
   (directions $? east $?)
   (test (> 999 ?*pasos*))

  =>
     (bind ?*pasos* (+ ?*pasos* 1))
	  (bind ?*x* (+ ?*x* 1))
  (moveWilly east)
   )
   
   
(defrule moveWillyUpIfThereAreNoPlace
   (declare (salience -10))
   (directions $? north $?)
   (test (> 999 ?*pasos*))
  =>
   (bind ?*pasos* (+ ?*pasos* 1))
	  (bind ?*y* (+ ?*y* 1))
  (moveWilly north)
   )
  
(defrule moveWillyDownIfThereAreNoPlace
   (declare (salience -10))
   (directions $? south $?)
   (test (> 999 ?*pasos*))
  =>
   (bind ?*pasos* (+ ?*pasos* 1))
	  (bind ?*y* (- ?*y* 1))
  (moveWilly south)
   )
  