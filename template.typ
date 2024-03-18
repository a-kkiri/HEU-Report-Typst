#let project(
  title: "",
  author: "",

  infos: (
  ),

  coverTable_display: true,
  outline_display: true,
  header_display: true,
  
  body
) = {

  // 文本和代码的字体
  let text_font = "Times New Roman"
  let code_font = "DejaVu Sans Mono"
  let title_font = "STXinwei"
  let songti = "SimSun"
  let heiti = "SimHei"

  let 字号 = (
    四号: 14pt, 小四: 12pt,
  )

  // 设置正文和代码的字体
  set text(font: (text_font, songti), size: 12pt, lang: "zh", region: "cn")
  show strong: it => {
    show regex("[\p{hani}\s]+"): set text(stroke: 0.3pt)
    it
  }
  show raw: set text(font: code_font, 10pt)

  // 设置文档元数据和参考文献格式
  set document(author: author, title: title)
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
      
      if elems != () {
        emph(elems.last().body) + h(1fr) + emph(title)
      }else{
        h(1fr) + emph(title)
      }
      
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
  set heading(numbering: "1.1 ")

  show heading: it => box(width: 100%)[
    #set text(font: (text_font, heiti))
    #if it.numbering != none { counter(heading).display() }
    #it.body
    #v(8pt)
  ]

  show heading.where(
    level: 1
  ): it => box(width: 100%)[
    #set heading(numbering: "一、")
    #set align(center)
    #v(4pt)
    #it
  ]

  // 配置公式的编号和间距
  set math.equation(numbering: "(1.1)")
  show math.equation: eq => {
    set block(spacing: 0.65em)
    eq
  }

  // Cover
  let underlineField(key, value) = [
    #set align(center + horizon)
    #set text(size: 字号.小四)
    #grid(
      columns: (80pt, 250pt),
      align(right + top)[
        #text(size: 字号.四号)[#key]
      ],
      grid(
        rows: (10pt, auto),
        row-gutter: 0.2em,
        value,
        line(length: 98%, stroke: 0.5pt)
      )
    )
    #v(12pt)
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
    #for i in infos{
      underlineField(i.key, i.value)
    } 
  ]
  
  if coverTable_display == true {
  block(width: 100%,height: 25%, spacing: 0pt)[
    #set align(center + horizon)
    #set text(size: 字号.小四)
    #table(
      columns: 425pt,
      rows: (35pt, 140pt),
      stroke: 0.5pt,
      align: left + horizon,

      [大作业成绩：], 
      table.cell(
        align: top,
        inset: (y: 12pt),
      )[任课教师评语：],
    )
  ]}

  pagebreak()

  counter(page).update(1)

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

  show raw.where(block: true): it => block(width: 100%, fill: luma(240), inset: 10pt, radius: 3pt, breakable: true)[#it]

  show ref: set text(orange)

  //show link: underline
  show link: set text(rgb("#007aff"))

  body
}