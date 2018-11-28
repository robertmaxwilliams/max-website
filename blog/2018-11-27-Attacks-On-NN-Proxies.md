---
layout: post
title: Attacks On NN Proxies
---

I'm working on a way of controlling arbitrary physical systems using low energy inputs. The idea is 
to create a NN (neural network) model that emulates the real world system, develop adversarial attacks against the NN
model (which I call the proxy for the real system) and apply those attacks against the real system.

When I say "system", I'm imagining a stock and flow system or similar, as described
[here](https://wtf.tw/ref/meadows.pdf), which has external inputs and outputs, and dynamic internal
behavior. By observing inputs and outputs, a NN should be able to emulate the behavior of the system
with some degree of accuracy.

A toy example is attacks on a mass spring system. First, create a simple simulation of a mass spring
system, which can be given little nudges at every time step. This is the "real" system that we want
to attack. In this example, let's say our goal is to maximize the energy in the system after 10
seconds of simulation. A recurrent neural network (RNN) is trained to behave the same as the mass
spring system. Next, adversarial inputs are create against the model. If the RNN model is perfect, 
then the result should be a wave at resonance of the real system, which would maximize our
objective for both the mass spring system and the proxy. More likely, however, is that the RNN would
have weaknesses besides those inherent to the real system, and would the adversarial example's
resulting behavior on the real system would be used as a training run. Iterating this process might
lead to an RNN the emulates the real model so accurately that attacks on the proxy always transfer
to the real model.

This is the experiment I'm working on implementing right now, but learning Autograd frameworks is 
difficult. 

Should I succeed at this, the next step is to apply this technique to complicated coupled mass
spring systems, and see how it works with chaotic behavior, like in a double pendulum or three body
gravitational system. 

Imagine doing this for a three body system, and learning a policy for a tiny booster on an asteroid
that could force the ejection of the largest body into deep space. Or an attack on a global trading
network to cause a flash crash. How possible either is these is is up for debate but there's no harm
in dreaming.

This technique almost sounds like a variation on reinforcement learning, but with a different
starting point. I do believe it will work on mechanical systems (I won't know until I do
experiments) but it's hard to say if it could work on video games or biological systems. What if you
could train on audio input to human ears as system input with fMRI data as system behavior, and
tried to maximize activation in a part of the brain? Could it be trained to create hypnotic or
physiologically powerful audio? Speculating is fun but it's pointless until I make a toy model
showing that the concept is sound. 

There are some things where this would simply not work. For instance, it would probably be very poor
at Mario... I think. Actually I have no idea.


