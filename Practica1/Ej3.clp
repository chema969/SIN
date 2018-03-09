(deftemplate trayectos (slot origen) (multislot destino))

(deffacts vuelos
(trayectos (origen lisboa) (destino paris madrid))
(trayectos (origen madrid))
(trayectos (origen paris) (destino roma))
(trayectos (origen roma) (destino lisboa frankfurt))
(trayectos (origen estocolmo) (destino paris))
(trayectos (origen frankfurt) (destino estocolmo roma)))
