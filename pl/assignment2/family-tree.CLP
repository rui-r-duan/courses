;;;----------------------------------------------------------------------------
;;; author: Rui Duan (0561866)
;;;----------------------------------------------------------------------------

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
(deftemplate sibling-of (slot sibling-1) (slot sibling-2))
(deftemplate aunt-of (slot aunt) (slot nephew-or-niece))
(deftemplate uncle-of (slot uncle) (slot nephew-or-niece))
(deftemplate cousin-of (slot cousin-1) (slot cousin-2))
(deftemplate grandfather-of (slot grandfather) (slot grandchild))
(deftemplate grandmother-of (slot grandmother) (slot grandchild))
(deftemplate ancestor-of (slot ancestor) (slot person))

(deffacts family
  (person (name "A") (age 65) (gender male) (height 180)) ; height in cm
  (person (name "B") (age 64) (gender female) (height 170))
  (person (name "C") (age 63) (gender male) (height 175))
  (person (name "D") (age 62) (gender female) (height 165))
  (person (name "E") (age 61) (gender male) (height 170))
  (person (name "F") (age 60) (gender female) (height 166))
  (person (name "G") (age 49) (gender male) (height 171))
  (person (name "H") (age 48) (gender female) (height 164))
  (person (name "I") (age 47) (gender male) (height 168))
  (person (name "J") (age 46) (gender female) (height 177))
  (person (name "K") (age 45) (gender male) (height 191))
  (person (name "L") (age 44) (gender female) (height 193))
  (person (name "M") (age 43) (gender male) (height 205))
  (person (name "N") (age 42) (gender female) (height 179))
  (person (name "O") (age 41) (gender male) (height 172))
  (person (name "P") (age 40) (gender female) (height 160))
  (person (name "Q") (age 23) (gender male) (height 158))
  (person (name "R") (age 22) (gender female) (height 156))
  (person (name "S") (age 21) (gender female) (height 167))
  (person (name "T") (age 20) (gender male) (height 166))
  (person (name "U") (age 19) (gender male) (height 178))
  (person (name "V") (age 22) (gender female) (height 162))
  (person (name "W") (age 27) (gender male) (height 178))
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

(defrule brother
  (parent-of (parent ?p) (child ?a))
  (parent-of (parent ?p) (child ?b))
  (person (name ?a) (gender male))
  (test (not (eq ?a ?b)))
  =>
  (assert (brother-of (brother ?a) (sibling ?b))))

(defrule grandfather
  (father-of (father ?f) (child ?c))
  (parent-of (parent ?c) (child ?gc))
  =>
  (assert (grandfather-of (grandfather ?f) (grandchild ?gc))))

(defrule grandmother
  (mother-of (mother ?m) (child ?c))
  (parent-of (parent ?c) (child ?gc))
  =>
  (assert (grandmother-of (grandmother ?m) (grandchild ?gc))))

(defrule aunt
  (parent-of (parent ?p) (child ?c))
  (sister-of (sister ?s) (sibling ?p))
  =>
  (assert (aunt-of (aunt ?s) (nephew-or-niece ?c))))

(defrule uncle
  (parent-of (parent ?p) (child ?c))
  (brother-of (brother ?b) (sibling ?p))
  =>
  (assert (uncle-of (uncle ?b) (nephew-or-niece ?c))))

(defrule sibling
  (or (sister-of (sister ?a) (sibling ?b))
      (brother-of (brother ?a) (sibling ?b)))
  =>
  (assert (sibling-of (sibling-1 ?a) (sibling-2 ?b))))

(defrule cousin
  (parent-of (parent ?a) (child ?x))
  (parent-of (parent ?b) (child ?y))
  (sibling-of (sibling-1 ?x) (sibling-2 ?y))
  =>
  (assert (cousin-of (cousin-1 ?x) (cousin-2 ?y))))

(defrule ancestor-1
  (parent-of (parent ?a) (child ?c))
  =>
  (assert (ancestor-of (ancestor ?a) (person ?c))))

(defrule ancestor-2
  (parent-of (parent ?x) (child ?z))
  (ancestor-of (ancestor ?z) (person ?y))
  =>
  (assert (ancestor-of (ancestor ?x) (person ?y))))

;;;----------------------------------------------------------------------------
;;; Find one's all grandfathers
;;;----------------------------------------------------------------------------
(defrule prnt-grandfather
  (grandchild ?gs)
  (grandfather-of (grandfather ?gf) (grandchild ?gs))
  =>
  (printout t ?gf " is " ?gs "'s grandfather." crlf))

;;;----------------------------------------------------------------------------
;;; Query about someone's age
;;;----------------------------------------------------------------------------
(deftemplate find (slot age))

(defrule query-property
  ?name-adr <- (name ?n)
  ?find-adr <- (find)
  (person (name ?n) (age ?value))
  =>
;  (retract ?name-adr ?find-adr)
  (printout t ?n "'s age is " ?value crlf))

;;;----------------------------------------------------------------------------
;;; flow control
;;;----------------------------------------------------------------------------

(defrule start
  =>
  (printout t crlf crlf crlf)
  (printout t "           ************************************" crlf)
  (printout t "           *  List of your choises            *" crlf)
  (printout t "           *      Choose one                  *" crlf)
  (printout t "           ************************************" crlf)
  (printout t "           * 1. add a member                  *" crlf)
  (printout t "           * 2. query someone's age           *" crlf)
  (printout t "           * 3. who are someone's grandfathers   *" crlf)
  (printout t "           * 4. display someone's mother's properties *" crlf)
  (printout t "           * 5. who's older than 20 and taller than 170? *" crlf)
  (printout t "           Your choice? ")
  (bind ?menu (read))
  (switch ?menu
    (case 1 then
      (assert (choice one)))
    (case 2 then
      (assert (choice two)))
    (case 3 then
      (assert (choice three)))
    (case 4 then
      (assert (choice four)))
    (case 5 then
      (assert (choice five)))
    (case 6 then
      (printout t crlf "stopping..." crlf)
      (halt))
    (default then
      (printout t crlf "What did you choose?" crlf)
      (reset)
      (run))))

(defrule one
  (choice one)
  =>
  (printout t crlf "Input name: ")
  (bind ?name (readline))
  (printout t crlf "Input age: ")
  (bind ?age (read))
  (printout t crlf "Input gender (female / male): ")
  (bind ?gender (read))
  (printout t crlf "Input height (cm): ")
  (bind ?height (read))
  (watch facts)
  (assert (person (name ?name) (age ?age) (gender ?gender) (height ?height)))
  (unwatch facts))

(defrule two
  (choice two)
  =>
  (printout t "Input the name of the person that you are going to query about: " crlf)
  (bind ?name (readline))
;  (printout t "Input the property that you are going to query: " crlf)
;  (bind ?prop (read))
  (assert (name ?name))
  (assert (find)))

(defrule three
  (choice three)
  =>
  (printout t "Enter name of grandchild: ")
  (bind ?gs (readline)) ; (readline) yields a STRING while (read) yields a symbol or numeric field instead of string, (read) and input "V" yields string "V"
  (assert (grandchild ?gs)))

(defrule four
  (choice four)
  =>
  (printout t crlf "Whose mother are you going to query? ")
  (bind ?child (readline))
  (assert (display-mother ?child)))

(defrule disp-mother
  ?adr <- (display-mother ?c)
  (mother-of (mother ?m) (child ?c))
  (person (name ?m) (age ?age) (gender ?gender) (height ?height))
  =>
  (retract ?adr)
  (printout t ?c "'s mother " ?m ": (age: " ?age "), (gender: " ?gender "), (height: "
              ?height ")" crlf))

(defrule five
  (choice five)
  (person (name ?a) (age ?age) (height ?h))
  (test (and (> ?age 20) (> ?h 170)))
  =>
  (printout t ?a " is older than 20 (" ?age ") and taller than 170 (" ?h ")." crlf))
