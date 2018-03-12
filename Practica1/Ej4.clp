(deftemplate familiares 
(slot padre) 
(slot madre) 
(multislot hermanos) 
(multislot primos) 
(multislot tios) 
(multislot abuelos)
(multislot hijos))

(deffacts familia_perez
(familiares (padre pepe) (madre juana) (hermanos 