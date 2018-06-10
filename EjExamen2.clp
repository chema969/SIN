(deffacts hechos
(pepe 1 2 3 4 5 6 ))


(defrule regla
(not (and 
(pepe $? ?a $? ?b $?)
(test (> ?a ?b))))
=>
(printout t "Esta ordenado" crlf))