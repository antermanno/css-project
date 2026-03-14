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
= Framing the political situation of Italy.

In Europe, in the years following the Great Financial Crisis of 2008, it was possible to observe the rise of far-right parties across the continent #citeb(<lazaridis2016rise>). 
Italy was not exempt; parties such as "Lega Nord" (North League) and Fratelli D'Italia, rose through the polls and overtook the leadership role of the right wing coalition, previously held by Forza Italia - a Europeist, Atlantist, liberal center right party.
FI dominated the Italian political scene since 1994, when the entrepreneur Silvio Berlusconi decided to enter politics. Campaining was run on the creation of the cult of personality of the party leader #citeb(<campus2006antipolitica>) NOTE.

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
Fratelli d'Italia

Fratelli d'Italia was founded before the 2013 election NOTE, as members left PDL - the great right wing coalition party led by berlusconi. The party remained marginal, with the exception of the region Lazio (of ROME) until the 2022 election. The party gained traction under the leadership of Giorgia Meloni (Italian PM at the time of writing). The party was one of the few party that remained in the opposition for the length of the 2018 2022 period. They honed in into European, Italian christian messaging.




== Frame the volatility,
Italy is a democratic parliamentary republic. The rules concerning electoral threshold still allows for small parties (\<3%) to have seats in both the Senate and the chambers of Deputees. This allows for a more fragmented political scenery. Where parties build temporary coalitions to support the government. This makes governance very unstable, and changes of governments are frequent. 



== Rise of far right movement,


== Topic of immigration
The public debate centered around the topic of migration from 2013 to 2018, mainly under the constant mediatic pressure by Salvini. While thinking on what the most appropriate metric for racial animus. However the prevalence of the topic leading to the 2022 elections decreased - possibly beacuse of covid-19 #citeb(<pasini2023issue>).
== Decrease in turnout
Another noticeable trend in italian elections is the stark decline in turnout. This is possibly due to loss of trust of the republican institution. People seeked to move away from traditional parties (PD, FI) and seek alternative that presented themselves as anti-system (M5S, FDI, LEGA). This phenomenon is already well observed at the time of the Roman Republic, (_homo novus_).

== Role of Incumbency

When we consider that most popular party by number of votes we can clearly see an alternating trends, historically (before 2013) mainly between the biggest left party and Berlusconi's party. This trend continued after, but each time with a new face on top. (NOTE: graph from wikipedia)
As elected parties and leaders spent political capital, consensus declines. That is why a lot of work in the paper went into being able to include incumbency in the modelling.

#figure(
  image("img/Italian_Elections_1994-2018.png"),
)


= Motivation

== Google data as proxy for socially sensitive attitudes,
The original paper #citeb(<salganik2020measuring>) tries to asses the impact of racial animus on Obama's electoral performance. In surveys, respondents tend to hide socially undesirable behaviours #citeb(<kreuter2008social>), such as racial animus; this is know as the social desirability bias. 
Therefore researchers are always in search of unbiased indirect measures for sensitive topics.
The proxy measure proposed by the author relies on the fact that people feel more free in front of a screen, reducing the social desirability bias.
The paper found that the effect of racial animus was up to 2 times more than NOTE what is was obatined with traditional methods. 
Google trends provides relative area values for search rate, obfuscated so that it is not possible to identify single users. 
These relative measurement are defined as follow:
NOTE: it looks horrible
$ "Racially Charged Search Rate"_j = ["Google searches including the word N"/"Total google searches"]_j/["Google searches including the word N"/"Total google searches"]_"max" $ 

Many studies found out that GSR correlate with people, quote paper.NOTE


== Why is still relevant to the timeframe analyzed - before ChatGpt
One concern regarding the use of google trends data is that nowadays most people replaced traditional search engines with LLMs. However the timeframe analyzed in this paper was before chatgpt market dominance. As of November 2022 NOTE, chatgpt had only 1mill users globally. Not enough to be a disruptive force in the market share of web searches in Italy.
==  Difference between the US context and the Italian context
In his case the treatment variable of a black candidate is self evident.
In the Italian context, however, the number of seats occupied by people of african descent can be counted on on hand (3 out of 600 in the current legislature). 
Even tho the black population in Italy consists of bareli 1mill, the topic has been central in recent Italian political history.
Especially since the newer right wing parties initiated a more aggressive and pervasive comunication thanks to the use of social media.
The second part of the paper focuses on analyzing the electoral effect of this more aggressive campaign, and try to capture wheter racial animus played a role in this shifting political trends.

== Area limitation - possible improvements with rearranging (see "limitations")
#cite(<salganik2020measuring>) uses media market as areas, as the people in said area are exposed to the same radio and tv content.
Italy doesn't have a strict equivalent, as the state broadcast is the same everywhere (NOTE CHECK), with the addition of local regional tv channel.
Also google search areas are neatly available only at regional level.
Ideally it would be possible to construct more granular areas for rcsr. That could be done convenientely at the release of google official api. See "limitations" NOTE
== Justification for the choice of the proxy
The search term used to compute the RCSR, is the Italian equivalent of the n-word, from here referred as WORD1. Using google's trend tool we can see that most correlated researches are a play cards company and some locations, and they still are weakly correlated to it.
That implies that most of the searches for the word are isolated and confounding uses of the word by the black population as an endearing term are absent or negligible in the italian context. 

= Data
The electoral data are from the government source #link("https://elezionistorico.interno.gov.it/")[_eligendo_] for elections. Data is available at comune level (town). With information about the candidated and the electoral list (coalition) they are running for.
The region Valle d'Aosta is excluded, as their data comes from a different sources due to administrative reasons.

+ camera and senato are very similar
+ people vote mainly for the list and rarely for the candidate.
+ Focus on the camera data.

The data is transformed such that proportion of votes is available at polling district level for the Chamber of Deputies.

= Aggregate Model Justification - WT <aggregate>
== Research Q: Capturing the vote flux from M5S party to right wing coalition
For the first question analyzed, we observe the right wing coalition votes as an aggregate. 
In 3 election cycle, the leading right wing party changed each time, however the overall perfomance of the coalition - that run together during the election - increases over time. 
Leading to the 2022 election M5S party lost a great amount of consensus. 
The party run on the premise of behing neither "right" nor "left", capturing in 2013 and 2018 the vote of people dissappointed in traditional parties or the establishment in general. 
We assumed that people disappointed in the party had 2 options, go back to their previous voting habits (right, left or center) or not-to vote.
Some of the voters must have come from a right wing background. With this aggregate model we try to capture the fraction of voters that turned their back on M5S and went back to the right. 
The model tries to capture wheter people that did that were driven by racial animosity. 
+ Vote share analysis among the right.
Graph the right wing parties.

#figure(
  image("img/alluvial_right.png"),
  caption: [Hello bob]
) <right-wing>

+ Doesn't account for incumbency
The model has the flaw of not accounting for incumbency.
Since the party of the right wing coalition are binded to run together only for the time of the elction, with the startegical decison o fgetting as many seats as possible. However once the seats are obtained there is no allegiance regarding the formation of goverment.

+ Including turnout
Analyzing the data we can clearly see that turnout is a very relevant factor in the elections. That is why is included as regressor at regional (observation) level.

= Methodlogy
== The vote share model
To model parties' characteristics more granurarly we choosed to use a multi-state agent-based model that assumes a herding behaviour, as in #cite(<kononovicius2017modeling>).
The following model was originally proposed by #cite(<kirman1993ants>), and it assumes that agents make their decisions based either on the perceived actractiveness of their options or due to peer-pressure, even when rational reasons to choose are lacking.
For the two states case, we choose to represent the transition probabilities as follows#footnote(
[The original model is defined in terms of the actractiveness parameter $sigma_1$ and the interaction strength between the two groups $h$.
Equation @transition1 looks as follows: $P(X -> X + 1) = (N-X)(sigma_1 + h X)Delta_t$. #cite(<kononovicius2017modeling>) ignores the temporal component, as it is not relevant in his case and introduces the rescaled time $t_s = h t$ and the rescaled actractiveness parameter $epsilon_i = sigma_i/h$. As in my NOTE case a temporal analysis is conducted, the theoretical stationary distribution is not necessarly a Beta and the parameter h should be considered. 
To keep the Beta distribution assumption valid from a theoretical standpoint, we discretize time at the three election dates and we assume that the rescaled actractiveness remain constant for the duration of one election cycle.]
) <note1>:

\
$ P(X -> X + 1) = (N - X)(epsilon_1 + X)Delta t_s $ <transition1>
$ P(X -> X - 1) = X (epsilon_2 + (N - X))Delta t_s $. 
\

Where $N$ is population size, $X$ is number of population mebers in category 1 and $epsilon_i$ is the actractiveness of category $i$.
At each moment in time the probability of switching to the other category depends on the number of members in both categories and the group specific actractiveness.

In the limit $N -> infinity$, the stationary distribution for the quantity $x = X/N$ - the proportion of members of category 1 - is the beta distribution $"Beta"(epsilon_1, epsilon_2) $
#citeb(<kononovicius2017modeling>).

The beta distribution density function...

The $epsilon_1$ parameter, actractiveness parameter in our framework, models the the expected value for $x$ and the concentration of the shares NOTE: graph with real examples.

When we generalize the model to more than two parties, underr the limit $N -> infinity$, the stationary distribution is a $"Dirichlet"(epsilon_1, epsilon_2, dots, epsilon_P)$. That is true only under the following assumptions#footnote([
The non binary state case of the model's transition probabilities look as follows:

\
$ P(X_i -> X_i + 1) = sum_(j != i) X_j (sigma_(j i) + h_(j i)X_i)Delta t, $   
$ P(X_i -> X_i - 1) = X_j sum_(j != i) (sigma_(i j) + h_(i j)X_j)Delta t. $
\

To get equations @multipos and @multineg we require that $sigma_(i j) = sigma_i $ and that $h_(i j) = h$, $forall i,j$. The validity of the simplyfing assumptions can be contested
(#cite(<kononovicius2017modeling>),  #cite(<deffuant2006comparing>)), especially (1.), that is explicitly contradicted in the aggregate model in section @aggregate. More details in the limitation section. ])<note2>:

+ the perceived actractiveness of a party doesn't doesn't depend on the party from which an agent comes from;
+ the interaction between agents is symmetric and independent of the current agent's party.

Under this assumption we can simplify the transition probabilities for each party to look as follows:
\
$ P(X_i -> X_i + 1) = (N - X_i)(epsilon_i + X_i)Delta t_s $ <multipos>

$ P(X_i -> X_i - 1) = X_i (epsilon_(-i) + N - X_i)Delta t_s $<multineg>.
\

Where $epsilon_(-i) = sum_(j!=i) epsilon_j$ is the sum of the actractiveness parameters for all other parties. The marginal distributions for the votes of each party is looks like a beta distributions. The joint is Dirichlet.


+ The Dirichlet distribution + interpretation
The dirichlet distribution is characterized by:

\
$ F(x) = "something" $ 
\

NOTE Look figure for interpretation NOTE (make graph with estimate with real parties and estimated alpha levels).




== How the parameters are estimated, modelling issues.
Ideally the independent variables that affect the $alpha_j$ would be jointly estimated through a Dirichlet regression. However, due to the time correlated nature of the data, there is the need to include correlated errors. 
However non bayesian routines for the estimation of dirichlet regression have not yet the degree of flexibility required to capture the requirements mixed effect required by the model. 

On the other end bayesian implementations of this model struggle with convergence and are computationally intensive due to the big size of the dataset.

For that reason the approach implemented in this paper, first estimates the $alpha$ coefficient of the dirichlet regression, and later regress linear mixed models on the $log(.)$ of the $alpha$.

In order to control for decrease in turnout, abstension is also modelled as a party. With its own alpha estimate to account for the actractiveness of the non voting option. The MMM model should reasonably apply to abstension.
If people around decide not to vote, I may also be encouraged to do the same. 
The final regression is not run on the $alpha_"abstention"$ as it makes no sense to define incumbency and other regressors for abstentions. 

== Structure of the final time regression

The estimates are performend across the three election cycles - 2013, 2018, 2022 - as this is the earliest of date for which all parties are present. For each year, the parameter vector of the dirichlet is estimated for each region. The final alpha estimates will have 3 indexes:
$ alpha_(t r p); t = "year"; r = "region", p = "party" $ 
For each region each year the vector $bold(alpha_(t r)) = (alpha_(t r 1), ..., alpha_(t r P))$ is estimated, where $P$ is the total number of parties modelled.

Note that also abstension (complement of turnout) is treated as a party, and is deemed to follow the same herding + actractiveness behaviour assumed for parties.

\
In the recond step the (log) $alpha$ are regressed on the following set of regressors using a mixed effect model.
$ log(alpha_(p r t)) = beta_0 + M_(t p) + "INC"_(t p) + gamma_(r p) + "RCSR"_(t r) times M_(t p) + epsilon_(p r t) $ 
$ epsilon  tilde N(bold(0), Sigma) $ 
NOTE check mixed model assumptions.


The variables are:
- $M_(t p)$ : "treatment" variable. When a right wing party switched to the more aggressive communication approach.
- $"INC"_(t p)$ : Binary variable representing wheter a party $p$ is incumbent in year $t$. It equals to 1 if the party partook in at least one government in the legislature leading to election in year $t$.
- $"RCSR"_(t r)$: the racially charged search rate by region $r$, in the time frame between year $t$ and $t - 1$. Year $t_(-1)$ is 2008.
- $gamma_((dots))$ represents the random effect for indexes $(...)$. 

Random intercept are included to account for party specific regional variation. As some party consistently perform better in certain region due to historical allegiances or effect of local government.



+ "treatment" variable
The binary variable $M_(t p)$ is included as to account for the effects of change in communication policy by the parties. What we are interested in looking at is the interaction effect of this variable with the RCSR, to capture wheter the policy improves electoral performances in racially more intense regions. RCSR is included only in the interaction effect as - due to the availability only at regional level - it's effect would be strongly confounded by the region effect. We assume the its non-interaction component of the effect is absorbed by the random effect $gamma_(r p)$.


= Results
+ Aggregate model results
 - Mainly driven by incumbency
+ Disaggregate model results
 - Effect estimation/interpretation
 - Limitation with identifiability and model selection

= Limitations
= Conclusions
This analysis has not found statistically significant effects of ratial animus on the most recent Italian elections.
The analysis doesn't claim any causal interpration. 

The author finds it difficult to justify all the assumptions that lead to the final analysis. 

First of assumption (1), required that the the actractiveness of a party doesn't depend on the party where an agent comes from. In the construction of the aggregate model in section NOTE, in order for the model to answer the research question, it is asuumed that the votes of the right wing coalition shift almost entirely among the coalition. This assumption is backed by observing the electoral trend and the details discussed in the aggregate model results section. Therefore there is no theoretical basis for assuming a Dirichlet stationary distribution, independently on how well the data are fit.

In #cite(<kononovicius2017modeling>), they use mixture of betas to model parties that have segregationist NOTE: reword: tendencies. While some of that tendencies are controlled for by the regional nature of the analysis, some of the in-region segregation is still not accounted for. See for example FDI in Trentino-Alto Adige - a region with a strong ethnical separation between the Italian and German speaking community - we can observe the effect on the mixture nature of the distributions. Same thing can be observed at national level for Lega (strong in the north) and M5S (more prevalent in the south). See graph NOTE: link graph, in the Appendix.

Check the error distribution shape of the alphas. Log NORMAL????

The RCSR score are available only at regional level. This severly limits the statistical power of the analysis. In #cite(<salganik2020measuring>), there are more than 200 areas for which the RCSR is available. To get more granular data it would be required to aggregate the scores and weight by region. However at the time of writing google is testing the new official api. Due to the time constraints of the project I decided to get manually get the data instead of waiting for the access granting. Once an official stable api is released is possible to run the aggregation of the numbers in a way that is simply too much work at the moment. 

In the time model, we have issue with the negative residuals in the 3rd year, as the shock in the party distribution of FDI was beyond what we have seen previously (possibly in the history of the Italian republic).

The "treatment" variable $M_(t p)$ is motivated by the political and mediatic perception of the author and there are no purely empirical justifications for it. It could be appropriate to run some sensitivity analysis and/or permutation to test the validity of the construct. 

It is difficult to identify a model, due to the limited number of data points. 

Sensitivity analysis of the google trend measure are not performed.

Many limitations can be addressed by a more granular availability of the google trends data. 

Limited interpretability due to contestable model assumptions, possible proposal for improvement:

 - more fine grained index,
 - More complex Dirichlet regression method (difficult to obtain convergence)
 - Beta regression

#set math.equation(numbering: none)  // There are no numbers in sample paper.

