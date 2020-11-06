---
layout: post
title: Thesis Update Log Week 1
---

This is the first week of keeping updates on my thesis. I've been working on it since the start of
the semester, and now I'm keeping track of my progress each week for Dr. Yampolskiy.

We talked on Friday and I now have a better understanding of what I want to accomplish. I need to
find common themes between AI failures that have occured, and create guidlines for guessing at what
kind of failures to look out for. There's no need to worry about goal specification if you're
writing a simple AI that prices products, but you do need to worry about how it interacts with other
agents (refereing to the time when Amazon pricing bots escalate to astromical prices when in a weird
sort of bidding war).

---


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


