---
layout: post
title: Artificial Intelligence Safety And Security Independent Study Week 4
---

# Week 4 Monday 
Monday, Luke and I had a meeting with Dr. Yampolskiy and Dr. Harrison, and each presented one paper.
I presented


# Week 4 Wednesday

Wednesday was a snow day, I worked on an implementation of curiosity machine. I did it in Keras, and
did pretty well for the first swing at it. I'm worried that it wasn't actually using the curiosity,
bit it did manage to "solve" the double pendulum game, although I like that one can be solved by a
random agent. More experiments for later.

# Week 4 Friday

On Monday, Dr. Yampolskiy shared a paper with me. It's a bit long (33 pages) but "it's a fun read",
so it should go quickly. 

### The Surprising Creativity of Digital Evolution: 

A Collection of Anecdotes from the Evolutionary Computation and Artificial Life Research Communities
<br>
[https://arxiv.org/abs/1803.03453](https://arxiv.org/abs/1803.03453)

The paper introduces itself as a correction to a trend of interesting evolution results going
unpublished, losing knowledge about biological-like artificial life and cleverness.

I read over the whole paper, now I'll list off the stories that stood out the most and why I think
they're interesting:

#### Tic-tac-toe memory bomb

An AI playing 5-in-a-row tic-tac-toe on a unlimited board used an exponential function to output
board coordinates, and could cause other AI players to crash by playing a move with a really large
coordinate value. The other AI players used arrays to store the board, and ran out of memory. 

It's not surprising this was possible (although I doubt the game makers had considered it) but it is
surprising the malignant AI discovered this bug. I think human players would also attempt this, and
if playing against an AI that forfeited when out of memory, I have no doubt humans would do this.

#### The Q\*bert one

These bugs sound very obscure and I'm amazed the AI discovered them. They sound like intentional
Easter eggs, but it might just be an artifact of the very efficient (dense, terse) programming
techniques used at the time of the game's creation.

#### Light Seeking Robot

If you have a robot with two light sensors and a wheel on each side, you can wire up the motors to
be controlled by the light sensor such that the robot moves toward the light. An evolutionary
algorithm was given the task of wiring such a robot to seek light most effectively, but the control
scheme it discovered was different from the one humans saw as obvious. It learned to turn in
circles, and drive quickly when facing the light source and slowly when facing away. This pattern
allows it to drive much faster without over correcting as it gets closer to the light, and is "much
more stable in the evolutionary search space", and enabled more adaptations than the "fragile"
solution.

#### Tierra

This evolution simulation looks really interest. I watched this video about it and realized how old
it is:

[Project Tierra](https://www.youtube.com/watch?v=Wl5rRGVD0QI)

I also found this cultish website with a really good write-up on how Tierra came from a game called
"red code" where you would try to hack a minimal instruction set virtual machine, and your program
could even compete for space with other programs.

[Core Wars and Tierra](https://infidels.org/library/modern/meta/getalife/coretierra.html)

They seem to mimic the life patterns of viruses or very simple early organisms, who's main substance
was information-rich molecules and main task was copying themselves. In early life, materials for
these molecules has to be gathered from the environment and assembled; a much more complex process
than what happens inside of Tierra.

Seeing how many interesting things they found in this seemingly simple situation, I think I should
hack together my own open-ended evolution simulation. Theirs runs on a 1d line, with creatures that
have their own "CPU" that runs its "code". It's like a massively concurrent virtual machine... I
think this could be fun. I didn't have any plans for the weekend anyway ;)

Oh shoot, there's an entire [Tom Ray Collection](http://life.ou.edu/pubs/) on his website.

Also, more information about core wars, I want to try this out: 
[https://en.wikipedia.org/wiki/Core\_War](https://en.wikipedia.org/wiki/Core_War)

Oh, and a wonderful web version: [https://www.corewar.io](https://www.corewar.io)

#### Block Creatures

I've seen videos of these things, they're voxel creatures with soft, hard, and articulated blocks.
All of the structural members like arms and legs and all of the motions have to be evolved. Here's
the original paper:

[Unshackling Evolution: Evolving Soft Robots with Multiple Materials and a Powerful Generative Encoding](http://jeffclune.com/publications/2013_Softbots_GECCO.pdf)

Others have created similar simulations over the years, I think this is a wonderful approach. The
3D world and open-endedness of the problem make it very engaging, especially since it discovers
valid morphologies for land animals.
