(deffacts hechos
(pepe 3)
(pepe patata)
(pepe paco)
(pepe totalis)
(total))


(defrule regla
(pepe ?a)
?h1<-(total $?x)
(not (total $? ?a $?))
=>
(retract ?h1)
(assert(total ?a $?x)))