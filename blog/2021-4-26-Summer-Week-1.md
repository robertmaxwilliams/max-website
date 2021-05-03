---
layout: post
title: Summer Week 1
---

This is the end of the end of my schooling, and the beginnning of my first summer off in 5 years.
What to do? How to keep from drifting into the abyss?

- Monday:
    - 10-12: Soliciting my signature page signatures and starting on elevator project
    - 2-3:
- Wednesday:
    - 11:30-12:30: starting on making NAT figure
    -  2-3: finished draft #2 for uploading to arXiv and sent to Dr. Yampolskiy for appoval 
- Thursday: (all day)
- Friday: (not sure)

# Monday

There is not much left to school. My thesis is practically complete (all that's left is paperwork),
so I have finished that series and began a new one: Summer. I'm not going to start looking for a job
just yet, I'm going to be spending this summer doing other things first, and starting looking for
(probably remote) work in the Fall. 

One thing I do need to do before I check out of school is finish my final Simulation of Discreet
Systems project. It's an elevator simulator, which I find incredibly ironic since my first project
in pre-engineering in high school was a tiny motorized elevator, and I never did get the software
quite right for it. Now I would definitely be able to come up with the good abstraction for such a
thing. I really want to do this project over the top, so I'm going to make a Pygame visualization
that shows people getting on and off the elevator. This is going to be fun. I've got the core logic
written already, I just need to get it running and then I'll start on the display. Visualization
makes debugging 100000 times easier so I'll do that before I even *really* test it.

Back from long lunch break and running some errands. Now that I'm vaccinated I don't feel compelled
to absolutely minimize every trip out anymore (I'm still trying to be relatively safe though).

I think I have the elevator working, I'm going to make a pygame animation of it tomorrow. I already
have the sprites drawn and the image loading code in.

Tomorrow, I need to split up my sprites, then write the rest of the animation code. I think it'll be
pretty simple, at the start of an elevator action, it'll send a command to the animation code to
linearly move from its current position to the next (or change state, like opening door and such).
And the people moving is the same thing. This'll be so cool if I get it to work. I also made all the
sprites SO ugly, I drew them in Tux Paint. Making graphical stuff in Pygame is really satisfying.
Oh, also I need to add sounds: ding for door open, ding for door closed, movement sound for the
elevator, and increasingly loud crowd sounds as the line gets longer. And a sound for taking the
stairs once I implement that.

# Wednesday

I'm working on redrawing a figure for my thesis. I had implicit permission to use it for my thesis,
but not in a standard publication (in this case, arXiv). So, I'm redrawing it, with some of the info
removed or changed. I get to brush up on my tikZ, which is not nearly as hard as I remember is
being, I guess the practice paid off.

Done with that, and a few other small changes. I need to work on my simdis assignment, besides
making the animation, I also need to write the report for it which might be non-trivial.

Done for the day, I have the drawing code basics working. Tomorrow, setting the scene and animating
it.

# Thursday

(didn't blog, spent all day finishing the project)
