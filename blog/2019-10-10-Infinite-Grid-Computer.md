---
layout: post
title: Infinite Grid Computer
---


Luke mentioned this idea of ininitely expandable computing, where a computer network is extended to
a size where speed of light becomes significant, and you have to design algorithms that run on N
nodes in T time. I want to make an emulator where you can write algorithms for extremely simple
nodes where utilizing many nodes becomes important. I also want it to run quickly even for millions
of nodes, so the nodes should "pack" well into a standard CPU. So very simple nodes and instruction
set and means of moving data between nodes and reuploading code. What would a single node look like,
and what does a transaction between them look like?

Let's say each node gets an array of 32 bytes and can do addition and subtraction and some basic
branching on those values. It can also do a C-style fork to an adjacent node, or transmit directly
into an adjacent node's memory. Imagine you want to collect all prime numbers up to some fixed
number. In a single node, this would take a long time, but with a single line of nodes, each one
would get a single number to check, or some other more efficient scheme.
