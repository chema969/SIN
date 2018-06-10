(defglobal ?*x* = 1)

(deftemplate persona
(slot nombre)
(slot apellidos)
(slot ordenado))

(deffacts personas
(persona (apellidos perez)(ordenado 0))
(persona (apellidos ramirez) (ordenado 0))
(persona (nombre juan) (apellidos cuevas) (ordenado 0))
(persona (nombre paco)(apellidos cuevas) (ordenado 0)))

(defrule ordenar
?h1<-(persona (apellidos ?a) (ordenado 0))
(not(and(persona (apellidos ?b) (ordenado 0) )
(test (eq 1 (str-compare ?a ?b)))))
=>
(retract ?h1)
(assert(persona (apellidos ?a) (ordenado ?*x*)))
(bind ?*x* (+ 1 ?*x*)))


