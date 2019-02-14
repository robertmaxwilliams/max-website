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
