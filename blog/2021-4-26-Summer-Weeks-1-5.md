---
layout: post
title: Summer Weeks 1-5
---

# Week 1

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

## Monday

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

## Wednesday

I'm working on redrawing a figure for my thesis. I had implicit permission to use it for my thesis,
but not in a standard publication (in this case, arXiv). So, I'm redrawing it, with some of the info
removed or changed. I get to brush up on my tikZ, which is not nearly as hard as I remember is
being, I guess the practice paid off.

Done with that, and a few other small changes. I need to work on my simdis assignment, besides
making the animation, I also need to write the report for it which might be non-trivial.

Done for the day, I have the drawing code basics working. Tomorrow, setting the scene and animating
it.

## Thursday

(didn't blog, spent all day finishing the project)

# Week 2

Went backpacking over the weekend, now to get through commencement

- Monday: clean up day
- Tuesday: at mom's, not a work day either
- Wednesday: Scrapbooking
- Thursday:
    - 10-12: ???
    - 1-3: got cap and gown, and singing lesson
- Friday: 
    - 10-12: Finished reading "Interface", gardening
    - 1-4:30: submit paper to MDPI, learn freeCAD

## Monday

I'm in a weird place, not quite out of the grasp of the school but not yet completely taking part in
what it is that I'm doing this summer. I feel a bit lost, tired. But also I had a very exhausting
weekend: I went backpacking with my friend Greg, the first backpacking I've done in a long time. My
body is tired, and after a bit of remembering what it's like away from the city I find it
increasingly unpleasant and hostile.

Today was about cleaning up. All my stuff from backpacking and a backlog of dishes and such from
preparing for the trip. 

Also, I was up until 2am playing card games (a Nomic variant) with my roommates. We had a lot of
fun, and I shouldn't be so quick to attibute my current lack of mental energy to some broad societal
ill before noticing that I slept restlessly on the dirt one night, and the stayed up very late the
next. There's probably a correlation there.

So in other words, I'm fine. The start of this week isn't such that I can start my work schedule
just yet, but Thursday and Friday are work days. I need to fit in some singing practice today, then
drive to mom's and I won't have any work until Thursday. That's so hard for me to understand, not
having work to do. But I have so much work to do, with all the portfolio building I have planned and
hobbies I have going. I'm going to list them:

- Organize past work (github, etc) into a portfolio, preferably interactive or videos
- NMFM project
- Some other alife project, evolvable grid stuff thing
- Fictional Product Manuals
- Starting my side gig growing gourmet mushrooms for fun and profit
- Taking singing lessons and practicing enough during the week

The first 4 are things I hope to finish this month. 

## Friday

This hasn't been an office work sort of week, but next week and the week after will be, so I can
accompish my software-related goals. Commencement is tommorrow, I think that's as real as it gets
for being done (for now).

Whew, using that paper template was a nightmare. It broke my bibliography, mangles links so they get
forwarded through a broken .gov website, and just looks pretty ugly with its line numbers and huge
margins. What a pain. Not as bad as reformatting a paper in word, though, by a long shot.

I feel really anxious, like there's something I need to do. Commencement tomorrow is stressful, but
it's more than that. Isn't today something important? I think it's because I haven't had a deadline
in a week I feel like I'm probably failing some class. It's weird that this whole summer I don't
have any deadlines.

I finished the submission, and stayed on overtime to learn to use freeCAD. I have a top secret
project that's going to require it.


# Week 3

Got through commencement, letting the dust settle and organizing and planning

- Monday: Got back from mom's, did a bit of cleaning
- Tuesday: Went clothes shopping
- Wednesday: deep cleaned kitchen and this room, innoculated grain spawn with pink oyester LC
- Thursday: cleaned bedroom, baked bread, singing lessons, and started another batch of rye
- Friday: 

## Thursday

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

## Friday

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


# Week 4

The first full week of Summer, and I'm finally getting some work done on improving my website. As
much as I like the retro look, I think I'm going to do some style updates, while keeping my
anti-spa ethos in tact.

- Monday:
    - 10-12:30: Prepared another batch of rye, improved website security, took a backup, started on
      website improvements
    - 12:30-2: Continued website improvements
- Tuesday: ???, had errands in the evening
- Wednesday: Went to mom's, taught her how to make soap
- Thursday: Not a work day, managing appointments and so on
- Friday: Cleaning bathroom, cleaning sheets

## Monday

I feel refreshed today, and I feel like working. I also feel like laying around being anxious about
nothing. I guess I can do both. Part of me wants to just work and work and work but moderation is
key to long term productivity (ha, produtivity...), so I'll take a lunch break, then come back and
work another two hours before signing off and doing something non-work stuff.

Oops I skipped lunch.

I'm having trouble getting my website to run locally, I set up my emacs/slime/sbcl stack locally to
run it interactively. I am also learning emacs for real this time, using a video. I might be able to
obtain dual user status - emacs *and* vim. But it'll cost me. I think it's worth it though - lisp
interaction modes in emacs are excellent, and vim mode is clunky. I think the main thing holding me
back before was lacking a full keyboard, but now I have that so it's time to learn emacs.

Anyway I skipped lunch so I'm quitting at 2 today, I'll be back at it tomorrow.

## Epilogue

I didn't get back at it tomorrow, I had a lot going on this week and I felt better not adding my
structured work on top of it. With my project in Bloomington starting week after next, I think it's
best to leave next week (week 5) unstructured since we'll be working in a structured way for the
next month.



# Week 5

This isn't a structured (work schedule) week. However, there are a few things I'd like to get done:
- website improvements
- Lisp mfm
- finish intro to emacs video

I also have my creative pursuits, which work better the less I structure them. I will be practicing
singing at least 3 times before my lesson on Thursday, and I'd like to make some visual art this
week, too

## Monday

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

## Tuesday

I've developed the "tying the knot" code for making my 2d/3d hexagonal linked list. I'm really glad
I took linear algebra so I understand the trick for making hexagon's 3d coordinates and 6 directions
act like a 2d hexagonal grid.

I did it! I have a working system, with empty cells and a res cell. Now I need to make a renderer
for it... I think the best thing to do is make it in C using SDL and have shared memory, or maybe
foriegn function call from lisp. Not sure, but I'm done programming for today.

## Thursday

I'm going to burn through some more of the emacs tutorial, I really want to switch to editing lisp
using emacs and not using evil mode.
