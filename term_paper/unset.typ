// cite things in bracketed form
#let citeb(tag) = {
  cite(tag, form: "normal")
}
// coloring things in red
#let colred(x) = text(fill: rgb("#fe624f"), $#x$)

// Page numbering
#set page(numbering: "1.")
// Equation numbering
#set math.equation(numbering: "(1)")  
// section numbering
#set heading(numbering: "1.")


#set page(
  paper: "us-letter",
  header: align(
    right + horizon,
    context document.title,
  ),
  numbering: "1",
  columns: 1,
)

#show title: set text(size: 22pt)
#show title: set align(center)
#title[Effect of Racial Animus in Italian Elections]

#align(center)[Ermanno Antonucci\
15-03-2026\
Computational Social Sciences Report]

#linebreak()


#align(center)[
  #set par(justify: false)
  *Abstract* \
  In this paper, we investigate the role that racial animus played in the last three Italian elections, spanning fifteen years, using Google Trends and publicly available government data. While we found no evidence that racial tendencies drove the exodus of voters from centre parties to right-wing ones, it can be argued that racially charged political messaging contributed to the electoral success of far-right parties, namely “Lega” and “Fratelli d'Italia”. These parties formed the government in both the 2018 and 2022 legislatures. 
]

// justify text
#set par(justify: true)

= Introduction

Italy has undergone changes to its political power structure.
Historically institutionalised parties are gradually losing popular support, with alternatives starting to gain popularity.
The country has also been experiencing a prolonged period of financial stagnation#cite(<baccaro2022growth>). This process was accelerated by the Great Financial Crisis of 2008 and exacerbated by the global pandemic and energy crisis that followed the Ukraine war. Politicians have gradually shifted from messaging about common prosperity to communicating a constant state of emergency#cite(<bobba2021comunicazione>). People started to demand more from their leaders than the management of a system that had failed them; they demanded change.
Over the years, old and new political entities have proposed different approaches.
The emerging Italian far right suggested that this change should be a return to the past.
They presented a project of reclaiming old values, national strength and unity.
Through the savvy use of new communication channels, such as social media, they managed to take control of the national political narrative.

This led to its sudden rise in the polls. This narrative focused on migration(#cite(<regalia2025issue>), chp 11), gradually polarising the topic in public debate and aggravating racial prejudice#cite(<sebastiani2017razzismo>).

In this paper, we attempt to quantify the impact of racial animosity on the voting behaviour of Italian citizens from the period of the Great Financial Crisis until 2022.
During this period, the far right reclaimed a dominant role in right-wing politics.
It did so by taking on a new form while retaining old, familiar traits.
It conquered a position held by Silvio Berlusconi for the previous 20 years#cite(<campus2006antipolitica>). 

What impact had racial animus in this? Inspired by the work of #cite(<salganik2020measuring>), this paper tries to tackle the issue on two different fronts. We will try to answer the following questions:
+ What role did racial animus in center voters play in the success of the right in the 2022?
+ To what extent is success of election winning far-right parties due to appealing to racial animus?
= Context

== Italian Politics
In Europe, in the years following the Great Financial Crisis of 2008, it has been possible to observe the rise of far-right parties across the continent #citeb(<lazaridis2016rise>). 
Italy was not exempt; parties such as "Lega Nord" (LEGA) and "Fratelli D'Italia" (FDI), rose through the polls and overtook the leadership role of the right wing coalition, previously held by Forza Italia (FI), in 2018 and 2022 respectively.
This is not a small feat, considering that FI, under the leadership of the charismatic entrepreneur Silvio Berlusconi #citeb(<campus2006antipolitica>), was the most popular right wing party since 1994. However, the first transformative political force to initiate this shift was not a right wing party.

The following section is a brief introduction to the parties which are relevant to the analysis, included here to make the modelling process clearer.
=== Italian Political Parties

The "Movimento 5 Stelle" party was founded in 2009 by the Italian comedian Beppe Grillo.
The party advocates digitalisation in state affairs and moving away from professional politicians in favour of direct democracy, all of which is to be enacted through the party's proprietary online platform.
M5S was presented as a people's party, by the people, for the people. In the 2013 election, almost all of those appointed to Parliament had not held any previous political positions.
The party promoted initiatives such as 'Vaffa Day' ('Fuck You Day'), its annual political gathering, and streamed meetings with leaders of other parties online.
M5S shattered the dichotomy of right versus left, claiming that such categories had been superseded. The party was very successful in collecting votes from the ever-growing fraction of the population who were tired of institutional parties such as FI and its centre-left adversary, the Partito Democratico (PD).
Resentment towards institutional representatives was exacerbated by the financial crisis. In its first political appearance in the 2013 elections, M5S collected 25% of votes.
The party leadership decided not to participate in any government coalition during the 2013–18 legislature.
This strategy proved successful when, in 2018, the party won first place with an impressive 32% of the vote.


Following the gradual decline of Forza Italia, LEGA first claimed the role of leader in Italian right-wing politics. 
Following Matteo Salvini's leadership in 2013, the party moved away from its roots in Northern Italian separatism, federalism, anti-Meridionalism, and regionalism, embracing a national dimension (#citeb(<albertazzi2018no>)).
This change is epitomised by the alteration of the party slogan from 'Prima il Nord' ('North first!') to 'Prima gli Italiani!' (Italians first!).
Despite being the oldest party in Parliament at the time and having been part of previous governments, Salvini managed to present LEGA as a new entity altogether.
To this end, he dropped the 'Nord' (North) from the name and centred the party's imagery and communication around his own persona. The results were not long in coming.
The party skyrocketed in the polls, not only in its traditionally strong northern regions, but also establishing a solid presence in the centre and south of the country. 
It increased from 4% in 2013 to 17% in 2018.
Following the 2018 elections, LEGA formed a coalition government with the Movimento 5 Stelle (M5S).


Fratelli d'Italia (FDI) was founded in 2012. It was formed by former members of the super party 'Popolo della Libertà' (PDL — a rebranding of FI), who shared a background in the historical far-right party 'Alleanza Nazionale'. The new party remained marginal until the 2022 elections; it held nine seats in 2013 and 19 in 2018, with four per cent of the vote.
It did not join any government, even when its allies LEGA and FI did. It has always maintained its role as a member of the opposition and has slowly garnered support by critiquing the three governments that came to power during the 2018–2022 legislative period. 
While different factions on the left and right participated to some extent in the government, Fratelli d'Italia was the lone exception.
In the 2022 election, it became Italy's largest party (under the leadership of Giorgia Meloni, who has led the party since 2014).
Meloni presented herself as an accessible figure, focusing on her personal experiences as a mother, a Christian, and someone of humble origins.
The party's agenda focused on national security, which was interpreted more broadly than the anti-migration policies promoted by LEGA.
Compared to its predecessor, FDI pushed for a stronger connection with European allies and the USA.

=== Electoral System


Italy is a democratic parliamentary republic. 
Its parliament comprises two entities: the Chamber of Deputies (Camera) and the Senate of the Republic (Senato). 
General elections are usually held every five years, during which the members of both assemblies are elected.
The President of the Republic appoints the Prime Minister, who is tasked with forming a government. The prospective government then needs to secure a majority in both assemblies to officially take power.
The Italian parliament is typically made up of a few large parties and several smaller ones.
This fosters the necessity to create alliances, many of which are fragile, in order to establish a government coalition. Out of the 68 Prime Ministers since the start of the Republic in 1946, only five served for more than 1,000 days, with an average tenure of 1.1 years.
Electoral threshold rules still allow small parties (\<3%) to have seats in both the Senate and the Chamber of Deputies. This results in a more fragmented political landscape compared to the USA.


The electoral system changed once before the 2018 election, in 2008. 
Between 2008 and 2013, seats were assigned proportionally based on the number of votes received, with a majority bonus awarded to the leading coalition. For the 2018 and 2022 elections, a mixed system combining first past the post and proportional representation was introduced, similar to the system in place in 1993.
In both systems, electoral coalitions (known as 'lists') can be formed.
In the first system, parties in a list share the majority bonus and in the second system, they nominate candidates jointly for the seats determined by first past the post.
Coalitions, such as FI, FDI and LEGA, do not have to share strategies once the elections are over.
Each party is free to act in its own interest when deciding which executives to support.
This differs significantly from the US system, where incumbency coincides with electoral success. This means it is necessary to keep track of incumbency separately for each party and control for its effects.

Due to changes over time and the complex interplay between areas, vote shares and the seat assignment mechanism, our analysis will focus on vote shares and the factors impacting them.



== Google data as proxy for socially sensitive attitudes,

In #cite(<salganik2020measuring>), researchers attempted to assess the impact of racial animus on Barack Obama's electoral performance in 2008 and 2012.
This is not a trivial task, since respondents tend to hide socially undesirable behaviours, such as racial animus, in surveys (#cite(<kreuter2008social>)), and champion more accepted ones, such as inclusivity. This phenomenon is sometimes referred to as social desirability bias. 
Researchers are always searching for indirect, reliable, unbiased measures of sensitive topics.
The proposed proxy measure relies on the idea that people feel more comfortable expressing themselves in front of a screen at home (#citeb(<conti2007honest>)), thus reducing social desirability bias.

Now, let us introduce Google Trend data. Google stores queries and their locations of origin. They provide free access to aggregated data in the form of relative search volume.
Whether the data is analysed over time or over region, it is standardised on a scale from 0 to 100. 
A value of 100 is assigned to the subregion (or time interval) with the highest ratio of searches containing the word of interest (or related searches) to total Google searches within a given timeframe and area.


For a given territory (country, state, region, etc.) $A$ and an overall timeframe $T$; the google trends score for the term $w$ - ranging from 0 to 100 - is defined as follows: 
$ S(A)^"tot"_(t) = sum_(k=1)^(infinity)S(A)_(k,t), $ 
$ Q(A)_(w,t) = (S(A)_(w,t))/(S(A)_("tot",t)), $ 
$ "RSV"(A)_(w,t) = (Q(A)_(w,t))/(Q(A)_("max",t))* 100, $ 


Where $S(T)_(k,t)$ is number of searches on google for term $k$ during time interval $t$ in territory $A$; $Q(A)_(w,t)$ is the ratio of the number of searches for term $w$ and total google searches in area $A$ in time interval $t$; $"RSV"(A)_(w,t)$ is the relative search volume for term $w$ for the given territory 


=== Justification for the choice of the proxy

We then define the Racially Charged Search Rate (RCSR) for a region as the relative search volume of the Italian equivalent of the n-word, which will be referred to as 'WORD1' from now on.
When we look at the other kinds of queries that use the term, most of them are about a renowned Italian toy company. However, the relative volume of such searches is minor in comparison to the total number of searches for 'WORD1' (see @word1-dal).
Other searches pertain to surnames, as well as the names of tourist hotspots and businesses. However, these also account for a negligible amount of the total searches.
It seems that the term is most often searched for according to its main meaning.



The use of WORD1 has unambiguously reached the status of a slur in Italy (#citeb(<gaye2023razza>)). For this reason, it was the search term of choice when defining the racially charged search rate.
More details can be found in the appendix (see Word1-migration).

=== Difference between the US context and the Italian context

In his study#cite(<salganik2020measuring>), Salganik found that the 'treatment' variable for a black candidate was self-evident.
In the Italian context, the effect of racial animus on politics is difficult to quantify. Black politicians constitute only a minority of the total (three out of six hundred in the current legislature). Throughout Italian history, only one person of colour has led a ministry.
Today, around 1 million people in Italy are of African descent. Compared to US figures, they constitute a small minority of the population. 

Looking at Google Trends' data, we can see that the search term 'WORD1' has remained stable over time, while other key terms referring to migration have fluctuated considerably (see 'WORD1-migration').

=== Why is still relevant to the timeframe analyzed - before ChatGpt
One concern regarding the use of Google Trends data is that, nowadays, many people have replaced traditional search engines with LLMs. However, the timeframe analysed in this paper predates ChatGPT's market dominance. 
As of November 2022, ChatGPT had not yet encroached on Google's market share. Nevertheless, further caution must be exercised in future analyses that employ a similar methodology.

= Data
The electoral data are from the Ministry of Internal Affairs website #link("https://elezionistorico.interno.gov.it/")[_"https://elezionistorico.interno.gov.it/"_]#footnote("Last accessed on 15-01-2026"). Data is available at comune level (town). 


Information about candidates and electoral lists (coalitions) is available. 
The Valle d'Aosta region is excluded from our analysis as it has autonomy concerning electoral matters.

The following can be noted:
- vote shares are similar across the Camera and Senate;
- voters usually express a preference for parties instead of single candidates.
In the current system (2018–2022), voting for a party counts as expressing a preference for the list that the party belongs to, as well as for the local candidate running on that list.
Voting for a party only affects the proportionally assigned share of seats (based on national vote shares for the Camera and regional vote shares for the Senate).

As the distribution of vote shares is similar between the two assemblies, all the data examined from this point onwards comes from the Camera.


= Methodology


The following are brief considerations about the role played by incumbency and decreasing turnout in Italian elections. This justifies their inclusion in the models.

For most of the duration of the Second Republic 
#citeb(<koff2000italy>), we can see that the leading party was electorally damaged by incumbency (M5S, represented by yellow, did not govern in 2013).

#figure(
  image("img/Italian_Elections_1994-2018.png"),
  caption: [We observe and alternating pattern between the major right (blue) and left (red) party each election. We can see the rise of M5S (yellow) in 2013 and similarly of Lega (green) in 2018.
  This belief is strengthened by looking at the electoral performance of M5S in 2018, that increased when they remained at the opposition despite being one of the larger parties.
  Thus, we are led to believe that incumbency is a relevant predictor of electoral performance.
  Adapted from Wikimedia Commons#citeb(<wiki:itelection>)]
)

Italy has also experienced decreasing political participation over the years. This phenomenon seems to have accellerated in the year following 2000 (See @turnout-year)

= Modelling
To tackle the measuring of effect of racial animus, two different research questions are proposed.


== Q1: In the 2022 election, are disappointed M5S voters with a right wing background returning to the right motivated by racial animus? <aggregate>


Following their time in government during the 2018–2022 legislature, M5S experienced a sharp decline in popularity, losing the position of the most popular party they had held since 2013 and falling into third place. 
Thanks to their meteoric rise in 2013, M5S attracted voters from various backgrounds, including FI, some left-wingers and independents.

The intention behind the aggregate model is to determine whether this returning flow of voters was disproportionate in areas where the racial animus proxy, RCSR, is higher.

The electoral system was the same in 2018 and 2022. FI, FDI and LEGA ran together as one unified list in both elections, even though only FI and LEGA participated in governance.
Considering that the combined number of votes for the three parties was similar in both elections, the present analysis aims to establish whether 'come-back voters' from M5S who offset the effect of declining turnout were motivated by racial animus.

However, the model has the flaws of not accounting for incumbency and not taking advantage of information about voters of other parties.

The change in the right-wing coalition's vote share is regressed against RCSR.

The aggregate model is:

  $ Delta%"SHARE"_(r) = beta_0 + colred(beta_"rcsr")* X_r + beta_"turnout"*Delta T_(r), $
#set math.equation(numbering: none)  // There are no numbers in sample paper.
  $ Delta %"SHARE"_r = "Change in vote share 2018-2022," $ 
  $ Delta T_r= "Change in turnout 2018-2022," $ 
  $ X_r = "Racially charged search rate," $ 

#set math.equation(numbering: "(1)")  // There are no numbers in sample paper.
where $r$ indices the 19 regions considered in the analysis.

== Q2: Is effective for a right wing party to start adopting a far-right, social media strategy, in attracting racially animated voters?  <vote-share>


Parties such as LEGA and FDI have adopted social media as a means of communicating with a broader audience, enabling them to disseminate their far-right agenda effectively. We would like to examine the role played by racially motivated voters in the rise experienced by both parties.

=== Herding behaviour model

To model parties' characteristics more granularly we choose to use a multi-state agent-based model that assumes a herding behaviour, as in #cite(<kononovicius2017modeling>).
The model was originally proposed by #cite(<kirman1993ants>), and it assumes that agents make decisions based on the perceived attractiveness of their options or moved by peer-pressure, even when rational reasons to choose the latter are lacking.

For the two states case, we choose to represent the transition probabilities as follows#footnote(
[The original model is defined in terms of the attractiveness parameter $sigma_1$ and the interaction strength between the two groups $h$.
@transition1 looks as follows: $P(X -> X + 1) = (N-X)(sigma_1 + h X)Delta t$. #cite(<kononovicius2017modeling>) ignores the temporal component, as it is not relevant in his case and introduces the rescaled time $t_s = h t$ and the rescaled attractiveness parameter $epsilon_i = sigma_i/h$. 
  // As in my NOTE case a temporal analysis is conducted, the theoretical stationary distribution is not necessarly a Beta and the parameter h should be considered. 
In our case, the analysis is conducted at 3 different points in time. Therefore there should be some caution in adopting a static approach as in #cite(<kononovicius2017modeling>).
  We require the $epsilon_i$ parameter to vary over time, which is not in line with the model specification. 
  We make the simplifying assumption that the attractiveness parameter stays constant in the four years leading to an election, but changes afterwards.]
) <note1>:

\
$ P(X -> X + 1) = (N - X)(epsilon_1 + X)Delta t_s, $ <transition1>
$ P(X -> X - 1) = X (epsilon_2 + (N - X))Delta t_s, $ 
\

where $N$ is total population size, $X$ is the population in category 1 (_e.g_ party 1 voters), $epsilon_i$ is the attractiveness of category $i$ and $Delta t_s$ is the size of a time step.
At each time interval, the probability of an agent to switch to the other category is a function of the size of the categories and the attractiveness of the other category. 

In the limit $N -> infinity$, the stationary distribution for the quantity $x = X/N$ - the proportion of agents with choice 1 - is the beta distribution $"Beta"(epsilon_1, epsilon_2) $
#citeb(<kononovicius2017modeling>).
The attractiveness parameter $epsilon_1$ models the the expected value of the proportion $x$ and how concentrated the observations are (see @epsilon)

If we want to generalize the model to more than two parties, under the limit $N -> infinity$, the vector of vote shares $bold(x) = (x_1,x_2, dots , x_P)$ of the $P$ parties has for stationary distribution a $"Dirichlet"(bold(epsilon))$, with vector of attractiveness parameters $bold(epsilon) = (epsilon_1, epsilon_2, dots, epsilon_P)$, under following simplifing assumptions#footnote([
For the $P > 2$ case, the generalized form of the model transition probabilities looks as follows:
$ P(X_i -> X_i + 1) = sum_(j != i) X_j (sigma_(j i) + h_(j i)X_i)Delta t, $   
$ P(X_i -> X_i - 1) = X_j sum_(j != i) (sigma_(i j) + h_(i j)X_j)Delta t. $
To get equations @multipos and @multineg we require that $sigma_(i j) = sigma_i $ and that $h_(i j) = h$, $forall i,j$. The validity of the simplyfing assumptions can be contested
(#cite(<kononovicius2017modeling>),  #cite(<deffuant2006comparing>)), especially (1.), that is explicitly contradicted in the aggregate model in section @aggregate. More about this in @limit. ])<note2>:

+ the perceived attractiveness of a party does not depend on the party from which an agent comes from;
+ the interaction between agents is symmetric and independent of the current agent's party.

Under this assumptions we can simplify the transition probabilities for each party to look as follows:
\
$ P(X_i -> X_i + 1) = (N - X_i)(epsilon_i + X_i)Delta t_s, $ <multipos>

$ P(X_i -> X_i - 1) = X_i (epsilon_(-i) + N - X_i)Delta t_s, $<multineg>

where $epsilon_(-i) = sum_(j!=i) epsilon_j$ is the sum of the attractiveness parameters for all other parties. The marginal distributions for the vote share distribution of party $i$ looks like $"Beta"(epsilon_i, epsilon_(-i)).$


#figure(
  image("img/shape_distribution_ex.png", height: 29%),
  caption: [Histogram that exemplifies how empirical vote share distribution looks like. Data from 2018. \ Concentration parameters $epsilon$ are 1.3, 4.4 and 4.2 respectively. Lega vote share distribution looks clearly bi-modal. This pattern of behaviour is illustrated in more detail in #cite(<kononovicius2017modeling>). See also @trentino.]
)<epsilon>


=== The regression model

The estimates are performed across the three election cycles - 2013, 2018, 2022 - as this is the earliest of date for which all parties are present. 
Each year $t$ , for each region $r$, the attractiveness vector $bold(epsilon_(t r)) = (epsilon_(t r 1), ..., epsilon_(t r P))$ is estimated, where $P$ is the number of parties modelled, by fitting a dirichlet distribution to the vote share of the parties.

Note that also abstension (complement of turnout) is treated as a party as it is deemed to follow the same herding and attractiveness dynamic. 

The regression model has the following structural assumptions:
$ log(epsilon_(p r t)) = beta_0 + beta_1 S_(t p) + beta_2 "INC"_(t p)  + beta_3 "RCSR"_(t r) times S_(t p) +beta_4 t + gamma_(r)+ gamma_(p)+ gamma_(r p)+ epsilon_(p r t), $ 
and the following distributional assumptions:
$ vec(bold(epsilon), bold(gamma)) tilde N(  vec(bold(0), bold(0)), mat(
sigma bold(I), bold(0);
bold(0), bold(G);)). $ 

The variables are the following:
- $S_(t p)$ : binary variable. It represents the novel communication Strategy employed by LEGA in 2018 and FDI in 2022. It should control for the idiosyncratic events that led to the two parties' sudden rise in each respective year.
- $"RCSR"_(t r)$: numerical variable between 0 and 100. Racially charged search rate by region $r$ in the time frame between year $t$ and $t - 1$.
- $beta_3$ is the interaction coefficient between $S$ and $"RCSR"$. It is the quantity of interest. It is supposed to capture effect of the component of party communication that was effective at increasing the attractiveness in areas with higher racial animus.
- $t in {0,1,2}$ : representing years 2013, 2018 and 2022 respectively.
- $"INC"_(t p)$ : Binary variable. It represents whether a party $p$ is incumbent in year $t$. It equals to 1 if the party partook in at least one government in the legislature leading to election in year $t$.
- $gamma_((dots))$ are random effect for indices $(...)$. Random intercepts are included for each party - to account for general national party performance -, each region - to account for vote share concentration differences in each region#footnote([
  If we consider the $bold(epsilon)$ from the point of view of a Dirichlet (or Beta) regression, we have the following reparametrization: we go from a vector $bold(epsilon) = (epsilon_1, dots, epsilon_P)$ to the vector of expected values $bold(mu) = (mu_1, dots, mu_(P-1))$ and the concentration parameter $phi$  #citeb(<ferrari2004beta>).
  We can recover $epsilon_i$ through the relationship $epsilon_i = phi mu_i $, where $m_P$ can be recovered to the constraint $sum_(i = 1)^(P)mu_i = 1$.
  In both cases we are estimating $P$ params.\ In our context we are estimating one dirichlet distribution for each region, with parameter $bold(epsilon)_r$ or, equivalently, $bold(mu)_r$ and $phi_r$.
  We can decompose the fitted values for each region $r$, $hat(epsilon)_r = exp(dots) exp(gamma_r)$, where the exponential of the region specific random effect $gamma_r$ takes the role of $phi_r$ and controls for region specific concentration.
  Barring that the log-normal relationship conditional distribution assumption for $EE(epsilon | X)$ holds, we can then consider the fixed terms to have a direct multiplicative effect on the *expected value of vote shares*.
])<mu-beta> -, and the region-party specific effect to account for parties heterogeneus strengths at regional level.
- $epsilon$ is the error term.
- $bold(I)$ is the identity matrix and $sigma$ is the error variance.
- $bold(G)$ is the covariance matrix for the random effects.


The binary variable $S_(t p)$ is included as to account for the effects of change in communication policy by right wing parties.
We are interested in looking at the interaction effect of this variable with the RCSR, to capture whether the policy improves electoral performances in regions with higher racial animus.
RCSR is included only in the interaction effect as - due to the availability only at regional level - it's effect would be strongly confounded by the region effect. We assume that the non-interaction component of the effect is absorbed by the regional random term $gamma_(r)$.

== Model estimation


Ideally the independent variables that affect the $epsilon_i$ would be directly estimated fitting a Dirichlet regression across all years and regions. However, due to the time correlated nature of the data, there is the need to control for time correlated errors.
Non-bayesian routines for estimation of dirichlet regression do not have (at time of writing) the degree of flexibility required to include mixed effects *and* different regressors structure for each party.

On the other hand, bayesian implementations of this model struggle with convergence and are computationally intensive due to the big size of the dataset ($>21000$ polling stations across the three election, roughly 7000 each year).

To quickly and flexibly estimate the regression a two step estimation approach is used: first, we get estimates for $epsilon_(t r p)$ fitting a Dirichlet distribution for each region each year. Later a linear mixed model regresses $log(epsilon_(t r p))$ against the independent variables.


In order to control for a decrease in turnout, abstention is also modelled as a party, meaning we estimate the share of potential voters for seven parties (LEGA, FDI, FI, M5S, PD, OTHERS and ABSTENTION).
We are now dealing with the share of potential voters for each party. This differs from the aggregate, where the vote share referred only to the votes that were actually expressed.

We also assume that the herding behaviour of voters applies to those who decide not to vote.

The final regression is not run on the $epsilon_"abstention"$ as it makes no sense to define incumbency and other party characteristics in this circumstance. 
= Results
== Aggregate model results

After running a linear regression on the aggregate model, two outlier regions (CAMPANIA and TRENTINO) were identified in the leverage vs residuals plot.
This can be explained by the fact that Campania experienced the second biggest decrease in turnout of all the regions (after Molise).
Trentino, on the other hand, has a particular situation as it is the region with the lowest racially charged search rate. It should be noted that Trentino has a significant German-speaking minority of Italian citizens (see also @trentino).

To account for the outlier behaviour, the analysis was conducted in parallel on both datasets, with and without the two outliers.
Additionally, the possibility of a quadratic effect of change in turnout was considered; however, this did not improve model fitness. Regardless of the model specification, the coefficient corresponding to the racially charged search rate was negative in all cases.

When comparing the linear model with the full dataset with and without RCSR as a regressor, an e-value of 1.16 was obtained #cite(<ramdas2025hypothesis>). This was computed as the likelihood ratio. For reference, an e-value needs to be greater than 10 as a rule of thumb to be considered to carry evidence in favour of the alternative hypothesis #cite(<jeffreys1961theory>).

This, in conjunction with the almost constant number of votes for the coalition between 2018 and 2022, leads us to hypothesise that the right-wing coalition's increased electoral performance was mainly driven by a drop in turnout (see figure @turnout-by-party).

== Mixed model results

We now look at the results of the second model to answer the second research question.
#figure(
  table(
    columns: (auto, auto, auto, auto, auto ,auto, auto,auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [*Regressors:*],[RE],[incumb], [year], [S], [A], [RCSR $times$ S], [#align(center)[*BIC*]], [ #align(center)[*e-value*] ],
    ),
    [*m_0*],[$checkmark$ ],[],[],[],[],[],[643.2],[],
    [*m_inc*],[$checkmark$ ],[$checkmark$ ],[],[],[],[],[559.6],[],
    [*m_S*],[$checkmark$ ],[$checkmark$ ],[],[$checkmark$ ],[],[],[465.7],[],
    [*m_A*],[$checkmark$ ],[$checkmark$ ],[],[],[$checkmark$ ],[],[535.8],[],
    [*m_S_time*],[$checkmark$ ],[$checkmark$ ],[$checkmark$ ],[$checkmark$ ],[],[],[452.3],[$star$ ],
    [*m_rcsr*],[$checkmark$ ],[$checkmark$ ],[$checkmark$ ],[$checkmark$ ],[],[$checkmark$ ],[452.3],[$star$ *19.10* ],
    [*exp(Estimates)*],[],[.*508*],[.*904*],[*1.102*],[],[*0.010*],[],[],
  ),
  caption: [RE stands for random effect and they are present in all model.
  Regressors are iteratively based on BIC improvement. Once the full best fit model is obtained, the interaction term between *start of far right communication* and *Racially charged search rate* is tested by computing an e-value with the likelihood ratio between the model with and the model without the interaction term.
  The exponential of the estimates tells us that, ceteris paribus, the amount our alpha is multiplied when the regressor increases by one.
  More detail on the model fitting can be found in the attached repository.]

)<table>

When testing the interaction effect between the variable S and RCSR we observe an e-value $>10$, thus suggesting strong evidence in favor of the alternative hypothesis. 

Let us quantify the impact of racial animus on the attractiveness (or directly on the vote share, see@mu-beta).

Keeping everything else constant, the years in which respectively LEGA and FI found the most success, for a unit increase of Racially Charged Search Score, their attractiveness was multiplied by a factor of 1.01 on average.

We present an example to give some some intuition.
Leading to the 2022 election, FDI are expected to have an attractiveness score roughly 10% higher in Sardegna (rscr 70) than Molise (rcsr 60) once all other factors are controlled for#footnote([
This is just an example to give a broad intuition. The differences in Molise and Sardegna are also controlled into random effects and difference in performance of FDI in the two regions is not expected to be 10% since the regional random effects will have to come into play when making the distinction.
]).

It is interesting to notice how incumbency is expected to halve a party's attractiveness score on average.
All parties lose 10% attractiveness on average each election cycle due to the loss of the increase in abstention.


#figure(
  image("img/all_against_turnout.png", height: 30%),
  caption: [In the figure we can observe how the turnout affected different political forces. Notice that %in turnout was less than zero for all regions.\
On the left most panel, we can see that the right wing coalition (Lega, Fratelli D'Italia, Forza Italia), experience increase in vote share everywere. The increase was stronger in regions where the was a stark drop in turnout. That may suggest an attachment by historical right wing voters. That suggest that the right does a good job at retaining his base, even if the distribution of votes changes among the major right wing parties.
Partito Democratico, center left, doesn't exibit any strong turnout trend, same as Movimento 5 Stelle, that experienced a uniform decline in all region, regardless of turnout. 
\We see that for the minor parties (O), we see that they experienced performance boost in regions with less turnout decrease. That may suggest that in more politically active areas, the vote mass shifted from M5S to other less institutionalized entities.]
) <turnout-by-party>

#figure(
  grid(
    columns: (auto, auto),
  image("img/alluvial_all.png"),
  image("img/alluvial_right.png"),
  ),
  caption: [On the left major parties performance across the election cycles 2013, 2018, 2022. On the y axis we have total number of votes, parties are ordered each year vote ranking.
\ On the right the focus shifts to the right wing parties alone. The total number of votes accrued by the coalition remains more or less constant across years.]
) <right-wing>
= Conclusions


When we consider the first research question: Q1: 'Did former right-wing voters who voted for M5S in 2018 return to voting on the right, motivated by their racial animus?' 
No effect was found. Looking at the turnout trend, and bearing in mind that the total number of right-wing voters remained roughly the same over the years, we can conclude that the coalition's improved electoral performance was due to its ability to retain voters (even though those votes shifted from Lega and Forza Italia to Fratelli d'Italia).


Turning to Q2, 'Does adopting a far-right communication strategy have a greater impact in areas with higher levels of racial animosity, as indicated by racially charged search rates?', we found evidence suggesting an affirmative answer.
However, we must take into account that both parties started below the 5% vote threshold and were not incumbents when they rose through the polls.
We cannot comment on whether adopting a far-right communication style is an effective strategy for established parties or those coming out of a governing experience. 
A similar analysis could be run in other countries where far-right parties are on the rise, such as Germany, the UK and France, to gain more insight.



== Limitations <limit>

The above conclusions must be weighed against the following considerations.

First, assumption (1) in @vote-share required that a party's attractiveness does not depend on the party from which an agent comes.
This assumption is explicitly violated in @aggregate, where we assume that votes shifted among right-wing parties, making it more likely that a right-wing voter would move to another right-wing party.

In @note1, it is also explained how the static framework employed in #cite(<kononovicius2017modeling>) does not automatically translate into this dynamic analysis over time. There are no theoretical guarantees that the $epsilon_i$ are an accurate depiction of a party's attractiveness, given that the stationary distribution of votes may not be Dirichlet.

In #cite(<kononovicius2017modeling>), a mixture of betas is used to model parties with a spatially segregated base. While the regional nature of the analysis controls for some of that segregation, and the empirical marginal distributions of vote shares resemble Betas for most regions and parties, some of the in-region segregation is still not accounted for.
For example, see Trentino-Alto Adige, where a bimodal distribution is clearly visible (see @trentino). A unimodal distribution of ε in regions with spatial segregation of the base results in a loss of information.



RCSR scores are only readily available at a regional level. In Salganik et al. (2020), more than 200 areas for which the RCSR is available were used for the analysis.
To achieve a similar level of granularity, the RCSR should be computed at provincial level or, at least, at electoral district level.
In its current state, such a transformation could only be achieved by weighting the available city scores against the regional scores.
This would then need to be followed by a matching procedure for the electoral districts. This is not trivial, since the cities available on Google Trends do not always align with the Italian sub-regional classification.
This thorough work could be conducted more efficiently once Google releases the official API it is currently working on.
Due to the time constraints of the project, I decided to download the data manually instead of waiting for access to the API's alpha version to be granted.


The definition and operationalisation of the variable S in @vote-share is informed by the author's political and media perceptions, as there are no purely empirical justifications for it.
The analysis in @vote-share resembles a difference-in-difference approach; however, here the treatment variable is not empirically established, and its validity is debatable.



#set math.equation(numbering: none)  // There are no numbers in sample paper.
#pagebreak()
#set heading(numbering: none)
= Bibliography
#bibliography("main.bib", style: "american-physics-society")

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
  image("img/rcsr_map.png"),
  caption: [Racially Charged Search Rate over Years. It must be noted that the values are standardized along the 4-5 year time period before each election. The 2022 RCSR, is standardized across the 2018-2022 time frame. Where 2018 refers to the time after the election.]
)<map-rcsr> 

#figure(
  image("img/turnout_map.png"),
  caption: [Turnout across elections. We can observe a North South divide and a decreasing trend.]
)<map-turnout>

#figure(
  image("img/turnout_over_time_italy.png"),
  caption: [Historical turnout in Italy. Adapted from https://www.openpolis.it/lastensionismo-e-il-partito-del-non-voto/, last accessed 15-03-2025]
)<turnout-year>

#figure(
  image("img/trentino_voteshare.png"),
  caption: [In Trentino-Alto Adige, a region with a strong independentist tendencies#cite(<agnoletti2012trentino>), we observe the mixture of beta behaviour described by #cite(<kononovicius2017modeling>).
This is an example of the vote segregation effect. It can happen when a party electoral base is geographically segregated, _e.g_ if it is predominantly present in cities. The mixture distribution can stems from the fact that the vote share distribution in areas with higher presence of voters of the segregated community can look substantially different from the the one in areas where they are the minority.
In the graph we can see that for the minor parties, we have a peak at above 40%. Those are probably the districts in ALto-Adige (northern part of the region) where Südtiroler Volkspartei (Svp), the party for the German speaking minority performed the best.]
)<trentino> 
