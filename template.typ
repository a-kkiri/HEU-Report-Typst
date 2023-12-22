#import "@preview/tablex:0.0.7": tablex, hlinex, vlinex, colspanx, rowspanx

#import "@preview/codelst:2.0.0": sourcecode, codelst

#let project(
  title: "",
  course_name: "",
  class_id: "",
  student_id: "",
  student_name: "",
  teacher_name: "",

  coverTable_display: true,
  outline_display: true,
  header_display: true,
  
  body
) = {

  // 文本和代码的字体
  let text_font = "Times New Roman"
  let song_font = "SimSun"
  let noto_serif_font = "Noto Serif CJK SC"
  let code_font = "DejaVu Sans Mono"
  let title_font = "STXinwei"

  let 字号 = (
    四号: 14pt, 小四: 12pt,
  )

  // 设置正文和代码的字体
  set text(font: (text_font, song_font), size: 12pt, lang: "zh", region: "cn")
  show strong: set text(font: (text_font, noto_serif_font), size: 11.3pt)
  show emph: set text(font: (text_font, noto_serif_font), size: 11.3pt)
  show raw: set text(font: code_font, 10pt)

  // 设置文档元数据和参考文献格式
  set document(author: student_name, title: title)
  set bibliography(style: "gb-7714-2015-numeric")

  // 设置页面
  set page(
    paper: "a4",
    margin: auto,

    header: locate(loc => {
      if header_display == false or loc.page() == 1{return}
      let footers = query(selector(<__footer__>).after(loc), loc)

      let elems = query(
        heading.where(level: 1).before(footers.first().location()), footers.first().location()
      )
      
      emph(elems.last().body) + h(1fr) + emph(title)
      
      v(-7pt)
      align(center)[#line(length: 105%, stroke: (thickness: 1pt, dash: "solid"))]
    }),

    footer: locate(loc =>{
      if loc.page() == 1 {return}
      [
        #align(center)[#counter(page).display("1 / 1",both: true,)]
        #label("__footer__")
      ]
    })
  )

  //设置标题
  set heading(numbering: "1.1")

  show heading: it => box(width: 100%)[
    #v(0.50em)
    #set text(font: noto_serif_font, weight: "bold")
    #if it.numbering != none { counter(heading).display() }
    #h(0.75em)
    #it.body
  ]

  show heading.where(
    level: 1
  ): it => box(width: 100%)[
    #v(0.5em)
    #set align(center)
    #set heading(numbering: "一")
    #it
    #v(0.75em)
  ]

  // 配置公式的编号和间距
  set math.equation(numbering: "(1.1)")
  show math.equation: eq => {
    set block(spacing: 0.65em)
    eq
  }

  // Cover
  let fieldname(name) = [
    #align(right + top)[
      #text(size: 字号.四号)[#name]
    ]
  ]

  let fieldvalue(value) = [
    #set align(center + horizon)
    #set text(size: 字号.小四)
    #grid(
      rows: (auto, auto),
      row-gutter: 0.2em,
      value,
      line(length: 95%, stroke: 0.5pt)
    )
  ]

  block(width: 100%, height: 15%, spacing: 0pt)[
    #set align(center + bottom)
    #box()[
      #image("figures/heu_title.png", width: 10.5cm, height: 1.4cm, fit: "stretch")
    ]
  ]

  block(width: 100%, height: 25%, spacing: 0pt)[
    #set align(center + horizon)
    #set text(size: 50pt)
    #text(font: title_font)[#title]
  ]

  block(width: 100%, height: 35%, spacing: 0pt)[
    #set align(center + horizon)
    #grid(
        columns: (80pt, 250pt),
        row-gutter: 2.2em,
        fieldname("课程名称:"),
        fieldvalue(course_name),
        fieldname(text("班") + h(2em) + text("级:")),
        fieldvalue(class_id),
        fieldname(text("学") + h(2em) + text("号:")),
        fieldvalue(student_id),
        fieldname(text("姓") + h(2em) + text("名:")),
        fieldvalue(student_name),
        fieldname("任课教师:"),
        fieldvalue(teacher_name),
    )
  ]
  
  if coverTable_display == true {
  block(width: 100%,height: 25%, spacing: 0pt)[
    #set align(center + horizon)
    #tablex(
      columns: 425pt,
      rows: (35pt, 35pt, 105pt),
      stroke: 0.5pt,
      align: left + horizon,
      auto-hlines: false,
      hlinex(),
      [#text(size: 字号.小四)[大作业成绩：]], 
      hlinex(),
      [#text(size: 字号.小四)[任课教师评语：]],
      [],
      hlinex(),
    )
  ]}

  pagebreak()

  // 显示目录
  if outline_display{
    outline(indent: auto)
    pagebreak()
  }

  // Main body
  set par(first-line-indent: 2em)
  set enum(tight:false, indent: 2em, body-indent: 8pt)
  set list(tight:false, indent: 2em, body-indent: 8pt)

  show figure: it => [
    #v(12pt)
    #it
    #par()[#text(size: 0.0em)[#h(0.0em)]]
    #v(-8pt)
  ]

  show image: it => [
    #it
    #v(-12pt)
    #par()[#text(size: 0.0em)[#h(0.0em)]]
  ]

  show figure.where(
    kind: raw
  ): it => {
    set block(width: 100%, breakable: true)
    it
  }

  // 配置行内代码块、行间代码块
  show raw.where(block: false): it => box(fill: luma(240), inset: (x: 2pt), outset: (y: 3pt), radius: 1pt)[#it]

  show raw.where(block: true): it => box(width: 100%, fill: luma(240), inset: 10pt, radius: 3pt)[#it]

  show: codelst(reversed: true)

  show ref: set text(orange)

  //show link: underline
  show link: set text(rgb("#007aff"))

  body
}