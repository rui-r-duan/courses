(defrule first
  =>
  (assert (fire second)))

(defrule second
  (fire second)
  =>
  (assert (fire third)))

(defrule third
  (fire third)
  =>)