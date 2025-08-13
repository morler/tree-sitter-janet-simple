# 并发测试文件2 - 复杂嵌套结构
(def nested-structure
  {:level1 {:level2 {:level3 {:level4 {:level5 "deep nesting"}}}}
   :arrays [[1 2 [3 4 [5 6]]] [7 8 [9 10]]]
   :mixed-data [0xFF 0b101 8r777 "unicode测试" :keyword]})

(defn fibonacci [n]
  (if (<= n 1)
    n
    (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

@"buffer2 with\nescapes"