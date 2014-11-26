(deffacts family
    (father philip charles)
    (mother liz charles)
    (father charles wills)
    (father charles eddy)
    (mother diana wills)
    (mother diana eddy)
    (father james diana))

(defrule parent
    (or (mother ?p ?c) (father ?p ?c))
    =>
    (assert (parent ?p ?c)))

(defrule grandfather
    (father ?f ?c)
    (parent ?c ?gc)
    =>
    (assert (grandfather ?f ?gc)))

(defrule getgrandchild
    (declare (salience -100))
    (initial-fact)
    =>
    (printout t "Enter name of grandchild : ")
    (bind ?gs (read))
    (assert (grandchild ?gs)))

(defrule prntgrandfather
    (grandchild ?gs)
    (grandfather ?gf ?gs)
    =>
    (printout t ?gf crlf))
