#import "@preview/classic-jmlr:0.7.0": jmlr

#let affls = (
  one: (
    department: "Department of Statistics",
    institution: "Ludwig-Maximilians-Universität",
    location: "Munich, Bavaria",
    country: "Germany"),
)

#let authors = (
  (name: "Ermanno Antonucci",
   affl: "one",
   email: "Er.Antonucci@campus.lmu.de"),
)

#let abstract = [Hello darlings]

#show: jmlr.with(
  title: [Effect of Racial Animus in Italian Elections],
  authors: (authors, affls),
  abstract: abstract,
  keywords: ("Google Trends", "Election Modelling", "Computational Social Sciences"),
  bibliography: bibliography("main.bib"),
  appendix: include "appendix.typ",
)

= Introduction

#set math.equation(numbering: none)  // There are no numbers in sample paper.

Here is a citation .

= Acknowledgments and Disclosure of Funding

All acknowledgements go at the end of the paper before appendices and
references. Moreover, you are required to declare funding (financial activities
supporting the submitted work) and competing interests (related financial
activities outside the submitted work). More information about this disclosure
can be found on the JMLR website.
