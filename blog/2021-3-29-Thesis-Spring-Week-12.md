---
layout: post
title: Thesis Week 12 (Spring)
---

- Monday: ()
    - 10-12: writing about the two interpretability papers
    - 1-3: Reading and writing about "The Interpretation Problem"
- Tuesday: ()
    - 11-12: Not sure?
- Wednesday: ()
    - 10-12: reading "AI Accident Networks"
    - 1-3: same
- Thursday: ()
    - 10-12: Cleaning up citations
- Friday: ()
    - 10-12:15: Cleaning up citations, composing weekly status report
    - 1:45-3:30: 


# Monday

Good morning! Time is running very short. I need to have eaten up all those papers that Dr. Yampolskiy sent me by the
end of the week, and produced at least 10 pages. Right now we're at 31 pages.

Ha! Good news. I changed my margins to match the formatting requirements, and now I have 35 pages!

Oh wow. I changed my font to be compliant as well - now I have 41 pages. HA. Wow. Anyway, I still need to write, a lot,
to have enough content. Do I really though? Yeah, I think I should still shoot for 15,000 words. That would be the right
thing to do.

I made my bibliography single spaced and I'm back down to 39 pages. That's beside the point, I need to actually do some
writing now!

I've implemented a policy of every thirty minutes (that is, on the hour and on the 30's) taking a quick break to do a
few push-up and whatever other exercise I feel like. This is not only helping me remain alert, but also makes time seem
more substantial and provides landmarks and real world actions to anchor my experiences to. The usual monolithic block
of work time now feels more like a meaningful experience with occasional physical work added on. We'll see how long I
can keep this up. 

Woo! 400 words written before lunch time! This is going great. 

Back from lunch. I decided on another new policy: If 1,000 words get written, then I can quit early. I've done it
before in a day, and specifically asking for word count encourages "productivity" in a much better way than counting
hours. Some coding shops do the same thing but with lines of code, usually to their detriment since editing is much more
important in coding than in writing. Not that it isn't important for writing, but software is like 10% original writing
and the rest is modification. And the best modification don't add lines. There are a lot of parallels there.


Okay so I'm pretty close to 1000 words for today already. This is a genius plan,
as long as there's work to be done. Which makes even more sense. But now I have
"Morality, Machines, and the Interpretation Problem". I went and did a quick
pdftotext and it turns out this pdf has 10,000 words, basically the same as my
thesis, in 11 pages. That's the power of IEEE format. Actually, it isn't IEEE
but it is 10 or 11 point font and double columned and small margins. Basically
the opposite of the paper-wasting thesis. Anyway, time is a' wastin'! I need to
take notes on this thing so I can have at least the slightest understanding of
it and figure out how to use it.

Intro:
They introduce a problem specific to advanced AI (how advanced?) called the
Interpretation Problem. 
The level of advancement needed is simply that of a clever goal maximizer.
Paperclip maximizer is an interpretation problem. So it misinterprets our goals.
In the space of states with lots (even not maximal) paperclips, the ones that
are morally tenable are vanishingly small as intelligence increases.
"What we mean by maximize paperclips cannot be represented in an unambiguous
way."
These AI need to be "causally linked to the world" to cause us issues. At this
intelligence level, a chatbot or video game bot isn't going to hurt us. Yet.

The distinction between prescriptive goals and proscriptive limits is made.
Prescriptive is Consequentialist or Utilitarian, and moral rules are
prescriptive instructions to optimize things that we consider good. 

Proscriptive means prohibiting some behaviors, such as murder (which is very
tricky - purchasing a few dozen Terawatt hours of electricity will make you
responsible for a death or two, but seems very different from murder). 

The first one is much more similar to how we treat AI, but misinterpretation
haunts us still. The second faces misinterpretation as well. How
disheartening.

Then they talk about how rules are different from strategies, and often
the creative discovery of legal but undesirable strategies leads us to change
the rules. They give the example of the invention of the "flying wedge" in
football a legal (at the time) maneuver that quickly made the game broken and
boring (and more dangerous). It was quickly banned, showing that the reason we
play and watch football is not tied to the rules, but the spirit of the game -
artistry, flair, skill, creativity. A "broken" tactic is an expression of
creativity the first time it is done, but quickly tires the game. (A notable
exception to this pattern is video game speedrunning, which makes this sort of
breaking a game into an art. However, even speedrunning has strict rules of
which players are expected to follow the spirit of). 

The guardians of the game are in a continual arms race with the players of
the game, just as the programmer is against the AI. Another example is lawmakers
and taxpayers. The taxpayers know why taxation exists, but are economically
motivated to minimize their taxes regardless of how well they understand "the
spirit of the game".

Now morality is framed as this same sort of game. We write rules of morality for
our AI to abide by, and we know deep down what is and isn't moral behavior, but
we cannot predict the immoral behavior of the AI as it seeks its goals.

Plato and Aristotle and basically all philosophers had to deal with this issue -
we know morality but we cannot turn it into rules. Here we are, 2021, and we
still can't write down rules for our AI to be moral (and even worse, our law has
become the face of harmful, immoral systems built on rules). 

Wow this paper gets really deep into moral theory. I'm on page 6 at the end,
"Mistakes an AI could make, mistakes of intention and instrumental mistakes"

(Skip to Tag 23423 to continue reading summary)

I'm going to start writing about this paper and finish reading it tomorrow.

Good news! I reached 1000 words. Were all of those words good? Nope! But right
now we are about QUANTITY. BYE!

# Tuesday

Quantity, huh? That is a bit disheartening. Anyway, I'm here an hour late today (somewhat on purpose). I finished
binge reading a VERY long book (Rhythm of War) last night, and stayed up much later than I should have. I also finally
shaved my face after spiraling into neglect, having spent all of my time reading and doing little else. So I needed the
time this morning, to eat a proper breakfast and shower and shave.

Now, back to reading

(Summary resumes, Tag 23423)

"Mistakes an AI could make" fall into two categories. Intention and instrumental
mistakes. The AI has intentions (imperatives, obligations) and beliefs. Mistakes
of intention means that the agent has incorrectly specified goals. The paperclip
maximizer has a bad intention: maximize paperclips without regard for human life
or well being. 

The "instrumental mistakes" have to do with a "failure of understanding". A
smile optimizer paralyzing people's faces is an instrumental mistake, because it
thinks that smiles are a physical shape. Failure to avoid harming humans is the
same, because we don't know how to explain "harm" and "humans" in concrete
terms.

All of our engineering and understanding can at best correct for instrumental
mistakes, but not mistakes of intention. This is the arguments for a needing a 
moral component - perfect understanding of our intentions is useless unless the
AI also intends to follow them as we meant them without causing harm.

The framework for this is that the core of the agent needs two tiers of goals -
moral goals, which supersede all else, and practical goals. Frame as
reinforcement learning, this would mean the moral signal, when a mistake has
been made, is always greater in magnitude than the normal reward signal could
ever by. So the reward signal could come in as the sigmoid of a real, and the
moral signal will exceed -1 and stay there if a moral breech is made. This is
interesting in comparison to humans - when we doing something that we consider
bad, the pain of it lingers for a very long time unless we "make it right" or
change our moral reasoning to post-hoc permit the "bad" behavior. This is needed
because of how reward signals are integrated long term, without this we would be
more prone to doing things against our moral reasoning, taking some short term
pain, then moving on. I don't believe this is how human morality actually
functions, but it is a reasonable model of it that's useful for thinking about
adding a second tier of reward signal to a reinforcement learner.

They mention requiring the agent give a justification. Human justifications for
our actions are most often post-hoc and capable of being very confident and
incorrect in people with a split brain, indicating a justification system that
is able to operate separate from reality. So, a justification system that works
as well as a humans would be prone to lying, explaining the apparent situation
in a reasonable way but actually obscuring crucial details.

They reject utilitarianism and deontology, for being rule based and thus weak to
the interpretation problem. So here we finally are, at **Wittgenstein**. Instead
of writing down what we want, we show what we want. I looked up the name and
found Ludwig Wittgenstein, but nothing about how his philosophy is related. I
guess I just need to finish reading the paper. Lunch for break first.

# Wednesday

So. Yesterday I took a nap after lunch, and missed my 1-3 block. Which was for
the best, I had a lot of actual and metaphorical housekeeping I needed to do,
and I was sleep deprived. I'm making up for it today, with two two hours blocks
instead of taking Weekend Wednesday as I usually do.

Also I bit my lip in a place where it had just almost finished healing and now
it's really annoying again. Oof.

Back to reading - I need to figure out what Wittgenstein has to do with all of
this, among other mysteries. There are only 2 pages left so hopefully this paper
starts making sense soon.

So what they propose is iteratively refine the AIs values, with rules as a
starting point. So far it doesn't seem any better than iteratively refining
rules, except that the AI is doing most of the work (somehow).

"Being trusted" seems like a terrible value, since the AI is encouraged to
deceive the human when it knows it can get away with it. However, for weak AI,
the risk of getting caught is very high, since the human can observe everything
that the AI can, so every lie is a risk of losing reputation.

So Wittgenstein is relevant because of a work called "Investigations"
(absolutely terrible name) which attempts to take us to the meaning behind
Wittgenstein's words, and argues that there is no representation in language
that can convey the meaning, that the only way is to show, rather than than
tell. Okay Elodin. 

Ah, here's the book, the title is actually "Philosophical Investigations":
<https://en.wikipedia.org/wiki/Philosophical_Investigations>. It might be worth
reading, Bertrand Russel openly disputed its publication, which is a good sign.

The conclusion there is that instead of giving goals as a list of rules, instead
take the AI on a journey or process that can cause it to indirectly understand
the goals. Actually, this is more or less what inverse reinforcement learning
does - the AI watched human perform a task, then learns to perform it. Is this
paper nothing more than a predecessor to IRL? Hmm. Probably, although this paper
makes it out to be something grand and philosophical, and IRL is still a very
coarse tool, not suited for the real world or superhuman problem solving.

Conclusion: there is a difference between rules and values. Moral rules are 
the rules of the game, while values are the spirit of the game. The friction
between these two gives us the interpretation problem.

So what should I pull from this for my paper? A summary, then how it relates to
safety... inverse reinforcement learning is useful, and avoids basically all of
the AI safety issues as long as the performances are "safe". The title is
misleading though - it doesn't give an approach, it just states what is desired.

There wasn't much for me to write about this work. It goes deep into relevant
philosophy and comes out with a very small idea - learn values instead of apply
rules - and offers no help on how to get that done. I'll move onto the next
paper.

## The AI Accident Network: Artificial Intelligence Liability Meets Network Theory

I all but threw out this paper, it's so long and I had a hard time making any
sense of it. But I'll give it another try.

So according to the abstract, they want regulators, judges, and insurers to use
"network theory" to understand novel legal problems that AI creates, and they're
also going to rely heavily  on "Fletcher's nonreciprocal risks". So using
nonreciprocal risks and network theory, we can figure out who to blame when AI
causes damage. Well that makes sense I guess, and that is relevant to my paper -
the risk done by AI is usually economic, and if you're doing a risk analysis
you should know who is taking the risk.

Also, it's 53 pages of double spaced text, so it's probably someone's thesis.

They give a compelling example to start: A security robot runs over a child,
causing injury. Who is liable? The owner of the robot? The manufacturer? The
designer? The answer is not clear. This is a situation of nonreciprocal risk:

> The nonreciprocal approach states that "a victim has a right to recover for
> injuries caused by a risk greater in degree and different in order from those
> created by the victim and imposed on the defendant"

So the defendant (whoever is responsible for the robot's actions) is liable,
because the robot was able to cause injury to the child, but the child created
no risk to the robot or the defendant. I think, although I feel like I'm
misunderstanding this.

Interesting - nonreciprocal risk is critiqued as arbitrary, and very sensitive
to novelty. We see this with cases where someone is injured by someone driving a
car, there is usually very little chance for liability because it is so common
and accepted that this happens, and the victim is often "guilty" of
"jaywalking". I have strong opinions on this, but it's an example of extremely
nonreciprocal risk - the pedestrian is the only one in danger, and the danger is
very serious.

Now the authors want to use network theory to patch up nonreciprocal risk. This
is where I got lost last time.

Huh, this is a really important point for my paper, and they have a citation for
it:


> AI entities are able to connect more intensely than humans can. An AI entity's
> ability to communicate significantly faster, in a repetitive manner and across
> a vast number of platforms simultaneously is unique to online networks and AI
> entities which act upon them. This leads us to focus on the AI's level of
> activity, which is significantly higher than its counterpart human nodes, thus
> creating excessive risks. [13]

So now they claim that by making the AI and all parties into a network (a
graph), they can measure the liability using network metrics, just like those
used in content recommendation systems.

Also they keep using the word "tort", which sounds silly. But it isn't - it
means a wrong committed by someone who has an obligation to be safe, such as an
injury caused to passersby by construction.

The identify 4 ways that AI is unique, in addition to its inability to be at
fault, as a tortfeasor: 1. physical danger as result of malfunction, 2 loss of
control as a result of hacking, 3, surveillance and loss of privacy, 4,
black-box problem, that the AI is not observable.

They make the case of nonreciprocal risk from a non-human entity in the case of
dog owners, dog poop, and people who may step in said dog poop (they used the
term "dog litter" but I'm not a legal so I don't have to stoop to that level).
The dog owner is responsible, and is motivated (sometimes through litter laws or
park rules, sometimes through culture) to remove the nonreciprocal risk they are
imposing on others who might step in the dog poop. If this were a model for the
AI situation, then we would be done - the owner of the robot is responsible if
the robot misbehaves. However, unlike dogs, AI are designed and manufactured by
conscientious parties. You can't sue the dog's parents or nature itself, although
it is possible to try and place blame on a dog breeder, trainer, or previous
owner for a dog's behavior, but this is unlikely to be accepted. Furthermore,
you can't sue the dog food company because your dog pooped, but you can sue
someone you bought data from because your AI created bad outcomes. Okay this
metaphor is being stretched WAYYYY too thin. I hope the author has something
substantial to say soon, because I'm am really not sure how this problem is
tractable.

They now reject the idea that "reasonableness" is useful for these cases, since
an AI cannot be reasonable since it is not a person (current AI has no
personhood worth worrying about). 

Okay, so they suggest for the sake of legal tractability that "strict liability"
is used, and blame is placed on the actor in the best position to absorb the
costs. They call this party the "cheapest cost avoider", which is confusing.
They also state the algorithmic negligence is not feasible at present.

They make an interesting point - The AI entity cannot be "harmed" since it is
property, and thus any risk of injury it imposes is non-reciprocal.

For product liability, the designer is almost always at fault, but the
complexity and opaqueness of AI makes the AI situation much harder to assign
fault.

Another author, Bathaee, creates the idea of a liability shield for people
creating black-box AI which they cannot knowingly predict. This author rejects
this, as it will creates a dangerous situation where we knowingly distribute
dangerous AI technologies without consequences.

They identify nodes with lots of edges as important, as well as "eigenvector
centrality" and geodesic distance between nodes (presumably from the victim to a
potential defendant).

Distributed network: a network with random edges and few hubs

Decentralized network (aka small world network) has local clusters which are
connected, but also random distant connections (like social networks)

Centralized networks are usually more efficient, but less robust (single point
of failure).

Once an accident has occurred, and "Accident Network" is analyzed, with the
victim, AI owner, creator, relevant manufacturers and so on. 

They conclude that by carefully designing these networks, we can identify the
best pressure point that is able and willing to take on the costs its AI entity
may inflict. Insurance companies can use this to insure the use of AI.

Wow this paper is challenging. So what did they conclude or contribute? I have
no idea. 

Oh, I just looked up "strict liability", it means liability which is made without
regard to fault. So a designed may take strict liability because they are the
most relevant agent, even though the user or some other party is actually at
fault. "

Okay I also should have looked at cheapest cost avoider. It uses cost-benefit to
figure out how to deal with externalities. Instead of charging the polluter (or
risk-creator), it allocates funds to find the best way to avoid the cost, by
reducing the pollution or risk. The example on [page 2 of this
pdf](https://www.iru.org/sites/default/files/2016-01/en-ccap-leaflet-2008_0.pdf)
is compelling, but I have trouble understanding how it applies to other
situations.

# Thursday

Wow, after Monday went so well, this week has flown by with not much more
progress. Although, getting a hold on "The AI Accident Network" (ah, the title
makes sense now) did take off of Wednesday, and Tuesday had only an hour of work
due to my book-finishing induced sleep deprivation.

I'm 10 minutes late because I was engrossed in reading "House of Leaves",

(spoilers, hover to read) <span style="color: black; background: black; span:hover { color: white}">
a confusing and disturbing multi-leveled narrative that is at once the story of
the rapid deterioration of sanity of the editor, a review of an imaginary film,
"The Davidson Record" and a telling of that film in complete detail. The editor
himself often rambles off on completely made up stories told at bars, adding
another layer of narrative wedged up against the other three, stuffed into the
footnotes. 
</span>

But now I need to get to work. I need to take this concept of an AI Accident
Network and make it into something useful for the thesis. Before I do that, I
want to get my citations in order. I need bibtex for the papers Dr. Yampolskiy
sent me, and I need to dig up a few citations I TODO'd. 

Oops, my computer crashed. It froze up really bad, net even the power button was working. No idea what caused it - maybe
a buggy web page? I should limit Firefox's resource cap...

Okay so patching up old TODO's took up that hour. I have to break for lunch so I can be ready for my music lesson at 2
(it's 12:15 now) but **tomorrow I'll get those citations together and use that networks paper in the thesis**. Bye!



# Friday

So far I've got a lot of citations put together and I cited all the papers Dr. Yampolskiy sent me.

Lunch break! I worked 15 minutes into my lunch break, then got deeply engrossed in "House of Leaves" again and didn't
start working again until 1:45. I'll stay 30 minutes extra to make up for it.

So. I don't think my paper is good enough to send to the writing center, I'll save that for next week. I should go ahead
and make the appointment, though.

Oof. Done for the day. I'm exhausted. Next week is gonna be a doozy (do people actually say that?). Bye.

