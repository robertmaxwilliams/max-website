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

