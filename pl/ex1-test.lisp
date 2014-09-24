(load "unit-test")
(load "ex1")

(deftest test-prod-from-to ()
  (check
    (= (ex1.pl.ryan:prod-from-to 3 10) 1814400)
    (= (ex1.pl.ryan:prod-from-to 10 3) 1814400)
    (= (ex1.pl.ryan:prod-from-to 1 10) 3628800)
    (= (ex1.pl.ryan:prod-from-to 10 1) 3628800)
    (= (ex1.pl.ryan:prod-from-to -1 10) 0)
    (= (ex1.pl.ryan:prod-from-to 1 1) 1)
    (= (ex1.pl.ryan:prod-from-to -1 -1) -1)
    (= (ex1.pl.ryan:prod-from-to -10 -3) 1814400)
    (= (ex1.pl.ryan:prod-from-to -10 -2) -3628800)
    (= (ex1.pl.ryan:prod-from-to -2 -10) -3628800)))

(deftest test-sum-from-to ()
  (check
    (= (ex1.pl.ryan:sum-from-to 1 10) 55)
    (= (ex1.pl.ryan:sum-from-to 1 1) 1)
    (= (ex1.pl.ryan:sum-from-to 0 -1) -1) ; from larger to smaller
    (= (ex1.pl.ryan:sum-from-to 0 0) 0)
    (= (ex1.pl.ryan:sum-from-to -10 0) -55)
    (= (ex1.pl.ryan:sum-from-to -10 1) -54)))

(deftest test-ryan-count ()
  (check
    (equal (ex1.pl.ryan:ryan-count 10) '(1 2 3 4 5 6 7 8 9 10))
    (equal (ex1.pl.ryan:ryan-count 1) '(1))
    ; (equal (ex1.pl.ryan:ryan-count 0))  ; cannot be 0, will raise a condition (exception)
    (equal (ex1.pl.ryan:ryan-count 3) '(1 2 3))))

(deftest test-ryan-count-2 ()
  (check
    (equal (ex1.pl.ryan:ryan-count-2 10) '(1 2 3 4 5 6 7 8 9 10))
    (equal (ex1.pl.ryan:ryan-count-2 1) '(1))
    (equal (ex1.pl.ryan:ryan-count-2 0) nil) ; can be 0
    (equal (ex1.pl.ryan:ryan-count-2 3) '(1 2 3))))

(deftest test-ryan-list-length ()
  (check
    (equal (ex1.pl.ryan:ryan-list-length '(a b c)) 3)
    (equal (ex1.pl.ryan:ryan-list-length '(a)) 1)
    (equal (ex1.pl.ryan:ryan-list-length '()) 0)))

(deftest test-ryan-list-length-2 ()
  (check
    (equal (ex1.pl.ryan:ryan-list-length-2 '(a b c)) 3)
    (equal (ex1.pl.ryan:ryan-list-length-2 '(a)) 1)
    (equal (ex1.pl.ryan:ryan-list-length-2 '()) 0)
    (equal (ex1.pl.ryan:ryan-list-length-2 (loop for x from 1 to 999999 collect x)) 999999)))

(deftest test-p ()
  (check
    (equal (ex1.pl.ryan:p '(4 1 2 3)) 24)
    (equal (ex1.pl.ryan:p 'nil) 1)
    (equal (ex1.pl.ryan:p '(-2)) -2)
    (equal (ex1.pl.ryan:p '(3 5 9 28 -3552 0)) 0)))

(deftest test-flat ()
  (check
    (equal (ex1.pl.ryan:flat '(1 (2 (3 4 5) 6) 7)) '(1 2 3 4 5 6 7))
    (equal (ex1.pl.ryan:flat '(1 (2 (3 4 5) (6 5 (11 12))) 7 (88 99)))
	   '(1 2 3 4 5 6 5 11 12 7 88 99))))

(deftest test-bubble-sort-list ()
  (check
    (equal (ex1.pl.ryan:bubble-sort-list '(3 1 4 1 5 9 2 6 5))
	   '(1 1 2 3 4 5 5 6 9))))

(deftest test-ryan-sqrt ()
  (check
    (= (ex1.pl.ryan:ryan-sqrt 121.0) 11)
    (= (ex1.pl.ryan:ryan-sqrt 256.0) 16)))

(deftest test-ex1 ()
  (combine-results
    (test-prod-from-to)
    (test-sum-from-to)
    (test-ryan-count)
    (test-ryan-count-2)
    (test-ryan-list-length)
    (test-ryan-list-length-2)
    (test-p)
    (test-flat)
    (test-bubble-sort-list)
    (test-ryan-sqrt)))