(deftemplate familiares
(slot yo) 
(slot padre) 
(slot madre) 
(multislot hermanos) 
(multislot primos) 
(multislot tios) 
(multislot abuelos)
(multislot hijos))

(deffacts familia_perez
(familiares (yo carlos) (padre pepe) (madre juana) (hermanos Julio Maria))
)