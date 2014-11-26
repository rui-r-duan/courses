(deffacts myfact
  (loop-fact))

(defrule simple-loop
  ?old-fact <- (loop-fact)
  =>
  (printout t "Looping!" crlf)
  (retract ?old-fact)
  (assert (loop-fact)))
