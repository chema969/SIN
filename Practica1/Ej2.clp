(deftemplate paciente
(slot nombre (type STRING))
(slot apellidos (type STRING))
(slot dni)
(slot seguro_medico))

(deftemplate visita
(slot id-visita)
(slot fecha)
(slot sintomas)
(slot pruebas)
(slot medicacion))

