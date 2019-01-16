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

**Ethical Status**: An entity has ethical status if you believe it deserves consideration into
ethical choices. For instance, most people agree that all humans have ethical status and deserve to
live. Vegeterians choose to believe that animals have ethical status and deserve to not be
systematically killed for their flesh. Vegans take this further and grant animals even higher
ethical status by believing that animals lack the facualty to grant consent to take from them, and
thus taking milk from cows or eggs from chickens is unethical.

**Mindcrime** (from Bolstrom): A crime that can be performed within ones own mind (which may or may not be a
computer) such as simulating sentient beings suffering. That's actually the only one I can think of.

After reading the abstract once, I tried to guess at what the paper was about:

    It sounds like this paper is focusing on how to satisfy multiple agent's goals,
    once you have a good way of extracting goals. So if a paperclip CEO and a postage stamp CEO both
    wanted to make a universe eating AI, how could they makes sure it had both of their values?

My guess wasn't entirely wrong, it's actually a way to sidestep the multi-agent value alignment problem entirely
by giving every agent their own simulation. So the paperclip maximizer would maximize paperclips in
one simulation and the stamp maximizers would maximize stamps in another simulation, each free to be
as destructive and horrible within the safety of the computer. Yamposkiy also states that is is
probably desirable for the agent (called the "user" at this point in the paper) to "forget" that
they are in a simulation.  The simulation itself is ran by an AGI (artificial general intelligence)
and the virtual environment is assumed to be "safe", meaning the AGI controlling everything is
assumed to have some degree of human value alignment preventing it from putting everyone in eternal
torture or reducing humanity for the sake of a poorly defined goal, such as maximizing happiness by
filling the universe with tanks of seratonin. 

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

## Week 1 Friday

Reading: [https://arxiv.org/pdf/1806.07366.pdf](https://arxiv.org/pdf/1806.07366.pdf)

From the abstract, they claim to have made a continuous version of a multi-layered neural network,
so instead of having 10 layers you have 10.0 layers with data smoothly sliding between them, using
differential equation solvers somehow.

The first page explains it in terms of basic calculus. They call a normal hidden state RNN a "Euler
discretization of a continuous transformation", and the smooth version.

If the discreet version is this:

`h_(t+1) = h_t + f(h_t, O_t)`

then their "smoothed out" version would be the limit of this:

`dh(t)/dt = f(h(t), t, O)`

as h approaches zero (actually it looks like varying `h` is on of the important aspects of this
model)

They describe various advantages of this, such as constant memory usage with depth, ability to
tradeoff accuracy with resource consumption, reducing the number of parameters needed, something to
do with change of variable and normalization, and the ability to process continuous time data.

The key part of this method is the use of an "ODE solver" to compute the parameter updates. It is
possible (but not usually necessary) for gradients to be backpropagated completely through the
model, allowing it to be used as a part of a large end-to-end trainable model.

I really don't understand a lot of the math here. It's somewhat familiar from differential equations
but my math reading skills are quite poor. I'll come back to the mathy section after I'm done with
the first read through of the paper.

They also introduce "continuous normalizing flows", where the differential equation describing the
network changes with time. Also they introduce a "gating mechanism" for each hidden unit, it seems
to be another way of taking time as a parameter that tweaks the network parameters.

#### Experiements

The next section shows several experiements, including density plots showing the difference in
learning a normalizing flow (NF) and continuous normalizing flow (CNF). The CNF is shown to be
superior. They also show this distinction on the task of drawing two concentric circles, and talk
about how the CNF learns to "rotate" the plane to draw the circles accurately. I have no idea how
that could work. They included a series of videos of the learned behavior:

[http://www.cs.toronto.edu/~jessebett/nodes/playlist.html](http://www.cs.toronto.edu/~jessebett/nodes/playlist.html)

And I see the rotating now, and the first few show the vector field, but I really don't understand
what't going on. 

The experiements with spirals are interesting, the RNN performs very poorly at extrapolation and has
a lot of sharp edges in its prediction, while the LNODE (Latent Neural Ordinary Differential 
Equation) smoothly follows the path and extrapolates accurately. 

#### Math stuff

I don't think this paper will make any sense unless I understand the underlying math.

They compare their method to residual networks in several places. I read
[this](https://blog.waya.ai/deep-residual-learning-9610bb62c355) to get an idea of how residual
networks work. The idea is to have the identity function as a shortcut around some layers, allowing
for really deep networks to be trained without having to have the gradient get all scrambled in
dozens of intervening layers while training. 

After staring at Figure 1 for some time, I think I'm starting to get an idea about how this all
works. Interpreting the figures is half the battle, since I don't understand what they represent. On
the left, they're modeling a normal multi-layered network as a series of transforms. I think the
reason they choose a residual network is because they add the layer's output and input to get the
residual block's output, which makes a continuous approximation more sensible. 

<img src="/images/resnet-vs-ode.png" alt="Figure 1 from ODE paper" width="286"/>

I think how you're supposed to read this figure is each black line is one data point coming into the
network at the bottom and being transformed by several layers, following a trajectory until it
reaches the end of the network as output. In the ODE network, they same thing is done, but instead
of adding something to the state at each layer, the field is a vector field defined at every point,
and the ODE solver approximates the motion of a data sample through the network, sampling the
function as nescassary. 

I think I have a sorface level understanding of it now. How this "network" is trained, however, is a
mystery to my. They talk about using the "adjoint method". They cite a 1962 paper on optimimal processes:

Lev Semenovich Pontryagin, EF Mishchenko, VG Boltyanskii, and RV Gamkrelidze. The mathematical
theory of optimal processes. 1962.

It's hard to find, but the method itself is on wikipedia:

[https://en.wikipedia.org/wiki/Adjoint\_state\_method](https://en.wikipedia.org/wiki/Adjoint_state_method)


(Out of time for now, I should revisit this at a later time)


# Meeting Notes

We had a 30 minute meeting with Dr. Yampolskiy, Dr. Harrison, Luke, and myself. 

At the mention of the curiosity driven AI paper, Dr. Yamposkiy sent us this paper:

[https://www.mitpressjournals.org/doi/pdfplus/10.1162/EVCO\_a\_00025](https://www.mitpressjournals.org/doi/pdfplus/10.1162/EVCO_a_00025)

I would really like to make my own implementation of the curiosity reward signal, it seems fairly
straighforward in it basic form and the official implementation isn't monumental in size. I wish
there was a better way to describe graphs in programming languages, like a text-based format with an
interactive editor. Most object oriented programs are graphs as well, program source visualization
seems to be very underutilized. 

Next we talked about the "Personal Universes" paper (that Dr. Yampolskiy authored). I wanted to ask
more question but we were short on time. I emailed Dr. Yampolskiy and he said my questions were good
questions to ask and we should talk about it in person. Dr. Harrison also brought up a paper he
authored about using simulations to solve the stop button problem:

[https://arxiv.org/abs/1703.10284](https://arxiv.org/abs/1703.10284)

I heard about this solution in a Computerphile video by Rob Miles (might have been
[this one](https://www.youtube.com/watch?v=3TYT1QfdfsM)) and the problem is that when the agent is
returned to the real world, it experiences some kind of interruption, which might lead to a negative
reward and thus the stop button problem returns. 

We trailed off at "Neural Ordinary Differential Equations". Luke and I approached this one the same
as the other two (by trying to understand it as best as possible) and got tangled in the details.
Dr. Harrison reminded us that our final paper doesn't need to include summaries of all of the
papers' contents, but instead on thier claims, support, impact, etc. A good thing to notice here
would have been the apparent cherry-picking of toy problems they solved using their method. How
could it perform on some varient of MNIST? I could search around for other studies on this method,
and see if anyone has performed more experiments like MNIST or natural language processing.

Dr. Yampolskiy also sent me some links to read, which I'll catalog here:

[http://iopscience.iop.org/article/10.1088/0031-8949/90/1/018001](http://iopscience.iop.org/article/10.1088/0031-8949/90/1/018001)

(Oooh html format, and very tastefully done.)

This paper reviews existing literature to review the possibility of catastrophic risk from AGI.
Their references are a great pool of material for this indepentent study.

[https://www.lesswrong.com/posts/a72owS5hz3acBK5xc/2018-ai-alignment-literature-review-and-charity-comparison](https://www.lesswrong.com/posts/a72owS5hz3acBK5xc/2018-ai-alignment-literature-review-and-charity-comparison)

(Oh I love lesswrong! The stuff here tends to be a bit extreme but I guess I'm a bit of an extremist
in some domains, too. Also this html paper format is nicer than the other one.)

I also like how they drop words like "infohazard", it makes me feel like I'm living in the SCP
universe. Feeling like you're in a sci-fi tends to be a goal of "futurists", whatver implications
that has. 

"Contemporaneous unemployment has more to do with poor macroeconomic policy and inflexible labour
markets than robots."

That's a bold statement, I'll have to start throwing that around when people are throwing around
thier expert opinions on unemployment.

The aithor also believes that UBI will not be helpful when there are a lot of emulated humans around
claiming personhood. I don't think this is relavent to the UBI discussion at all. It also harks back
to [Meditations on Moloch](https://slatestarcodex.com/2014/07/30/meditations-on-moloch/) which I
appreciate greatly but find myself wondering about how applicable it is to the real world, with its
many levels of living things and their interactions.

[https://futureoflife.org/landscape/](https://futureoflife.org/landscape/)

A graph visualization of the entire field of AI safety, in a taxonomy. I'll have to spend more time
with this, it's very dense with meaning.

