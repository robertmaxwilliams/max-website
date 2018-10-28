---
layout: post
title: Adversarial Examples for human vision
---

Adversarial examples are very revealing about a neural net's inner workings and weaknesses. [This wonderful post](https://blog.openai.com/adversarial-example-research/) by open AI discusses the security implications of adversarial examples, and [this arxiv paper](https://arxiv.org/abs/1712.09665) demonstrates extremely robust "adversarial patches" that can work on new networks that were not used in design. With adversarial example generation reaching this level of complexity, it raises the question of how immune the human vision system is to similar attacks, and what we can learn from attempting to generate adversarial examples for human vision.

## Optical Illusions as Adversarial Examples
 
Optical illusions are patterns that when observed by the human eye, create false impressions of non-existent stimulus. Examples of especially powerful illusions are [Skye's Oblique Grating](http://www.michaelbach.de/ot/ang-SkyeGrating/index.html) which causes straight line to appear parallel and the [Scintillating Grid](http://www.michaelbach.de/ot/lum-scGrid/index.html) which causes black dots to appear anywhere you are not looking at directly. This can be seen as a related phenomenon to a misclassification by neural networks when observing an adversarial example. These patterns are painstakingly created by human artists, and developing a new kind of pattern (as opposed to a new instance of a known pattern) requires incredible skill and luck, especially given the large amount of existing patterns. 

[Disruptive coloration](https://en.wikipedia.org/wiki/Disruptive_coloration) is another kind of optical illusion, but created by nature through evolution. Illusions of this type are more organic and generalize to nearly anything with a vision system, perhaps even to machine learning based systems. They are created through evolution with incredible amounts of trial and error on extremely complex environments and agents, on a scale not reproducible in simulation.

## Generative Model for Human Adversarial Examples

[Recent work](http://research.nvidia.com/publication/2017-10_Progressive-Growing-of) on generative adversarial networks (GANs) has shown that high resolution images of faces can be created using a large dataset of 30,000 images. This size and quality of images is not available for optical illusions; naively applying their methods would likely yield a model that is extremely overfit or generates nothing of value. Any attempt at pre-training on general images would also be fruitless, as optical illusions are usually non-photographic and exist outside the space of common visual stimulus. The number of static optical illusion images is likely in the low thousands, and the number of unique kinds of illusions is certainly very low, perhaps even less than one hundred. Creating a model capable of learning from such a small and limited dataset would represent a huge leap in generative models and understanding of human vision

## Human in the Loop

Both artistic designers of illusion images and the glacial process of evolution have access to active vision systems to verify their work against. An illusion artist can make an attempt at creating an illusion, observe its effect on their eyes, and add or remove elements to try to create a more powerful illusion. In an evolutionary process, every agent has a physical appearance and a vision system, allowing for patterns to be verified in their environment constantly. A GAN trained on existing illusions would have none of these advantages, and would be just as likely to create non-illusions as it is to create a novel class of images. 

To improve the model beyond the existing data, its outputs can be classified by hand and fed back into the network. I am not sure if this form of dataset expansion has been used with generative models before.

## Dataset

In coming blog posts, I will search out sources of illusion images and make further considerations for how to approach this problem.

