(deffacts cocina
(pisto ingredientes "pimientos verdes" "pimientos rojos" "berenjenas" "calabacines" "cebollas" "tomate triturado" "sal" "aceite")
(tortilla ingredientes "huevos" "patatas" "cebollas" "aceite" "sal")
(actual "pimientos verdes" "pimientos rojos" "cebollas" "aceite"))

(defrule compra
( ?x ingredientes $? ?y $? ) 
(not(actual $? ?y $?))
=>
(printout t "Necesito para cocinar "  crlf))