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

TODO: hit this one at least 2 more days.

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
         (binary-search el arr (1+ middle) end))))))



## Kata03: How Big? How Fast?

I'm going to copy in the questions and answer them as I go. Not today, though.


    roughly how many binary digits (bit) are required for the unsigned representation of:

    1,000
    1,000,000
    1,000,000,000
    1,000,000,000,000
    8,000,000,000,000

    My town has approximately 20,000 residences. How much space is required to store the names,
    addresses, and a phone number for all of these (if we store them as characters)?

    I’m storing 1,000,000 integers in a binary tree. Roughly how many nodes and levels can I expect
    the tree to have? Roughly how much space will it occupy on a 32-bit architecture?

## Kata04: Data Munging

This one comes in parts, each is completed before the rest are revealed. So, I've download the first
data file, and copied the prompt to do in tomorrow's session:

    Download this text file, then write a program to output the day number (column one) with the
    smallest temperature spread (the maximum temperature is the second column, the minimum the third
    column).
