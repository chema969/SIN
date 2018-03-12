(deftemplate coches 
(slot nombre(type STRING))
(slot color)
(slot cantidad(type INTEGER))
(slot litros(type NUMBER))
(slot motor (type SYMBOL)(allowed-symbols diesel gasolina))
(slot puertas(type NUMBER)))

(deftemplate venta
(slot vendedor(type STRING))
(slot fecha) (slot modelo)
(slot cliente(type STRING)))

