(defglobal ?*pasos* = 0)
(defglobal ?*x* = 0)
(defglobal ?*y* = 0)

(deftemplate casilla 
        (slot estado) 
	(slot fila)
	(slot columna)
     )
	
(deffacts inicio 
(casilla (fila 0) (columna 0) (estado ok)))		

(defrule fireWillyLeft
       (declare (salience 100))
	(hasLaser)
       (and (casilla (fila ?f) (columna ?c) (estado alien))
          (and (test (eq ?c ?*y*)) (test (< ?f ?*x*))))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser west)
	)



(defrule fireWillyRight
       (declare (salience 100))
	(hasLaser)
       (and (casilla (fila ?f) (columna ?c) (estado alien))
          (and (test (eq ?c ?*y*)) (test (> ?f ?*x*))))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser east)
	)

(defrule fireWillyUp
       (declare (salience 100))
	(hasLaser)
       (and (casilla (fila ?f) (columna ?c) (estado alien))
          (and (test (eq ?f ?*x*)) (test (> ?c ?*y*))))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser north)
	)


(defrule fireWillyDown
       (declare (salience 100))
	(hasLaser)
       (and (casilla (fila ?f) (columna ?c) (estado alien))
          (and (test (eq ?f ?*x*)) (test (< ?c ?*y*))))
        =>
	(bind ?*pasos* (+ ?*pasos* 1))
	(fireLaser south)
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
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (- ?*x* 1))) (test (eq ?c ?*y*))))
  (test (> 999 ?*pasos*))
  =>
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*x* (- ?*x* 1))
  (moveWilly west)
  )  

  
  
  
(defrule blackHoleMoveRight
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f (+ ?*x* 1))) (test (eq ?c ?*y*))))
  (test (> 999 ?*pasos*))
  =>
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*x* (+ ?*x* 1))
  (moveWilly east)
  )    
  
  
  
  
  (defrule blackHoleMoveUp
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (+ 1 ?*y*)))))
  (test (> 999 ?*pasos*))
  =>
  (assert(casilla(fila ?*x*)(columna ?*y*)(estado ?p)))
  (bind ?*pasos* (+ ?*pasos* 1))
  (bind ?*y* (+ ?*y* 1))
  (moveWilly north)
  )    
  
  
  
  (defrule blackHoleMoveDown
  (percepts $? ?p $?)
  (and(casilla (fila ?f) (columna ?c) (estado ok))
       (and (test (eq ?f ?*x* )) (test (eq ?c (- ?*y* 1)))))
  (test (> 999 ?*pasos*))
  =>
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
