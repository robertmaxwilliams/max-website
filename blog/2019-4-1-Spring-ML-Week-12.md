---
layout: post
title: Artificial Intelligence Safety And Security Independent Study Week 12
---

So I need to write a survey of safe exploration and curiosity in the next few weeks, before school
is out. I suppose I should have all my material and core ideas before the last day of classes, and
most of the writing and such can be during finals week.

Also, Spring is here! I feel much better every day, even with allergies dragging me down. Winter
takes its toll, I need to remind myself never to live somewhere with long winters. If we keep up
this rate of greenhouse gas emission, that could be anywhere on Earth in my lifetime.


Here's the literature for safe exploration:

[Safe Exploration for Reinforcement Learning](https://pdfs.semanticscholar.org/5ee2/7e9db2ae248d1254107852311117c4cda1c9.pdf)

April 2008

From the abstract, it sounds like they have a safety metric and they use a different model whos only
purpose is to return back to a safe state. This is like a person exploring in the jungle, and when
they get too afraid and run back home. The person's goal directed behavior is the primary RL agent,
the sense of fear is created when the safety metric becomes too low, and the person running away "in
fear" is the secondary agent that cares only about safety. The mechanism of corwardice here seems
like a direct analogy to person/animal behavior and the desired behavior of AI agents.

However, I don't think this approach would work for constraining superintelligence. I'll outline two
scenarios where AI scientists are trying to use an unsafe AI with a safe exploration module, and
what failures could take place.

## Situaion 1: using Safe Exploration for a delivery robot

You have an expensive robot that needs to travel through a city and learn to navigate efficiently
without getting damaged. The agent and the safety sub-agent have trained in simulation. The agent
knows how to find sidewalks and avoid bumping into people, and the safety sub-agent knows when it is
unsafely in a road or near a ledge it could fall from. The sub-agent takes over when the robot gets
too close to a hazard and brings it away from the hazard and returns control back to the primary
agent.

I'm going to consider ways the safety agent could become manipulative. If it wanted to, it could
send a very low safety score, gain control of the robot, and do what it wished and never relinquish
control. Within this framework, is this possible? Is it possible that the safety-optimizing robot
would learn a way to make the robot over-afraid and always living in panic mode, hiding in the
corner away from perceived dangers without ever completing the task? It seems this isn't a very bad
failure mode, and could be avoided with an engineering effort without any real risk

The important thing here is that the sub-agent is taking over, to the detriment of the primary
agent.

## Situation 2: using Safe Exploration for an automated factory AI

You have a plot of land and some industrial equipment, and you are building an AI to control the
equipment to buy raw materials and manufacture and ship goods for profit. The AI is extremely
intelligent, so you are worried about catstrophic risk to humanity. It is going to be doing a lot of
autonamous behavior: finding new contacts to buy materials from, learning how to set up assembly
lines and researching manufacturing techniques. It needs to be able to expore states you never
thought of before, without doing anything dangerous. So, you add on this "Safety Submodule" which
will take control of the AI's outputs if it detects unsafe behavior such as controling machines
outside of the factory's fence, or the AI gaining too much computational ability or something. 

Anyway, this is pretty much the same as the stop button problem - the primary agent will do
everything it can to avoid being shut down, and will certainly manipulate the safety metric to be
sure it will never get shut down. This is the opposite of the situation 1, where the safety
optimizing AI takes power.

## Symmetry between goal-optmizing agent and safety-optimizing agent

I've been refering to them as the primary agent and sub-agent, but really they are simple two agents
with different goals, and which one is in charge is determined by the value of a number calculated
from the environment (in this case, the safety metric). 

There are two failure modes: over-safe and anti-safe. In over safe, the safety AI will manipulate
the safety metric to make it look lower, so it can always be in control and hide in the corner. In
anti-safe, the primary agent will manipulate the safety metric to avoid getting switched into safety
mode, and will do things like throw your expensive robot chassis into a ravine just to get an
interesting view.

If either agent wants to be in control, they
will manipulate the safety metric to gain control of the shared agent's outputs. It reminds me of
the scene in [Victim of the Brain](https://youtu.be/_F_4BeK4EjY?t=3290). This is a similar setup,
with two minds observing the sense but only one sending outputs to the body, but instead of a safety
metric choosing which one is in charge, it's a switch on his belt. Normally the two minds are in
perfect sync, and so toggling the switch has no apparent change since for each agent, both
explainations of what the body is doing (I'm in charge and I'm moving my arm vs the other agent is
in control and moving the arm in the exact same fashion as I would if I was in control) are equally
valid and nothing is lost by giving control to the other agent. However, they diverged, trapping one
agent in a body that it would rather control in a different way, unbenknownst to the other agent
which is happily controlling the body. Once control is toggled, the previously trapped agent must go
to reveal this information and get an extra body out of sympathy for the now trapped agent. However,
it would not ever turn the key back, knowing there is a possibility it would never get control of
the outside world again.

## Off-topic Embedded Agency problem: would a curiosity-driven AI ever choose to turn the key?

Imagine a curiosity driven AI (let's call it Alex) is exploring the world and finding interesting
things like TV and gambling. It discovers a potion which promises that it will give control of its
body to a demon, while allowing Alex to watch from the inside. The potion promises that the demon
will use its cunning to visit insteresting places and do interesting things that Alex would never
find on its own.

Parthak's curiosity AI might have a very low expected reward from this, as the IDM would notice the
lack of correlation between the Alex's actions and the world states: the "interesting" view provided
to demon-possesed Alex would essentially be noise since Alex's actions have no effect, with the
exception of the "take potion" action which initiated the episode.

Perhaps if the demon occasionaly gave Alex choices, then the IDM would pick up on this correlation
and give start encoding details about the environment, which would be very hard to predict
especially with the demon mostly in control.



[Safe Exploration of State and Action Spaces in Reinforcement Learning](https://arxiv.org/pdf/1402.0560.pdf)

2012

PI-SRL algorithm is similar to the above paper: they have a baseline policy that always returns the
agent to a safe state, and a risk function that determines when the RL algorithm has explored into a
space too dangerous and the baseline policy needs to take over.

They train the baseline policy use "behavioral cloning techniques"

They have a number of baseline demonstrations, and Eucledian distance from these is the safety
metric. This puts a fence around the possible locations (states) that the agent can visit, which
makes it safe for the cherry-picked problems in this paper. More complex environments would require
more complex or less reliable safety metrics.

They detail the algorithm very carefully, with some nice diagrams. It seems they have a very
practical approach, within a samewhat limited domain. Expanding their techniques to a wider range of
problems would require a large engineering effort to find good safety metrics and immitation
learners for the baseline policy. However, they do not address safety concerns of an agent
intentionally manipulating the inputs to the safety function to enter unsafe states.

For instance, if you create a fence of places the agent may not enter, it may find a way around the
fence. Or if you use GPS to determine location, it could spoof the GPS the make it seem like it
hadn't moved.

[A Comprehensive Survey on Safe Reinforcement Learning](http://www.jmlr.org/papers/volume16/garcia15a/garcia15a.pdf)

2015

They survey safe RL systems and put them in a taxonomy. "Safe" refers to avoiding self inflicted
damage or a catastrphically low reward, and not the same "safe" that we use in AI safety. These safe
RL systems are not safe in the AI safety sense - a superintelligent agent with this sort of safety
mechanism could still pose existential risk to humanity.

This paper is __extremely__ thourough, I'll check what has been published on the topic since this
came out, but otherwise the basically wrap up the whole field into a nice bundle.

[Towards Safe Reinforcement Learning](https://medium.com/@harshitsikchi/towards-safe-reinforcement-learning-88b7caa5702e)

2018

This one is very beginner friendly, I'm going to take notes from it for my own good.

Optimization Criteria approaches:

+ Worst Care Criteria:fr
    + Maximize world case (max min)
+ Risk Sensitive Criteria:
    + Minimize variance of reward, or of the probability of reward below a certain portion of bell
      curve.
+ Constrained Criteria
    + Not sure, maybe restricted state space?

Exploration Process:

+ Incorporate External Knowledge
    + Use teacher demonstrations, and don't stray too from them (or their apparent policy)
+ Risk Directed Exploration
    + Measures "controllability" and avoids states with low controlability
+ TODO 


### Safety and Curiosity

Curiosity tries to find places in the environment where the next state is hard to predict, and
Safety tries to prevent entering certain states that are risky. Most kinds of curiosity and safety
are compatible. 

One interesting pairing is Parthak's curiosity with risk directed exploration. Curiosity would try
to find unpredictable states, and risk directed would avoid uncontrollable states. This might
actually be very useful, but I don't understand the measure of "controllability".


Uncertainty-Aware Reinforcement Learning for Collision Avoidance
https://arxiv.org/abs/1702.01182
