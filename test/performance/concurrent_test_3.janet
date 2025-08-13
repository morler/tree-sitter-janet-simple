# 并发测试文件3 - Unicode和转义序列
(def 中文变量 "中文内容")
(def символьные "символы") 
(def シンボル "日本語")

# 复杂转义序列
(def escape-test "\\x41\\u0042\\U000043\\n\\r\\t")
(def unicode-escape "\\u4E2D\\u6587\\u6D4B\\u8BD5")

{:keys [:key1 :key2 :key3 :key4]
 :values ["value1" "value2" "value3" "value4"]}