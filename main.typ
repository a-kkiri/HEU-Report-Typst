#import "template.typ": *


#show: project.with(
  title: "课程设计",
  author: "X X X",
  
  infos: (
    (key: "课程名称:", value: "XXXX"),
    (key: "班        级:", value: "xxxxxxxx"),
    (key: "学        号:", value: "xxxxxxxxxx"),
    (key: "姓        名:", value: "X X X"),
    (key: "任课教师:", value: "X X X"),

  ),

  coverTable_display: true,
  outline_display: true,
  header_display: true,
)


= 模版简介

本模板适用于编写哈尔滨工程大学课程报告，默认页边距为 2.5cm，中文宋体，英文 Times New Roman，字号为 12pt（小四）。

默认模板文件由以下五部分组成：

#list(
  [main.typ 主文件],
  [refs.bib 参考文献],
  [template.typ 文档格式控制，包括一些基础的设置、函数],
  [fonts 字体文件夹],
  [figures 图片文件夹],
)

= 使用说明

模版默认使用的字体包括 "SimSun（中易宋体）", "Times New Roman", "DejaVu Sans Mono"，如果想要在本地使用VSCode 进行预览，可能需要安装这些字体。

如果系统中没有安装这些字体或想更换其他字体，请在 `template.typ` 中修改字体。

= 使用示例 <example>

== 特殊标记 <bug1>

你可以 Typst 的语法对文本进行特殊标记，我们为如下标记设定了样式：

#enum(
  [*突出*],
  [_emph 强调_],
  [引用 @example],
  [`raw text`] 
)

=== 注意事项

由于 Typst 的语法， 如果你使用 `*本文*` 来标记突出，那么你需要在 `*` 前面加上一个空格，但这会导致你 *突出的文本* 前后附带一个空格，如果你#strong("不想要这个空格")，你可以使用 `#strong("本文")` 来代替。

== 图片

图片插入例：

#figure(
  image("./figures/heu_logo.png",  width: 60%),
  caption: [
    示例图片
  ],
)<img>

== 表格 <bug2>

表格有助于数据的整理与展示。Typst 支持使用 `table` 来插入表格，详见 #link("https://typst.app/docs/reference/model/table/")[typst/docs/table]。下面是一些表格插入的示例：

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [], [*Area*], [*Parameters*],
    ),
    [*Cylinder*],
    [$pi h (D^2 - d^2) / 4$],
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],
    [*Tetrahedron*],
    [$sqrt(2) / 12 a^3$],
    [$a$: edge length]
  ),
  caption: "示例表格"
)

#figure(
  table(
    columns: 4,
    align: center + horizon,
    stroke: none,
    table.hline(),
    table.header(
      table.cell(rowspan: 2, [*Names*]), 
      table.cell(colspan: 2,[*Properties*],),
      table.hline(stroke: 0.6pt),
      table.cell(rowspan: 2, [*Creators*]),
      [*Type*], [*Size*],
      
    ),
    table.hline(stroke: 0.4pt),
    [Machine], [Steel], [5 $"cm"^3$], [John p& Kate],
    [Frog], [Animal], [6 $"cm"^3$], [Robert],
    [Frog], [Animal], [6 $"cm"^3$], [Robert],
    table.hline()
  ),
  caption: "示例表格"
)

== 公式

Typst 可以使用 Typst 原生语法插入公式，参考 #link("https://typst.app/docs/reference/math/")[typst/docs/math]。下面是一些公式插入的示例：

首先是行内公式，例如 $a^2 + b^2 = c^2$。行内公式使用 `$$` 包裹，公式和两端的 `$$` 之间没有空格。

其次是行间公式，例如：$ integral.triple_(Omega)\(frac(diff P, diff x) + frac(diff Q, diff y) + frac(diff R, diff z)\)d v = integral.surf_(Sigma)P d y d z + Q d z d x + R d x d y $ 式（1）是高斯公式。行间公式使用 `$$` 环境包裹，公式和两端的 `$$` 之间至少有一个空格。

公式内可以使用换行符 `\` 换行。若需要对齐，每行可以包含一个或多个对齐点 `&` 对其进行对齐。例如：
$ sum_i b_i &= sum_i sum_(h,j != i) frac(sigma_(h j) (i), sigma_(h j)) \ &= sum_(h != j) frac(1, sigma_(h j)) sum_(i != h,j) sigma_(h j)(i) $ `&` 是对齐的位置，`&` 可以有多个，但是每行的个数要相同。

矩阵输入示例：
$ A = mat(
  a_(1 1), a_(1 2), ..., a_(1 n);
  a_(2 1), a_(2 2), ..., a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), ..., a_(n n);
) $ \


分段函数可以使用 `case` 环境：
$ f\(x\)= cases(
  0 #h(1em) x text("为无理数,") ,
  1 #h(1em) x text("为有理数.") 
) $
假如公式里面有个别文字，需要把这部分放在 text 环境里面,即 `text[文本内容]` 。

如果公式中有个别需要加粗的字母，可以使用 `bold()` 进行加粗。如，$alpha a bold(alpha a)$。

以上仅为一些简单的公式示例，更多的公式使用方法可以查看 #link("https://typst.app/docs/reference/math/")[typst/docs/math]

另外，如果需要插入 LaTeX 公式可以使用外部包 #link("https://typst.app/universe/package/mitex")[mitex]。

== 代码

行内代码例 `main()`。

#figure(
```c
#include <stdio.h>
int main()
{
   // printf() 中字符串需要引号
   printf("Hello, World!");
   return 0;
}
```,
  caption: [代码块插入例]
)

== 参考文献

使用 #cite(<HEU-report-typst>), 即可。

例如：此处使用参考文献 #cite(<0Isaac>)，此处使用参考文献 #cite(<2016The>)。

#bibliography("ref.bib")