(deftemplate barco
(slot tipo (default ?NONE)(allowed-symbols patrullera dragaminas fragata acorazado destructor portaaviones))
(slot estado (default indemne)(allowed-symbols indemne tocado hundido))
(multislot casillas (default ?NONE))
(slot tamanho)(type INTEGER)(allowed-integers 1 2 3 4) )
