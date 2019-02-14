---
layout: post
title: Code Katas?
---

Today Luke sent me a link to a page with some "code Katas", which are like Euler problems except
focused on software design and extensibility. I figured I might as well try out the first few, even
if I get bored and forget about it before I make any progress.

[http://codekata.com/](http://codekata.com/)


## Kata01: Supermarket Pricing

This is like an introduction Kata, with no programming. It has you consider supermarket pricing
schemes such as:

+ three for a dollar (so what’s the price if I buy 4, or 5?)
+ $1.99/pound (so what does 4 ounces cost?)
+ buy two, get one free (so does the third item have a price?)

and answer questions such as:

+ does fractional money exist?
+ when (if ever) does rounding take place?
+ how do you keep an audit trail of pricing decisions (and do you need to)?
+ are costs and prices the same class of thing?
+ if a shelf of 100 cans is priced using “buy two, get one free”, how do you value the stock?

and come up with a pricing system that has desirable properties, such as ease of valuing stock, ease
of checking out, or even nefarious things like confusing customers into paying more or feeling like
they're getting a better deal.


For the first question, I would say no, no fractional money. Nothing below $0.01, or in other words,
the amount you pay, times 100, should always be an integer. However, It might be adventagous to use
smaller amounts in calculations and prices. Maybe something costs $0.032 per ounce. Because the
price is so small, one tenth of a penny is 3% or so of the cost, and controlling the price to be
fair/profitable would be very difficult if a penny was the smallest level of granularity presented.

However, if all the databases and cashier software used floating points (possible evil due to base
conversion issue) or 6 place decimal representation (much smarter but the programming task is harder
since you have to use a specialized number type) then savvy customers might notice the two-place
rounded math on the receipt doesn't add up - if the true prices are ±0.01, and they get added up,
the computed sum and the sum they would get would be different values and they might complain that
your machines are rigged, and it would look bad on you. 

You could circumvent this by using high-precision internally then rounding each product
independently, then adding them up in two-places precision. No fractional pennies come into any
calculation the customer sees, except for price-per-ounce or price-per-square-foot of bulk items,
which the custom should expect to be three or four places accurate and rounding after multiplying by
quantity is a pretty good strategy. The Kata-Master suggests only going for this one bit by bit,
sleeping on it a few times, so I'll leave this one to rest for now.


#### Second Time Around

I'll focus more on this question:

+ how do you keep an audit trail of pricing decisions (and do you need to)?

I think it'd be nice if every price change of every item was stored in a huge database, as well as
how much was bought. You could do some crazy analytics on that data, like seeing how raising and
lowering prices changes purchases. If you had a unique identifier for each item, it shouldn't be too
hard having a list of every price change, and if you wanted to change the price, just push a new
pricing scheme to the top of the list. I guess I'm imagining a huge table with barcodes or product
ids as keys, and a list of (pricing scheme, data added) pairs as values. You would also need a table
of how the products are sold (by count, by pount) to check that the schemes match up with the kind
of thing.

Another issue that comes up is arbitrage. Not exactly arbitrage, since customers aren't selling to
you. But if you sell small-bunch-celery for 2$ and big-bunch-celery for 4$, you should be sure they
have about the same value per pound, or that the larger quantity provides a slightly better deal.
I've seen at Kroger when 2 half gallons of milk is less than one whole gallon. It must have been
something about their supply of each, or the expiration dates present in their supply. Expiration
and limited inventory complicate pricing greatly. 

If I have too much of something, I can benefit from selling it at a loss. Pricing decisions like
that need to be handled carefully, ideally returning to normal once the old products are
sold/discarded and new products arrive. 

TODONE: hit this one at least 1 more days.

#### Third time around

I'll address one more question and try to wrap up my thoughts on this.

+ if a shelf of 100 cans is priced using “buy two, get one free”, how do you value the stock?

Looking to Kroger again, they often don't actually require you buy the right amount to get the deal.
They have the "base price" and then the "member price" in yellow, which might be something like "buy
one get one free" but really they're just halving the original price. Also, on a side note, their
membership doesn't cost anything, so it's more of just a control thing, or to have an excuse for a 2
level pricing scheme. The disadvantage with the "illusory buy and save" manuever is the customers
won't feel pressured to buy more than they need (aka the whole point of America) if they realized
what was going on. I think even people who know this are still subconciously influenced by the
apparent good deal, that whether or not you actually have to buy two is irrelevant. I think this is
a good solution, keeps the math easy while still subtley manipulating your customers.

The other option is to have or guess at statistics on how often people buy an even amount, and
calcuate an expected value, maybe even something with a normal distribution... but the programmers
won't like having to deal with expected value of a product having a standard deviation... or maybe
they will, you never know. Your expected profits could be some probability function or something.
Programmers love that.


## Kata02: Karate Chop

Spec, from the page:

"Write a binary chop method that takes an integer search target and a sorted array of integers. It
should return the integer index of the target in the array, or -1 if the target is not in the
array."

And you should find 5 different implementations on five different days.

I'm going to assume not repeates in the list for today, maybe I'll try alternate schemes on other
days.

(In common lisp, btw)

    (defun binary-search (el arr &optional (start 0) (end (length arr)))
      "recursive binary search on sorted (ascending) array for el"
      ;; off-by-one-notes:
      ;;   the end is never used as an index, but one below it should.
      ;;   the start index should be used as an index (last, if it is)
      (if (= start end)
          -1
          (let* ((middle (floor (+ start end) 2))
             (middle-val (aref arr middle)))
          (cond
        ((= el middle-val) ;;found it!
         middle)
        ((< el middle-val) ;; go to bottom half
         (binary-search el arr start middle))
        ((> el middle-val)
         (binary-search el arr (1+ middle) end)))))) ;; this 1+ gave me some trouble


The errors I came across in this one was mixing up the less-than and greater-than case, and
off-by-one error on the case where I take the second half of the array. I would either chop off the
element you want, or recur endlesly due to not chopping off enough.

I also had to move the accessing-the-middle-element bit to after I checked if the list was
non-empty. Index 0 of an empty array is an error... I could calculate middle differently... or do
some hack inside of cond... or make a lazy accessor lambda... or a macrolet... so many options!

#### Try 2

I'm going to use "displaced arrays" this time... if I can figure them out. It should let me recur in
a more functional way, but without duplicating the actual array.

So I decided to use `ignore-errors` when accessing the middle element before checking if it's in the
array. It's just simpler that way, even if it's ugly.

So displaced arrays just know where the true array is, how long to be, and what index of the true
array to treat as "0". I assume it'll do bounds checking at creation time to make sure you don't
make one too long.

The displaced arrays create the problem of doing to arithmetic on the way back up the stack, since
low down function calls have no idea what the true index of the array is.

Also, finding the length of the top and bottom half is a bit tricky, I could use a case on odd/even
but using floor/ceil/1+/1- works well enough. It's bad for explainability, because I arrive at the
equations for the length by tabulating on paper. Things like that tend to create nice terse
algebraic expresions, ideal for using tacitely, like in `J`, the ultimate language.

I just finished writing the code (about 20 minutes of writing, and some googling for offset arrays
and dealing with errors). I didn't write it in smaller units, so I need to run it all at once for
the first time now -  that always goes well.

First wack: compile error, need to use `let*`, didn't realize I was using stuff from let forms in
the others

Now I misspelled middle as midde... and next forgot to close a cond form. 
Okay, Now iit compiled.

Uh oh... so when I add all the offsets to the answer as it comes up the stack, sometimes it returns
-1 for not found, and that gets added... I need a way of returning an error symbol, that doesn't
mind having stuff added to it.... hmm...

Gersh dargnit. I had my `>` and `<` backwards again! How does this keep happening to me?

All the tests pass... good riddance!

    (defun binary-search-2 (el arr)
      "similar to before, but using displaced arrays"
      (let* ((len (length arr))
         (middle (floor (length arr) 2))
         (middle-el (ignore-errors (aref arr middle))))
        (cond
          ((= 0 (length arr)) ;; array is empty
           -1)
          ((= el middle-el) ;; found it!
           middle)
           ((< el middle-el) ;; if el > middle, we need to take bottom half
        (binary-search-2
         el
         (make-array
          (floor len 2) ;; length of bottom half
          :displaced-to arr
          :displaced-index-offset 0)))
          ((> el middle-el) ;; if el > middle, we need to take top half
           ;; displace output index same as array, since it starts higher
           ;; up now. Also, have to check if negative
           (add-if-positive
        (1+ middle)
        (binary-search-2
         el
         (make-array
          (floor (1- len) 2) ;; length of top
          :displaced-to arr
          :displaced-index-offset (1+ middle))))))))


#### Try 3

I'm not really sure what to do now... I guess I could use a loop instead of recursion. By tomorrow
I'll be using gotos and symbol-macro-only computation.

I'm using a distinctly algol-like programming method. I thought for a second "this is a really
convenient way to implement these algorithms then I realized two things:

+ Algol style programming is good to the kinds of algorithms you find in freshman Computer Science
  classes, and become less attractive after that.
+ The fact that common lisp easily supports this style of programming is another reason to see it as
  superior

One thing I can't quite figure out is how to do chained if-else statements. I think for that, `cond`
is much more clear.

It took me forever to realize I had forgotten to add this line inside iter:

`(setf middle (floor (+ start end) 2))`

Hmmm so the testing loop shows it's only finding every third element... weird.

So I had the exit condition (the thing that compares start and end and returns -1) and now the only
thing it's missing is finding the last element. 

Okay so I changed it to -1 and it works now... oh except not that condition never trips.

Hmm... writing algol style in Lisp creates a lot of visual noise... Python is better.

So it seems like I just can't catch that last element. I'll try adding a special case for it.

OKAY All tests pass for real this time. This sucks.



    ;; using iter this time
    ;; and Cee style programming, with returns and such
    (defun binary-search-3 (el arr)
      (block main
        (if (zerop (length arr))
        (return-from main -1))
        (let* ((start 0)
           (len (length arr))
           (end (1- len))
           (middle (floor len 2))
           (middle-el nil))
          (iter (repeat 100)
            (setf middle (floor (+ start end) 2)) ;; forgot this for 10 minutes!
            (setf middle-el (aref arr middle))
            (cond ;; returning forms can be placed outside cond if desired
              ((= el middle-el) (return-from main middle))
              ((> el middle-el) ;; check top half
               (setf start (1+ middle)))
              ((< el middle-el) ;; check bottom hal
               (setf end middle))
              (t (print "that shouldnt happen")))
            ;; special case for last element
            (if (<= (- end start) 1) (return-from main
                           (cond ((= el (aref arr start))
                              start)
                             ((= el (aref arr end))
                              end)
                             (t -1))))
            ;; terminating condition
            (if (<= (- end start) 0) (return-from main -1))
            (finally (return-from main 'bad))))))


I really couldn't figure out what the bug was. I started off thinking looping would be much simpler
but I had trouble with off by one errors that I couldn't debug. It should be the same as
recursion... I guess I'm just not very good at this.

## Kata03: How Big? How Fast?

From the past: I'm going to copy in the questions and answer them as I go. Not today, though.

So today is the day! I'll try to do these as fast as I can, and as roughly as possible with no
complex calculations or internet.


    roughly how many binary digits (bit) are required for the unsigned representation of:

    1. 1,000 (10^3)
    2. 1,000,000 (10^6)
    3. 1,000,000,000 (10^9)
    4. 1,000,000,000,000 (10^12)
    5. 8,000,000,000,000

Umm so I know there's something with log, but I also know that these are powers of two:
+ 1
+ 2
+ 4
+ 8
+ 16
+ 32
+ 64
+ 128
+ 256
+ 512
+ 1024

Notice that they grow linearly, as is the nature of doubling numbers written in a base notation.
Using counting, it turns out that 2^10 is about 10^3, so we can use 10 powers of 2 for every power
of 10. 

Also have an extra bit, just in case.

So #1 is 11 bits, #2 is 21 bits, #3 is 31 bits, #4 is 41 bits, and number 5 is three more powers of
two, to let's say 44.

    My town has approximately 20,000 residences. How much space is required to store the names,
    addresses, and a phone number for all of these (if we store them as characters)?

So those first and last names should be on average like 10 characters apiece, address should be like
50 chars or so, and 10 chars for phone number, right? So 10+10+50+10 = 80 bytes.l

    I’m storing 1,000,000 integers in a binary tree. Roughly how many nodes and levels can I expect
    the tree to have? Roughly how much space will it occupy on a 32-bit architecture?

So using 32 bit integers... so like a heap, where each node is (value, left-pointer, right-pointer)
or like a tree where all the leaves are integers? It sounds like the latter. So 2^20 is about that
many, so we need like 20 or 21 layers. So like 2^20 bytes for pointers. Oh, the tree part should be
the same size as the data part, if it's fairly balanced, so let's say the final answer is 2,000,000
32 bit data cells (either pointers or ints).


## Kata04: Data Munging

This one comes in parts, each is completed before the rest are revealed. So, I've download the first
data file, and copied the prompt to do in tomorrow's session:

    Download this text file, then write a program to output the day number (column one) with the
    smallest temperature spread (the maximum temperature is the second column, the minimum the third
    column).
