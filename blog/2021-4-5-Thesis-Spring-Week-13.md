---
layout: post
title: Thesis Week 12 (Spring)
---

- Monday: ()
    - 10-12: 1 hour reading AI failure material that Dr. Yampolskiy sent me,
    - 1-2: Analyze the failures for common themes.
- Tuesday: ()
    - 10-12: Writing preventative measures section
    - 1:30-3: same
- Wednesday: ()
    - 10-12: proofreading
    - 1-3: proofreading
- Thursday: ()
    - 10-12: proofreading
- Friday: ()
    - 10-12:
    - 1-3: 

# Monday

Spent the first hour of the week reviewing all of the AI failures that Dr. Yampolskiy sent me. This is actually really
helpful, seeing what kind of AI failures are happening out there. Most of them happen "in the lab" or on purely virtual
spaces, although a few with a physical component happen too. AI that informs medical decision making seems to be the
most dangerous at the moment, there was a case where the algorithm for determining severity for assigning organ
transplants assigns lower severity to black patients than white patients, all other inputs kept constant. The reflection
of racial bias is an issue with the technology only in a small way, the greater issue is that our data contains racial
bias of our society and individual decisions. Algorithms that ingest this then spit it back out is dangerous because 1.
feedback loops could greatly increase racial bias past our current baseline 2. software and datasets are likely to be
used for some time, causing biases to be perpetuated longer than they would otherwise 3. culturally, we assume computers
are bias-less and objective, so output from a computer is going to be treated as either fact or bug, but not with some
nuanced failure like racial bias. (3) is quickly changing, though. The will remain problems but cultural acknowledgement
of fallibility of AI and AIs ability to reflect human biases will mitigate the damage.

Somehow this information has made me even less certain of what to write. Oh, there was a Roomba-adjacent robot failure.
It sucked up a woman's hair while she was sleeping. Sleeping or laying on the floor on a mat or futon is common in South
Korea and Japan, and so this failure could only have been predicted by someone who is aware of that.

I'm going to list all the links he sent me, to get an idea of what failures are happening or being discussed in them.

- AI "emotion detection" only detects facial expressions which, without context, cannot be used to determine emotion.
    - <https://onezero.medium.com/amazons-a-i-emotion-recognition-software-confuses-expressions-for-feelings-53e96007ca63>
    - Not exactly a failure
- AI driven hot air balloon learned to tack back and forth, getting better performance than a straight course. Human
  operator/designers didn't realize and though it was going the wrong way. 
  - <https://www.bbc.com/future/article/20210222-how-googles-hot-air-balloon-surprised-its-creators>
  - Failure of interpretability, human thought a failure while occurring while in fact useful innovation was taking
    place.
- Facial recognition software to determine gender is very unreliable for (binary) transgender people, and does not have
  classes for nonbinary or agender people. I would say the problem statement for a gender determining AI is ill-posed,
  since gender is not completely knowable by appearance alone.
  - <https://www.forbes.com/sites/jessedamiani/2019/10/29/new-research-reveals-facial-recognition-software-misclassifies-transgender-non-binary-people/?sh=4e6ad5b1606b>
  - Distributional shift failure. Within a strictly gender binary world where everyone's gender is "obvious" from their
    face this AI would be fine (the premise of the AIs creation), but that was never how our world worked and by
    focusing on a specific population (transgender people) the failure rate goes from a few percent to 60-100%. 
  - This failure is interesting because the premise of an entire sub-problem of computer vision has been challenged and
    rendered obsolete, not just the specific technologies being used.
- Using terms "black" and "white" in a chess context caused a chess channel to get blocked. The failure is again the
  failure to understand context, and the result is likely that content creators self-censor to avoid being mislabeled as
  racist, creating a strange world where merely saying the words "black" and "white" is discouraged.
  - <https://www.news18.com/news/buzz/youtube-ai-blocked-chess-channel-after-confusing-black-and-white-for-racist-slurs-3454316.html>
  - Failure of an AI to understand context of natural language. Seemingly harmless but this causes a change in how
    people use language, which can have complex consequences.
- Someone's "good morning" is translated to "attack them", leading to arrest
  - <https://www.theguardian.com/technology/2017/oct/24/facebook-palestine-israel-translates-good-morning-attack-them-arrest>
  - There is an obvious failure and a hidden one. Mistranslations occur, and not much can be done about that. But the
    fact that an arrest was made without verifying the validity of the translaction reflects a much greater societal
    failure to acknowledge the unreliablity of AI. Disclaimers on tranlations (espcially in languages with smaller
    datasets or when the language pair has known issue or very little real world testing). Techniques for predicting
    failures might be able to know when a language pair is likely to give drastically incorrect outputs.
- Medical decision making AI assesses black people as being in less danger than white people in the same situation.
  - <https://www.wired.com/story/how-algorithm-blocked-kidney-transplants-black-patients>
  - The AI has hidden biases, and once discovered the AI can be fixed or decommissioned. The real issue here is
    black-box decision making from poorly understood tech. Racial bias is a really difficult thing to fix.
- AI camera operator tracks goalie's head instead of the ball. A human job given to a machine without human oversight
  causes a small but telling failure.
  - <https://www.sbnation.com/soccer/2020/10/30/21541962/soccer-match-ai-camera-bald-head-ball>
  - The failure itself is a minor thing, but the lack of oversight is the more important failure. Someone should have
    noticed (fans did) and put a human in control of the camera. Instead most of the game went with this terrible
    filming.
- I didn't understand this one, it seems that their citations were considered plagiarism? Since two people citing
  something in the same format should make the same text.
  - <https://mindmatters.ai/2020/02/anti-plagiarism-software-goof-paper-rejected-for-repeat-citations/>
  - This is bad software, but worse there was no human-in-the-loop to fix the issue. The paper was auto-rejected based
    on the output of a low-quality algorithm.
- An important politician's name is translated to "Mr. Shithole", which is very rude.
  - <https://www.theguardian.com/technology/2020/jan/18/facebook-xi-jinping-mr-shithole>
  - Lack of context sensitivity, combined with a less common language (Burmese). Maybe posts seen by millions should
    have their translations moderated?
- When asked a question about the heart, a home assistant repeats a tirade about the heart being the cause for life and
  suffering and suggests suicide.
  - <https://www.aol.com/article/news/2019/12/20/amazon-echo-speaker-goes-rogue-tells-scared-mom-to-stab-yourself/23885142/>
  - The way Alexa finds content from the internet and repeats it allows for all sorts of incredibly inappropriate
    content to be read aloud to you, and without the context of its creation (in this example, probably some blog post
    on a personal website or forum full of weird stuff) it seems that Alexa is the one telling you to do this, which is
    much more disturbing than encountering the same text in the wild. Again, a **context** failure. Not only does the AI
    misunderstand the context of the question and the text that it grabbed, but it creates a context of a friend telling
    calmly telling you truths about the world. Juxtaposed with the harsh worldview expressed in that passage it quoted,
    the effect is truly disturbing. 
  - I would attribute the failure to a heavily anthropomorphized AI (natural language use, convincing vocal output,
    consistent personality, a name) product combined with deeply subhuman levels of contextualization.
- Roomba eats hair, fire department called. "Outch" says victim.
  - <https://www.theguardian.com/world/2015/feb/09/south-korean-womans-hair-eaten-by-robot-vacuum-cleaner-as-she-slept>
  - Robot vacuums have very simple sensors and control and couldn't stop from doing something like this. Now we know, if
    you have a robot vacuum and long hair, don't sleep on the floor. I think the addition of auto-deployment and
    auto-docking made this failure plausible, as you would know not to sleep on the floor while the vacuum is going, but
    if you merely have such a thing in your house you might forget what it's capable of.
- Facial recognition used by government online passport service fails for people with very dark or very light skin
  - <https://www.bbc.com/news/technology-49993647>
  - Out of distribution failure, and presumably racial bias in training data. Being able to detect out-of-distribution
    or otherwise low confidence situations and having a human intercede would make this far less likely to occur. Even
    something as simple as "if it fails 3 times or the user requests it, a human can check and landmark the image
    manually". Part of accepting the fallibility of high-tech solutions is being able to mitigate their failures with
    low-tech low-cost solutions.
- Some pressed the emergency button on the robot. It should have called police dispatch (I assume) but instead just
  acted quirky.
  - <https://metro.co.uk/2019/10/04/police-robot-told-woman-go-away-tried-report-crime-sang-song-10864648>
  - This is certainly a programming mistake and not an "AI" mistake, since the robot had an "emergency" button which
    presumably should be hard-coded to alert authorities. 
- This post looks at output from improved GPT-2 text prediction models and finds errors in the text
  - <https://www.reddit.com/r/slatestarcodex/comments/d6modp/the_extremely_subtle_errors_of_megatron_the_83/>
  - They specifically look for self contradictions or other blatantly wrong parts of the text. A commenter notes that
    text AI have come so far that it takes some effort to find its mistakes.
  - Not exactly a failure, unless you expected the AI to be human level. So as long as anthropomorphization is
    controlled,  then this AI can be used for things.
- This reviews a bunch of failures that I won't cover here, some old, some new. Celebrities misidentified as criminals,
  increased voice-spoofing abilities from AI, robot dog flailing on stage, automated trading losing someone millions.
  - <https://syncedreview.com/2019/12/19/2019-in-review-10-ai-failures/>
  - A major theme here is AI tries to do something that humans do and fails in ways a human wouldn't. Even if the AI has
    higher performance than a human, it doesn't matter if it doesn't know when to ask for help or if it fails on
    something that should be obvious.
- Small muddy road offered as detour. It wouldn't matter if one person made this mistake, but a route recommendation
  taken by dozens of people at the same time makes this a proper incident
  - <https://whas.iheart.com/content/2019-06-26-dozens-of-cars-get-stuck-in-mud-after-google-maps-led-them-to-empty-field>
  - Shows a lack of real world knowledge and two pieces of missing context - the tiny, infrequently traveled road is
    much worse after rain, and sending a bunch of cars down it will make the path even harder to travel. Worse, the
    crowd increases faith that the route is traversable, and makes turning around much harder.
- GPT-3 tries to come up with ideas to prank yourself (by the prompting of the author). Not a failure - the AI gives
  a few genuinely creative ideas, although most of them are impossible or not funny.
  - <https://aiweirdness.com/>
  - However, if these were unironically handed out in a brochure on ideas to have fun during the pandemic, then it would
    be an extreme case of lack of human oversight, common sense, and proof-reading. CONTEXT is what matters, and AI is
    not ready for serious contexts.
- A twitter collecting similar failures. Not going to go on a deep dive there.
  - <https://twitter.com/mlfailures>
- Curated AI failures list. Also not going on a deep dive there.
  - <https://github.com/daviddao/awful-ai>

So this did take an hour and half to do, but I have come out of it with an insight - humans are incredibly good at what
I'm calling "contextualization", and AI are incredibly bad at it even when they get very good at other human traits,
good enough that we can create a shared illusion that Alexa is a person. 

Also, perfecting a technology that has a flawed premise doesn't make for good outcomes. Both emotional state and gender
are not captured completely on a person's face. Both require more information that a single photo can express. More so,
gender isn't predictable - the "assuming someone's gender" issue doesn't exist because we have imperfect vision but
because we're at a point where gender is internal and personal, so the only way to know it is to ask.

I have a feeling that as human-like AI moves from novelty -> online-only -> recommendation systems -> robots, we're going
to see more and more of these issues. The physical presence of "smart speakers" has introduced a whole slew of novel
failures. 

I'm out of time for today - I've got to quit an hour early to go get dose 2 of my covid vaccine! It's a good day.
Although, it sucks that I'll probably be sick the rest of the week while I'm trying to work.

# Tuesday

Got the vaccine. I don't really feel sick, maybe a little bit more tired than usual, and a bit of a headache. I was up
early today, I thought about coming in early but instead I took a shower. Work time. What to do. I feel smarter today
than yesterday, but maybe that's just because I haven't started yet. Safety recommendations are the next thing on the
list.

Wow, work is going really well today. I'll have this section done today, then all I need is another few case studies and
I'll be ready to start editing.

I can't believe I've come this far. I read over my paper and I was actually really happy with it. I also noticed a TON
of small things to be edited, so editing is going to be quite a task (but a good one). I'll be ready for the writing
center on Thursday.

Back from lunch. I took a quick nap (30 minutes). I think the tiredness from the vaccine is getting to me. I made a
glass of orange juice, it always helps me feel energized.

Done with that section. I think it's basically done. Now just to come up with some more case studies. I don't think
anyone will mind if these are haphazardly thrown together - the heart of my system is a bunch of rough guesses and
estimates coming together to make a slightly better picture than you start with. Reading the paper doesn't so much as
forecast your risk as it does introduce you to the big ideas of Perrow and others so you can see that some humans have
been trying to figure out how not to destroy the world for a long time and have some pretty sound advice.

Time is up for today. Tomorrow I'll pick back up at editing the case studies to be more readable. They also all need
citations for news sources, where I'm drawing the information from. Tomorrow I should have the case studies done. I
think 6 or 7 is a good amount of them, I can make one in about 30 minutes, since they are relatively simple and don't
require serious research.

# Wednesday

I'm supposed to send the writing center a draft today by 12, so I'm going to do all the editing I can now, then add some
case studies in the afternoon.

Back from lunch. I went for a jog. I've been feeling really distracted all day and it didn't really help that much.
I didn't get very far in editing before it was nearly 12 and I had to submit my draft. Oh well. I'm going to try to
piece together some more case studies. Actually, I'll keep proofreading. That deadline might have been midnight instead
of noon, so I should get a better draft so we can spend more effort on actual important errors tomorrow.

Got a bit interrupted, mom called and I made a dental appointment. I'm going to work an extra shift today so no big deal
missing half an hour here.

# Thursday

Proofreading is going much slower than I expected.
