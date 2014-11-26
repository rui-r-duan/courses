(deffacts numbers
  (number 56)
  (number -32)
  (number 7)
  (number 96)
  (number 24))

(defrule find-largest-number
  (number ?x)
  (not (number ?y &: (> ?y ?x)))
  =>
  (printout t "Largest number is " ?x crlf))