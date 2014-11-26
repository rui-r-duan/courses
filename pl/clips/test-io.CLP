(defrule to-start
  ;(phase choose-name)
  =>
  (printout t "Enter your name" crlf)
  (assert (your-name =(read)))) ; '=' is optional

;(defrule to-begin
;  =>
;  (printout t "Enter something: ")
;  (bind ?something (read))
;  (printout t "Your have entered " ?something crlf))