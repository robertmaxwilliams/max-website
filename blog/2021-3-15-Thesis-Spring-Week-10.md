---
layout: post
title: Thesis Week 10 (Spring)
---



# Work log:

- Monday: (1g oolong tea, 200mg theanine
    - 10-12: Worked on autonomy section
    - 1-3:45: (off topic) got SDL2 + Cuda stack working
- Tuesday: (2g oolong tea, 200mg theanine)
    - 10-12: Working on AI risk section
    - 1-2:  Same, also all the charts are done.
- Wednesday: (0.25g oolong tea)
- Thursday: (2g oolong tea, 200mg theanine)
    - 10-12: 
- Friday: (2g oolong tea, 200mg theanine)
    - 10-12: 
    - 1-3: 


# Monday

15 minutes late. Oops. I could have been on time but I wanted to go for a walk before I started, it seems to really help
me focus. My sleep schedule has been getting chaotic over this weekend, hopefully the schedule of the week will bring it
back to baseline. Also, I only drank half my tea over the weekend, which kept away the headaches. After this week I'll
be tapering off caffeine to take a tolerance break. Apparently it's not normal to take caffeine in a calculated way, I
guess most people expect addiction and tolerance and don't bother trying to maximize positive effects. Culture is weird
like that.

Okay so what to work on? I guess converting my bulleted lists into proper paragraphs is a good start. I'll do that.
Although, the bulleted lists are nice, I'll keep them as tables as well. Also I'm going to get some headphones and
listen to some sort of background music.

It's hard to find a practical definition of autonomy. Dictionaries have overly simplified definitions ("2 :
self-directing freedom and especially moral independence") while philosophers focus on societal context and how "free" a
person's society is. I want a definition for that thing that people have, and some reinforcement learners have, but other
kinds of AI (like an image classifier) lack. Maybe I should switch to using the near-synonym "volition". 

There are some 5 or 6 level autonomy schemes for self driving cars or automated testing code generation frameworks.
These are application specific, but somewhat on track for what I'm looking for. Also, autonomy is an illusion, a
hallucination dreamed by living things to understand the world. However, that can be said about basically any facet of
reality so not helpful. The Wikipedia cite for "autonomy" leads to
<https://en.wikipedia.org/wiki/Self-determination_theory>, which is more or less what I'm looking for. However, autonomy
isn't really a quality of AI systems at all, it's just a part of how we anthropomorphize them. A completely mindless
system with no freedom, such as Bostrom's [Outcome Pump](http://intelligence.org/files/ComplexValues.pdf) which uses a
hypothetical time travel mechanism to ensure some outcome occurs, can completely control a situation and even "deceive"
us with "clever" solutions despite having no intelligence. (The outcome pump is similar to using 
[quantum immortality](https://en.wikipedia.org/wiki/Quantum_suicide_and_immortality) to force some outcome. Both are
completely impossible but make for good thought experiments.) Perhaps my closest understanding to autonomy in a pure
form is in the game of Go. Sometime you are in situations where you can only play reflexively to avoid losses, spending
every move countering your opponent. In this state you are still thinking and making rational and intelligent choices,
but you have no freedom. You only have one good option at any time, so you aren't able to use calculated decision making
to defeat your opponent. Being on the other side of this is very different: you have the other person backed into a
metaphorical corner, and you can leave to do something else at any time. 

Lunch time. Breaking a few minutes early, but I did not have enough to eat for breakfast.

Back from lunch. I am really having trouble staying motivated. Maybe it's the weather, it's so grey. Maybe I should just
call it off for the day. I thought that this light schedule would keep me from getting burnt out. Maybe its not burnout,
just lack of motivation. I should stay here and work on something, though. Nothing is due for any of my classes. I guess
I'll go try to learn Cuda. That's something I really want to do. Okay, so no thesis but I need to be learning Cuda
programming until 3. Sounds good.

Wow that was a nightmare. I'm here 15 minutes past and haven't written a single line of code, just trying to figure out
how to get any of this to work.

3:37 - FINALLY got a stack working, based on this repo: <https://github.com/fsan/cuda_on_sdl>. I had to mess with the
linking a bit (a lot) but it compiles, and I modified it so it's stripey instead of solid. This is the ultimate stack.
Cuda and sdl2. It's not the most efficient since the render result has to be copied to cpu for sdl2 to draw it, but I
could not get the direct openGL interop to work. Well I'm starting to get a headache. I need to really up the green tea
dose tomorrow.

It's not great that I gave up on working, but I did do something work-ish instead so it was an okay day. I just really
wish I had the motivation and energy to work on my thesis today.

# Tuesday

Hey I'm here on time today! I did skip the morning walk. ALSO yesterday I got  
<h1 class="animated intensifies">vacccinated!!!</h1>
Anyway spending 20 minutes adding that animation (hover mouse over text to see it) wasn't the best use of time, but it
wasn't the worst either. Anyway anyway. Oof. Gotta work.

Hey I'm doing work look at me. I'm going to get up and walk around, stretch a bit. 

Back from lunch. A really good lunch: penne with tomato sauce, onions, and a fancy bean burger. The sauce cooked in the
cast iron with leavings from yesterday's cooking (kept in the fridge) made the sauce very deep and complex. Couscous is
a surprisingly complex ingredient, too, I found it goes really well in tacos to simulate the texture of ground beef. But
this isn't a cooking blog. Also I'm 20 minutes late because I got caught up enjoying reading a book on the front porch
in the sunlight. Ooops. After work I'll probably return to there, it was so pleasant.

It's strange, when I look at my calendar and count the weeks until this is due (3, plus a few days) I want to maximize
the time I spend working. But when I'm actually working, I want to minimize it. This kind of contradiction is similar to
those found in hierarchical reinforcement learning, where a top level agent struggles again lower level agents when they
become unaligned. The version of myself capable of long term planning is different from the one capable of academic
writing. Planning-me just wants to push the writing-me to write as much as possible, and writing-me wants to weasel out
of having to work (for some reason). Why is it that writing-me doesn't like working and would rather read off topic
stuff? And why is it that both of them find writing hundreds of words into this blog perfectly acceptable? I don't think
the I (and people in general) have a highest self or true self, just a myriad of ways of being each with their own
goals and each capable of emerging and dissolving as needed. Actually, under this simplified image of the mind, there
should be "viral" mind states that refuse to give up control or find ways to be put in control frequently despite not
being useful. Evolution must have found some way to suppress those kinds of states, otherwise living things with these
kinds of many-modes of being would often get stuck in harmful modes. Ugh so complicate, living. And those dang
philosophers don't make it any easier.

ANY WAY. I should be writing into the thesis. Jeez.

And here I am, trying to find citations for AI containment and I end up 
[reading the basalisk](https://rationalwiki.org/wiki/Roko%27s_basilisk), something that AI researchers are much better
off not knowing about: an infohazard. Eh, I don't think it's quite so dramatic as that and it's unlikely to shape my
decisions. Anyway I now realize I was off task, so now back on task.

600 words yesterday and today, not bad. Although that's in the latex source, it's probably much less in actual content.
But it does reflect content length well, since the tables take up more space than text. I just reached 30 pages, and I
have not idea how I'm going to make it to 50. But Dr. Yampolskiy will be able to advise me on topics to unravel unto the
page. Anyway, despite only being at about 50% capacity today, I feel like I got a lot done. Upping the caffeine might
have had something to do with that. However, 2g of tea is not that much compared to what coffee drinkers ingest, so as
long as I manage the taper off well, the withdraw at the end of the week shouldn't be too bad.


## Thursday

Oh the half day. Gotta make it count. I'm reading over my draft, and it looks pretty good. It makes sense, its organized
pretty well. There are a few weird things. I spend a lot of time on NAT-HRT, but don't draw too heavily on it. Also I'm
still missing basically all of the content to the recommended measures field. I'm going to skim Normal Accidents to see
if I can get any ideas, but NAT isn't as useful as I thought, as normal accidents are so rare. I suppose high
reliability theory might be more useful - if your system lacks high reliability properties, then try to add them. That's
pretty easy. Imagine if Roombas came with an autonomy warning, about its ability to go missing and make novel messes in
your house.

It seems that Perrow uses a very specific definition of linear/complex, on page 75. "... *complex interactions*,
suggesting that there are branching paths, feedback loops, jumps from one linear sequence to another because of proximity
and certain other features...", then "The much more common interactions, the kind we intuitively try to construct because
of their simplicity and comprehensibility, I will call *linear interactions*. 

This reminds me of my time spend programming the Moveable Feast Machine to do TSP problems. I thought I understood what
I made and accounted for all the edge cases, then after a few million iterations some sort of debris would be in an
unexpected state (meaning that as time approaches infinity, the entire machine will fill with debris). This is a major
motivation to switch to evolvable components - programmers are extreme experts in creating systems-linearity, actually,
I think it's the very thesis of structured programming. One task done by two things (i.e. two different if's that check
the same thing in different places) has been identified as an anti-pattern, and one thing that does two tasks (an object
that should be split into two objects, reusing variables) is also discouraged. The earliest computers were crazy Rube
Goldberg machines, and programmers were very clever and holistic in making something that worked. This limited complexity
and was prone to bugs, and also required the maintainer to understand the entire system just to make a change. Now
things are linear and decoupled, at least that's what we dream when we code. But in reality there are always bits of
complexity, either designed due to not having any other choice, or due to bugs or unexpected hardware interactions.
Hackers don't make good industry programmers. This is the Correct First Attractor... I hadn't expected my thesis to
relate to the Moveable Feast Machine. Maybe I should put our paper on Arxiv so I can cite it and talk about Indefinitely
Scalable Computing as an example of intentionally introducing coupling, complexity, and incomprehensibility, swimming in
it instead of trying to build walls to keep back the tide. Safety and predictability are antithetical to our universe,
but needed for current technology to function on basically every level. Technology that doesn't work this way, such as
unstructured programs or neural networks, is seen as useless due to the lack of comprehensibility, but comprehensibility
holds us back. The way forwards is to swim in incomprehensibility, build things we'll never understand and use them
productively. 

That was quite a rant, huh. Not sure if any of that is true or a good idea, but it is the direction we're headed in. And
my thesis is about how to maintain safety in ways that matter despite delving into inherently unsafe technology. Isn't
that what Perrow was all about? Although he did often say maybe we shouldn't be using nuclear reactors at all, which
based on deaths/GWh I'd disagree with (but we've also improved a lot since Perrow's time).

"What passes for understanding is really only a description of something that woks." Wow, that describes basically all
machine learning. There are very limited attempts to actually understand them in a meaningful way. The search for a
better LSTM (which found the GRU), shows how little we know, that a mindless search of architecture space found an
improved design.

He also gives examples of tight/loose coupling, but I don't think he gives a definition. On page 97, there is the
Interaction/Coupling chart, which my classification schema uses centrally.

Okay done for the day. Reading for 2 hours wasn't especially productive but I feel okay about it. I also feel fairly
energetic - not discouraged - but I still don't know what to write. Hopefully I'll hear from Dr. Yampolskiy soon.

# Friday

Stayed up late last night, oops. I'm a bit tired. Oh well. Starting the day reading this instructional/motivational
piece: <https://www.believeandempower.com/8-tips-to-write-a-thesis-in-30-days-bonus-tip-included/>.

The advice seems solid so far.

1. You don't have to contribute original research (and probably can't at your level of knowledge)
2. Don't be a perfectionist. "A mediocre finished thesis is better than an unfinished one".
    - that's basically my motto, but I have some friends who really need to hear this. No one expects perfection but
      completion is nessasary. 
3. HAHA they're hocking Gr\*mmerly, I knew I was going to get advertised at. Oh well. Everyone has a weakness.
4. Someone has already done it - so read their paper and use their sources
5. Draft fast, fail quick. Don't spend a long time perfecting any one part during drafting, as you might need to cut it
    later.
6. Read short succinct journal articles? I don't see how that qualifies as advice, if you're looking for research on a
    topic, a lot of it is going to be journal articles.
7. They suggest writing it everywhere. Maybe if you want to write it in a month this is a good idea, but for me the
    constrained hours and dedicated work area are the only way to be productive.
8. Join online writing communities - not a bad idea actually, I've never thought of this. Probably won't, though.

Well that wasn't awful, as SEO'd advice articles go. I do feel good about my thesis as an imperfect and sufficient piece
of non-original research. So maybe I'm a little bit motivated. But my main issue is that I don't know how to move
forward now that I've only got 30 pages and I feel like I've got all the content I needed already. 

Oh, I know, I have a homework assignment in one of my classes, I'll do that today for work instead. Hopefully I'll get
that feedback from my thesis advisor before long because I'm having trouble moving forward on my own.

I watched the lectures for simdis, and I'll start the assignment after lunch. I also had the impulse to get out my
drawing tablet and procrastinate, and found the **incredible** program Tux Paint. This is software design genius, no one
makes real software like this anymore. It's honestly inspiring. I have a new twitter account,
[@tuxpaintpro](twitter.com/tuxpaintpro), where I'll be posting my creations. I spent too much time fiddling with it so
now I'm late to lunch. Oh well.

Back from lunch, then spent 30 minutes creating some more art. Off task, I know, but when inspiration strikes it's
foolish to ignore it. So now I just need to finish that homework assignment and be done with this week.

Hmm, it seems like the second question requires him to define some terms for us, so I'll have to wait on another
lecture. I'll go ahead and simulate the situation in the question, then call it done for the day.

That went pretty well. I'll be ready to finish that assignment easily next week when the lecture comes out.
