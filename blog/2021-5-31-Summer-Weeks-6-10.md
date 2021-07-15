---
layout: post
title: Summer Weeks 6 - 10
---

# Week 6

I just moved to Bloomington to work on [secret project] with Luke and Charlie. I only got my computer
set up today (Thursday) but now I should have daily work day blogs. We're working more than 4 hours
per day, but we also have socializing etc in there so it's about the same true work load as my 4
hour days. I don't think we'll be doing a weekend Wednesday either since project only goes on for a
month and we'll get more coherence this way.

## Thursday

We finally got a voice call to work over WebRTC! It turns out you have to run it on two different
computers otherwise it never works - but now that's solved and we're a step closer to having a
working app.

Now Luke is getting the app on a new Linode and Charlie and I are both working on the two player
visual interactive board things.

Oh, I also crammed the last 5 weeks into one blog post, since they were pretty scattered and
inconsistent due to me doing lots of non-computer stuff most of the time.

## Friday

We did it! We have a minimum working product, and next week will be a lot more fun because we'll be
doing graphics stuff. Check it out at <splashcall.com>!

# Week 7

(no blogging this week)

# Week 8

(no blogging this week)

# Week 9

We have the app working great, with the UI looking really good thanks to Charlie's design
improvements. Adding new "textures" (aka interactive games) to the app is the most fun part of
development, but the app has serious reliability issues that still need addressing.

## Monday

Added color sync to flatwaves, and made the bouncy balls colors always the same pattern. I tried to
make is depend on room code, but getting the correct room code ended up being really buggy. React is
hard! I question the wisdom of using frameworks at all, but the advantages of React are enourmous
and the downsides are mostly due to my inexperience with it.

The second half of the day was spent on fixing a bug with the server where two identical websocket
bindings would get attached to a socket during a specific reload order. I fixed it, but I also
realized the need for websocket health monitoring - this is what the hands were supposed to do, but
they are often incorrect or confusing. Charlie doesn't like it when I add ugly UI elements, but
right now the technical issues are the only thing that matters and our on-screen indicators are the
only way to get technical feedback in the field.

Actually, that gives me an idea. We could have a "report issue" button that sends us the console
log, along with other information. If getting the console isn't possible, we could make centralized
logging functions that also save to a string that can be saved as an issues log, this could also
give us information like toasts.

## Tuesday

`k

