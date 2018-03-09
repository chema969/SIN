(deftemplate persona 
(slot nombre (type STRING)(default ?NONE))
(slot apellidos (type STRING)(default ?NONE)) 
(slot color-ojos (type SYMBOL)(default marron))
(slot altura(type FLOAT)(default 1.6))
(slot edad(type INTEGER)(default 30))
)


(deffacts personas_en_un_bar 
(persona (nombre "pepe") (apellidos "ramon"))
(persona (nombre "maria") (apellidos "DB"))
)


(defrule alguien (persona (nombre ?x) (apellidos ?y)) => (printout t ?x " " ?y crlf))