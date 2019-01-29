---
layout: post
title: Bananagrams AI!
---

I just finished the code for my banangrams playing AI! I've added it under the "fun" tab.
Type in all of the letters you have and it returns an html table with a board you can play.

Try it out here:
<br>
[https://www.maxwilliams.us/fun/banana-gram-solver](https://www.maxwilliams.us/fun/banana-gram-solver)


Bananagrams is played as a series of individual scrabble games, where you have a pile of letters
that you need to organize into a valid board, as in scrabble, as fast as you can.

It does a depth first search by looking at the letters it has to play and playable spots on the
board. It sorts these by a "word score", where it ranks possible plays by the length of word played,
use of hard to play letters, and what hard to play letters are left in the letters bank. Without
this mechanism, it takes incredibly long to finish using all of its letters.

One problem is that it may play a few long words to start, then try to fill in the rest with the
letters it has. Because the search space is to big, it never tries lifting up those few words. There
are a few ways to solve this. The best is using `A*` search, but that would be a lot of word.
Another would be a modified Monte Carlo, where it goes from the top all the way down to a random
leaf (a filled in board, either a solution or somewhere where no more words can be played) and
search aroud there, and give up after some time. I could also limit the number of iterations at each
DFS iteration... Actually that would be a one line change! I'll experiment with that. I also need a
way to limit search time so web use to prevent abuse or accidental non-terminating process creation.
