(deffacts cocina
(ingredientes pisto "pimientos verdes" "pimientos rojos" "berenjenas" "calabacines" "cebollas" "tomate triturado" "sal" "aceite")
(ingredientes tortilla "huevos" "patatas" "cebollas" "aceite" "sal")
(actual "pimientos verdes" "pimientos rojos" "cebollas" "aceite"))

(defrule compra
(ingredientes ?x $?antes ?y $?despues )
?h2 <- (actual $?lista)
(not(actual $? ?y $?))
=>
(printout t "Necesito " ?y " para cocinar " ?x  crlf)
(retract ?h2)
(assert (actual ?y $?lista))
)
