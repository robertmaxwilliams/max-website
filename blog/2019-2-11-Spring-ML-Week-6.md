---
layout: post
title: Artificial Intelligence Safety And Security Independent Study Week 6
---

We're going to focus more on reinfocrcement learning this week, such as inverse reinforcement
learning and other variations.



# Monday Week 6

Paper:

Active Reinforcement Learning with Monte-Carlo Tree Search
<br>
[https://arxiv.org/abs/1803.04926v3](https://arxiv.org/abs/1803.04926v3)

This paper explains an algorithm for "Active Reinforcement learning", a variant of reinforcement
learning where a cost has to be payed to view the reward. I don't understand the direct applications
of this, but it seems to be a good way to make the agent understand the reward function better than
if it could view it all the time. I also can't think how this would be useful for safety, unless if
the reward function was a human and we wanted to bother the human as little as possible. Still,
human-in-the-loop RL is a dangerous game: a superintelligent agent could easily manipulate the human
to output higher reward in horrible ways.

Reading the first page, they offer medical testing as an application. Testing medicines requires
expensive human studies, so once enought patients have been tested that the efficacy of the
treatment is known to some degree of accuracy, recruiting more patients is a waste of resources.


I really don't understand what the paper is talking about... I'm going to review inverse
reinforcement learning and go from there. I started with this powerpoint (as a pdf):

[https://people.eecs.berkeley.edu/~pabbeel/cs287-fa12/slides/inverseRL.pdf](https://people.eecs.berkeley.edu/~pabbeel/cs287-fa12/slides/inverseRL.pdf)


# Wednesday Week 6

I really want to make my curiosity bot implementation. I made a one-shot learning NN in Keras,
available for viewing [here](https://www.maxwilliams.us/files/few-shot-mnist-1.html) and 
[here](https://github.com/robertmaxwilliams/max-website/blob/master/notebooks/few-shot-mnist.ipynb).

I need to tune it and compare it to a pixel-space distance based method, which should underperform
the neural network.

ALSO. I spend HOURS trying to figure out why it kept training to 50% accuracy. My first mistake was
putting a relu layer before the sigmoid output. This meant the sigmoid function always took in a
positive value, and always output a value greater than 0.5. The next issue was much more sneaky. I
was using `binary_crossentropy` as the loss, and `accuracy` as the metric. Well it turns out that
that metric was garbage for my task, and I wanted `binary_accuracy`. With that fixed it worked great
:|

I feel like this is the reason beginner DL is hard, it has a lot of black boxes and new concepts,
and opaque APIs.

# Friday Week 6

So this came out:

[Better Language Models and Their Implications](https://blog.openai.com/better-language-models/)

And now they have a model that can write, from a prompt, anything from imagined news stories,
clickbait articles, fanatical contradictory ravings, recipes, and fantasy stories. The content it
produces makes sense, and is easy to read and understand. Sometimes it spouts a bit of nonsense here
and there, but for the most part the text it produces is mostly indestinguishable from human
produced text.

They also talk about respsonible discosure, and reference DeepFakes. They didn't realease the final
code or trained model, but did release a "smaller model" to experiment with. I don't think this is
sufficient, even releasing the knowledge that this is possible and the vauge research direction is
enough to gaurentee that someone will recreat this feat within a year, if not less. 

I've only read the press release, I'll read the [paper](https://d4mucfpksywv.cloudfront.net/better-language-models/language_models_are_unsupervised_multitask_learners.pdf)
and see what I think then about the possibility of full reproduction.

They claim from the start to have a completely general text generation/question answering/etc
machine, that can perform tests from supervised learning datasets with none of the training samples,
by being good "in general" at working with text. They also say their model is a "1.5B parameter
Transformer", I'm not sure what a transformer is or if 1.5B parameters is a lot. If each parameter
was a byte, it would be 1.5 Gigabytes, which isn't an astounding amount. It's probably closer to
four to eight bytes per parameter, if they're 32 or 64 bit floating point numbers. Still, 6
gigabytes of numbers would fit in the ram of my laptop, if the software was heavily optimized. 

Actually, AlexNet has 60 million parameters, and VGGNet has 138 million, and both of those are
monstrous image classification models, that take weeks to train.  So... 1.5 billion is quite a lot.
I imagine you can't train that on a single GPU in a reasonable amount of time. 

They also point out that supervised learning creates narrow intelligence, and use the term
"independent and identically distributes (IID)" for the kind of held out test data, which doesn't
tell you how well it will generalize to novel data. For instance, a classifier may do poorly on
poorly lit photos or photos with motion blur, like a user might take, if the train and test data was
all high quality photos. They propose "multitask learning" as the solution. When I read about the
[innovation engine](https://www.maxwilliams.us/blog/2019-2-4-Spring-ML-Week-5) it seemed that their
main __innovation__ was having multiple objectives all present for every creature in the gene pool,
allowing cross-innovation and promoting generally good solutions over those that fit one metric very
well.

The model they used is "Transformer (Vaswani et al., 2017)". I recognize the title: "Attention is
all you need". They touted their model as being conceptually simpler, easier to train, and much
more effective than recurrent or convolutional techniques applied to sequences. It relies solely on
attention mechanisms, one thing I barely understand.

I'll have to read up on attention before I have any hope of understanding this paper.

Back to the perfect text generating machine, they describe the dataset in great detail (the same
dataset they refused to release) and it seems anyone could reproduce it, a sub-scale reproduction is
possibly within my skills. They also mention that their model is based heavily on the "OpenAI GPT"
model with modifications.

Interestingly, they trained four models with increasing size, up to the 1.5B parameter model, and
still underfit the training data and could continue to train productively.

In question answering, they find increasing model size improves perfmance and from this, they
conclude that poorperformance in the past has been to limited model size. From this, I gather that
this technique is nowhere near the end of its scale, and could in theory do even better with a
factor of 10 increase in parameter count. However, OpenAI put all of the resources they had into
training this enourmous model. Perhaps more powerful matrix computers will be available soon,
allowing for a few orders of magnitude increase in size in the next 10 years. 

Appendix A has a ton of samples, from different sizes of models. The GPT-2 text is uncanny. There is
even a recipe it created! A few, actually, but they're all cut off. I would like to try to make one
of them, or synthesize the 4 recipes it has into one decent recipe, to be made to celebrate the
anniversary of GPT-2's creation which heralded the end of truth and the automation of thought.
