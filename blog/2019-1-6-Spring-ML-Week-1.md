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

