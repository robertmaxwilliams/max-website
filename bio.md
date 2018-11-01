
# Current Stuff

## Undergraduate at UofL

I'm studying Computer Engineering and Computer Science, with a Math minor.  While I tend to learn
more in my own projects than in curriculum, I also know I wouldn't be able to do it without the
scheduled and mandated learning environment filled with skilled professors and deadlines.

## Research Project 

I'm currently working on the topic of "Adversarial Examples Transfer from Recurrent Neural Networks
to Finite State Automata". Recurrent Neural Networks (RNNs) can be made to misclassify a sequence
with very small input perturbations, analogous to 
[adversarial examples for image classification](https://blog.openai.com/adversarial-example-research/).
Some adversarial examples also 
[transfer to humans](https://arxiv.org/abs/1802.08195). From this, I make the hypothesis that given
some real-world or simulated system of any kind that performs a task, a neural network proxy can be
made to approximate it and that, correctly crafted, inputs that cause a failure of the proxy should
have a similar effect on the real system. Exactly what kind of systems this is possible for and how
to go about making proxies that give useful adversarial examples is the challenge here.

I'm working on an RNN that emulates a spring-mass system, and seeing if the standard way of creating
adversarial input will discover how to make a sine wave at resonance to maximize displacement. This
is starting to sound like a poor substitute for reinforcement learning, I'll have to consider where
that lies.

## Lisp

This website it written in lisp, using the `hunchentoot cl-who parenscript` stack. Why do this when
I already know how to use python's flask and javascript and a few python templating and reverse
templating systems? Because this is more fun! Also, it is much nicer. When you makes a website in
python, you have your routing and your templates and some glue here and there. If you want to makes
a template for a template or functions that return template bits, it all gets confusing and hacky.
In lisp, everything is already confusing and hacky! So you can go about and mix several mini
languages without ever loosing the main language.

Lisp also allows you to turn your architecture ideas into programming constructs. This website uses
a "define-url-fn" macro that I adapted from a similar one, which allows for functions defined
in that way to be registered on the `/fun/` page and provides a url based on the name of the
function. And it's all done at compile time, so there's no performance difference than if you did it
all painstakingly by hand. By using this macro to define these functions, there's no way you could
ever forget to register a function with the routing parts.

# Past Stuff

## MAST-ML

Summer of 2019, [Luke Miles](https://lukemiles.org/) and I worked for Dr. Finkel at the University
of Kentucky, on the [MAST-ML](https://github.com/uw-cmg/MAST-ML) project with the University of
Wisconsin. We worked full time for 10 weeks and worked with the main developer, Ryan Jacobs, to
understand how the software did and didn't work, and made a rewrite which is now the main branch. We
learned many lesson about software development; it was the first time either of us has worked on a
project of that scale. Most of our time was spend considering how to approach a problem, and when to
break a model to allow for some functionality. For instance, we wanted to:

