(deffacts hechos
  (dato 1)
  (dato 3)
  
  (todos-los-datos)
)

(defrule Valores
 (dato ?x)
  ?h1<-(todos-los-datos $?antes)
  (not(todos-los-datos $? ?x $?))
  =>
  (retract ?h1)
  (assert (todos-los-datos $?antes ?x))
  )
  
