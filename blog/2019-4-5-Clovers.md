---
layout: post
title: Four Leaf Clovers
---

I searched for four leaf clovers yesterday and today, and doing so brought a lot of ideas into my
head about intelligence and probability.

# Zero shot classification

Imagine you've never seen a four leaf clover before, but you've seen plenty of ordinary clovers.
Somehow, your mind can take (knowledge of what 3 leaf clovers are like) and (the idea that a clover
could exist with 4 leafs) and you can:

1. Imagine and even draw a four leaf clover
2. Identify a four leaf clover if you happened to see one among three leaf clovers.

This is pretty crazy, that you can take a visual intuition for looking at clovers and an idea
(formulated in English) and create a new visual intuition, for spotting four leaf clovers. No AI
system I know of could do something so profound.

# Anomaly Detection

Even more impressive, if I told you to find some interesting clovers, you would eventually find out
that most clovers have white speckles in a V shape, and some are plain green, and the hue of green
varies, and some have red speckles and splotches. Some clovers are missing leaves or have malformed
leaves. After a long time looking at clovers, you would eventually find a four leaf one, and perhaps
many four leafed clovers, and you would note how rare and remarkable they are.

# Exhaustive Search vs Skimming

Every time you look at a clover, you should can classify it with poor accuracy very quickly, and
high accuracy. Your confusion matrix for half a second might look like this:

    | actual ->  | 3 leaf | 4 leaf |
    | \/predicted|        |        |
    |------------|--------|--------|
    | 3 leaf     | 90%    | 30%    |
    | 4 leaf     | 10%    | 70%    |
    |            |        |        |

And might have half the error in a whole second. If you have an endless supply of independent new
clovers to look at, and you assume one in five thousand clovers have four leaves, how do you define
the optimal strategy? 

Also note that you can change your sensitivity (I think that's actually the technical term) to 4
leafs, and decrease false negatives at the cost of increasing false positives or something. This can
be done to a classifier by adding biases to the outputs, but how the human mind does this through
act of will is a mystery as far as I know.

My intuition about the values of my own confusion matrix led me to a strategy of looking at clovers
very quickly, hardly pausing on one before the other, or even skimming around many at once without
really fixating completely. If it looked normal, ignore it. If it looks anything like a four leaf
clover, then go investigate it, otherwise ignore it. I will miss quite a few four leaf clovers, but
I make up for it in the number of clovers I see.

# Non-Independence

Something that seems to be true, both from my own experiences (on two occasions) and information
posted online is that four leafed clovers come in groups. I don't know how clovers grow, but it
seems that a cluster a few feet in diameter will share the same genetics. Four leafed clovers are
hard to use for this since they are so rare, but less rare traits (white V shapes, red speckles) do
seems to be clustered in certain locations.

This makes finding them significantly easier. For every 5,000 clovers there may only be 1 four leaf
clover, but it will be among many other four leaf clovers. This means your strategy should take into
account that several observations of no four leaf clovers in an area means that that particular area
probably won't have a single four leaf clover, while finding a four leaf clover means that many are
nearby.

# My data

Yesterday, a friend and I search for an hour for four leaf clovers, and found none. Today, another
friend and I search for a half hour before one of us found one and then we immediately found several
withing a few feet of the first one. We found 8 between the two of us, only 2 of those being "true"
four leaf clovers, with a tiny stem for each of the 4 leaves. The rest had 3 stems, and one leaf
split slightly above the stem to make 4 leaves. From this, I have a single sample for the expected
time to find one four leaf clover __cluster__ to be 3 person hours. Assuming this is 
[Poisson distributed](https://en.wikipedia.org/wiki/Poisson_distribution), my best guess for the
value of λ in hours is 3. 

The null hypothesis is that the true value of λ is 3. There isn't much data so I don't really know
how to approach this, I don't know how to make 95% error bars on this, but I would gander a guess
it's between 1 and 5 hours.

# My recommendations for searching

You want to cover as much ground as possible, so find somewhere with endless patches of diverse
clover. You should see many variations in coloring and patterns, to indicate that there are enough
clovers to have the genetic diversity needed to run into the "mutant" patch (it isn't known
whether this is a mutation or a virus or environmental, but I think "mutant" is still roughly the
right idea and everything above still applies). After looking at one spot for a minute, walk away
from it never to return. Try to keep a little bit of distance from places you've already looked. And
bring friends - the number of person hours spent is also important, so long as you can avoid looking
in the same place twice, or you can look in the same place and exhaust it sooner.

Once you find a single four leaf clover, or a weird leaf mutation, comb the area for a few feet
around. Four-leafedness correlates with other traits, so if for instance your four leaf clover has
red splotches, then look at nearby clovers that have red splotches.

# An AI gridworld

There is a 6x8 grid of clover tiles, except for one starting tile for the agent and one randomly
placed 4 leaf clover containing tile. If the agent stands on a clover tile, it is trampled and
becomes dirt. The agent may spend an action to search nearby tiles, and each search has a 1% chance
of finding the four leaf clover (and getting a reward and destroying the four leaf clover) if it is
present, and 0% otherwise. An intelligent agent would spend a reasonable amount of time searching
each tile, and would attempt to minimize the chance of trampling the only four leaf clover. It's a
bit like playing minesweeper. I think a perfect solution with unlimited time is impossible, since
you would never trample a tile that might contain the four leaf clover, and you can never be certain
that you haven't just happened to miss it no matter how many times you check.

This actually relates to safe exploration - the topic of my AI safety independent study.
