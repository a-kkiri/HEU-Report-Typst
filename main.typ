#import "template.typ": *


#show: project.with(
  title: "课程设计",
  course_name: "XXXX",
  class_id: "xxxxxxxx",
  student_id: "xxxxxxxxxx",
  student_name: "X X X",
  teacher_name: "X X X",

  coverTable_display: true,
  outline_display: true,
  header_display: true,
)


= 模版简介

本模板适用于编写哈尔滨工程大学课程报告，默认页边距为 2.5cm，中文宋体，英文 Times New Roman，字号为 12pt（小四）。

默认模板文件由以下五部分组成：

#list(indent:2em, 
  [main.typ 主文件],
  [refs.bib 参考文献],
  [template.typ 文档格式控制，包括一些基础的设置、函数],
  [fonts 字体文件夹],
  [figures 图片文件夹],
)

= 使用说明

模版默认使用的字体包括 "SimSun（中易宋体）", "Noto Serif CJK（思源宋体）", "Times New Roman", "DejaVu Sans Mono"，如果想要在本地使用VSCode 进行预览，可能需要安装这些字体。

如果系统中没有安装这些字体或想更换其他字体，需要在模版中修改字体。

= 使用示例 <example>

== 特殊标记 <bug1>

你可以 Typst 的语法对文本进行特殊标记，我们为如下标记设定了样式：

+ *突出*

+ _强调_
+ 引用 @example
+ `raw text` 

=== 注意事项

由于 Typst 的语法， 如果你使用 `*本文*` 来标记突出，那么你需要在 `*` 前面加上一个空格，但这会导致你 *突出的文本* 前后附带一个空格，如果你#strong("不想要这个空格")，你可以使用 `#strong("本文")` 来代替。

在列表中使用 raw text 可能会导致不正确的显示，如 @bug2 中的列表。

raw text 中的中文字体可能较小，这是因为 Typst 无法为不同的中英文字体设置不同的字号，所以我们将中英文的字体设置为了相同的字号，这对于英文来说是合适的，但对于中文来说可能不合适。如`raw text: English 中文`。

== 图片

图片插入例：

#figure(
  image("./figures/heu_logo.png",  width: 60%),
  caption: [
    示例图片
  ],
)<img>

== 表格 <bug2>

本模板创建表格引入了 `tablex` 包，具体使用方法可以查看 #link("https://github.com/typst/packages/tree/main/packages/preview/tablex/0.0.7")[GitHub 页面]。

#figure(
  tablex(
    columns: (auto, auto),
    inset: 8pt,
    align: (x, y) => (center, left, left, left).at(y),
    [文件名], [说明],
    "main.typ", "主文件",
    "refs.bib", "参考文献",
    "template.typ", "文档格式控制，包括一些基础的设置、函数"
  ),
  caption: "示例表格"
)

== 公式

行内公式 $e^(i x) = cos x + i sin x$

行间公式：
$ e^(i x) = cos x + i sin x $

== 代码

行内代码例 `main()`。

#figure(caption: [代码块插入例])[#sourcecode(
```c
#include <stdio.h>
int main()
{
   // printf() 中字符串需要引号
   printf("Hello, World!");
   return 0;
}
```
)]

== 参考文献

使用 #cite(<HEU-report-typst>), 即可。

例如：此处使用参考文献 #cite(<0Isaac>)，此处使用参考文献 #cite(<2016The>)。

#bibliography("ref.bib")