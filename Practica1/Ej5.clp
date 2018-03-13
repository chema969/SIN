(deftemplate libros 
(multislot autor(type STRING))
(slot nombre (type STRING))
(slot año (type INTEGER))
(slot editorial (type STRING))
(slot edicion(type INTEGER)))

(deffacts bibliografia_sin
(libros (autor "Mira, J." "Delgado, A. E." "Boticario, J. G." "Díez, F. J") (nombre "Aspectos Básicos de la Inteligencia Artificial") (editorial "Sanz y Torres") (año 1995))
(libros (autor "Galán, S. F." "Boticario, J. G." "Mira, J.")(nombre "Problemas Resueltos de Inteligencia Artificial Aplicada: Búsqueda y Representación") (editorial "Addison-Wesley Iberoamericana S. A.")(año 1998))
(libros (autor "Rich, E." "Knight, K.") (nombre "Inteligencia Artificial") (edicion 2) (editorial "McGraw-Hill Interamericana") (año 1994)))

(defrule libreria (libros (autor ?x ?y) (nombre ?z)) => (printout t "El libro " ?z " tiene 2 autores y son " ?y " y " ?x crlf))