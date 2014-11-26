(deffacts basla
  (phase check-continue))

(defrule continue-check
  ?phase-adr <- (phase check-continue)
  =>
  (retract ?phase-adr)
  (printout t "Continue (yes/no)? ")
  (bind ?answer (read))
  (while (and (neq ?answer yes) (neq ?answer no)) do
    (printout t "Invalid answer, continue (yes/no)? ")
    (bind ?answer (read)))
  (if (eq ?answer yes)
   then (assert (phase continue))
   else (halt)))