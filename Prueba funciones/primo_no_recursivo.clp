(deffacts hechos 
(planeta 696000000000.00)
(pasa mano 0.13)
(pasa pelota_b 0.0764)
(pasa folio 0.01)
(pasaran))


(deffunction circunferencia(?a)
  (if (numberp ?a)
   then
     (* 3.14 (* ?a 2))
	else
	  then FALSE
	)
)


(defrule circunferencia_dist
    (declare (salience 10))
    (and(and (planeta ?a) 
	?h1<-(pasaran $?b))?h2<-(pasa ?c ?d))
	
	=>
	(if (> 1 (- (circunferencia (+ ?a ?d)) (circunferencia ?a)))
	then
	(retract ?h1)
	(assert (pasaran $?b ?c)))
	(retract ?h2))
	
	
(defrule imprimir
    (pasaran $?a)
	=>
    (printout t "Pasaran por debajo " $?a crlf))