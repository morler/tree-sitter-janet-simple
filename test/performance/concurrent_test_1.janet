# 并发测试文件1 - 基础语法结构
(def simple-data
  {:name "test1"
   :values [1 2 3 4 5]
   :functions [(fn [x] (+ x 1)) (fn [y] (* y 2))]})

(defn process-list [lst]
  (map (fn [x] (* x x)) lst))

@"buffer1"
``string content 1``