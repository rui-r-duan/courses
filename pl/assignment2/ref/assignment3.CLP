(deftemplate father-of 	(slot father) 	(slot child))
(deftemplate mother-of 	(slot mother) 	(slot child))
(deftemplate parent-of  (slot parent)   (slot child))
(deftemplate sister-of  (slot sister) 	(slot sibling))
(deftemplate brother-of (slot brother) 	(slot sibling))
(deftemplate aunt-of    (slot aunt) 	(slot nephew-or-niece))
(deftemplate uncle-of   (slot uncle) 	(slot nephew-or-niece))
(deftemplate cousin-of  (slot cousin-1) (slot cousin-2))
(deftemplate grandfather-of (slot grandfather) (slot grandchild))
(deftemplate grandmother-of (slot grandmother) (slot grandchild))
(deftemplate grandparent-of (slot grandparent) (slot grandchild))
(deftemplate wife-of 	(slot wife) 	(slot husband))
(deftemplate husband-of (slot husband) 	(slot wife))
(deftemplate ancestor-of (slot ancestor)(slot person))
(deftemplate male 	(slot person))
(deftemplate female 	(slot person))

(deffacts family
  (father-of (father "Ajay") (child "Parth"))
  (father-of (father "Ajay") (child "Isha"))
  (mother-of (mother "Stela") (child "Parth"))
  (mother-of (mother "Stela") (child "Isha"))
  (wife-of (wife "Stela") (husband "Ajay"))
  (husband-of (husband "Ajay") (wife "Stela"))
  (male (person "Ajay"))
  (male (person "Parth"))
  (female (person "Stela"))
  (female (person "Isha"))
  (father-of (father "Birendra") (child "Stela"))
  (mother-of (mother "Sudha") (child "Stela"))
  (father-of (father "Birendra") (child "Rakesh"))
  (mother-of (mother "Sudha") (child "Rakesh"))
  (female (person "Sima"))
  (male (person "Rakesh"))
  (wife-of (wife "Sima") (husband "Rakesh"))
  (husband-of (husband "Rakesh") (wife "Sima"))
  
  (wife-of (wife "Isha") (husband "Maharshi"))
  (husband-of (husband "Maharshi") (wife "Isha"))
  (male (person "Maharshi"))
  (female (person "Sudha"))
  (male (person "Birendra"))
  (father-of (father "Ashwin") (child "Maharshi"))
  (mother-of (mother "Nalini") (child "Maharshi"))
  (male (person "Ashwin"))
  (female (person "Nalini"))
  (wife-of (wife "Nalini") (husband "Ashwin"))
  (husband-of (husband "Ashwin") (wife "Nalini"))
    
  (father-of (father "Rajnikant") (child "Ajay"))
  (father-of (father "Rajnikant") (child "Nilima"))
  (mother-of (mother "Jaywanti") (child "Ajay"))
  (mother-of (mother "Jaywanti") (child "Nilima"))
  (wife-of (wife "Jaywanti") (husband "Rajnikant"))
  (husband-of (husband "Rajnikant") (wife "Jaywanti"))
  (male (person "Ajay"))
  (male (person "Rajnikant"))
  (female (person "Jaywanti"))
  (female (person "Nilima"))

  (father-of (father "Kaushik") (child "Kruti"))
  (father-of (father "Kaushik") (child "Maitry"))
  (father-of (father "Kaushik") (child "Harsh"))
  (mother-of (mother "Nilima") (child "Kruti"))
  (mother-of (mother "Nilima") (child "Maitry"))
  (mother-of (mother "Nilima") (child "Harsh"))
  (wife-of (wife "Nilima") (husband "Kaushik"))
  (husband-of (husband "Kaushik") (wife "Nilima"))
  (male (person "Kaushik"))
  (male (person "Harsh"))
  (female (person "Kruti"))
  (female (person "Maitry"))
  (father-of (father "Ratanlal") (child "Kaushik"))
  (mother-of (mother "Gulab") (child "Kaushik"))
  (wife-of (wife "Gulab") (husband "Ratanlal"))
  (husband-of (husband "Ratanlal") (wife "Gulab"))
  (male (person "Ratanlal"))
  (female (person "Gulab"))
  (wife-of (wife "Kruti") (husband "Harshit"))
  (husband-of (husband "Harshit") (wife "Kruti"))
  (male (person "Harshit"))
  (father-of (father "Kirit") (child "Harshit"))
  (mother-of (mother "Amrita") (child "Harshit"))
  (male (person "Kirit"))
  (female (person "Amrita"))
  (wife-of (wife "Amrita") (husband "Kirit"))
  (husband-of (husband "Kirit") (wife "Amrita"))
)  

(defrule brother
(declare (salience 10))
(and(father-of (father ?dad) (child ?child1)) (mother-of (mother ?mom) (child ?child1)))
(and(father-of (father ?dad) (child ?child2)) (mother-of (mother ?mom) (child ?child2)))
(male (person ?child1))
(test(not (eq ?child1 ?child2)))

=>
(assert (brother-of (brother ?child1) (sibling ?child2)))
(printout t ?child1 " is brother of " ?child2 crlf))

(defrule sister
(declare (salience 9))
(and(father-of (father ?dad) (child ?child1)) (mother-of (mother ?mom) (child ?child1)))
(and(father-of (father ?dad) (child ?child2)) (mother-of (mother ?mom) (child ?child2)))
(female (person ?child1))
(test(not (eq ?child1 ?child2)))
=>
(assert (sister-of (sister ?child1) (sibling ?child2)))
(printout t ?child1 " is sister of " ?child2 crlf))



(defrule uncle1
(declare (salience 8))
(or (and (brother-of (brother ?child1) (sibling ?child2)) 
(father-of (father ?child2) (child ?chld3)))
(and (brother-of (brother ?child1) (sibling ?child2)) 
(mother-of (mother ?child2) (child ?chld3))))
=>
(assert (uncle-of (uncle ?child1) (nephew-or-niece ?chld3)))
(printout t ?child1 " is uncle of " ?chld3 crlf))

(defrule uncle2
(declare (salience 8))
(and (aunt-of  (aunt ?aunt1)(nephew-or-niece ?child))
(husband-of (husband ?uncle1)(wife ?aunt1)))
=>
(assert (uncle-of (uncle ?uncle1)(nephew-or-niece ?child)))
(printout t ?uncle1 " is uncle of " ?child crlf))

(defrule aunt1
(declare (salience 7))
(or (and (sister-of (sister ?child1) (sibling ?child2)) 
(father-of (father ?child2) (child ?chld3)))
(and (sister-of (sister ?child1) (sibling ?child2)) 
(mother-of (mother ?child2) (child ?chld3))))
=>
(assert (aunt-of (aunt ?child1) (nephew-or-niece ?chld3)))
(printout t ?child1 " is aunt of " ?chld3 crlf))

(defrule aunt2
(declare (salience 7))
(and (uncle-of  (uncle ?uncle1)(nephew-or-niece ?child))
(wife-of (wife ?aunt1)(husband ?uncle1)))
=>
(assert (aunt-of (aunt ?aunt1)(nephew-or-niece ?child)))
(printout t ?aunt1 " is aunt of " ?child crlf))


(defrule cousin
(declare (salience 6))
(or (and (brother-of (brother ?person1) (sibling ?person2))
(parent-of (parent ?person1) (child ?person3))
(parent-of (parent ?person2) (child ?person4)))
(and (sister-of (sister ?person1) (sibling ?person2))
(parent-of (parent ?person1) (child ?person3))
(parent-of (parent ?person2) (child ?person4))))
=>
(assert (cousin-of (cousin-1 ?person3) (cousin-2 ?person4)))
(printout t ?person3 " is cousin of " ?person4 crlf))


(defrule grandfather
(declare (salience 5))
(father-of (father ?person1) (child ?person2))
(parent-of (parent ?person2) (child ?person3))
=>
(assert (grandfather-of (grandfather ?person1) (grandchild ?person3)))
(printout t ?person1 " is grandfather of " ?person3 crlf))

(defrule grandmother
(declare (salience 5))
(mother-of (mother ?person1) (child ?person2))
(parent-of (parent ?person2) (child ?person3))
=>
(assert (grandmother-of (grandmother ?person1) (grandchild ?person3)))
(printout t ?person1 " is grandmother of " ?person3 crlf))

(defrule grandparent
(declare (salience 4))
(parent-of (parent ?person1) (child ?person2))
(parent-of (parent ?person2) (child ?person3))
=>
(assert (grandparent-of (grandparent ?person1) (grandchild ?person3)))
(printout t ?person1 " is grandparent of " ?person3 crlf))

(defrule ancestor
(declare (salience 3))
(or (parent-of (parent ?person1) (child ?person2))
(grandparent-of (grandparent ?person1) (grandchild ?person2)))
=>
(assert (ancestor-of (ancestor ?person2) (person ?person1)))
(printout t ?person1 " is ancestor of " ?person2 crlf))

(defrule parent 
(declare (salience 2))
(or (mother-of (mother ?person) (child ?chld))
(father-of (father ?person) (child ?chld)))
=>
(assert (parent-of (parent ?person) (child ?chld)))
(printout t ?person " is parent of " ?chld crlf))
