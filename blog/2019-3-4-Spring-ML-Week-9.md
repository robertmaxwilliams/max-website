---
layout: post
title: Artificial Intelligence Safety And Security Independent Study Week 9
---

This week I won't be doing any exploratory reading. Instead, I will be studying curiosity rewards in
open ended problems, such as Game of Life or Minecraft. I will start by getting a reference
implementation running, and plugging in a game of life simulator with some RL-friendly interface to
take actions in the game. I think the setup be like this: There is a 400x400 board of active GOL
pixels that the AI can observe. In the middle of it, there is some limited fence where the AI can do
various things. This way, the AI can take actions within this limited fence. However, a 400 bit
output channel is a bit much for most RL learners, so instead I would provide a few actions. Here is
where I diverge into a few different schemes:

1. Clipboard/Registers: The AI can draw boxes on the visible pixels, and copy them to a clipboard.
   It could even have multiple clipboards. This way, if it likes a glider it can copy it and paste
   several of them or rotate them and experiment with this
   + This raises the question of how to do the selection. It could take in 4 continuous inputs and
     draw a rectangle on screen, restricted to the maximimum size of the AI's control zone. Or, it
     could be a fixed size, and only take in the center coordinates. Or, it could be fixed size and
     the ai would have discreet "left/right/up/down" to move the box around.
   + There could be a copy button and paste button, and a button for each register. Or there could
     be a copy/paste pair for each register. I think having three registers, with a copy and paste
     button for each one, is a pretty reasonable way to do this

2. Random Starting: A way to find patterns in GOL is to put down noise and watch for interesting
   patterns to evolve. There should be a button to replace the AI's control area with random noise,
   for when it wants to sample interesting stuff.

3. Drawing from scratch: It should have a way to draw arbitrary shapes, with some sort of pen or
   stamps.
4. Play/Pause: It might want to pause the simulation, and draw or copy and paste inside its control
   area. A healthy AI would only pause for short times, because the paused game is not only boring
   but also unlikely to give a reward. Which leads to...
5. Extrinsic rewards: No-reward RL is good, but this setup could also be used in a weakly supervised
   way, or at least with some secret goal states that I expect. Some goals I think are meaningful:
   + Get something to hit the edge of the board (ie build a glider or a universe bomb)
   + Get 5% of pixels on the edge of the board to be alive - either build a lot of gliders or
     universe bomb
   + Create a glider gun - I'm not sure how to measure this one. I could keep track of various
     forms that I want it to find and check for their pressence programatically. This would make a
     nice chart, like seeing which Pokemon you've collected so far.

As much as I want to do this, I'm having trouble working on it. Maybe if I could make it into a real
AI gym and convince myself that other people would use it, I could do it.
