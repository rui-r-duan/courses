(deffunction factorial (?X)
  (bind ?temp 1)
  (loop-for-count (?i 1 ?X) do
    (bind ?temp (* ?temp ?i)))
  (return ?temp))

(defrule example
  =>
  (printout t crlf crlf "N factorial: ")
  (bind ?N (read))
  (printout t "Factorial=" (factorial ?N) crlf))