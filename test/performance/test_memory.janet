# Simple memory test file
# This contains basic structures to test memory allocation

(def complex-data
  {:numbers [1 2 3 4 5 6 7 8 9 10]
   :strings ["hello" "world" "janet" "programming"]
   :nested {:level1 {:level2 {:level3 "deep"}}}
   :arrays [[1 2] [3 4] [5 6] [7 8]]})

(defn recursive-function [n]
  (if (<= n 0)
    0
    (+ n (recursive-function (- n 1)))))

# Create some variability in parsing
@"buffer content here"
``long string content
with multiple lines
and various symbols``