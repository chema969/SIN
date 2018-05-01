(deftemplate bandera (slot pais)(multislot color))

(deffacts hechos (bandera (pais españa)(color rojo amarillo))
 (bandera (pais alemania)(color rojo negro amarillo))
 (bandera (pais japon) (color rojo blanco))

(color_deseado rojo)
(color_deseado amarillo))


(defrule encontrar_pais 
(and(and(bandera (pais ?a)(color $? ?b $?))?h1<-(color_deseado ?c))(test (eq ?b ?c)))
=> (retract ?h1)(assert (color_deseado ?c ?a)))

(defrule patata 
(and (and(color_deseado $? ?a $?)(color_deseado $? ?b $?)) (test (eq ?a ?b )))=>(printout t ?a crlf))