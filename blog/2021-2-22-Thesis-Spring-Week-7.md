---
layout: post
title: Thesis Week 7 (Spring)
---

I'm starting on time today! The first full week of *the schedule*. It's not perfect because I slept
in so I'm going to have to break in a second to eat some toast and make some tea. Today I'm drinking
tea from 1 teaspoon oolong tea. It's really old so it might not be effective anymore, I'm not sure
how tea works. I'll see. Anyway I need to get to work. 

# Work log:

- Monday: (Oolong tea 1g) Working on understanding and summarizing Shrivastava's NAT-HRT reconciliation
    - 10-12: lost 15 minutes to toast
    - 1-3: lost 15 minutes to call, 10 minutes to GPT-3
- Tuesday: (Oolong tea 1g)
    - 10:30-12: got up late and started 30 minutes late. 
    - 1-3: work work work (idk I didn't put an entry here but I did work)
- Thursday: (Oolong tea 2g, 100mg L-theanine)
    - 10:30-12: got up early and started on time. I lost about 30 minutes to fiddling with tech but
      I also stayed 15 minutes over. Good day but I started feeling really lost when touching the AI
      safety stuff.
- Friday: (Oolong tea 2g, 100mg L-theanine)
    - 10:20-12: I went for a jog and chatter with roommates, getting distracted and late. But I got a
    lot of work done making the classification system make sense again.
    - 1-3: started 4 minutes late, 


# Monday 

Where was I? I was reading about how the pessimism of NAT and the optimism of HRT are not
contradictory, and can be understood together to make a more complete theory. This is good, because
NAT-based analysis is really disheartening. 

Wow I really need to shave, my face is getting itchy. Okay time to break for toast 5 minutes into
work. 

Okay break took until 10:18, no more procrastinating. 

10:53: work is going well, I'm basically summarizing Shrivastava's NAT-HRT reconciliation arguments
in my related works section. I hope that it's not too redundant, but I do need as many pages of
related works (even at the cost of quality) for this paper to work. 

Off topic idea: Put work into general purpose visualizers for software. Software control is so
dangerous because of how much invisible hidden state and complexity is completely hidden inside
(with only the smallest peeks given by its outputs). There might be some elegant way of depicting
information flow and state through a program which works in general for any software. I guess the
size of real-world programs makes this much more difficult, as you have megabytes of ram doing stuff
at any given point in time, most of which is impossible to understand without a deeper understanding
of the program. I encountered this when trying to visualize neural networks - looking at the weights
and activations as 2d images could only tell you so much, Although it was key to me finding the bug
that was breaking my program. Or maybe it was careful reading of my code that fixed it, and the
visualization stuff only added complexity and wasted time? I don't remember exactly.

TODO: recreate the 2-axis figure with different industries on it as part of my risk assessment, and
show where modern systems lie on it. I love those kinds of plots, even if they are extremely
arbitrary. 

Open systems is a really interesting concept. It replaces what might also be called an "autonomous
agent" or an "embedded agent", and goes to the trouble of understanding the boundary between the
system and environment as "arbitrary, changing, and not physical but mental"

Breaking for lunch. I finished reading the paper but I stopped writing my summary because I was a
bit confused by some parts. I need to figure out what they mean by NAT and HRT working at different
points in time. Figure 2 seems to show that HRT focuses on steady state accidents while NAT focuses
on eventual catastrophe, and also bringing in the degradation theory complicates things further. So
an organization is a block of slices of Swiss cheese, where the holes move around, and they get
bigger and interact in worse ways the more time goes on? And when things go wrong, the system tries
to compensate by increasing coupling, which causes a spike in complexity and cognitive overload
occurs.

I think I have it - the degradation followed by sudden accident is what HRT is concerned with, while
the explosion in apparent complexity is what NAT is concerned with. So I need to retract what I said
about NAT being Swiss-cheese oriented. Ugh.


Also I wrote about 300 words. I need 10,000 more, so if I just do that 33 more times I'll be good.
Each week has 4 days, 2 sessions each (minus one on Thursdays). So 7 sessions per week, 7 weeks, 49
sessions. Hey, that makes this possible with a healthy margin of error! But I really really really
have to stay productive to reach that. Ha, it's like a burn-down chart. A metric! How neat.

Lunch break. 

I started back up at 1 but my mom called me back, so now it's 1:30 and I'm back to work. I was
reading a fundamental work that Shrivastava cited in a footnote, but unless I need to pull in more
nebulous material I'm going to drop it for now. Back to understanding and using Shrivastava's
perspective. 

Actually, according to Shrivastava, this paper has a tier of systems which might be a useful axis
for my classification system.  (15 minutes later) Nah, while the (framework, clockwork, thermostat,
open system) breakdown is very good, the (plant, animal, human, society) levels seems very arbitrary
and human-centric. It seems that at this point he's just restating the common understanding of the
hierarchy of the world that puts humans at the top, to which there is plenty of evidence against
(intelligence of non-humans being abound in the natural world, and failures of so-called general
intelligence of humans being so incredible).

Well. Now I need to read Shrivastava and write a few paragraphs about the reconciliation of NAT and
HRT.

I'm very confused about their notion of entropy. They claim that open systems appear to defy
thermodynamics, which is absolutely untrue as they consume energy. A plant growing and becoming
ordered (and amassing chemical energy) isn't defying anything - it's just using the energy that
rains down from the sky and holding onto longer than would happen otherwise. "Wear and tear" as
entropy is very different from thermodynamic entropy, and conflating the two seems like a mistake
made here. And even more so for social systems. 

Okay, time to introduce DIT into my paper. Oof this is getting complicated

Okay I did that, then got distracted for about 10 minutes because someone sent me a video about
GPT-3. 

Okay done for today. Wow, I wrote almost a thousand words today. Not all of it is good, but that's
what editing is for. Write, write, write, the rest is for the editing stage.

Well that's all for today. Feeling good about writing, and I made some small conceptual progress. I
still need to figure out how to recommend actions based on the classification, and classify more
real world accidents.

# Tuesday

Starting 30 minutes late today. Oops. I'm sure I'll be on time Thursday. Tomorrow is a day off so I
need to make sure I'm really focused today. 

I'm using my new desktop today. I got all my repos synced and such already, so I shouldn't lose any
time to technical issues.

Alright I spent 5 minutes fiddling with vim to get my colorcolumn the right color. I don't really
know what to work on right now. I need to come up with the classification system, and I have some
more content for doing to now. 2-axis charts are good, and so are 2-axis tables for creating tags. I
should sketch this out on paper. (Done!)

I'm working over my classification section for the new label system I've made,
and I've run into the bit on the AI boxing problem. This is definitely something that I can dig into
for more pages, but should be its own section to avoid detracting from the point of this section. I
haven't found a source saying that AI at current level aren't capable of unboxing. However, most
researchers (and production users) don't bother to box their AI - the AI is very simple and isn't
going to hack your stuff. So it isn't so much about unboxing as spontaneous agency and alignment.
Current AI have very simple alignment (minimize loss, then the trained network is used in
production). However this character as AI-as-an-agent is pretty important. Maybe I should add an
agency level? But agency is interrelated with how much power is put under AI control, and how well
we understand it. The better you understand something, the less agency it seems to have. My
thermostat isn't an agent, I only personify it in a very simple way. An Atari-playing AI, however,
acts (in-world) as a completely free agent and I have no way of predicting its actions except by
personifying it and understanding its motivations (maximize score). Maybe I'll call Luke and see
what he has to say, he's studied embedded agents.

Lunch break! I'm leaving at 12:07 so I guess I payed back a small amount of time lost. Oh, there was
something I was going to do... learn to use vim mode in my web browser? I forget. Oh right! Set up
i3 shortcuts for sleep and hibernate. I should also set up a better lock screen, and backgrounds for
each desktop.

I'm back at 1:02. Or 13:02 according to the status bar... I need to change that so it isn't in
military time. Human friendly. Compact but human friendly, that's my UI motto now. 

Oh right, call Luke. I didn't do that during break, I should do it now.

Okay it's 1:24. Call with Luke helped, so there are 2 things going on in my idea: perverse
instantiation is when the AI meets its goals in a way that is not at all what you wanted. (oops
spent 10 minutes learning browser's vim mode shortcuts).

I'm looking at Dr. Yampolskiy's "Predicting future AI Failures from historic examples", it seems
that what's different with these failures (compared to the sort that NAT and HRT deal with) is that
there is either some amount of agency, or the expectation of agency by humans of the systems, which
causes many of these failures. More importantly, brand-new under-tested technologies (high knowledge
gap) are more likely to act unexpectedly, especially when pushed to consumers/users as fast as
possible. 

But what I'm more interested in is the component/agent dichotomy. The notion of "clockwork" from
that one paper was especially useful, but it doesn't really get into agency, just homeostasis and
intelligence. What I need is "will the AI act outside of the frame you designed it for?" and "will
the AI pursue its designed goals in a way that is technically correct but undesirable?". Either of
those reflects agency, and both of them are only possible if you lack understanding of the inner
workings - if you understood the inner workings better, you would have modified it so it didn't
misbehave. 

So the question - does a Roomba have agency, is it susceptible to perverse incentives, can it break
out of the box? These things seem like they should be a flow chart at the very beginning of the
assessment, or in another section. Yes! Agency section and Systems section. Agency is an AGI fear.

One sec I'm going to take a couple of minutes to water the crickets. Their terrarium is looking
really dry. Okay it's 2:10 and I only got distracted for a few minutes taking care of that.

Yes, that breakthrough. Agency danger and Systems danger. Related but separate enough they need to
have their own section. Likelihood of an intelligence explosion should also be considered if the AI
in question is for research. I wonder if GPT-3 could bootstrap and understand its own code well
enough to improve it? Its working space is too small, I think (and parameters grow as a square of IO
space for transformers). Still, if you made a good DSL for neural networks it might be able to come
up with some good architectures. 

Anyway I'm going to start structuring the paper for such.

Quitin' time. After 3 I spend 10 minutes configuring git. Now time to go OUTSIDE because the weather
is GREAT.

# Thursday

Maybe Wednesdays off aren't the best idea, I feel a serious lack of continuity trying to get back
where I was. On the other hand, burnout is my biggest concern, and spending 10 minutes trying to
catch back up isn't that big of a deal.

Also, it's 10:03, I was here on time today. I slept well, too. If only that pain in my throat would
go away. Running helps temporarily and it wasn't there when I woke up. Some sort of tension is
causing it, I think. Anyway I can ignore it and work for now.

I drank tea made from 2 grams of green tea (~50mg caffeine) and 100mg of L-theanine. I think I can
feel the caffeine but I don't know if the theanine has any non-placebo effects. I didn't have any
caffeine Wednesday and I didn't have any side effects from not drinking it, but I did get a headache
in the evening. More likely from playing too much video games than from caffeine withdraws.

Anyway, what is this, a diary? I need to figure out how to get to work. Where was I? I was trying to
make my classification system better, and organize it. 

Oh, yes. I was writing an AI safety section in related works. 

I was trying again to find a good cite for Mario memory injection and guess who wrote the paper on
AI containment which mentions Mario? Yep, Dr. Yampolskiy (and others). 

Okay I tried putting in some of the AI safety stuff. I probably wasted about 30 minutes today
fiddling with configurations and installing programs. I feel more distracted than usual, actually.
There are still 8 minutes left on the clock but I'm not sure what to do. The length of the paper (12
pages) is more than I'm used to having to manage all at once. 

I guess I should read all the way through the paper now. It's about time.
Wait actually I really want to be able to draw on the pdf. I'm going to waste some time setting up
my Wacom tablet, but I'll go past 12 to make up for it!

Oh wow I plugged it in and it works, that's nice. Now time to find a pdf reader that can draw good.

Done, I annotated up to Classification. At that point the need for major restructuring is too great,
I need to spend some time on that.

I'm putting my current goals in Friday so I can remember what I'm doing. Signing off at 12:15.

# Friday

- Work on restructuring Class section
- use notes from yesterday to fix some stuff
- spellcheck, solid read-through and send to Yam

Heyo I'm late. The I spent 5 minutes trying to make i3 launch my workspace (vim my thesis, vim my
blog, open my pdf, tabs for my research pdfs, one for my thesis pdf, and Firefox). It wasn't
working, I'll try again after work. So now it's 10:20. Outch. Anyway, I have a todo list from
yesterday that I feel pretty good about. I also had my tea already, I can't tell if it or the jog
had the greater effect. I think the jog accelerated the caffeine. Anyway I feel focused and ready to
work. 

Classification section is reworked. I don't work to rework the Roomba just yet. Now to use notes
from yesterday to correct the mistakes I noticed.

Oh wait not yet, it's lunch break already. 

Okay I'm back, 4 minutes late (it takes 5 minutes to drop something off at the post box, not 1). 

Right, editing. Fun.

Aw dang, my PC case just showed up, I wish I could go put that together! But I have to work until 3
until I can do that. 

Alright, editing is pretty good. I'm going to ask Dr. Yampolskiy to give it a brisk read-through this
time, since I've added so much. I feel much better now that I'm spending so much time working on
this. Also, putting a newpage before each section and adding a table of contents, I'm now at 22
pages (!!!!). I'm seriously almost halfway through. Well, maybe more like a third (wordcount also
points toward me being a third of the way through). The progress I've made this week is tremendous.
Now I just need to keep doing this for 6 more weeks and I'll have my thesis. In 2 weeks, I should
have a draft. I'm going to send Dr. Yampolskiy my update email then quit early for having done such
good work today (and also I have no idea what to do next).

It's 2:45 and I've sent the email, time to pack up for the day. And build my PC into its case!
