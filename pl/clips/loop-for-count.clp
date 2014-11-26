(defrule factorial
  =>
  (printout t crlf crlf "Enter a number: ")
  (bind ?N (read))
  (bind ?temp 1)
  (loop-for-count (?i 1 ?N) do
    (bind ?temp (* ?temp ?i)))
  (printout t "Factorial=" ?temp crlf))