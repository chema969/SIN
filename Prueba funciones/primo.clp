(deffunction primo(?a ?b)
  (if(or (not (integerp ?a) )(< ?b 1) )
  then FALSE
  else
   (if(and (= ?b 2) (neq (mod ?a ?b) 0)) 
    then TRUE
    else	
   (if (= (mod ?a ?b) 0 )
     then FALSE
    else 
	(primo ?a (- ?b 1)))
	)))