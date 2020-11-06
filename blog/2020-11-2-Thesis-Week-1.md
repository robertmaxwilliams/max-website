---
layout: post
title: Thesis Update Log Week 1
---

### Getting started 

This is the first week of keeping updates on my thesis. I've been working on it since the start of
the semester, and now I'm keeping track of my progress each week for Dr. Yampolskiy.

We talked on Friday and I now have a better understanding of what I want to accomplish. I need to
find common themes between AI failures that have occured, and create guidlines for guessing at what
kind of failures to look out for. There's no need to worry about goal specification if you're
writing a simple AI that prices products, but you do need to worry about how it interacts with other
agents (refereing to the time when Amazon pricing bots escalate to astromical prices when in a weird
sort of bidding war).


### Trying to come up with a foundation

My goal for this week is to go through the AI failures that are presented so far and come up with a
task-oriented classification system and some useful terminology for describing the risky situations
and when and how they should be mitigated or avoided.

I also want to bring to the table the idea that these concepts also apply to human institutions and
some humans. Humans reward hack, fail in unexpected ways, and are mostly inscutiable.

Distribution Shift failure: When new situations or agents are added, a catastophe can occur to a
previously stable system
- image classifiers only work on their test dataset and not for real world images
- chatbot/gpt-2 starts producing nonsense if a user provides nonsense text

Pushing a classification system for either very high precision or very high recall results in an
apparent improvement at the degredation of true performance.
- ... cars in semi-autonomous ... fatalities ... too many reactions to actual false positives resulted in a jerky ride 


Interaction Failure: Agents with limited self awareness can cause catastrphes in the ways they interact
- flash crash of the stock market

Race to the Bottom: perverse insentives drive healthy competition into reward hacking territory and
forces prioritization of short term gains
- tetris AI refuses to unpause the game when losing becomes innevitable
- disasters of capitalism: mistreatment of workers, monopolization

Pollution of Distances: If your tech changes how people interact, it might damage social
institutions (democracy, capitalism, community cohesion, trust newtworks)
- social media companies have incredible amounts of leverage on public perceptions
- national leaders can choose to interact directly with the public (trump's twitter)

Reward Hacking type I: If you're optimizing something, it might optimize the reward correctly but in
a way that isn't useful
- evolution creates tall creatures that fall over when you wanted something that could jump

Reward hacking type II: Your reward is misspecified
- boat racing game AI learns to do tight spins on the inside boundary of the track instead of racing
  around the entire track

I thought these two were different, but apparently they are the same? I've forgoten how I thought
they were different.

Sandboxing failure: If you're sandboxing your AI, it might break out of the sandbox.
- JS sandboxing broken by spectre/meltdown
- deep NNs with only linear activations should be equivalent to single layer NNs, but by exploiding
  floating point irregularity, can be trained to compute arbitrary functions

Off-label Usage: If you build a tool to do X with safety precautions a,b,c for that task, it might
be catastrophic if someone uses your tool for Y.
- Hammers are more or less safe for hammering nails, but their safety features cease to be relavent
  if you swing them at people

### An idea?

The race for self-driving cars is
the reason they're doing unsafe things, not some issue with regression. The flash crash happened
because we never should have put a mad cluster of future predicting AI in charge of our economic
system, not because system A did X and system B did Y. Evolution doesn't fail because any particular
reward is misspecified, it fails because exploiting rewards is the ONLY thing it knows how to do -
it just so happens to do it in a useful way sometimes. 

Here is an idea for how to contrain my thesis: If I had to come up with a list that would do the
most good if every data scientist and roboticist read it in five minutes, what would I write? 

I guess I could just start writing such a list, then write the rest of the paper supporting the idea
that these are the most central ideas to avioding catastrophes.

### The List

This is the first iteration of "The List" of things to consider when making __any__ automated system
or system with learned components.

- If your system interacts with the source of its training data, it could reinforce existing
  biases.
- Your reward is not specified correctly
- If you're using evolution, it will hack the reward and game the environment
- If you're using any optimization method, it might hack the reward
- Sandboxing is impossible/best-effort
- The AI will be used for a purpose you did not intend 
- If your AI (however simple) interacts with other AI and/or with humans, it will create a very
  complicated system that you do not have the tools to analyze. Avoid this.
- If your AI changes how people interact (social media, content suggestion algorithms), it will
  change how people talk, think, and live.
- Your AI most likely has defense applications


