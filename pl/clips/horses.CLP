(deftemplate horse
  (slot marked)
  (slot name)
  (slot owner)
  (slot price))

(deffacts knowledge-base
  (horse
    (marked no)
    (name Pebbles)
    (owner Paul_peeps)
    (price 300000))
  (horse
    (marked no)
    (name Gonzo)
    (owner Grace_Green)
    (price 100500)))

(defrule print-name "print out names of all horses"
  ?v <- (horse (marked no) (name ?name))
  =>
  (modify ?v (marked yes))
  (printout t "HORSE -- " ?name crlf))