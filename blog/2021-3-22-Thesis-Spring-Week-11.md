---
layout: post
title: Thesis Week 11 (Spring)
---

- Monday: ()
    - No work today
- Tuesday: ()
    - 11-12: 
    - 1-2:
- Thursday: ()
    - 10:20-12: 
- Friday: ()
    - 10-12: 
    - 1-3: 

# Monday

Today is a day off. Let me go find a holiday... checkiday claims it's national goof off day, which is honestly a pretty
great coincidence. It's only three days after Mojoday, I'll just say its a late Mojoday. I spent all morning cleaning,
and took a nap. The roommates and I stayed up late last night watching Tenet and playing games, and today has paid the
price. Worth it because we almost never all get together anymore. So no work on the thesis today. I'm taking a vacation
day.

# Tuesday

Good news is that I'm caught up on sleep. Bad news is I got here at 11. Oops. Even better news is I have feedback and
guidance from my thesis advisor! He had some small edits and structural changes to suggest but overall likes what I've
written so far. He suggested a handful of papers for me to read to get some new content, and that I'm probably just
feeling stuck because I've covered all the material I've read so far. 

I'll do a quick review of each paper to get an idea for how they fit in.

Oh also Annie suggested that I create a software development section in the paper, I think I'll do that as a way to use
up a few pages and provide some substance in the paper to anchor that side of the project to (otherwise it would only
be mentioned briefly and most readers wouldn't notice it).

## Towards Accountable AI: Hybrid Human-Machine Analysis for Characterizing System Failure

This is a great paper - they present "Pandora", an image captioning system with extremely well thought out
interpretability and human-in-the-loop design features. I don't understand it that well after just one read through, but
the point I'm going to make with it is that this is an example of the kinds of improvements that are desirable in
machine learning systems, extra components that help interpret why failures happen. Of course, these analysis tools can
themselves fail, leading to a greater degree of confusion than if they weren't in place to begin with (faulty gauge
problem). That's not an argument against having safety measures, just a note that they can introduce new and surprising
failures of their own and those should be weighed in when making design decisions.

## Adversarial Examples Are Not Bugs, They Are Features

You know you have a strong point to make when you boldly state it in the title. This is probably the most helpful
title-meme that's come about recently, almost the opposite of "considered harmful" which is itself pretty harmful when
overused. 

They make the case that standard classifiers are actually doing what we want them to when learning non-robust (aka
easily missed by a human) features of a dataset, which despite being non-robust, transfer well to the test set and other
data sets. So by making a robust classifier, you might also be making a less accurate or even less useful classifier.
Not only that, but adversarial examples are only incorrect from a human point of view, and this brings in alignment. The
classifier's predictions are not aligned with ours once adversarial perturbations have been applied, but they are only
wrong from a human perspective. From the perspective of the learner, the perturbed images have had meaningful changes
made to them.

## Explainable AI for System Failures: Generating Explanations that Improve Human Assistance in Fault Recovery

This looks like an improvement on previous error-explanation systems which also tries to give an explanation for why
something went wrong, and has pretty good accuracy for the example they gave of a free-moving household pick and place
robot. Also the name "XAI" for eXplainable AI is a bit unsettling because it immediately brings to mind "AIXI" which is
despite its incomputability, is still terrifying.

## Morality, Machines and the Interpretation Problem: A value-based, Wittgensteinian approach to building Moral Agents

Wow that's quite a title. Also this is a loooong paper, and extremely dense. I'm going to skip it for now so I can
finish the others, but I think it has a lot of good content.

## The AI Accident Network: Artificial Intelligence Liability Meets Network Theory

This one is basically a book! But it approaches from a legal perspective (which I know nothing about) and a network
perspective (I don't know what that means). So it'll be valuable as a different perspective.

That's all for today! Be back Thursday.

# Thursday

Today I'm going to work on some of the corrections/suggestions that Dr. Yampolskiy sent me. Also I am really tired this
morning. Unusually so, especially since I've had enough and consistent sleep the past few days. 

1. Move terminology to the appendix, also typo: "metal" should be "mental".
    - Done
2. Support (or change) the claim the most AI failures are not malicious. A statistical analysis would be forthright.
    - I could look at the AI failures database, I think they include enough information that I wouldn't have to classify
      them by hand.
    - So I'm on <https://incidentdatabase.ai> (also, nice top level domain) and it seems there aren't any tags on any of
      the submissions. They just have a unique "incident id", and a few writeups each with news sources. There are a lot
      of them - I guess I could draw 10 random numbers and see how many are malicious? Or 20? I'll do 20. That's a good
      number. So by scanning through the ids, there are only 92 failures in the database. However, their homepage claims
      to have over 1,000 incident reports - there can't be that much duplication, right? Actually, it looks like many
      incidents have 10-20 reports about them: <https://incidentdatabase.ai/summaries/incidents>. With this summary
      page, I think I can quickly scan through and note which "accidents" were caused by malicous actors. This is biased
      because most things with malicous actors are not considered accidents but attacks, but this is the best I have for
      now.
    - Done. Of the 92 failures, only 8 of them contain malicious intent by a human, usually the public manipulating an
      AI or perputrating some sort of cybersecurity hack. 
    - I wrote about it in the thesis but some restructuring is needed there for it to make sense.
3. I called the dangers of AI "AI Safety" where it would make sense to call it "AI risk"
4. The NAT diagram and reframed NAT diagram is borrowed directly from Shrivastava, I need to make sure I'm not violating
copyright. I guess I should email the authors? Or I could remake the diagram, which would have the added bonus of being
vectorized. Actually, I should do both.

That's all for today. There is more to the list, I'll be picking it up tomorrow.

TODO email Shrivastava about using diagrams, and remake them using latex plotting.

# Friday 


Aw gee, do I really want to do that? It'll take all day. Actual, I reviewed the journal's conditions and it sounds like
that I'm allowed to use up to three figures without needing to request permission:
<https://us.sagepub.com/en-us/nam/pre-approved-permission-requests-journals>

That's nice. So now I can move on to the rest of the list.

5. Try to frame autonomy as unpredictability? (links to "Unpredictability of AI")'
    - Read the paper, I'll try to do this!
6. "it" should be "is" on page 21
    - Found it, fixed it.

Next time I send a pdf to Dr. Yampolskiy, it needs to show where the changed content is. I should undo back to when I
made that pdf and take a checkpoint. Done, I saved a checkpoint as "2", a vim trick I learned by accident - if you enter
`:w2` or `:w1` or so on, it saves as as file with that name. It's actually `:w name` but by starting with a number the
tokenizer breaks the command and the name apart.

I just learned about `latexdiff` - it works perfectly right out of the box! I can't believe it, honestly. I just ran
`latexdiff 2 main.tex > diff.tex` then typeset `diff.tex` and it crossed out deleted text and underlined in blue new
text. So... nifty! Nift nift nift.

Anyway. I'm back late from lunch break. I think I'm very sleepy today, I might have stayed up later than I though I did
reading. So. That bulk of what's left of my paper is going to come from these publications that Dr. Yampolskiy sent me.
He also said that once I worked through those, he had more to send me, so I better chomp through these as quickly as I
can. I also have exactly two weeks left. I think I'll take away Wednesdays off, and add an extra hour here and there.
Not today though. Gee, I also need to take extra good care of my sleep in the weeks to come, and part of that is
exercising. I don't even dislike exercise, I just run out of the will to do it. Ugh.

There's only about an hour left today. I'll make a related works section for one of the papers and call it good. It's
okay if 60\% of my paper is related works, since it is a thesis, after all. As long as the works are actually related
(even if they've been forced to relate).

Well... it was a good try. I'm going to work on some homework that's due soon instead for the rest of the time.
