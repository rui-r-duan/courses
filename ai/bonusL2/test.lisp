;;; Test for Solution one
;;;
;;; Author: Rui Duan <rduan@lakeheadu.ca>
;;; Date: Sep 16, 2014

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
(ai.bonus:prop-query 'instance-of 'frosty *knowledge-base*)

;;; What is frosty made of?
(ai.bonus:prop-query 'made-of
		     (ai.bonus:prop-query 'instance-of 'frosty *knowledge-base*)
		     *knowledge-base*)
;=> SNOW

;;; Snowman is made of what?
(ai.bonus:prop-query 'made-of 'snowman *knowledge-base*)
;=> SNOW

;;; What is the temperature of snow?
(ai.bonus:prop-query 'temperature 'snow *knowledge-base*)
;=> COLD

;;; Water forms what?
(ai.bonus:reverse-prop-query 'form-of 'water *knowledge-base*)
;=> (SNOW ICE)

;;; What are the colors in the knowledge base?
(ai.bonus:property-values 'color *knowledge-base*)
;=> (WHITE CLEAR)