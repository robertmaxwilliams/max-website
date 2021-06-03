---
layout: post
title: Summer Week 3
---

Got through commencement, letting the dust settle and organizing and planning

- Monday: Got back from mom's, did a bit of cleaning
- Tuesday: Went clothes shopping
- Wednesday: deep cleaned kitchen and this room, innoculated grain spawn with pink oyester LC
- Thursday: cleaned bedroom, baked bread, singing lessons, and started another batch of rye
- Friday: 

# Thursday

I haven't been doing any desk work this week, and that's okay. I'm shifting my goals again - I want
to quit any unfinished projects I started and focus on artificial life. I think I've gained a
deeper understanding of the nature of what makes living things alive, and I want to put my feeling
of knowledge to the test by trying to implement it. Cellular automata are really the best that we've
got, and I think they're tenable. Ackley's random updates is VERY clever, since it adds robustness
and I think it's the only feature required for indefinite scalability.

So, I want to throw everything else he did out the window and only focus on 2d tiling CA with random
updates. There are 3 directions to go, using MFM as the starting point:

- More complex. Each cell gets to be its own computer, and the language allows for writing in an
  interruptable style intead of complete functional style. Persistent memeory for each cell is
  raised to hundreds of bytes
- Less complex. Each cell is in some resticted binary computer styles, which allows for discreet
  eveolution
- Smoother. Use Neural network techniques to make a floating point linear algebra based system,
  which also allows for evolution. This also means the the "programs" can be matrices which are
  stored inside the world instead of outside of it.

Smoother and less complex are the first to work on, since being able to evolve and diversify the
cells through stored, volatile programs feels important.

# Friday

Other alife programs have really simple rules and so little state that it's almost non-extistant.
For example, Lenia (which is awesome) has a 2d grid of floating point scalars.

I have a fairly elegant idea for a neural-network-like MFM-inspired alife system, but I'm worried
that it might not be expressive enough and it will end up being a huge mess by the time I'm done. 
This is the "Smoother" system mentioned yesterday and I'm not sure I'm ready to try and make it.

The simplified stored program MFM (less complex) might be just the right thing. Each cell has
program memory and data memory, and the programs just consist of bit arrarys that act like matrices
for the bit vector data.

Noon:

Got the program written, need to fix a few minor issues (accidentally allocated a megabyte of data
on the stack which cause instant segfault) but then it should be running and I can hack together a
quick anti-gui. Lunch time.

