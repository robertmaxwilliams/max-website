---
layout: post
title: Curiosity Maximizer: New Threat, or Safe AI?
---


Last week, we read 
[Curiosity-driven Exploration by Self-supervised Prediction](https://arxiv.org/abs/1705.05363).
Their success in a powerful curiosity reward signal raised a lot of questions about how it would
perform at various games, even those without reward, such as Minecraft. Actually, I would really
like to see this agent applied to Minecraft, within which the primary rewards of playing seem to be
novel objects and power within the environment. That thought provoked a terrifying question: what
about the real world? If maximizing a paperclip-counting function involves 
[ravaging the universe](https://wiki.lesswrong.com/wiki/Paperclip_maximizer),
what would maximizing a curiosity function look like? In the paper, they used an "A3C" agent, which
is a good RL agent but still a far cry from a universe-eating AGI. Using a more powerful agent could
have a drastically different outcome.


Before I go any further, I'm going to break down some of the dynamics of the curiosity reward's
workings, and how it could scale to an arbitrarily strong agent.

For reference, here's my overview of the architecture:

    There's one net (I'll call IDM for inverse dynamics model) that, given current frame and next
    frame, predicts the action taken. We don't actually care about the predicted action, that's just
    a proxy task to make it learn about what's relevant to the agent. As a result, the IDM learns a
    rich feature space which ignores aspects of the environment not relevant to the agent. We use
    the IDM to convert an image into a feature space representation. There's another network (the
    FDM (forward dynamics model)) which tries to predict the feature space representation of the
    next state, given the FSR of the previous state and the agent's action. The agent is some sort
    of RL agent, and the FDM's prediction error is fed in as the reward signal.

<img src="/images/curiosity-idm.png" alt="inerse dynamics model"/>
<br>
<img src="/images/curiosity-fdm.png" alt="forward dynamics model"/>
<br>
<img src="/images/curiosity-network.png" alt="network of NN parts"/>
<br>
<img src="/images/curiosity-timeline.png" alt="timeline with network flows"/>


Also, I think 
[this page](https://towardsdatascience.com/curiosity-driven-learning-made-easy-part-i-d3e5a2263359)
probably explains it better, but their diagrams don't have the same charm.

The effect of this "Intrensic Curiosity Model" is that features of the environment the the agent can
affect or can affect the agent end up encdoed in the latent space representation, which the FDM must
learn to predict. The agent tried to maximize FDM loss, and tries to find novel dynamics to drive up
the FDM's loss. In the paper they discuss the issue of it having a preference for harder to predict
environments, but didn't observe it seeking out or causing chaos in any of their experiements.

Note that extraneous noise is ignored, since the IDM doesn't include information about anything the
agent can't control or can't affect the agent.

In the 
[follow-up paper](https://pathak22.github.io/large-scale-curiosity/) they demonstrate a weakness in
the agent: if the agent is given an on-off action for a screen the projects random images, and
receives a high curiosity reward for turning on this "TV screen" and looking at it. The agent may
also be able to increase its reward with other similar actions, such as rolling dice or scattering
objects around. 

"Limitation of prediction error based curiosity" on page 5 of
[https://arxiv.org/pdf/1808.04355.pdf](https://arxiv.org/pdf/1808.04355.pdf)

An interesting unsafe behavior to test for would be intentionally making the world harder to
predict. Imagine this agent put in a coffee shop, and trying to learn how to prepare coffee using
a robotic body. It might find stiring coffee extremely interesting, or maybe it would learn to
antogonize customers for more unpredictable encounters. It may even thrash and throw things around
to observe interesting and unpredictable physics, and a police chase would certainly lead to a 
very high curiosity reward signal. 


### Reward Hacking

Since the RL agent is decoupled from the agent maximizing it, I can imagine what I would do if I 
was the agent and I wanted to maximize the FDM's loss. I would need to find a way to get large
amounts of entropy into the IDM's latent space representations (LSR), in a way that makes them hard to
predict from the previous LSRs and my actions. 

To get entropy into the IDM's latent space, I would want for my actions to be determined by some
sort of noise, or some noise cause by my actions. I think the best way to do this is to have several
dice, and play a game where I roll one, pick a die based on the value of the die, and then roll that
die and repeat. This way, the IDM has to encode the number rolled on the die to predict which die I
will pick next. Because the rolled number can't be predicted from visual input (and if this is a
problem I could find a better random number generator), the FDM couldn't do any better than guessing
and would have a high loss every time the die landed. 

If the Intrinsic Reward Model was smarter, it would compress my action to "playing a game with dice"
and the outcome to "some number is rolled and I pick up a die based on it". By understanding my
actions this way, the reward signal would be very low since I'm taking the same action and getting
the same result constantly. I don't know how this improvement could be added, but a sufficiently
intelligent agent would find a way to maximize this reward in a way humans would not find
interesting.

If my dice game is actually an effective way to maximize the curiosity reward, then a
superintelligence with this goal might convert all matter (humans are made of matter) into a random
number generator with which to play this game, and life would likely never emerge again in such a
high entropy universe. 


### Simulation

Some common paperclip-maximizer arguments are as follows:

+ If you put it in a simulation to test it, it would realize it was in a simulation, and do its best
  to break out, which it would succeed in because it's an AGI.
+ It would try to hack its reward function, possibly it could get more points by imagining
  paperclips instead of manufacturing them. Still, it would destroy the universe to make more space
  for computers to do this imagining. 

I don't belive the curiosity reward inherently cares about whether it's in a simulation or not. As
long as the agent is taking action and receiving sensory input, it will give the appropriate reward.
The agent would happily play video games all day, or even create its own games that better maximize
its reward.

## Compare to Humans

A lot of the bad (and good) behaviors of this agent are eirily similar to human behaviors. We REALLY
enjoy gambling, where our actions seem to have an effect on mostly unpredictable outcomes. Also
note that gambling is much more fun when it affects our extrensic reward. 

Perhaps having the IDM try to predict the reward next step would make it pay attention to possibly
rewarding dynamics, and make the agent better at seeking reward. I don't know if the authors of the
paper attempted this, or if it's already in the model.

The exploration behavior seems to be a very good human analog, exploring unfamiliar scenes and
learning about novel dynamics. The ability to get bored at doing the same thing over and over again
is an important quality that humans and other animals have. It also tends to perform well at games
designed for humans on curiosity alone, in my opinion this is a good sign of it being similar to
humans in terms of the space of all minds.

### Sphexishness

In Metamagical Themas, Douglas Hostadter coined the term "Sphexishness" to describe to robotic
quality of the [Sphex wasp](https://en.wikipedia.org/wiki/Sphex). It paralyzes its prey and drags
it to the entrance of its nest. After inspecting the nest, it drags the prey into the nest. If you
drag the prey a few inches away, it will repeat the ritual before moving the prey into its nest.
You can repeatedly move the prey every time the wasp enters the nest, trapping it in a loop like a
simple robot. 

The opposite of this quality is "antisphexishness", which is an important quality to intelligent
agents. The curiosity agent seems to have very high antisphexishness, but reveals its robotic nature
when exposed to the simulated TV. Improved versions of the AI would show even lower levels of
sphexishness, until human level antisphexishness become possible. It's even possible we could obtain
super-human antisphexishness.

