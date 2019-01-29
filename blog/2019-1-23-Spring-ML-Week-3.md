---
layout: post
title: Artificial Intelligence Safety And Security Independent Study Week 3
---

I'm still very interested (curious, even) in curiosity driven AI.
I didn't finish "Responses to Catastrophic AGI Risk: a survey", I need to make a high level review
of the paper sometime soon.


# Week 3 Monday

I wrote about the possible existential threat from an agent maximizing a curiosity reward signal
in detail, read it here:

[Curiosity Maximizer](/blog/2019-1-17-Curiosity-Maximizer)

# Week 3 Wednesday

Reading:

["Logical Induction (Abridged)"] (https://intelligence.org/files/LogicalInductionAbridged.pdf)
<br>
by Scott Garrabrant, Tsvi Benson-Tilsen, Andrew Critch, Nate Soares, and Jessica Taylor

They make the distinction between empirical uncertainty (an unseen coin flip) and logical
uncertainty (the value of the billionth digit of pi). Logical uncertainty occurs due to limitations
of intelligence and computational power of agents, something not usually considered in probability
theory.

The "logical induction" they wish to model in a computer imitates that of a human mathematician. It
takes in theorems in a formal language, and assigns each a probability, faster than they can be
proven. 

I believe this work is related to the insight that a mathematician can look at a theorem and quickly
know whether it is true of false. Mathematicians often make mistakes in constructing proofs
of theorems that eventually turn out to be true, showing they have a truth-telling mechanism which
is stronger than formal proof. An famous extreme example of this sort of skill is 
[Srinivasa Ramanujan](https://en.wikipedia.org/wiki/Srinivasa_Ramanujan), who created deeply
insightful theorems, usually without supplying proof, most of which later turned out to be true.


They claim such an algorithm has the following properties (quoted verbatim):

1. Their beliefs are logically consistent in the limit as time approaches infinity.
2. They learn to make their probabilities respect many different patterns in logic, at a rate that
   outpaces deduction.
3. They learn to know what they know, and trust their future beliefs, while avoiding paradoxes of
   self-reference.

They make a bold claim right away:

"Our main finding is a computable algorithm which satisfies the logical induction criterion, and
hence exhibits the properties listed above."

The next section gives an overview of the notation they use, the only notable thing is using
underlined variables to mean "substitute in the value of this variable", which is an interesting
language feature. It makes me want to write programs in a cyclic tag system... but back to the
paper.

They talk about "markets", as if the probability of each theorem was a price in a prediction market.
Prediction markets with mathematical theorems would be pretty interesting, actually, although there
may be a sudden influence of bogus proofs, and if a proof turned out to have a flaw there's no way
you could get people's money back.

I'm going to keep this paragraph for reference:

"We can visualize a computable belief sequence as a large spreadsheet where each column is a belief
state, and the rows are labeled by an enumeration of all logical sentences. We can then imagine a
reasoner of interest working on this spreadsheet, by working on one column per day."

They consider "traders" that buy and sell theorems at the "price" based on their likelihood, that
pay out at 1 when the theorem is proved, or go valueless if it is disproved. 

They consider the Godelian theorem "This theorem has a price less than 0.5 on day 10". It can't be
true, because then it would have a price of 1 and be false, but it can't be false (or it would
become true). They explain the resolution to this having to do with finite precision access to
trading prices, but I don't understand how that avoids the paradox.

Another interesting case is when two theorems are mutually exclusive, say we can't prove or disprove
`A` or `B` but we have a proof that exactly one of `A` and `B` are true and both are trading at 0.2.
Then we can buy one of both, and our position would cost 0.4 and have a value of 1 regardless of
which theorem turns out to be true. The kind of arbitrage would result in conditional facts about
theorems being included in the pricing. In this case, the price of `A` and `B` must sum to 1.

Oh, on page 12 they make the analogy of Ramanujan as the inductive "intuitive" mathematician, and
G.H. Hardy as the rigorous deductive mathematician.

# Week 3 Friday

Luke is continuing logical induction, I will do the same. 

I've gotten throught the main part of the paper, and now I'm in the theorems about the properties of
the algorithm. Even if I could summarize them, it would be more benificial for me to analyze the
paper on a higher level. I'm going to start with 
[How to Read a CS Paper](http://www2.cs.uregina.ca/~pwlfong/CS499/reading-paper.pdf).


1. What is the research problem the paper attempts to address? 
    How to create agents that can assign probabilities to theorems faster than they can be proved. 

2. What are the claimed contributions of the paper? 
    An algorithm that converges to this behavior and has many nice theoretical properties, while
    being provable.

3. How do the authors substantiate their claims?
    They explain how they developed the algorithm and why it has these properties. However, they do
    not show any output of the algorithm running, or indicate a publically available implementation
    as far as I can tell. They present many theories about their algorithm (and prove them in the
    full paper) but most of them are beyond my understanding at the depth I'm reading this paper.

4. What are the conclusions? 
    They conclude their algorithm can be applied to any situation with true/false conditions in
    descrete time; it could also play prediction markets and be used as a does-a-program-halt
    estimator. 

I foud this blog post by the first author (Scott Garravrant) explaining their process of making the
discovery: 
[https://www.alignmentforum.org/posts/iBBK4j6RWC7znEiDv/history-of-the-development-of-logical-induction](https://www.alignmentforum.org/posts/iBBK4j6RWC7znEiDv/history-of-the-development-of-logical-induction)

And their first blog post on a related issue:
[https://www.lesswrong.com/posts/NHFFzBF4b3SZLHckt/how-should-eliezer-and-nick-s-extra-usd20-be-split](https://www.lesswrong.com/posts/NHFFzBF4b3SZLHckt/how-should-eliezer-and-nick-s-extra-usd20-be-split)

They ask for the reader to consider their own solutions to the following problem before moving on,
so I will do so here, even through it's a bit off topic.

    Nick and Eliezer took a taxi and split the fare. They find an extra twenty. Both don't think
    it's theirs and want the other to take it. Nick thinks the probability that it is his is 15%,
    while Eliezer thinks there is a 20% chance it is his. How should the split the twenty?

The obvious joke solution is to give the taxi driver a huge tip, since neither person thinks it is
theirs. Or you could have a random number generator with a 15% chance of giving it all to Nick, 20%
chance of giving it to Eliezer, and the 65% chance of destroying it. Then, allow Nick and Eliezer to
modify their probabilties until they both no longer want to change.

The answers given all use the given facts and calculate some value around 11 or 12 dollars, using
four different methods of combining or averaging beliefs.
