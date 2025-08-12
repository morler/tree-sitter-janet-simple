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
如果安装了tree-sitter CLI：
```bash
tree-sitter generate
```

### 运行测试
如果安装了tree-sitter CLI：
```bash
tree-sitter test
```

### 运行单个测试文件
测试特定语法结构（如数字字面量）：
```bash
tree-sitter test test/corpus/num_lit.txt
```

### 解析文件示例
如果安装了tree-sitter CLI：
```bash
tree-sitter parse examples/example.janet
```

## 开发注意事项

- 生成的`src/`目录下的文件不应手动编辑
- 语法修改应在`grammar.js`中进行
- 新的测试用例应添加到`test/corpus/`目录
- 当前生成的解析器使用ABI 14
- 支持的文件类型：`.janet`, `.jdn`, `.cgen`

## 测试结构

测试文件使用Tree-sitter测试格式：
- `========...` 作为测试用例分隔符
- 测试代码后跟`----...`分隔符
- 预期的语法树结构用S表达式表示

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