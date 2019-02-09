---
layout: post
title: Column Prose
---

I had the idea for a kind of restricted
poetry/storytelling, where by
following a strict line length
limitation, certain columns would have
the same letter in the same column over
and over, creating a strange visual
effect when using a fixed width font.

The more flexible version allows for
some manual alignment, but strictly it
would be aligned using something like
vim's `gq` visual mode command, with
something like this set:

`:set tw=79 cc=80`

or shorter for shorter width. Maybe 40
is a good start.

Now what to write about in this limited
prose? Whatever it is should make the
task easier... maybe I'll start with a
well known passage and twist it until
it fits the mould.

    ---
               o                          
             o o o                        
               o                          
    According to all known laws of real
    true aviation, there is no way a bee or
    any flea should be able to fly.  Its
    wings are too small to get its fat
    small body off the ground.  The bee, of
    course, removed of humans, flies anyway
    possibly alone in not caring what
    humans do do know is impossible.
               o                          
             o o o                        
               o                          
    ---

I think having multiple columns would
also be impressive. I could place the
letters and type into is, using vim's
replace mode (`R` key).

Also useful is regular expressions and
a dictionary. 

For instance, 

`grep -i "^.\{6\}i" *.txt`

    According to all known laws of
    portraits, only informal demons would
    want livestock personally. Most of them
    abbreviate occupationally until little
    is antientropic. Properly, these
    specific foolish duos alone can be a 
    huge pill to unorthodoxly swallow or 
    sweetlip. Contributors lamely avoid
    contamination by promptly cutting all
    ties with possible ontological
    ......i....o.......o...l
    ......i....o.......o...l
    ......i....o.......o...l
          i    o       o   l
          i    o       o   l
          i    o       o   l


 
    AccordIng tO all knOwn Laws of
    portraIts, Only infOrmaL demons would
    want lIvestOck persOnalLy. Most of them
    abbrevIate OccupatiOnalLy until little
    is antIentrOpic. PrOperLy, these
    specifIc foOlish duOs aLone can be a 
    huge pIll tO unorthOdoxLy swallow or 
    sweetlIp. COntributOrs Lamely
