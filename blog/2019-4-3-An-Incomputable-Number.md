---
layout: post
title: An Incomputable Number
---

I heard that the [computable numbers are countable](https://youtu.be/5TkIe60y2GI?t=287), which seems
to lead to a paradox using 
[diagonalization](https://en.wikipedia.org/wiki/Cantor%27s_diagonal_argument). Imagine the list of
all computable numbers, between 0 and 1. That is, a decimal followed by an infinite stream of
digits. Now performs Cantor's diagonalization on this list. You must get a number not on the list,
and yet it seems that we just described a computer program to compute this number. There are 4
possibilities: 

#### Update:

> It seems that the list of all computable numbers (which I try to approach using the set D, below)
> is incomputable. I would like to prove this, maybe another time. For now, **don't bother reading
> this blog post.**, it's garbage.

Also, read this:

[THE LIMITS OF REASON](https://web.archive.org/web/20170830004923/https://www.cs.auckland.ac.nz/~chaitin/sciamer3.html)



1. That number is somehow hiding in the list (this one is actually false, guarenteed by the
   diagonalization process.
2. The list of computable programs is uncountable. The list of all finite programs is countable, so
   this seems impossible.
3. This new number is incomputable. There may be some part of our process of constructing the number
   that involves solving the halting problem, thus making the new number incomputable.
4. I forgot what #4 was, but it was good.

To address possibility #3, I'm going to explain a detailed procedure for listing out all computable
numbers for diagonalization.

Start with the list of all programs in a computer language that I'll call Plython. Plython is turing
complete and has one I/O instrutions: print, which takes a digit 0-9 and outputs it to a stream.
These number are interpreted as the digits after the decimal point,
so it is possible to make a Plython program that prints the decimal part of any computable number.
Plython runs on a machine that allows a program in memory to be stepped. At a single step, the
program will either run an I/O instruction and print out a digit, or run a normal instruction for
performing computation. On our computer, we enumerate all Plython programs: P1, P2, P3, and so on.
We don't actually have an infinite computer at this point - imagine using lazy evaluation to only
generate and run these programs as they're needed. 
[Lazy evaulation](https://wiki.python.org/moin/Generators)
is very important to making to keeping the inifities away, so make sure you're comfortable with it.
Take the first program on the list, and run it for one tick. Then, run P1 for another tick and P2
for 1 tick. At 10 top-level ticks, the number of ticks for each program would be:

- P1: 4
- P2: 3
- P3: 2
- P4: 1
- P5: 0


As the number of top-level ticks approaches infinity, the number of ticks spent on any particular
program also approaches infinity.

The halting problem provides a big hiccup at this point. It is impossible to tell, without running
the program, whether the program will create an infinite I/O stream or get stuck in a non-printing
loop at some point. A program that halts by not compiling or ending early can be taken to be
printing zeros forever. It is impossible to filter out the "well behaved" infinite digit
programs from the "bad" programs that eventually get stuck in a loop, as per the halting problem.

Here are some sample well-behaved programs:

#### Program for 1/3

    while True:
        print(3)

#### Programs for 1/2

    print(5)
    while True:
        print(0)

#### Program for [Champernowne constant](https://en.wikipedia.org/wiki/Champernowne_constant)

    Integer x = 1
    while True:
        for i in digits(x):
            print(i)
        x += 1


The issue is that many programs don't represent a computable number. For example:

    Digit x = 5
    print(x)
    while True:
        x += 1

gets stuck in an infinite loop, and doesn't represent any particular number. Although it may be
temping to make a loop snooper to scoop the bad loops, the halting problem makes sure you cannot do
such a thing in general. So, we cannot simply exclude these "bad" programs. One way to get a
diagonalizable list is the following proceedure: 

Take the list of all programs, P, and run in a staircase-concurrent fashion as shown above. The first
program to output a digit, Pn is recorded as the first element in a new list, D. So D1 has a program
the prints **at least** one digit. This process is continued for the first program to print 2 digits
(programs already added to D are not considered) and 3 digits and so on. Now D contains a listing of
a subset of P. D conatins many "bad" programs, which happened to print a few digits but were never
checked long enough to notice that they don't produce additional digits. Will all well-behaved
programs in P end up in D? I think so, email me a proof if you think of one. Actually, I think
that's false. A proof for that would also be nice.

So now we have D, which is fit for diagonizable, but has many programs where the take-next-digit
process would never halt. So D has at least one program for every computable number, and lots of
programs that end up stuck in loops. If we diagonalize D, we get a new number not in D. 

So, my conclusion is that the set of all computable numbers is incomputable, just like the set of
all programs that halt. QED?


