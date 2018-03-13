(deftemplate coches 
(slot modelo)
(slot color)
(slot cantidad(type INTEGER))
(slot litros(type NUMBER))
(slot motor (type SYMBOL)(allowed-symbols diesel gasolina))
(slot puertas(type INTEGER)))

(deftemplate venta
(slot vendedor(type STRING))
(slot fecha) (slot modelo)
(slot cliente(type STRING)))

(deffacts Coches_stock 
(coches (cantidad 1) (modelo Clio) (litros 1.600) (motor gasolina) (puertas 3) (color azul))
(coches (cantidad 1) (modelo Clio) (motor diesel) (litros 1.800) (puertas 5) (color blanco))
(coches (cantidad 1) (modelo Megane) (motor diesel) (litros 1.800) (puertas 5) (color dorado))
(coches (cantidad 2) (modelo Megane) (motor gasolina) (litros 1.600) (puertas 5) (color gris))
(coches (cantidad 1) (modelo Laguna) (motor gasolina) (litros 2.000)(puertas 5)(color negro))
)

(deffacts Ventas 
(venta (vendedor "Juan Pérez") (modelo Megane ) (fecha 10/10/2003) (cliente "Esteban Losada"))
(venta (vendedor "Ana Ballester") (modelo Laguna) (fecha 13/10/2003) (cliente "Juan Cano"))
)

(defrule alguien (venta (vendedor ?x) (cliente ?y)) => (printout t ?x " vendio un coche a " ?y crlf))
(defrule cuantos_hay (coches (cantidad ?x) (motor ?y) (modelo ?z)) => (printout t "Hay " ?x " coches del modelo " ?z " y con el motor " ?y crlf))