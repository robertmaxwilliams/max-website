
Hi! I'm Max Williams. I program computers, sometimes they even do things. I think the most
beneficial thing to do with my life is contribute to AI safety/AI alignment research. The most 
interesting (and most harmful) thing I could do is to research AI technology with no regard to
safety. It sure is fun, though, and everyone is paying for it. 

# Current Stuff

## Undergraduate at UofL

I'm studying Computer Engineering and Computer Science, with a Math minor.  While I tend to learn
more from my own projects rather than the curriculum, I also know I wouldn't be able to do it without the
scheduled and mandated learning environment filled with deadlines and skilled professors. 

## Current Projects

Since the [ES](https://arxiv.org/abs/1703.03864) paper came out, I've made a single core version
which solves cart pole, and learns degenerative behavior for the spider walking environment. It's
not a simple as the authors make it out to be, there are a lot of nuances in the rank ordering
scheme that they glance over in the paper. It also doesn't address exploration, adding an explicit
exploration scheme is needed for rare reward environments without good reward proxies. I am working
on a distributed version, after I found out the you can run 1000 instances for an hour for under
$10 on Google Cloud. That's crazy! It makes sense, though, since that's less than two months of
compute. So cheap! I can't wait to train state of the art reinforcement learners that usually take
days on a GPU.

## Lisp

I made this website using lisp, which was a lot of fun. The [fun](/fun) pages are all lisp functions
that do things, but the website architecture was the trickiest part. I'm not really sure what I did, 
but it sure is neat. 

I'm also working on some DSP stuff, [here](https://www.youtube.com/watch?v=CjsbYHC7b1g) is a sample
of my first attempt. Maybe I'll make more, with some percussion and more interesting virtual
instruments.

## Career Hunting

Like many people my age, I have grand ideas about what I want to do with my life but I have trouble
visualizing exactly what they would look like. I really enjoyed programming robots in high school, 
I also like doing math stuff for fun and exploring math things using programming. The corporate
software development world looks soulless and unproductive, like a big hamster wheel that consumes
man hours and keeps alive the collective conciousness of the business. Maybe I'm wrong, and making
software for Microsoft would actually be really enjoyable. 

My summer internship working on MAST-ML made me think that making software for researchers is a
valuable thing to do, many researchers write software for their own use and don't adhere to
coding standards or development paradigms; they get the job done but aren't left with something
useful for others. A lot of work is wasted doing the same tasks over and over again. Almost
all software I used in the bioinformatics world was hacky and under-documented.

At PNNL, I also got to write useful software in a self-directed way to solve some nebulous research
task. This was difficult in a good way, and is something I could see myself doing as a career. Also,
the work environment was very healthy, encouraging steady progress and goals, not the burnout cycle
of some (__cough__ Google __cough cough__ Microsoft) software dev shops. Overall, being a
non-academic researcher felt like a good fit for me, especially the practical focus of the work.

My dream is to do actual good for the AI safety community, but it's such a turbulent field and can
be hard to tell what skills will be useful. Will being a better programmer make me more useful, or
is general programming skill too general to be genuinely useful? Worse still, my experience with
lisp has made me think that "general programming skill" means "learning to work within a weak and
idiosyncratic model of thinking that's been practically unchanged for decades". Regardless of the
state of software engineering, I am committed to doing what I can to contribute to what I see as the
most slippery, impossible, and important issue humanity will ever face.

# Past Stuff

## PNNL Summer internship

Summer of 2019, I worked on few-shot image classification for Pacific Northwest National Lab. I
enjoyed the work, and I worked with people skilled in all aspects of deep learning. There were other
groups there that did statistical and principled computing, such as bayes inverse problem solving
and other scary stuff like that. It seems very practical, and solved problems in ways that seem
impossible with deep learning. Maybe the whole "throw your principles out the window and compute"
paradigm isn't always the best. Overall, I'm fluent in PyTorch now, which is so much better than
TensorFlow for writing research code. I can make whatever deep learning model I want from scratch.

## MAST-ML

Summer of 2018, [Luke Miles](https://lukemiles.org/) and I worked for Dr. Finkel at the University
of Kentucky, on the [MAST-ML](https://github.com/uw-cmg/MAST-ML) project with the University of
Wisconsin. We worked full time for 10 weeks and worked with the main developer, Ryan Jacobs, to
understand how the software did and didn't work, and made a rewrite which is now the main branch. We
learned many lessons about software development; it was the first time either of us has worked on a
project of that scale. Most of our time was spent considering how to approach a problem, and when to
break a model to allow for some functionality. For instance, we originally had a pattern of "no
magic keywords in csv column names" pattern, which we later broke to allow for the user to specify a
train/test column by name. It was tricky to integrate this change in data flow into our model of how
the program should work, but it was a necessary feature.

## Informatics Lab Internship

During my Sophomore year, I assisted the bioinformatics lab with some data tasks, neural network
programming in Keras, and typesetting their paper in Latex, word, and then Latex again. I made
several figures programmatically using Latex's tikz package, which was fun. I also got very good at
typesetting formulas.
The final version of the paper is
[here](https://ir.library.louisville.edu/cgi/viewcontent.cgi?article=4082&context=etd).

## Vex Robotics 

In high school I was on one of my high school robots teams, 5454J. We only had 4 people on our team
so all of us did a little bit of everything. We spent most of our time taking the robot apart and 
trying to fix things being weak and slow and wobbly. [Here](https://www.youtube.com/watch?v=QdJfA6GkgFk)
is a snippet of the arm robot we took to Worlds in 2015. We tended to go for the long shot and make 
unusual designs with the hope that we would get an edge that no one else had. This didn't really work
that well, but we had a lot of fun.

## Exchange Year in Thailand

I spent my senior year on a rotary exchange in Thailand. I stayed with three wonderful families for
a total of nine months, and went on a few rotary organized trips with the other exchange students.
[Here](http://thaipie.blogspot.com/) is my blog from the trips and other side adventures.  I can
also read/write/converse in Thai on a pretty good level, but since I've been away for so long I
would need to reacclimate to have a non-ridiculous accent and ease of speaking.

