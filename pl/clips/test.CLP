(deftemplate person
	(slot name)
	(slot age)
	(slot eye-color)
	(slot hair-color))
(deffacts persons
	(person (name "John") (age 20))
	(person (name "Biggy") (eye-color blue)))