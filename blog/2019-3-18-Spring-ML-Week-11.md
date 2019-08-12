---
layout: post
title: Artificial Intelligence Safety And Security Independent Study Week 11
---

This week I will be doing a comprensive, critical review of open-ended curiousity driven
exploration, and other open-ended learning techniques. That's a bit of a vauge subject: AlphaGo
could be considered open-ended since it learns to exceed human abilities through self-play. To
reduce the search space, I'll resetrict this to situations where the goal is unclear or
non-existent, like the real world. 

I still haven't done the experiment to run the DL Curiousity algorithm on Game of Life. I need to
make time for that, it could be very interesting and certainly a good programming task. 

Let's review some papers!

[Open-Ended Learning: A Conceptual Framework Based on Representational Redescription](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6167466/)

They establish a very rought framekwork of how open-ended learning could take place. The paper seems
like a bunch of mumbo jumbo to me, but I also like to see experiments or at least some
incomprehensible math before I start believing what a paper says. One valuable insight is the
problem formulation: Imagine you are a human, and you are going to deploy a robot into some sort of
environment to complete tasks. What kind of tasks? You have no idea. Maybe it has to complete mazes,
maybe it has to kill other robots, or play chess, or invent interesting chess variants to keep its
fellow robots entertained. The point is, this problem sounds impossible. How can you make a robot
that just "does stuff"? However, curiousity seems to be able to perform reasonably well at this
task. Not great, but it certainly tries. I don't understand how their "framework" solves this
problems, but it concerns greatly with representing the world, which was a large part of
curiousity.


[Curiosity-driven Exploration by Self-supervised Prediction](https://pathak22.github.io/noreward-rl/)

This is the one I reviewed before. It seems to be the most powerful exploration algorithm, but it's
only been used on a few tasks. I want to do some more tests with it as part of my paper this
semester.

I'm going to start looking through their references, to see what previous algorithms were attempted
for this task. I'll refer to this agent as Parthak, after the first author.

For more details and termimology, read [this blog post](/blog/2019-1-17-Curiosity-Maximizer)

[A possibility for implementing curiosity and boredom in model-building neural controllers (1991)](ftp://ftp.idsia.ch/pub/juergen/curiositysab.pdf)

This paper's curiosity reward signal is based on the distance between the network's
predicted future state and the actual future state. This is slightly different than Parthak, which
uses the FDM to create agent-relavent LSRs. Parthak's IDM is exactly the same as this paper's IDM.
I think Parthak's improvements over this are more about computer resources improving since 1991 and
less about improvements in technology.

[CURIOSITY AND MOTIVATION TOWARD VISUAL INFORMATION (2018)](http://www.diva-portal.org/smash/get/diva2:1184411/FULLTEXT01.pdf)

This is a human study, where participants clicked on a blurred image to reveal parts of it. They
measured curiousity for this task, the experiment would be an interesting game for an AI to play.

[Exploration in Model-based Reinforcement Learning by Empirically Estimating Learning Progress (NIPS 2012)](https://flowers.inria.fr/mlopes/myrefs/12-nips-zeta.pdf)

I don't understand this paper at all. They talk about how their approach can recover from "incorrect
priors" and changes in dynamics.

[Formal Theory of Creativity, Fun, and Intrinsic Motivation (IEEE 1990–2010)](http://people.idsia.ch/~juergen/ieeecreative.pdf)

THIS is really the key paper for creativity. It has a big list of several curiosity AI papers, and
provides a one paragraph summary of how human curiosity could work:

> For a long time I have been arguing, using various wordings,
> that all this behavior is driven by a very simple algorithmic 
> mechanism that uses reinforcement learning (RL) to
> maximize the fun or internal joy for the discovery or creation of novel patterns. Both concepts are
> essential: pattern, and novelty.  A data sequence exhibits a pattern or regularity if it is
> compressible [45], that is, if there is a relatively short program program that encodes it, for
> example, by predicting some of its components from others (irregular noise is unpredictable and
> boring). Relative to some subjective observer, a pattern is temporarily novel or interesting or
> surprising if the observer initially did not know the regularity but is able to learn it. The
> observer’s learning progress can be precisely measured and translated into intrinsic reward for a
> separate RL controller selecting the actions causing the data. Hence the controller is continually
> motivated to create more surprising data

They also list several existing curiosity algorithms. They tend to work by maximizing the prediction
error of a network trying to predict the environment. Parthak isn't much different, except for the
use of an environment compressed representation (the latent space representation) that correlates to
the agent. It is feasable that you could use the same mechanism to make a reward-relavent LSR.

[Unifying Count-Based Exploration and Intrinsic Motivation (NIPS 2016)](https://arxiv.org/pdf/1606.01868.pdf)

Count based learning is used in finite states, so that a state visited often is "boring" and one yet
unseen is "interesting". They find a way to create peudo-counts, and show that this is comparable to
intrinsic motivation.

[Variational Information Maximisation for Intrinsically Motivated Reinforcement Learning (NIPS 2015)](https://arxiv.org/pdf/1509.08731.pdf)

This is an algorithm for mutual information for high-dimensional data. For a small environment, 
the Blahut-Arimoto algorithm is used but it has exponential complexity. This paper is useful because
many AI algorithms in the past have used mutual information, and couldn't scale to pixel space
problems.



# EVolution

[Innovation Engine](http://www.evolvingai.org/innovationengine)

[Encouraging Creativity and Curiosity in Robots](http://www.evolvingai.org/creative-robots)

Evolution with a curiosity reward

[Curiosity-Driven Optimization](http://people.idsia.ch/~juergen/cec2011tom.pdf)

Using curiosity to explore a cost surface

