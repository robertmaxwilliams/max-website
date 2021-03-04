---
layout: post
title: Thesis Week 6 (Spring)
---

Despite the lack of blog posts, I have been working this whole time, and sending updates to Dr.
Yampolskiy. Sending him weekly updates was redundant with making these updates, but now I'm feeling
very serious about doing this so making both feel more appropriate.

I'm also committing to a 4-day thesis work week - Monday-Tuesday, Thursday-Friday. On those days,
I'll drink caffeine (which I usually don't like) with L-Theanine for a few weeks top see if that
regiment will help me work. Having fixed work hours will help to. 10-12am + 1-3pm is a lot of time,
but as long as I'm taking this seriously should be doable. I should have done this sooner.

Week 13 (April 9th) is the unofficial due date of my thesis. That means I have 7 full weeks to do
this, while staying motivated and productive. I think before now I was imagining this thing being
10-15 pages and just taking it easy. Not anymore, I've surveyed the thesis submitted by UofL
graduate students and found they're 50-80 pages. And my topic is much "softer" than most so the
expectation is higher.

Now I wish I was doing this on ISC. I could totally write a thesis about that. But alas, indecision
and regret are both fatal so instead I'll dream about that as being my PhD thesis someday. I can do
150 pages worth of research about indefinitely scalable computing, especially with the hardware to
scale it up, an electrical engineer to make hardware work, and an undergraduate assistant to pair
program with. But alas, that's a far off dream and right now it's just a distraction from the stress
of my current, real thesis.

Anyway, isn't this what I dreamed about a few years ago? Making a useful work on AI safety in a
practical way? I'm exactly where I want to be.

Work log:

- Tuesday: Not schedule, reading a bit of Perrow
- Wednesday: Didn't have schedule yet, some sporadic work and reading a bit of Perrow, making Roomba
  chart and emailing Dr. Yampolskiy about thesis length.
- Thursday: 
    - 11:30-12: Making the motivation structure and schedule.
    - (no afternoon work bc. singing lessons)
Friday:
    - 10-12: 30 mins Evaluating the 2018-2019 theses, an hour writing outline
    - 1-3: Working on reviewing high reliability theory and NAT-HRT synthesis that will be central to
      my related works section. Not espectially good generation but getting a better understanding
      of shivastave2009normal will help my get out of the pessimism holding my back from building
      the guideline of how to react to risk factors. NAT is pretty pessimistic and rare.

An explainable sequence-based something rather

- 6 pages of opening material (title page, thanks, etc)
- 2 pages abstract
- 4 pages table of contents and list of tables, figures
- 2 pages explaining the state of the art for ML
- 1 pages "objectives"
- 13 pages explaining the various sequence models
- 5 pages explaining data prep
- 6 pages FINALLY getting to the actual research, the model design
- 10 pages experimental reports
- 2 pages conclusion

It's clear how they get so many pages now. The text is VERY spaced out, and they have a huge gap
between paragraphs. In this whole paper there are only 5 pages of novel content, which would fit
into 2 pages of IEEE format minus the pictures.

Automatic IQ estimation using stylometry methods

(yikes, that sounds like a really bad idea, for classism reasons)

- 6 pages opening material
- 1 page abstract
- 3 pages tables
- 3 pages intro
- 7 pages setup
- 8 pages method
- some more pages then results

Anyway, they have double spaced text (maybe that's the norm? I can't say I'm a fan), some code for
fluff, and a few tables. It's really more like 20 pages worth of content. BUT. It's published. Dang,
and I was getting stressed about not being able to write as much. I should do a word count on all
these papers.

Clustering heterogeneous autism spectrum disorder data

- 7 pages opening material
- abstract

Oh wow, in the table of contents everything is covered in red boxes. Did they not know how to turn
off draft mode? Or maybe it's a setting with the hyperlink package. Anyway, it seems strange to
leave a mistake like that in the paper.

It's also double spaced. I guess it is going to be annotated so that makes sense, but still it
doubles the pages count.

This paper, being machine learning, has a lot of background that every single other ML paper has
along with borrowed low-res images from educational material.

Formulas, diagrams, bulleted lists. The amount of content is greatly exaggerated by the page count.

Here are the newline, word, and byte counts for all the theses I downloaded:

<pre style="  white-space: pre-wrap; word-break: keep-all">
<code>
  1133  19148 112613 An explainable sequence-based deep learning predictor with applic.txt
   350   8009  55157 Automatic IQ estimation using stylometry methods..txt
  1227  13818  81274 Clustering heterogeneous autism spectrum disorder data..txt
   941  13181  79794 End-to-end learning framework for circular RNA classication from.txt
   758  15462  84098 Horse racing prediction using graph-based features..txt
   980  17198 102293 Landmine detection using semi-supervised learning..txt
   973  11561  65256 Machine learning for omics data analysis..txt
  1713  13366  92154 Maintainability analysis of mining trucks with data analytics..txt
  1584  13520  80094 Modeling and counteracting exposure bias in recommender systems..txt
  1881  15139  86039 Robust fuzzy clustering for multiple instance regression..txt
</code>
</pre>

Word (middle column) being what I'm interested in. If I do the same to my pdf (or my tex) then I get
about 3,000 words. So apparently I'm anywhere from 3/8ths of the amount of content I need to 1/5th or
3/20.

That feels about right. I'm ready to get to work now.

# Outline

I guess I can write an outline now. Turning on double spacing, I've got 9 pages already. Adding on
the standard 5 pages of opening material, That means I have 14 pages already done! Well maybe not
really but I feel much better about this than I did yesterday.

Now for the outline:

- Acknowledgements [1 page]
- Abstract [1 page]
- Table of contents [1 page]
- List of tables [1 page]
- List of figures [1 page]
- Terminology [1 page]
- Introduction [3 pages]
    - AI Safety (AGI danger vs new technology danger)
    - Accidents and system accidents and AI systems' place in all that
    - We can't predict accidents but we can tell you where to look for them and how concerned you
      should be, or recommend that you should be worried about component failure instead of system
      accident
- Related works [5 pages]
    - NAT and HRT
    - Classification schema for AI
    - Impact on economic and political systems
- Problem statement: [2 page] AI brings new levels of unexplainability and incomprehensibility to systems
  that should be evaluated, as these are all things that NAT identifies as contributing to increase
  in system accidents
- Classification schema for AI systems [8 pages]
- Determining risk using schema tags [4 pages] this is the hardest part, and most likely to be seen as
  arbitrary and hand-waving. I should find another source that tries to do this.
- Case Studies [7 pages]
    - Roomba
    - ???
- Online tool for classifying AI systems and recommending risk management strategies [5 pages]
- Conclusion [2 pages]
- References [3 pages]
