---
layout: post
title: Summer Week 5
---

This isn't a structured (work schedule) week. However, there are a few things I'd like to get done:
- website improvements
- Lisp mfm
- finish intro to emacs video

I also have my creative pursuits, which work better the less I structure them. I will be practicing
singing at least 3 times before my lesson on Thursday, and I'd like to make some visual art this
week, too

# Monday

Prepared grain spawn for shitake today. I have a few fabulous golden oyster jars, some
under-hydrated pink oyster jars that are slowly colonizing, and my recently innoculated lion's mane
already on the shelf. The lion's mane has some little star-like growths of thin mycelium, I think
oysters have the best, dense fluffy mycelium and all others look weak by comparison.

My sleep has really been messed up lately, but I think it's almost restored. I took a short semi-nap
today after noon and just ate a very creative lunch (broccoli stir fry with msg and special K).

I made an art! And practiced music. I watched a CGP Grey video, and someone mentioned the hexagons
(the bestagons) and I realized that my Lisp MFM should be hexagonal based, and recursive
named-neighbors is the most elegant way to navigate the local plane (with a mechanism to prohibit
excessive wandering - special variables and 3-space hexagonal embedding here we come).

The hexagons don't need to be in an structured array, they can just be scattered about and linked
together. I guess there does need to be a 1d array from which to select them. Fuck yes, this is
going to be great.

# Tuesday

I've developed the "tying the knot" code for making my 2d/3d hexagonal linked list. I'm really glad
I took linear algebra so I understand the trick for making hexagon's 3d coordinates and 6 directions
act like a 2d hexagonal grid.

I did it! I have a working system, with empty cells and a res cell. Now I need to make a renderer
for it... I think the best thing to do is make it in C using SDL and have shared memory, or maybe
foriegn function call from lisp. Not sure, but I'm done programming for today.

# Thursday

I'm going to burn through some more of the emacs tutorial, I really want to switch to editing lisp
using emacs and not using evil mode.
