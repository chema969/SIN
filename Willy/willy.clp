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
	(fireLaser ?direction)
	)




(defrule moveWillyLeft
  (directions $? west $?)
  (test (neq 999 ?*pasos*))
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
  (test (neq 999 ?*pasos*))
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
  (test (neq 999 ?*pasos*))
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
  (test (neq 999 ?*pasos*))
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
  (test (neq 999 ?*pasos*))
  (percepts $? Pull $?)
  (and  ?h1<-(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f ?*x*)) (test (eq ?c ?*y*))))
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (- ?*x* 1))) (test (eq ?c ?*y*))))
  =>
  (retract ?h1)
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado pull)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*x* (- ?*x* 1))
  (moveWilly west)
  )  

  
  
  
(defrule blackHoleMoveRight
  (test (neq 999 ?*pasos*))
  (percepts $? Pull $?)
  (and  ?h1<-(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f ?*x*)) (test (eq ?c ?*y*))))
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (+ ?*x* 1))) (test (eq ?c ?*y*))))
  =>
  (retract ?h1)
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado pull)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*x* (+ ?*x* 1))
  (moveWilly east)
  )    
  
  
  
  
  (defrule blackHoleMoveUp
  (test (neq 999 ?*pasos*))
  (percepts $? Pull $?)
  (and  ?h1<-(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f ?*x*)) (test (eq ?c ?*y*))))
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (+ 1 ?*y*)))))
  =>
  (retract ?h1)
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado pull)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*y* (+ ?*y* 1))
  (moveWilly north)
  )    
  
  
  
  (defrule blackHoleMoveDown
   (test (neq 999 ?*pasos*))
  (percepts $? Pull $?)
  (and  ?h1<-(casilla (fila ?f) (columna ?c))
       (and (test (eq ?f ?*x*)) (test (eq ?c ?*y*))))
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (- ?*y* 1)))))
  =>
  (retract ?h1)
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado pull)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*y* (- ?*y* 1))
  (moveWilly south)
  )    




  
(defrule moveWilly
   (declare (salience -10))
     (test (neq 999 ?*pasos*))
   (directions $? ?direction $?)
   =>
   (moveWilly ?direction)
   )