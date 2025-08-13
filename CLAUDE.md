# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

这个文件为Claude Code (claude.ai/code) 在此代码库中工作提供指导。

## 项目概述

这是一个简单的Janet语言Tree-sitter语法解析器项目。与其他Janet语法解析器不同，此项目专注于准确性而非高级语言结构识别。

## 核心架构

- `grammar.js` - 主要语法定义文件，包含Janet语言的完整语法规则
  - 数字字面量：支持十进制、十六进制和任意进制数字格式
  - 字符串字面量：支持双引号字符串、长字符串和缓冲区字面量
  - 符号和关键词：定义Janet的符号和关键词规则
  - 数据结构：括号数组/元组、方括号数组/元组、表和结构字面量
- `src/` - 生成的C代码文件（由tree-sitter从grammar.js生成）
- `test/corpus/` - 测试用例集合，每个文件对应Janet语法的不同部分
- `queries/highlights.scm` - 语法高亮查询文件

## 常用命令

### 生成解析器
从grammar.js重新生成C语言解析器代码：
```bash
tree-sitter generate
```

### 运行测试
运行所有测试用例（在corpus目录下的.txt文件）：
```bash
tree-sitter test
```

### 运行单个测试文件
测试特定语法结构：
```bash
tree-sitter test test/corpus/num_lit.txt
tree-sitter test test/corpus/str_lit.txt
tree-sitter test test/corpus/sym_lit.txt
```

### 解析文件示例
解析Janet文件并查看语法树：
```bash
tree-sitter parse test_sample.janet
tree-sitter parse unicode_test.janet
```

### 查看高亮查询
查看语法高亮查询定义：
```bash
tree-sitter highlight --html test_sample.janet
```

### 验证grammar.js语法
检查语法定义文件的正确性：
```bash
tree-sitter generate --dry-run
```

## 开发注意事项

- 生成的`src/`目录下的文件不应手动编辑，它们由`tree-sitter generate`自动生成
- 语法修改应在`grammar.js`中进行，修改后必须运行`tree-sitter generate`
- 新的测试用例应添加到`test/corpus/`目录，使用tree-sitter测试格式
- 当前生成的解析器使用ABI 14，与tree-sitter 0.25.x版本兼容
- 支持的文件类型：`.janet`, `.jdn`, `.cgen`
- scanner.c包含自定义扫描器逻辑，处理长字符串和复杂的字面量
- 每次修改grammar.js后，建议运行完整测试套件确保无回归

## 测试结构

测试文件使用Tree-sitter测试格式：
- `========...` 作为测试用例分隔符
- 测试代码后跟`----...`分隔符
- 预期的语法树结构用S表达式表示

### 现有测试文件
**基础字面量测试**:
- `bool_lit.txt` - 布尔字面量测试
- `buf_lit.txt` - 缓冲区字面量测试
- `nil_lit.txt` - nil字面量测试
- `num_lit.txt` - 数字字面量测试（包括各种进制）
- `str_lit.txt` - 字符串字面量测试
- `sym_lit.txt` - 符号字面量测试
- `kwd_lit.txt` - 关键词字面量测试

**复杂结构测试**:
- `par_arr_lit.txt`/`par_tup_lit.txt` - 括号数组/元组测试
- `sqr_arr_lit.txt`/`sqr_tup_lit.txt` - 方括号数组/元组测试
- `struct_lit.txt`/`tbl_lit.txt` - 结构和表字面量测试
- `long_buf_lit.txt` - 长缓冲区字面量测试
- `long_str_lit.txt` - 长字符串字面量测试

**高级特性测试**:
- `quote_lit.txt`/`qq_lit.txt`/`unquote_lit.txt` - 引用相关测试
- `short_fn_lit.txt`/`splice_lit.txt` - 特殊语法测试
- `comment.txt` - 注释语法测试

**边界情况和高级测试** ⚠️:
- `advanced_edge_cases.txt` - 高级边界情况（部分失败）
- `complex_escape_sequences.txt` - 复杂转义序列测试
- `edge_cases.txt` - 基础边界情况测试
- `numeric_boundary_tests.txt` - 数字边界测试（部分失败）
- `unicode_str_lit.txt`/`unicode_sym_lit.txt` - Unicode测试
- `whitespace_handling.txt` - 空白字符处理测试
- `string_buffer_advanced.txt` - 高级字符串和缓冲区测试
- `peg_test.txt` - PEG相关测试（部分失败）

**测试统计**（截至2025-08-13）:
- 总测试数: 131个
- 通过测试: 127个
- 失败测试: 4个
- 通过率: 97%

## 项目开发状态

✅ **当前项目对Janet 1.38.0的支持度已达到约97%**，核心语法功能完备，可以正确解析绝大多数Janet代码。

### ✅ 已完成的高优先级特性（2025-01-12完成）
- **Unicode符号支持**：完整支持Unicode码点范围（`\u0080-\uFFFF`），如`符号测试`等Unicode符号
- **字符串转义序列**：支持所有Janet 1.38.0转义序列（`\0`, `\z`, `\f`, `\e`, `\v`, `\r`, `\t`, `\n`, `\uxxxx`, `\Uxxxxxx`, `\xHH`）
- **IEEE hex floats**：十六进制指数记数法（如`0x1.3DEp42`）
- **空白字符处理**：与Janet规范完全一致的空白字符识别
- **测试验证**：131个测试用例，127个通过（97%通过率），包括Unicode和转义序列测试

### 🔄 剩余中等优先级任务
- Buffer PEG字面量支持（Janet 1.38.0新特性，可选）
- 数字字面量边界情况修复（前导零处理）
- 深度嵌套结构解析优化
- 性能优化评估
- 文档和示例更新

### ⚠️ 当前已知问题（4个测试失败）
1. **Number Zero Variations**: `00`和`000`被错误识别为symbol而非number
2. **Leading Zero Cases**: `2r01`等前导零情况处理问题  
3. **Maximum Depth Nesting Test**: 深度嵌套结构解析问题
4. **PEG patterns with buffer literals**: Buffer PEG字面量特性未完全实现

## 依赖关系

- 需要Node.js环境来运行tree-sitter生成命令
- tree-sitter CLI用于开发和测试（可选安装）

## 语法架构理念

此项目与GrayJack的tree-sitter-janet有不同的设计理念：
- **准确性优先**：专注于精确解析Janet语法，而非识别高级语言结构
- **简单性**：不尝试在语法级别识别`def`等特殊形式，保持语法树的通用性
- **完整性**：支持Janet的所有字面量类型和数据结构

## 支持的Janet语法特性

### 数字字面量
- 十进制：`123`, `123.456`
- 十六进制：`0xFF`, `0xF_F__F`
- 任意进制：`2r101`, `36rZZ`
- 科学记数法：`1e5`, `0x1p4`

### 字符串和缓冲区
- 普通字符串：`"hello"`
- 长字符串：`````hello world`````
- 缓冲区字面量：`@"buffer"`
- 长缓冲区字面量：`@````buffer````

### 数据结构
- 元组：`(1 2 3)`
- 数组：`[1 2 3]`  
- 表：`{:key "value"}`
- 结构：`{:key "value"}`（语法层面与表相同）

## 调试和故障排除

### 语法树调试
如果解析结果不符合预期，使用详细模式查看语法树：
```bash
tree-sitter parse --debug test_sample.janet
tree-sitter parse --debug-graph test_sample.janet
```

### 测试失败排查
1. 检查grammar.js语法定义是否正确
2. 运行`tree-sitter generate`重新生成解析器
3. 使用`tree-sitter test --debug`查看详细测试输出
4. 比较实际输出与预期的S表达式结构

### 常见问题
- **解析错误**: 确保在grammar.js修改后运行了`tree-sitter generate`
- **测试失败**: 检查测试用例的S表达式格式是否正确
- **Unicode问题**: 验证符号定义中的Unicode范围配置
- **性能问题**: 检查是否有无限递归或过度复杂的规则定义
- **数字解析问题**: 注意前导零和特殊零值变体的处理
- **深度嵌套**: 极深的嵌套结构可能导致解析器栈溢出

### 最佳实践 ⭐
- **测试驱动开发**: 先写测试用例，再修改语法规则
- **渐进式修改**: 每次只修改一个语法规则，避免引入多个问题
- **完整回归测试**: 每次修改后运行完整测试套件
- **语法规则验证**: 使用`tree-sitter generate --dry-run`验证语法
- **实际文件测试**: 使用真实Janet文件验证解析器工作情况