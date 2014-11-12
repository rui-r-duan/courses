(deftemplate person
  (slot name (type STRING))
  (slot age (type INTEGER))
  (slot height (type INTEGER))
  (slot gender (allowed-symbols male female)))
(deftemplate husband-of (slot husband) (slot wife))
(deftemplate father-of (slot father) (slot child))
(deftemplate wife-of (slot wife) (slot husband))
(deftemplate mother-of (slot mother) (slot child))
(deftemplate parent-of (slot parent) (slot child))
(deftemplate sister-of (slot sister) (slot sibling))
(deftemplate brother-of (slot brother) (slot sibling))
(deftemplate aunt-of (slot aunt) (slot nephew-or-niece))
(deftemplate uncle-of (slot uncle) (slot nephew-or-niece))
(deftemplate cousin-of (slot cousin-1) (slot cousin-2))
(deftemplate grandfather-of (slot grandfather) (slot grandchild))
(deftemplate grandmother-of (slot grandmother) (slot grandchild))
(deftemplate ancestor-of (slot ancestor) (slot person))

(deffacts family
  (person (name "A") (age 65) (gender male) (height 180))
  (person (name "B") (age 64) (gender female))
  (person (name "C") (age 63) (gender male))
  (person (name "D") (age 62) (gender female))
  (person (name "E") (age 61) (gender male))
  (person (name "F") (age 60) (gender female))
  (person (name "G") (age 49) (gender male))
  (person (name "H") (age 48) (gender female))
  (person (name "I") (age 47) (gender male))
  (person (name "J") (age 46) (gender female))
  (person (name "K") (age 45) (gender male))
  (person (name "L") (age 44) (gender female))
  (person (name "M") (age 43) (gender male))
  (person (name "N") (age 42) (gender female))
  (person (name "O") (age 41) (gender male))
  (person (name "P") (age 40) (gender female))
  (person (name "Q") (age 23) (gender male))
  (person (name "R") (age 22) (gender female))
  (person (name "S") (age 21) (gender female))
  (person (name "T") (age 20) (gender male))
  (person (name "U") (age 19) (gender male))
  (person (name "V") (age 22) (gender female))
  (person (name "W") (age 27) (gender male))
  (husband-of (husband "A") (wife "B"))
  (husband-of (husband "C") (wife "D"))
  (husband-of (husband "E") (wife "F"))
  (husband-of (husband "G") (wife "H"))
  (husband-of (husband "I") (wife "J"))
  (husband-of (husband "K") (wife "L"))
  (husband-of (husband "M") (wife "N"))
  (husband-of (husband "O") (wife "P"))
  (husband-of (husband "Q") (wife "R"))
  (husband-of (husband "W") (wife "V"))
  (father-of (father "A") (child "I"))
  (father-of (father "C") (child "J"))
  (father-of (father "C") (child "K"))
  (father-of (father "E") (child "L"))
  (father-of (father "E") (child "M"))
  (father-of (father "O") (child "W"))
  (father-of (father "G") (child "Q"))
  (father-of (father "I") (child "R"))
  (father-of (father "I") (child "S"))
  (father-of (father "I") (child "T"))
  (father-of (father "K") (child "U"))
  (father-of (father "K") (child "V")))

(defrule wife
  (husband-of (husband ?a) (wife ?b))
  =>
  (assert (wife-of (wife ?b) (husband ?a))))

(defrule mother
  (father-of (father ?f) (child ?c))
  (husband-of (husband ?f) (wife ?m)) ; (wife-of (wife ?m) (husband ?f)) is also OK, becuase CLIPS can do forward chaining automatically
  =>
  (assert (mother-of (mother ?m) (child ?c))))

(defrule parent
  (or (father-of (father ?a) (child ?c))
      (mother-of (mother ?a) (child ?c)))
  =>
  (assert (parent-of (parent ?a) (child ?c))))

(defrule sister
  (parent-of (parent ?p) (child ?a))
  (parent-of (parent ?p) (child ?b))
  (person (name ?a) (gender female))
  (test (not (eq ?a ?b)))
  =>
  (assert (sister-of (sister ?a) (sibling ?b))))

(defrule grandfather
  (father-of (father ?f) (child ?c))
  (parent-of (parent ?c) (child ?gc))
  =>
  (assert (grandfather-of (grandfather ?f) (grandchild ?gc))))

;;;----------------------------------------------------------------------------
;;; Find one's all grandfathers
;;;----------------------------------------------------------------------------
(defrule get-grandchild
  (declare (salience -100))
  (initial-fact)
  =>
  (printout t "Enter name of grandchild: ")
  (bind ?gs (read))
  (assert (grandchild ?gs)))

(defrule prnt-grandfather
  (grandchild ?gs)
  (grandfather-of (grandfather ?gf) (grandchild ?gs))
  =>
  (printout t ?gf crlf))
