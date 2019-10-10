---
layout: post
title: Adversarial Transfer to Humans
---


I'm currently working on the topic of "Adversarial Examples Transfer from Recurrent Neural Networks
to Finite State Automata". Recurrent Neural Networks (RNNs) can be made to misclassify a sequence
with very small input perturbations, analogous to 
[adversarial examples for image classification](https://blog.openai.com/adversarial-example-research/).
Some adversarial examples also 
[transfer to humans](https://arxiv.org/abs/1802.08195). From this, I make the hypothesis that given
some real-world or simulated system of any kind that performs a task, a neural network proxy can be
made to approximate it. Correctly crafted, inputs that cause a failure of the proxy should
have a similar effect on the real system. Exactly what kind of systems this is possible for and how
to go about making proxies that give useful adversarial examples is the challenge here.

I'm working on an RNN that emulates a spring-mass system, and determining whether the standard way
of creating adversarial input will discover how to make a sine wave at resonance to maximize
displacement. This is starting to sound like a poor substitute for reinforcement learning, but I
need to actually do experiments before I can know anything.

Related is 
[World Models](https://worldmodels.github.io/) which learns a kind of emulator for an environment
then trains policies inside the emulator. You could make a human emulator then learn to manipulate
it.

