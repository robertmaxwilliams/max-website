---
layout: post
title: Artificial Intelligence Safety And Security Independent Study Week 5
---

Coninuing the trend on artificial life, I found a quantum evolution experiment and the "Innovation
Engines" paper.

# Week 4 Wednesday

I'm not sure what to read today, I found this:

[Quantum Artificial Life in an IBM Quantum Computer](https://arxiv.org/abs/1711.09442v2) which was
published in nature. I don't understand any of the quantum computing notation or schematics, but I'm
amazed by the claim "Thereafter, these and other models of quantum artificial life, for which no
classical device may predict its quantum supremacy evolution, can be further explored in novel
generations of quantum computers."

I don't know what "quantum supremacy evolution", but I figure it's some organization of quantum
information? I'm surprised it can't be predicted by a classical computer, I'm not sure what a
quantum computer does that is outside the realm of classical computing, I thought it was just a
matter of time complexity and not about computability.

# Week 4 Friday

Paper:

[Inovation Engine](http://www.evolvingai.org/innovationengine)

[pdf](http://www.evolvingai.org/files/InnovationEngine_gecco15_0.pdf)

Their results are startling, the images it produces seem to capture the essense of an images
classes. They also score high on AlexNet classification, which is surprising since neural nets tend
to not recognise icons or symbolic representation. I remember reading that before, pointing out that
shadows of a figure would never be classified correctly, but apparently it is possible to discover
"absctracted" images that get a high classification accuracy.

The problem with similar attempts at solving this problem was getting generated images that look
nothing like the target class and get a low score from the classifier. This is the classic local
optimum problem, where evolution settles on a bad solution because any offspring that vary from it
get an even lower score and can't mutate out of the local optimium.

Their solution was related to PicBreeder, which would use evolution to breed pictures that satisfy
user goals. Also, instead of one lineage to meet one goal, there was a huge pool of creatures and
its fitness is raised by meeting __any__ goal a user is optimizing for. This way, a creature good at
one goal can mutate into being good at something else, like how a few water animals turned out to be
okay at walking on land. Without having many different goals pulling in different directions,
evolving creatures to walk on land would have taken much longer or never happened at all. In the
same way, a creature in the Inovation Engine good at looking like a dog might suddenly be the best
water tower image.

The other aspect is encouraging variety between images. I think they used simple pixel-space
distance to keep it from stagnating, and relied on the other factors to keep the images interesting.
