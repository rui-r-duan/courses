;;; Test for query.lisp
;;;
;;; Author: Rui Duan <rduan@lakeheadu.ca>
;;; Date: Sep 16, 2014

;;; TEST 1
(defparameter *knowledge-base*
  '((snow
     (form-of water) (hardness soft) (texture slippery) (color white)
     (temperature cold))
    (snowman
     (made-of snow))
    (frosty
     (instance-of snowman))
    (ice
     (temperature cold) (form-of water) (texture slippery) (hardness hard)
     (color clear))))

;;; Frosty is what?
(prop-query 'instance-of 'frosty *knowledge-base*)
;=> SNOWMAN

;;; What is frosty made of?
(prop-query 'made-of 'frosty *knowledge-base*)
;=> SNOW

;;; Snowman is made of what?
(prop-query 'made-of 'snowman *knowledge-base*)
;=> SNOW

;;; What is the temperature of snow?
(prop-query 'temperature 'snow *knowledge-base*)
;=> COLD

;;; Water forms what?
(reverse-prop-query 'form-of 'water *knowledge-base*)
;=> (SNOW ICE)

;;; What are the colors in the knowledge base?
(property-values 'color *knowledge-base*)
;=> (WHITE CLEAR)

;;; TEST 2
(defparameter *animal-kb*
  '((reptile (is-a animal))
    (mammel (is-a animal) (has-part head))
    (elephant (is-a mammel) (color grey))
    (clyde (instance-of elephant) (color pink))
    (nellie (instance-of elephant))))

;;; What color is clyde?
(prop-query 'color 'clyde *animal-kb*)
;=> PINK

;;; What color is nellie?
(prop-query 'color 'nellie *animal-kb*)
;=> GREY

;;; What part does clyde have?
(prop-query 'has-part 'clyde *animal-kb*)
;=> HEAD

;;; Who has head?
(reverse-prop-query 'has-part 'head *animal-kb*)
;=> (MAMMEL)
;;; Currently, reverse-prop-query cannot handle inheritance
