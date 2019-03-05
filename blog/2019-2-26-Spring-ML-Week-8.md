---
layout: post
title: Artificial Intelligence Safety And Security Independent Study Week 8
---

Last week I spent a lot of time experimenting with GPT-2 (well, the tiny pretrained model that OpenAI shared with the public). It's an amazing creative tool, like how surrealist games can help people break out of creative ruts. Some possible uses for it:

+ Create descriptions of visual artworks then try to recreate them
+ Create magic items for role playing games
+ Complete dialogues
+ Finish lists when I run out of idea
+ Teach yourself about how to deal with the "bad guys"
+ Put the code inside something that's easier to understand
+ Create a series of videos that can lead you deeper into the real world
+ Write down all my ideas in the form of "nuggets"
+ Work on a new level of fun, like "This is great, I tried some other stuff!"

Okay so the last five were from GPT-2, and it's pretty obvious. It's better at some tasks than
others. It's really good at creative journalism (aka fake news) Check out this fairly coherent
passage about the FBI's new program to identify terrorists, generated after an end-of-text token in
some other passages I was generating:

    The FBI announced today that it will use a tooling program to identify "highly influential individuals to help them make an ongoing risk assessment or identify new, better, and more effective ways to use these data." But there's one question mark here that's no answer to. Does this actually work?
    So what does it tell us?
    What does "analyze and analyze data," as it now calls itself, mean? In other words, it can tell us who's at the top:
    Who is at the lowest risk for being involved with terrorism and who is at the highest risk for being involved with terrorism?
    And what are the people that are at the highest risk for involvement?
    A group of FBI scientists, known as the National Counterterrorism Center (NCC), has developed an anonymizing tool called "Icons" for this purpose. Icons, in their case, essentially offer data to be collected and compared when a person or group of individuals makes an ongoing risk assessment. It then can predict who will likely make a dangerous decision, and can also estimate an individual's level of risk.
    That data can then be linked to "identifications and analysis of those individuals' intelligence levels, behavior indicators, and other data." That data will then also be used for the classification of criminal suspects, or the classification of the nation's terrorism suspects, making terrorism more likely to occur.
    And a couple of years ago, the FBI announced it was giving the government access to these Icons as part of a broader effort to look at how people who have connections to militant groups use "intelligence gathering" to carry out terrorist attacks. As I wrote just now, this seems to be exactly what we do.
    You may be wondering, "How does it work?" Well, here's a quick answer: It works to keep you safer.
    You're not safe
    For the FBI's Counter-Terrorism division, it is a bit of a tough call, because your data comes in handy when you need it.
    It helps to know which criminal organizations may be at the top — the terrorist groups, the radical organizations, or even foreign terrorist activity groups, according to law enforcement officials.
    It takes about the same amount of time, energy, and effort to gather and analyze data as is


I should explain how a typical session with GPT-2 works. You input some string of characters, and it
generates some number of completions until it reaches its token limit. I think the limit can be
increased without retraining the model, but I haven't tried that yet. The tokens are multi-character
tokens that the model uses to represent arbitrary strings that are made to be efficient for English
text. 

It's a bit of an art trying to get the best output from the model. If your text is "in
distributions", that is, similar to the training data, it will perform better. It was trained on
anything text based that was linked from posts on Reddit, so it has a bias towards news. It is also
fairly good at DnD-style fantasy texts. Some things it is naturally better at than others. Recipes
and mechanical insructions are difficult for it because it has no way of understanding if the
instructions make sense in the real world - it lacks a "minds eye" and intuitive physics. Without
these common sense tools, it's very hard to explain how to cut up and stack pieces of a layered
cake or how to change a tire. It also takes the correct setup to coerce the model into performing
your task. A paragraph of text above the desired completion can help a lot with its ability to
follow the right train of thought. Not that it has thoughts, mind you.

It's also very easy to anthropomorphise GPT-2. It also often seems to have "ideas" and "content" in
the text that it generates. I think that it's very close, maybe it's top-40 most likely next tokens
could be used as the action space for a higher level agent. As it is, most of the text gives me the
same feeling as when reading something very technical or obscure, where I don't really connect with
the author and understand what they mean. I don't "enter their mind" to understand the text. Now in
the case of GPT-2, there is no mind to enter. It's not that the subject is so difficult that I fail
to empathise with the writer, it's that the writer has no thoughts to empathise with, no content
behind the form.

I don't think GPT-2 is dangerous in an AI sense. It lacks agency, and doesn't seem to be able to
create any more influential or memetic ideas than an average writer. Because I've read so much 
[SCP](http://www.scp-wiki.net/) I feel suspicious about wandering text and "word soup" text as being
a [cognitohazard](http://www.scp-wiki.net/forum/t-578967/memetic-vs-cognitohazard-vs-infohazard) or
some sort of memetic threat, but those things are mostly fiction at present so I guess that's just
me being paranoid about new technology. If memetics ever earns itself the status of a real science,
I think computer generated text would be an important area of research. Maybe it is already, or
maybe I should make it so. Although Richard Dawkins is a real jerk.
