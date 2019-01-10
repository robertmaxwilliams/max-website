---
layout: post
title: Artificial Intelligence Safety And Security Independent Study
---

This semester at UofL, Luke Miles and myself are working with our professors (Brent Harrison and
Roman Yampolskiy, respectively) on an independent study. We will be reading 2-3 papers concerning
advancements in artificial intelligence and AI alignment each week, and making write-ups on them,
leading up to a big publication at the end. I would also like to do some implementation work, and
get my TensorFlow skills up to the point where I can build things based on papers and implement my
own ideas.

## Week 1 Monday

Reading: Curiosity-driven Exploration by Self-supervised Prediction

https://arxiv.org/abs/1705.05363


#### Four questions, from Dr. Fong's "How to Read a CS Research Paper"

1. What is the research problem the paper attempts to address? 

    + How can an agent explore its environment productively?
    + How can an agent perform well with no extrinsic reward?
    + How can an agent work with very high dimensional data (images) efficiently? 
    + How to formulate curiosity

2. What are the claimed contributions of the paper? 

    + They have created a formulation for curiosity that works with noisy high dimensional input and leads
    to high performance in Mario and VizDoom without intrinsic reward.

3. How do the authors substantiate their claims?

    + They explain the algorithm and show the agent's performance in two video games, and perform
    experiments on the agent showing its abilities.

4. What are the conclusions? 

    + Their formulation is very useful and should be expanded on and applied to real world robotics or
    something.


#### My own thoughts as I read the paper:

The abstract makes it sound very promising and explains some high level aspects of the agent. 

They model "curiosity as the error in an agent’s ability to predict the consequence of its own
actions in a visual feature space learned by a self-supervised inverse dynamics model"

So it sound like they pass the screen pixels through some sort of convnet (imagine an autoencoder)
and have the agent try to predict the feature space. That makes sense. Instead of having me predict
the color of every pixel on the screen, I could instead try to predict the "is a coin near Mario"
neuron.

Aside: I was listening to a psychology talk about reductionist science and neuroscience. In early
neuroscience they wanted to understand the brain as a machine, and were very excited to see
individual neurons that would turn on for each "pixel" in they eye, and more for each little line,
and more for each curve, all of these spatially oriented along the plane of vision. They were very
disappointed when no neuron lit up for higher level shapes. There was no triangle neuron, or apple
neuron. The speaker claimed it was due to the exponential growth of the amount of hardware needed,
since having a plane of these neurons is increasingly spatially expensive as you have more shapes to
map. Convnets seems to be an excellent model for the reductionable parts of the brain, but our
models for the rest of the brain, where concepts exist in the lines between millions of neurons and
patterns loop back around and stimulate themselves, is completely lacking.

Curiosity driven AI have been attempted before. I remember a video of a robotic arm playing with
blocks.


"As human agents, we are accustomed to operating with rewards that are so sparse that we only
experience them once or twice in a lifetime, if at all."

I don't know what the author is thinking of, I can't think of a reward signal that sparse. If you
model my life as a reinforcement learning problem, most of my rewards are pretty straightforward.
For example, it might look like me attending college is part of a long running scheme to get more
money. But even though I might be going to college "to get a good job", I'm not here because I can
plan that far ahead, I'm here because of social pressures and inertia, and I stay because of social
bonds and enjoyment of the minor successes is grants. I think this is the author's point, that
modeling human motivation as RL doesn't make a lot of sense.

Aside: In my (probably inaccurate) imaginings of early humans, I see them are being much more
similar to RL agents, chasing reward signals and impulses. The only difference with modern humans is
social conventions and culture, which lend to an incredible increase in apparent long term planning
and impulse control. I say apparent because although education is a very long term thing for a
person to invest in, I don't think anyone does it for the right reasons. 

The author introduces two framings for curiosity. 1) encourage the agent to explore novel states and
2) have the agent try to learn about its environment, measured by its ability to predict the future.
Both of these have been tried many ways. They claim the following is the key insight of their
technique:

"we only predict those changes in the environment that could possibly be due to the actions of our
agent or affect the agent, and ignore the rest. "

They transform the input space into a feature space, which is learned on a secondary learning task,
that they refer to as an "inverse dynamics task". Given the current state and the next state,
the inverse dynamics model (IDM) learns to predict the agent's actions. This learns a rich feature space that ignores anything
that doesn't affect the agent or could be effected by the agent. Genius! __But how???__

They use this feature space to train the "forward dynamics model" (FDM) to predict the next state,
given the feature representation of the current state and the action taken. The FDM's prediction
error is given to the RL agent as its reward signal. 

I think I understand the basics of the model, but I'll have to think about how all of this
interacts.

Here's roughly how I understand it:
There's one net (I'll call IDM for inverse dynamics model) that, given current frame and next frame,
predicts the action taken. We don't actually care about the predicted action, that's just a proxy
task to make it learn about what's relevant to the agent. As a result, the IDM learns a rich feature
space which ignores aspects of the environment not relevant to the agent. We use the IDM to convert
an image into a feature space representation. There's another network (the FDM (forward dynamics
model)) which tries to predict the feature space representation of the next state, given the FSR of
the previous state and the agent's action. The agent is some sort of RL agent, and the FDM's
prediction error is fed in as the reward signal.

They use an "A3C" agent in VizDoom with and without the curiosity reward signal in addition to the
sparse reward provided by the game. The curiosity signal proved important for finding the goals in
the game.

It also explored most of the first level of Mario with no rewards at all, and learned how to walk
around in VizDoom without rewards.

I don't have enough time today for the rest of the paper but it seems to be mostly more careful
experimentation. What I really want to see is this agent play games that don't have goals, such as

Minecraft or Game of Life/[Lenia](https://chakazul.github.io/Lenia/JavaScript/Lenia.html). THAT
would be exciting.

One of the authors has a website with aditional content about the paper, and a follow up paper:

[https://people.eecs.berkeley.edu/~pathak/](https://people.eecs.berkeley.edu/~pathak/)


## Week 1 Wednesday 

Reading: 
Personal Universes: A Solution to the Multi-Agent Value Alignment Problem

[https://arxiv.org/abs/1901.01851v1](https://arxiv.org/abs/1901.01851v1)

This one was Luke's finding, it is more aligned with our goal (pun intended) of studying agent
alignment.


Terms used in the paper and in this write-up:

**ISU**: Individual Simulated Universe. A simulated universe tailored to a single person's best
interests.

**AGI**: Artificial General Intelligence. An artificial mind with general reasoning skills, possibly
similar to a human mind but possibly very different and dangerous because of their power and
different goals.

**User**: The "real" agent in an ISU, like the player in a video game.

**NPC**: Non-playable Character, a video game term I'm using to talk about the "fake" agents in an ISU.

After reading the abstract once, I tried to guess at what the paper was about:

    It sounds like this paper is focusing on how to satisfy multiple agent's goals,
    once you have a good way of extracting goals. So if a paperclip CEO and a postage stamp CEO both
    wanted to make a universe eating AI, how could they makes sure it had both of their values?

My guess was wrong, it's actually a way to sidestep the multi-agent value alignment problem entirely
by giving every agent their own simulation. Yamposkiy also states that is is probably desirable for
the agent (called the "user" at this point in the paper) to "forget" that they are in a simulation.
The simulation itself is ran by an AGI (artificial general intelligence) and the virtual environment
is assumed to be "safe", meaning the AGI controlling everything is assumed to have some degree of
human value alignment preventing it from putting everyone in eternal torture or reducing humanity
for the sake of a poorly defined goal, such as maximizing happiness by filling the universe with
tanks of seratonin. 

I have some troubles with this, that aren't addressed completely in the paper:

About being able to forget that you're in a simulation, is it ethical to enable people to forget
specific facts? (Think of the consequences in the movie "Eternal Sunshine of a Spotless Mind")?
This decision to doom your future self to never know the truth of their world seems like a
profound action, possibly even a crime against your future self. In the same line as suicide is
illegal, perhaps intentionally forgetting that you are in simulation could fall under the same
category.

If people are given the choice to live in the real world, what rights do they have in the real
world? A value alignment problem emerges here, for those agents who refuse to participate in the
simulation.

If there's no freedom to opt-out or if the real world is really terrible or boring, then this
situation is more like an eternal prison, like The Matrix.

In an accurate simulation of the world, you would have to simulate other people. The ethical
status of simulated minds is a point of debate, but I expect the following possiblilities to be
reasonable to anyone who rejects substrate cheavanism (like Bolstrom):
+ The simulated minds are accurate simulations of humans. In this case, allowing a person in their ISU
  (individual simulated universe) to torture its inhabitants, or simply deleting unneeded simulated
  minds, could amount to enourmous mindcrime. Any one "real" agent could dedicate all of the
  computer resources to simulating minds being tortured.
+ The simulations are externally completely indistinguishable from humans but carefully designed not
  to have ethical status. I question whether this is remotely possible, and I personally tend to 
  believe that a functionally equivalent human has the same ethical status as a perfect simulation
  which has the same ethical status as a meat and bones human. 
+ The simulations are more like today's video game AI and aren't capable of general intelligence.
  This would comprimise the believability of the simulation, and there comes a point where the
  simulation are accurate enough that the "real" agent develops deep empathetic bonds with the
  "fake" agents and treats them as real. 
+ **[Good idea]** Instead of dealing with the moral quandries of simulating lesser minds inside the
  ISU, the AGI that controls the universe could instead be like an actor in a play, simulating the
  characters within ISUs just as actors play the role as characters in a performance and no mind
  crime is committed when the actor takes off the costume and the character disapears. 
  
  
#### Issues with the idea of having the AGI be an "actor" to play the NPCs in everyone's ISU

An actor in a play has to create a mental model of their character accurate enough to represent the
character's personality, and the gaps are filled in with their real personality. Something similar
happens when we empathise with people around us: we create a mental model of their personality and
assume everything else is the same as our own mind.

Speculating about an AGI acting as a person inside of one of these ISUs, it seems there are many
ways mindcrime could still be committed. It's very speculative, because I'm assuming it would use a
human-like machanism for acting out the NPCs. Assuming that, the AGI would have a human-like
base personality mask, then specific masks for specific NPCs. If these "masks" are detailed enough,
then they might have ethical status of their own.

Aside: sorry for changing terms all the time, these are a lot of sticky ideas and I'm trying to get
my thoughts out as clearly as possible without spending tons of time editing. That will come later.

**And also some fun word play:**

The last line of the paper is as follows:

    "The main point of this paper is that a personal universe is a place where virtually everyone
    can be happy."

but add some commas and a different meaning emerges:

    "The main point of this paper is that a personal universe is a place where, virtually, everyone
    can be happy."


