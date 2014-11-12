(deffacts ESFact
  (ES gives soul to programs))
(defrule R-1
  (ES $?what)
  =>
  (printout t "$?what: " $?what crlf))
(defrule R-2
  (ES $?what)
  =>
  (printout t "?what: " ?what crlf))
(defrule R-3
  (ES ? $?what2)
  =>
  (printout t "$?what2: " $?what2 crlf))
(defrule R-4
  (ES $?)
  =>
  (printout t "$? mathes something!" crlf))