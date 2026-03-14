// cite things in bracketed form
#let citeb(tag) = {
  cite(tag, form: "normal")
}
// coloring things in red
#let colred(x) = text(fill: rgb("#fe624f"), $#x$)

#set page(numbering: "1.")
#set math.equation(numbering: "(1)")  // There are no numbers in sample paper.
#set heading(numbering: "1.")

#title[TEST UNSET]

= The Italian Election
= Framing the political situation of Italy.
In Europe, in the years following the Great Financial Crisis of 2008, it was possible to observe the rise of far-right parties across the continent #citeb(<lazaridis2016rise>). 
Italy was not exempt; parties such as "Lega Nord" (North League) and Fratelli D'Italia, rose through the polls and overtook the leadership role of the right wing coalition, previously held by Forza Italia - a Europeist, Atlantist, liberal center right party.
FI dominated the Italian political scene since 1994, when the entrepreneur Silvio Berlusconi decided to enter politics. Campaining was run on the creation of the cult of personality of the party leader #citeb(<campus2006antipolitica>) NOTE.

\
After the slow fall of FI in the elections, the role of hegemonic leader of the italian right wing politics was first claimed by "Lega" former north separatist party. The new party leader Matteo Salvini restructured the party to have now a nationalist imprinting rather than a regionalist one #citeb(<albertazzi2018no>). By 2013 "Lega" was the oldest party in the parliament with presence in the territory, especially in economically relevant regions in the North, such as Piedmont, Lombardy and Veneto.
Salvini push towards a national dimension allowed the party to gain consensus in the regions of center italy, previously lead by the left and even in some of the southern regions, previously actively despised by the party. NOTE.
As one of the most storied parties, the by 2013 "Lega" had been part of government coalitions 4 NOTE times, Salvini framed the party as an outsider. Pushing anti establishment messaging (mainly criticising europe, as opposed to italy), while shifting the public debate on the topic of immigrants. Looking at google trends data (see @word1-migration).

This pushed the league to be the leading party of the right. In 2018 they got the second most amount of seats in parliament (even tho they where the 3rd party by voteshare). 

\
Movimento 5 Stelle.

M5S was founded after 2008 by Italian comedian Beppe Grillo. The party advocated for direct democracy, informatization of politics and overall transparancy. This was a response to the numerous scandals that involved mainly silvio berlusconi. The leaders of the party said they were neither right nor left. The party created a dichotmization in "us" (the people) and "them" (the politicians, often referred to as "The Cast"). After the 2013 election, after a pretty succefull performance at the poll (Nth place NOTA), most of the inducted parliament members where not politicians by profession.

The party refused to form government coalitions,they remained at the opposition. That lead them to be the first party in the 2018 election. 

\
Fratelli d'Italia

Fratelli d'Italia was founded before the 2013 election NOTE, as members left PDL - the great right wing coalition party led by berlusconi. The party remained marginal, with the exception of the region Lazio (of ROME) until the 2022 election. The party gained traction under the leadership of Giorgia Meloni (Italian PM at the time of writing). The party was one of the few party that remained in the opposition for the length of the 2018 2022 period. They honed in into European, Italian christian messaging.




== Frame the volatility,
Italy is a democratic parliamentary republic. The rules concerning electoral threshold still allows for small parties (\<3%) to have seats in both the Senate and the chambers of Deputees. This allows for a more fragmented political scenery.
Where parties build heterogeneous temporary coalitions to support the government. This makes governance very unstable, and changes of governments are frequent.
Out of 68 governments since the start of Republican history (since 1946), only 5 of them lasted more than 1000 days, staying in charge for 1.1 years on average and median NOTE.

The electoral system has changed every two elections, since 2008.
For the years 2008 and 2013, the electoral system was proportional with a majority bonus. For the 2018 and 2022 election, a mixed system between first pass the post and proportional was introduced (similar to the 1993 system).
Relevant is the fact that for the 2018 and 2022 election, electoral coalitions can be formed (called list). First pass the post candidates are jointly nominated by each list. While the rest of the seats in are assigned proportionally (at national level for the Chamber of Deputees, at regional level for the Senate).

Due to the changes and complex nature of the system, our focus will be directed towards analysis of party vote shares and how those changes over time.
However it is relevant, especially when looking at the success of the right wing coalition, that the three parties ran as one list in since 2008. However this collaboration did not necessarely extended to the formation of goverments, where each individual party had their own unique strategy. 

For this reason it is relevant to also take into account the incumbency of individual parties in the analysis.

== Rise of far right movement


== Topic of immigration
The public debate centered around the topic of migration from 2013 to 2020, mainly under the constant mediatic pressure by Salvini. While thinking on what the most appropriate metric for racial animus. However the prevalence of the topic leading to the 2022 elections decreased - possibly beacuse of covid-19 #citeb(<pasini2023issue>).
== Decrease in turnout
Another noticeable trend in italian elections is the stark decline in turnout. This is possibly due to loss of trust of the republican institution.
People seeked to move away from traditional parties (PD, FI) and seek alternative that presented themselves as anti-system (M5S, LEGA, FDI).
This is in line with what is happening nowadays in other countries such as UK and Germany, where the popular support is gradually shifting from historical istitutional parties (Labour, Tories, SPD) to new - or previously marginal - political forces (Reform UK, AfD, Greens).


== Role of Incumbency

When we consider that most popular party by number of votes we can clearly see an alternating trends, historically (before 2013) mainly between the biggest left party and Berlusconi's party. This trend continued after, but each time with a new face on top.
However historically, for most of the duration of the 
Second Repulic #citeb(<koff2000italy>), we can observe that the leading party was electorally damaged by incumbency.
As elected parties and leaders spent political capital, consensus declines. That is why a lot of work in the paper went into being able to include incumbency in the modelling.

#figure(
  image("img/Italian_Elections_1994-2018.png"),
  caption: [We observe and alteranating patter between the major right (blue) and left (red) party each election. We can see the rise of M5S (yellow) in 2013 and similarly of Lega (green) in 2018.
  This is still true in 2018, as M5S did not join any governments, thus increasing their base.
  We are led to believe that incumbency is a relevant predictor of electoral performance.
  Adapted from Wikimedia Commons#citeb(<wiki:itelection>)]
)


= Motivation

== Google data as proxy for socially sensitive attitudes,
In #cite(<salganik2020measuring>), researchers try to asses the impact of racial animus on Obama's electoral performance.
This is not a trivial task since in surveys respondents tend to hide socially undesirable behaviours #citeb(<kreuter2008social>), such as racial animus, and chamption more accepted ones, such as inclusivity; this is sometime referred to as social desirability bias. 
Therefore researchers are always in search of unbiased indirect measures for sensitive topics.
The proxy measure proposed by the author relies on the fact taht people feel more at ease in front of a screen in their own home in expressing themselves #citeb(<conti2007honest>),thus reducing social desirability bias.

Let us introduce Google Trend data. Google stores the seraches as well as their origin. They provide free access to the aggregated data.
In terms of relative search volume.
Wheter it be over time, or over region, the data is standardized on a scale from 0 to 100. 
The value of 100 is assigned to the subregion (or the time time interval) in which the ratio of searches containing the word of interest (or related searches) to total google searches, for a given time frame and area is maximum.

For a given territory (country, state, region, etc.) $A$ and an overall timeframe $T$, let ${a_1, a_2, dots}$ be the set of spatial subdivisions of $A$ and $t$ be time subdivision of $T$; the google trends score for the term $W$ - ranging from 0 to 100 - is defined as follows: 
$ S^"tot"_(a_i,t) = sum_(k=1)^(infinity)S(A)_(k,t), $ 
$ Q(A)_(w,t) = (S(A)_(w,t))/(S(A)_("tot",t)), $ 
$ "RSV"(A)_(w,t) = (Q(A)_(w,t))/(Q(A)_("max",t))* 100, $ 

Properly define the spatial or temporal normalization.NOTE

Where $S(T)_(k,t)$ is number of searches on google for term $k$ during time interval $t$ in territory $A$; $Q(A)_(w,t)$ is the ratio of the number of searches for term $w$ and total google searches in area $A$ and in time interval $t$; $"RSV"(A)_(w,t)$ is the relative search volume for term $w$ for the given territory 


== Justification for the choice of the proxy
We then define the Racially Charged Search Rate for (RCSR) a region, to be the relative search volume of the Italian equivalent of the n-word. From now on referred to as "WORD1".
When looking what other kind of queries the word is used in,most of them are about a renowed italian toys company. However the relative volume of such searches is minor in comparison to the total number of searches for WORD1 (see @word1-dal).
Other searches pertain surnames and names of tourist hotspots and businesses. However, they are also a negligible amount of the total searches for WORD1.

The use of WORD1 has reached nowadays unambigously the status of slur in Italy #citeb(<gaye2023razza>). For this reason it was the search term of choice and it was not mixed with other terms potentially indicating racial animus. 
More details can be found in the Appendix (see @word1-migration).

==  Difference between the US context and the Italian context
In his #cite(<salganik2020measuring>) the treatment variable of a black candidate is self evident.
In the Italian context effect of racial animus  on national election is not trivial to quantify. Black politicians only constitutes a minority of the total (3 out of 600 in the current legislature). Only one person of colour lead a ministry in the entirety of Italian history.
And even when they NOTEexists they are seldom the center of public discourse.
Roughly 1 million people are of african descent. Compared to the numbers of the US, they constitute a small minority of the population. 

The topic of migration has been central to Italian political discourse, in particular after Lega party leader Matteo Salvini took the reins in 2013. 
Most of the representation of black people in media consisted of migrants trying to reach Italian shores on boats. 
The concern for migration issued could act as a confounder in the context of descerning wheter parties, such as the league, that focus their communication on this single issue, may muddy the waters NOTE, in the endeavor of measuring the impact of racial animus per se.
However whenr looking at google trends' data, we can see that the search term for WORD1, remained stable since the first available gtrend data NOTE, while key terms referring to migration oscillated visible, following local trends.

The second part of the paper focuses on analyzing the electoral effect of this more aggressive campaign, and try to capture wheter racial animus played a role in this shifting political trends.

== Area limitation - possible improvements with rearranging (see "limitations")
#cite(<salganik2020measuring>) uses media market as areas, as the people in said area are exposed to the same radio and tv content.
Italy doesn't have a strict equivalent, as the state broadcast is the same everywhere (NOTE CHECK), with the addition of local regional tv channel.
Also google search areas are neatly available only at regional level.
Ideally it would be possible to construct more granular areas for rcsr. That could be done convenientely at the release of google official api. See "limitations" NOTE
== Why is still relevant to the timeframe analyzed - before ChatGpt
One concern regarding the use of google trends data is that nowadays most people replaced traditional search engines with LLMs. However the timeframe analyzed in this paper was before chatgpt market dominance. 
As of November 2022, chatGPT had still not taken a piece of the pie of google market dominance. However further care must be exercises for future analysis that want to employ a similar method.


= Data
The electoral data are from the Ministry of Internal Affairs #link("https://elezionistorico.interno.gov.it/")[_"https://elezionistorico.interno.gov.it/"_]. Data is available at comune level (town). 
Information about candidates and the electoral list (coalition) are available. 
The region Valle d'Aosta is excluded from our analysis as they have autonomy as a region conerning electoral matters.

The following can be noted:
- the vote shares are similar across camera and senato;
- voters express preference for parties intead of single candidates most of the time.
In the current system, voting for a party counts as expressing a preference for the list the party is part of and for the local candidate running for the list. Expressing a vote for a party is only relevant to the extent of the proportionally assign share of the seats (Based on national vote shares for Camera, and regional for Senato).

Since the vote share distribution is similar between assemblies, all the data looked at from now on is from the Camera.

= Methodlogy
To tackle the measuring of effect of racial animus, two different research questions are proposed.


== Q1: In the 2022 election, are disappointed M5S voters with a right wing background returning to the right motivated by racial animus? <aggregate>

After their government experience in the 2018 2022 legislature, M5S experienced a stark decline in popular support (@right-wing), losing the most popular party position they held since 2013 and falling into $3^"rd"$ place. 
Thanks to their meteoric rise in 2013, M5S collected voters previously affiliated with FI, some elements of the left and independents.

With the aggregate model we try to capture wheter this returning flow of voters did so disproportionaly in areas where the racial animus proxy, RCSR is higher.

The electoral systems was the same in 2018 and 2022. FI, FDI and LEGA run together as one unified list in both elections, even if only FI and LEGA partook in governance.
Condidering that the total amount of votes of the three parties combined seems stable across years NOTE, the present analysis wants to establish wheter "come-back voters" from M5S that were balancing the effect of declining turnout where motivated by racial animus.

The model has the flaw of not accounting for incumbency, as well as not taking advantage of information about voter of other parties.

#figure(
  grid(
    columns: (auto, auto),
  image("img/alluvial_all.png"),
  image("img/alluvial_right.png"),
  ),
  caption: [On the left major parties performance across the election cycles 2013, 2018, 2022. On the y axis we have total number of votes, parties are ordered each year vote ranking.
\ On the right the focus shifts to the right wing parties alone. The total number of votes accrued by the coalition remains more or less constant across years.]
) <right-wing>


The change in vote share of the right wing coalition as a unit is regressed against RCSR.

Turnout is relevant factor in recent elections (NOTE see figure). The change in turnout between 2018 and 2022 is included as regressor to control for its effect.

The aggregate model is:

  $ Delta%"SHARE"_(r) = beta_0 + colred(beta_"rcsr")* X_r + beta_"turnout"*Delta T_(r), $
#set math.equation(numbering: none)  // There are no numbers in sample paper.
  $ Delta %"SHARE"_r = "Change in vote share 2018-2022," $ 
  $ Delta T_r= "Change in turnout 2018-2022," $ 
  $ X_r = "Racially charged search rate," $ 

#set math.equation(numbering: "(1)")  // There are no numbers in sample paper.
where $r$ indexes regions.

== Q2: Is effective for a right wing party to start adopting a far-right, social media strategy, in attracting racially animated voters?  <vote-share>

Parties like LEGA and FDI adopted the language of social media to communicate to the broader audience, allowing for their far-right agenda to widespread effectively. We would like to capture the component of the meteoric rise that both parties had (from \<3% to above 20%), that was driven by racially animated voters.

To model parties' characteristics more granurarly we choosed to use a multi-state agent-based model that assumes a herding behaviour, as in #cite(<kononovicius2017modeling>).
The model was originally proposed by #cite(<kirman1993ants>), and it assumes that agents make their decisions based either on the perceived actractiveness of their options or due to peer-pressure, even when rational reasons to choose are lacking.

For the two states case, we choose to represent the transition probabilities as follows#footnote(
[The original model is defined in terms of the actractiveness parameter $sigma_1$ and the interaction strength between the two groups $h$.
@transition1 looks as follows: $P(X -> X + 1) = (N-X)(sigma_1 + h X)Delta_t$. #cite(<kononovicius2017modeling>) ignores the temporal component, as it is not relevant in his case and introduces the rescaled time $t_s = h t$ and the rescaled actractiveness parameter $epsilon_i = sigma_i/h$. 
  // As in my NOTE case a temporal analysis is conducted, the theoretical stationary distribution is not necessarly a Beta and the parameter h should be considered. 
In our case, the analysis is conducted at 3 different points in time. Therefore there should be some caution in adopting a static approach as in #cite(<kononovicius2017modeling>).
  We would need to require the $epsilon_i$ parameter to vary over time, which is not in line with the model specification. 
  We make the simplifying assumption that the actractiveness parameter stays constant in the four years leading to an election, but changes afterwards.]
) <note1>:

\
$ P(X -> X + 1) = (N - X)(epsilon_1 + X)Delta t_s $ <transition1>
$ P(X -> X - 1) = X (epsilon_2 + (N - X))Delta t_s $. 
\

Where $N$ is population size, $X$ is number of population members in category 1 and $epsilon_i$ is the actractiveness of category $i$.
At each moment in time the probability of switching to the other category depends on the number of members in both categories and the group specific actractiveness.

In the limit $N -> infinity$, the stationary distribution for the quantity $x = X/N$ - the proportion of agents with choice 1 - is the beta distribution $"Beta"(epsilon_1, epsilon_2) $
#citeb(<kononovicius2017modeling>).

The $epsilon_1$ parameter, actractiveness parameter in our framework, models the the expected value for $x$ and the concentration of the shares.
When we generalize the model to more than two parties, underr the limit $N -> infinity$, the stationary distribution is a $"Dirichlet"(epsilon_1, epsilon_2, dots, epsilon_P)$ - that can be seen as the high dimensional generalization of the Beta. That is true only under the following assumptions#footnote([
The non binary state case of the model's transition probabilities look as follows:

\
$ P(X_i -> X_i + 1) = sum_(j != i) X_j (sigma_(j i) + h_(j i)X_i)Delta t, $   
$ P(X_i -> X_i - 1) = X_j sum_(j != i) (sigma_(i j) + h_(i j)X_j)Delta t. $
\

To get equations @multipos and @multineg we require that $sigma_(i j) = sigma_i $ and that $h_(i j) = h$, $forall i,j$. The validity of the simplyfing assumptions can be contested
(#cite(<kononovicius2017modeling>),  #cite(<deffuant2006comparing>)), especially (1.), that is explicitly contradicted in the aggregate model in section @aggregate. More details in the limitation section. ])<note2>:

+ the perceived actractiveness of a party doesn't doesn't depend on the party from which an agent comes from;
+ the interaction between agents is symmetric and independent of the current agent's party.

Under this assumptions we can simplify the transition probabilities for each party to look as follows:
\
$ P(X_i -> X_i + 1) = (N - X_i)(epsilon_i + X_i)Delta t_s, $ <multipos>

$ P(X_i -> X_i - 1) = X_i (epsilon_(-i) + N - X_i)Delta t_s, $<multineg>

where $epsilon_(-i) = sum_(j!=i) epsilon_j$ is the sum of the actractiveness parameters for all other parties. The marginal distributions for the votes share distribution of party $i$ looks like $"Beta"(epsilon_i, epsilon_(-i)).$


#figure(
  image("img/shape_distribution_ex.png", height: 30%),
  caption: [Histogram that exemplifies how empirical vote share distribution looks like. Data from 2018. \ Concentration parameters $alpha$ are 1.34, 4.46 and 4.21 respectively.)]
)

== How the parameters are estimated, modelling issues.
Ideally the independent variables that affect the $epsilon_i$ would be jointly estimated through a Dirichlet regression. However, due to the time correlated nature of the data, there is the need to include time correlated errors. 
Non-bayesian routines for estimation of dirichlet regression have not yet the degree of flexibility required to include mixed effects *and* different regressors for each party $i$.

On the other hand, bayesian implementations of this model struggle with convergence and are computationally intensive due to the big size of the dataset (>21000 polling stations across the three election, roghly 7000 each year).

To quickly and flexibly estimate the regression a two step estimation approach is used: first, we get NOTE estimates for $epsilon$ coefficients of the dirichlet regression at regional level for each year. Later a linear mixed model of $log(epsilon)$ is against the regressors.

In order to control for decrease in turnout, abstension is also modelled as a party - that means its $epsilon$ is estimated with the other parties.
We are now dealing with parties shares of potential voters. This is different from @aggregate, where the voteshare referred to actual votes.

We are also assuming the herding behaviour to apply to abstension.

The final regression is not run on the $epsilon_"abstention"$ as it makes no sense to define incumbency and other regressors in this circumstance. 

== Structure of the final time regression

The estimates are performend across the three election cycles - 2013, 2018, 2022 - as this is the earliest of date for which all parties are present. For each year, the parameter vector of the dirichlet is estimated for each region. The final alpha estimates will have 3 indexes:
$ alpha_(t r p); t = "year"; r = "region", p = "party" $ 
For each region each year the vector $bold(alpha_(t r)) = (alpha_(t r 1), ..., alpha_(t r P))$ is estimated, where $P$ is the total number of parties modelled.

Note that also abstension (complement of turnout) is treated as a party, and is deemed to follow the same herding + actractiveness behaviour assumed for parties.

\
In the recond step the (log) $alpha$ are regressed on the following set of regressors using a mixed effect model.
$ log(alpha_(p r t)) = beta_0 + S_(t p) + "INC"_(t p)  + "RCSR"_(t r) times S_(t p) + gamma_(r)+ gamma_(p)+ gamma_(r p)+ epsilon_(p r t), $ 
$ vec(bold(epsilon), bold(gamma)) tilde N(  vec(bold(0), bold(0)), mat(
sigma bold(I), bold(0);
bold(0), bold(G);)). $ 


The variables are:
- $S_(t p)$ : "treatment" variable. When a right wing party switched to the more aggressive communication approach.
- $"INC"_(t p)$ : Binary variable representing wheter a party $p$ is incumbent in year $t$. It equals to 1 if the party partook in at least one government in the legislature leading to election in year $t$.
- $"RCSR"_(t r)$: the racially charged search rate by region $r$, in the time frame between year $t$ and $t - 1$. Year $t_(-1)$ is 2008.
- $gamma_((dots))$ represents the random effect for indexes $(...)$. 
- $epsilon$ is the error.
- $bold(I)$ is the identity matrix and $sigma$ is the error variance.
- $bold(G)$ is the covariance matriz for the random effects.

Random intercept are included to account for party specific regional variation. As some party consistently perform better in certain region due to historical allegiances or effect of local government.



+ "treatment" variable
The binary variable $S_(t p)$ is included as to account for the effects of change in communication policy by the parties. What we are interested in looking at is the interaction effect of this variable with the RCSR, to capture wheter the policy improves electoral performances in racially more intense regions. RCSR is included only in the interaction effect as - due to the availability only at regional level - it's effect would be strongly confounded by the region effect. We assume the its non-interaction component of the effect is absorbed by the random effect $gamma_(r p)$.


= Results
== Aggregate model results
After running a linear regression on the aggregate model, two outlier regions were identified in the leverage vs residuals plot (CAMPANIA, TRENTINO).
That can be explained as Campania experienced the second biggest decrease in turnout of all region (after MOLISE).
Trentino holds the "autonomous region" title and as such as a fairly unique local political situation.

To account for outlier behaviour, the analysis was conducted on paralled on both the data set with and without the two outliers.
Additionally the possibility of a quadratic affect of change in turnout was considered. Regardless of the model specification, the coefficient corresponding to the racially charged search rate was negative for all cases.

Therefore the coefficient is not significant when looking at a postive effect.

This, in conjunction with the almost constant amount of votes between 2018 and 2022 of the coalition, lead us to hypothesize that the increase in electoral performance of the right wing coalition was driven mainly by drop in turnout (see figure @turnout-by-party).

 - Mainly driven by incumbency
== Mixed model results

We now look at the results of the second model, to answer the second research question.
#figure(
  table(
    columns: (auto, auto, auto, auto, auto ,auto, auto,auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [*Regressors:*],[RE],[incumb], [year], [S], [A], [RCSR $times$ S], [#align(center)[*BIC*]], [ #align(center)[*p-value*] ],
    ),
    [*m_0*],[$checkmark$ ],[],[],[],[],[],[643.2],[],
    [*m_inc*],[$checkmark$ ],[$checkmark$ ],[],[],[],[],[559.6],[],
    [*m_S*],[$checkmark$ ],[$checkmark$ ],[],[$checkmark$ ],[],[],[465.7],[],
    [*m_A*],[$checkmark$ ],[$checkmark$ ],[],[],[$checkmark$ ],[],[535.8],[],
    [*m_S_time*],[$checkmark$ ],[$checkmark$ ],[$checkmark$ ],[$checkmark$ ],[],[],[452.3],[$star$ ],
    [*m_rcsr*],[$checkmark$ ],[$checkmark$ ],[$checkmark$ ],[$checkmark$ ],[],[$checkmark$ ],[452.3],[$star$ *.015* ],
    [*exp(Estimates)*],[],[.*508*],[.*904*],[*1.102*],[],[*0.010*],[],[],
  ),
  caption: [RE stands for random effect and they are present in all model.
  Regressors are iteratively based on BIC improvement. Once the full best fit model is obtained, the interaction term between *start of far right communication* and *Racially charged search rate* is tested against the nested full model using anova.
  The exponential of the estimates tells us that, ceteris paribus, the amount our alpha is multiplied when the regressor increases by one.
  More detail on the model fitting can be found in the attached repository.]

)<table>

The interaction effect between the variable S- that signifies the start of far-right, social media driven, messaging  for a party- and the racially charged search rate is significant at level 0.025 (Bonferroni adjusted).

When interpreting the coefficient the following can be said: keeping eveything else constant, for a party that engages in far right messaging, their actractiveness value, as defined by the herding model, changes multiplicatively by a factor of 1.01, when the racially charged search rate of the region increases by 1.
For example leading to the 2022 election, when Fratelli D'Italia changed their communication strategy, we are expecting that in Sardegna (rscr 70) they would have an actractiveness score 10% higher than the one in Molise (rcsr 60) once we control for all other variables.

When we look at the other coefficients, it is interesting to notice how incumbency is expected to halves you actractiveness score on average. Also we notice that all parties lose 10% actractiveness on average each election cycle. This is due to the loss of actractiveness to abestention, that increases every year.

If we do not assume the herding behaviour voting model, then we cannot interpret the $bold(alpha)$ parameter vector of the dirichlet as the actractiveness parameters for the individual parties. 
In that case the interpretation of the regression can only tell us about how different regressors impact the expected value of alpha, the overall concentration of votes *or* both. In the context of a beta/dirichlet regression we model the 
expected values of each party separately from the global concentration parameter #citeb(<ferrari2004beta>).
In this framework, we will hold the herding model and ancillary assumption true.

#figure(
  image("img/all_against_turnout.png", height: 30%),
  caption: [In the figure we can observe how the turnout affected different political forces. Notice that %in turnout was less than zero for all regions.\
On the left most panel, we can see that the right wing coalition (Lega, Fratelli D'Italia, Forza Italia), experience increase in vote share everywere. The increase was stronger in regions where the was a stark drop in turnout. That may suggest an attachment by historical right wing voters. That suggest that the right does a good job at retaining his base, even if the distribution of votes changes among the major right wing parties.
Partito Democratico, center left, doesn't exibit any strong turnout trend, same as Movimento 5 Stelle, that experienced a uniform decline in all region, regardless of turnout. 
\We see that for the minor parties (O), we see that they experienced performance boost in regions with less turnout decrease. That may suggest that in more politically active areas, the vote mass shifted from M5S to other less institutionalized entities.]
) <turnout-by-party>

= Conclusions
We now consider what the two analysis give us for an answer to the research questions.

When we look at the first research question: Q1:"Did former right wing voters, that in 2018 voted M5S, returned to voting right motivated by their ratial animus?". 
No effect was found. By looking at the turnout trend, and with knowledge that the total number of voters for the rightwing coalition stayed roughly the same, we are led to believe that the increase in electoral performance across the board was due to the ability of the coalition to retain voters as a whole (even though those votes shifted among the coalition, from Lega and Forza Italia to Fratelli d'Italia).

When we look at Q2: "Does adopting a far-right communication strategy have a bigger effect in areas with higher racial animus - proxied by racially charged search rate?", we have some evidence that this appears to be true, if the party is also coming off as non incument.
There are no evidence that the strategy works in retaining the racially animated base. To have more insight the results of the coming 2027 elections, could provide more insight by analysing the performance of Fratelli D'Italia after the government tenure.

== Limitations
The above conclusions must be weighted against the following considerations.

First of assumption (1) in @vote-share, required that the the actractiveness of a party does not depend on the party where an agent comes from.
This assumption is explicitly violated in @aggregate, as we assume that the votes shifted among right-wing parties, thus making it more likely for a right wing voter to move to an other right wing party compared to a leftist.

Also in @note1 is explicited how the static framework employed in #cite(<kononovicius2017modeling>) doesn't automatically translate to this over time dynamic analysis. There are no theoretical guarantees that the $epsilon_i$ are an accurate depiction of the actractiveness of a party.

In #cite(<kononovicius2017modeling>), they use mixture of betas to model parties that have segregationist NOTE: reword: tendencies. While some of that tendencies are controlled for by the regional nature of the analysis, some of the in-region segregation is still not accounted for.
See for example FDI in Trentino-Alto Adige - a region with a strong ethnical separation between the Italian and German speaking community - that is clearly visible here (see @trentino).

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
#pagebreak()
#set heading(numbering: none)
= Bibliography
#bibliography("main.bib", style: "apa")

#pagebreak()
= Appendix <appendix>
#figure(
  image("img/word1_queries.png"),
  caption: [Relative search rate for WORD1 and the queries in which it most frequently appears. The queries are the minority of the searches.]
)<word1-dal> 

#figure(
  image("img/common_comparison.png"),
  caption: [WORD1 and unrelated words with similar Relative Volume.\
cartello : sign, cartel;\
  miniera : mine (location);\
  mistero : mistery.
]
)<word1-common> 

#figure(
  image("img/word1_migration.png", height: 35%),
  caption: [Here the RSV of WORD1 is compared with the word immigrati (migrants) and clandestino/i ($tilde$illegal alien/s). We can see that the terms "immigrati" and "clandestini" have a more spikey behaviour, when compared to WORD1 and clandestino, the singular version of the word. That can be explained by the fact that the negatively connotated term was almost always used in the plural form.]
)<word1-migration>

#figure(
  image("img/trentino_voteshare.png"),
  caption: [In Trentino-Alto Adige, a region with a strong independentist tendencies, we observe the mixture of beta behaviour described by #cite(<kononovicius2017modeling>).]
)<trentino> 
