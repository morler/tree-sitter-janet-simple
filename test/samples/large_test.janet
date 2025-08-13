# Large Janet test file for performance evaluation
# This file contains various Janet constructs to test parsing performance

# Function definitions
(defn fibonacci [n]
  "Calculate fibonacci number"
  (cond
    (<= n 1) n
    (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(defn factorial [n]
  "Calculate factorial"
  (if (<= n 1)
    1
    (* n (factorial (- n 1)))))

# Data structures
(def large-array @[
  1 2 3 4 5 6 7 8 9 10
  "string1" "string2" "string3" "string4" "string5"
  :keyword1 :keyword2 :keyword3 :keyword4 :keyword5
  true false nil
  #{:set1 :set2 :set3}
  {:table1 "value1" :table2 "value2"}])

(def nested-structure {
  :numbers [1 2 3 4 5 6 7 8 9 10]
  :strings ["hello" "world" "test" "janet" "language"]
  :nested {
    :level1 {
      :level2 {
        :level3 @{:deep "value"}
      }
    }
  }
  :unicode "测试Unicode字符串"
  :escaped "String with \n\t escapes \x41 \u4E2D"
})

# Loops and iterations
(for i 0 100
  (when (even? i)
    (print i)))

(loop [x :range [0 50]]
  (if (< x 25)
    (print "Small:" x)
    (print "Large:" x)))

# String processing
(defn process-strings [& strings]
  (map (fn [s]
    (string/upper
      (string/trim s))) strings))

# Mathematical operations
(def math-operations [
  (+ 1 2 3 4 5)
  (- 100 50 25)
  (* 2 3 4 5)
  (/ 120 2 3)
  (% 17 5)
  (math/pow 2 10)
  (math/sqrt 16)
  (math/sin math/pi)
  (math/cos 0)])

# Complex data manipulation
(def complex-data
  (->> (range 100)
       (map (fn [x] {:id x :value (* x x)}))
       (filter (fn [item] (even? (get item :id))))
       (take 20)
       (map (fn [item] (string "Item-" (get item :id))))))

# Pattern matching
(defn handle-value [x]
  (case (type x)
    :number (+ x 10)
    :string (string "Prefix-" x)
    :keyword (symbol x)
    :array (length x)
    :table (keys x)
    "unknown"))

# Macro usage
(defmacro when-let [binding & body]
  ~(let [,(first binding) ,(second binding)]
     (when ,(first binding)
       ,;body)))

# More complex structures for stress testing
(def stress-test-data
  (seq [i :range [0 1000]]
    {:index i
     :value (string "item-" i)
     :data @{:a i :b (* i 2) :c (* i 3)}
     :nested [i (+ i 1) (+ i 2)]
     :unicode (string "测试" i "项目")}))

# Long strings for testing
(def long-string
  (string/join 
    (seq [i :range [0 100]]
      (string "This is line " i " with some content\n"))
    ""))

# Buffer operations
(def test-buffer @"")
(buffer/push-string test-buffer "Hello ")
(buffer/push-string test-buffer "World ")
(buffer/push-string test-buffer "from ")
(buffer/push-string test-buffer "Janet!")

# PEG patterns (if supported)
(def simple-grammar
  ~{:main (* :word :space :word)
    :word (some :a)
    :space " "})

# Comments and documentation
## This is a comment block
## Testing various comment styles
# Single line comment
# Another single line comment

# Final complex expression
(let [result
      (->> stress-test-data
           (filter (fn [item] (even? (get item :index))))
           (map (fn [item] 
             (merge item {:processed true
                         :timestamp (os/time)})))
           (take 50))]
  (print "Processed" (length result) "items"))