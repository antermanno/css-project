#import "@preview/classic-jmlr:0.7.0": jmlr

#let citeb(tag) = {
  cite(tag, form: "normal")
}

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

= The Italian Election
Framing the political situation of Italy.

In Europe, in the years following the Great Financial Crisis of 2008, it was possible to observe the rise of far-right parties across the continent #citeb(<lazaridis2016rise>). 
Italy was not exempt; parties such as "Lega Nord" (North League) and Fratelli D'Italia, rose through the polls and overtook the leadership role of the right wing coalition, previously held by Forza Italia - a Europeist, Atlantist, liberal center right party. FI dominated the Italian political scene since 1994, when the entrepreneur Silvio Berlusconi decided to enter politics. Campaining was run on the creation of the cult of personality of the party leader #citeb(<campus2006antipolitica>) NOTE.

\
After the slow fall of FI in the elections, the role of hegemonic leader of the italian right wing politics was first claimed by "Lega" former north separatist party. The new party leader Matteo Salvini restructured the party to have now a nationalist imprinting rather than a regionalist one #citeb(<albertazzi2018no>). By 2013 "Lega" was the oldest party in the parliament with presence in the territory, especially in economically relevant regions in the North, such as Piedmont, Lombardy and Veneto.
Salvini push towards a national dimension allowed the party to gain consensus in the regions of center italy, previously lead by the left and even in some of the southern regions, previously actively despised by the party. NOTE.
As one of the most storied parties, the by 2013 "Lega" had been part of government coalitions 4 NOTE times, Salvini framed the party as an outsider. Pushing anti establishment messaging (mainly criticising europe, as opposed to italy), while shifting the public debate on the topic of immigrants. Looking at google trends data (NOTE: ADD GRAPH) we can get an idea of how prevalent the topic was in italian public debate.

This pushed the league to be the leading party of the right. In 2018 they got the second most amount of seats in parliament (even tho they where the 3rd party by voteshare). 

\
Movimento 5 Stelle.

M5S was founded after 2008 by Italian comedian Beppe Grillo. The party advocated for direct democracy, informatization of politics and overall transparancy. This was a response to the numerous scandals that involved mainly silvio berlusconi. The leaders of the party said they were neither right nor left. The party created a dichotmization in "us" (the people) and "them" (the politicians, often referred to as "The Cast"). After the 2013 election, after a pretty succefull performance at the poll (Nth place NOTA), most of the inducted parliament members where not politicians by profession.

The party refused to form government coalitions,they remained at the opposition. That lead them to be the first party in the 2018 election. 

\
Fratelli 



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
