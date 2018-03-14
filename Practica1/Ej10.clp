(deftemplate alumno
(slot nombre(default ?NONE))
(slot apellido(default ?NONE))
(multislot notas_examenes(range 0.0 10.0))
(slot media_examenes(range 0.0 10.0))
(slot nombre_grupo)
)

(deftemplate grupo
(slot nombre_grupo)
(slot nombre_1)
(slot apellido_1)
(slot nombre_2)
(slot apellido_2)(slot nombre_3)
(slot apellido_3)(slot nombre_4)
(slot apellido_4)
(slot nota_trabajo) )
