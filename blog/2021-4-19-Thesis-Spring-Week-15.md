---
layout: post
title: Thesis Week 15 (Spring)
---

- Monday:
    - 10-12: finished adding related works slides, went outside to practice reading over my slides and streamlining
    - rest of day: kept editing and practicing slides
- Tuesday:
    - 9-12: prepared
    - 1pm: successfully defended thesis
- Thursday:
    - 10:30-1:20: uploaded to University and to arXiv
    - 2-2:30: singing lessons
- Friday
    - 9:30-2: I've got a handwriting RNN model! At least, I have the data formatted and a semi-functional model.
    - 3-4: given up on my handrolled RNN to use the built in GRU. Also, float16 gave me NaN.

# Monday

I woke up a bit after 8, and for some reason I thought 8 was my starting time and I was late. It turns out 8 is when I
usually get up and even now it's only almost 9. Also it's cold but not cold enough to leave the heat on, I wish spring
would go ahead and commit to being warm.

I think my slides are good now, I'm going to practice reading my script out loud. I'll go outside to do this.

# Tuesday

[This is the day of my thesis. I presented my thesis, they discussed, and my thesis was approved. I defended is
successfully!]

# Thursday

It's all over. I have a bit of paperwork to do, and an assignment in another class, but I am basically done with school.
After 17 years of schooling I'm finally done. It's a bit overwhelming. I'm tempted to start working immediately to stave
off the existential dread, but everyone I talk to says that if you can afford to, you should take off some time before
jumping into work. For me, that means taking the summer off (although I still have a lot of projects and such going on
this summer) then looking for work in the Fall. Dr. Yampolskiy encouraged me to stay with academics, I think I want to
come back and get a PhD at some point but I want to start making money first. He says that once you start making money
it's really hard to come back to academics. I'll have to think on that one - the academic route is something I've
thought about. I would love to have reliable institutional backing to pursue research, but I don't know about teaching.
I might enjoy teaching intro programming a few times but I just don't know if I have the right skills to teach year
after year.

Anyway, I no longer need to work a strict schedule, but I think I still will keep up the 10-12, 1-3 minus Wednesday. It
gave me a reason to get out of bed, without replacing my whole life with structure. And blogging like this is a very
simple introspective activity. It didn't keep me from veering off course and drifting from productivity, but it did
provide an anchor when that happened. Time I didn't spend writing was spent blogging, and that kept me on task. There
isn't a task anymore, but there is the meta-task of creation and improvement that has a "what you're supposed to do"
feel to it. I'll check back in tomorrow, maybe make some more plans for how I want my 16 hours per week of structured
activity to go.


Idea: make a script I can run on Mondays to make a new blog, or just make all of them and check them into git as I go. 

# Friday

I stayed up past midnight installing cuda stuff. I finally became enlightened and threw away the outdate tutorials and
just installed stuff after deleting everyting. Thankfully I have a roughly okay log of things I did. Moral of the story
is, if it isn't an apt install, you don't need it. It's too bad I had to ditch Debian, but only Ubuntu is supported by a
lot of the deep learning stuff.

I did end up going wit conda, it manages optimized binaries correctly for tensorflow, and its virtual environments work.
So now I have both pytorch and tensorflow installed and working. I'm going to make an AI today to kick it off.

I saw a video where someone made lowest case and uppest case fonts. They used fonts, vector and raster, and had limited
success. The abyss-case all-letter was pretty cool, though. I have a different idea for finding uppest case letters.

There's a dataset of sentence-text pairs. Also I think it has word-text pairs. It's all handwriting, which is a
limitation. The goal is to make an RNN predict the text, conditioned on the text. But the text is encoded as 26-hot for
letter, and a 0-1 value for case. This should allow to smoothly modulate the case, including increasing it beyond normal
boundaries.

Or maybe I could use style transfer semantics. However, there are far fewer uppercase examples than lowercase. Maybe I
need a VAE and I can find the latent space direction for case. That might actually be a good way to do this. I can do
dimensionality reduction and use my limited examples to find an uppercase dimension.

I'm going to try the rnn first since it's the easiest and most fun. The rnn will have a lot of loss, since even if you
know the writer's style, a lot comes down to chance. Maybe it should also have an autoencoder form of a random word from
the passage to help it capture style? Nah, it'll be fine.


I ended up going with treating the handwritten sample as a series of versical slices, and made the object next-slice
prediction. My RNN worked pretty terribly (but I also didn't train it for very long or with much data), so I switched to
GRU. The GRU does everything all at once instead of using a loop, so it was a bit tricky to get it working again. Loss
is steadily decreasing, but the images are mostly white so it might have found a degenerate solution. 

So the results are bad. There are striped on the edges, and a very blurry approximation of the text. I don't know why it
makes the stripes - they should be trivial to avoid. Maybe the hidden to output part needs another layer.

So the stripes are gone, but it only learned the blurry line strategy. I think it needs maybe a day of training data.

Trained it with more data for 100 epoch (not long enough, I know) and still got blurry lines. I think this is similar to
the issue that look like a billion years for me to debug at PNNL, something to do with loss function sequential models
behaving badly due to the extra dimension. I don't remember how I fixed it, either. I switched MSELoss's reduction to
sum instead of average, but this just made the values really big.

Well, it's not only a straight blurry line anymore - switching to sum and stopping at 70 epochs gives clear word
boundaries, but the black bars are back. I'll keep training this model.

I think for the bug I had at PNNL, the MSE thing was actually a red herring and my mistake was misusing the output of
the LSTM. I'll double check that part of this code.
