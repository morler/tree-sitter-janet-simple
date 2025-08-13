# Simple performance test file for comparison
(def numbers [1 2 3 4 5 6 7 8 9 10])

(defn factorial [n]
  (if (<= n 1)
    1
    (* n (factorial (- n 1)))))

(defn fibonacci [n]
  (if (<= n 1)
    n
    (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(def data 
  {:name "test"
   :values [1 2 3]
   :nested {:level1 {:level2 "deep"}}})

@"buffer content"

``long string
content here``

# Comments are ignored
(+ 1 2 3 4 5)