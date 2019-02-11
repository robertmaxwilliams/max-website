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



