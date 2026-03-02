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

#let abstract = []

#show: jmlr.with(
  title: [Effect of Racial Animus in Italian Elections],
  authors: (authors, affls),
  abstract: abstract,
  keywords: ("Google Trends", "Election Modelling", "Computational Social Sciences"),
  bibliography: bibliography("main.bib"),
  appendix: include "appendix.typ",
)

= Introduction

Framing the political situation of Italy.
+ Frame the volatility,
+ Rise of far right movement,
+ Topic of immigration
+ Decrease in turnout
+ Role of Incumbency

= Motivation
+ Google data as proxy for socially sensitive attitudes,
+ Why is still relevant to the timeframe analyzed - before ChatGpt
+ Difference between the US context and the Italian context
+ Area limitation - possible improvements with rearranging (see "limitations")
+ Justification for the choice of the proxy

= Aggregate Model Justification - WT
+ Research Q: Capturing the vote flux from M5S party to right wing coalition
+ Vote share analysis among the right.
+ Doesn't account for incumbency
+ Including turnout

= Methodlogy
+ The model vote share model
+ The simplifying assumptions
+ The Dirichlet distribution + interpretation
+ How the parameters are estimated, modelling issues.
+ Structure of the final time regression
+ "treatment" variable

= Results
+ Aggregate model results
 - Mainly driven by incumbency
+ Disaggregate model results
 - Effect estimation/interpretation
 - Limitation with identifiability and model selection

= Conclusions
Limited interpretability due to contestable model assumptions, possible proposal for improvement:
 - more fine grained index,
 - More complex Dirichlet regression method (difficult to obtain convergence)
 - Beta regression

#set math.equation(numbering: none)  // There are no numbers in sample paper.

Here is a citation .

= Acknowledgments and Disclosure of Funding

All acknowledgements go at the end of the paper before appendices and
references. Moreover, you are required to declare funding (financial activities
supporting the submitted work) and competing interests (related financial
activities outside the submitted work). More information about this disclosure
can be found on the JMLR website.
