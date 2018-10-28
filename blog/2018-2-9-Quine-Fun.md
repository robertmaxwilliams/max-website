---
layout: post
title: Fun With (Fun With Quines in Python) Quines In Python
---

I've seen quines before, as well as quines that aren't really quines, like this dumb bash trick:
```bash
echo $BASH_COMMAND
```

However, I couldn't really get my head around how to write one. I decided to give it a shot using python and see what I could do. I struggled for a bit and went down several tunnels of infinite regression of quotes and escape characters.

I gave in and searched for "python quines" and peeked at the first page for a hint. I noticed that all of the quines used an interediate variable, so I went back to work with that one piece of information. A few more attempts at inifinitely nested quotations later, I came up with this monster:
```python
q = "\""
n = "\n"
s = "\\"

m1 = 'q = '+q+s+q+q+n+'n = '+q+s+'n'+q+n+'s = '+q+s+s+q
m2 = "'q = '+q+s+q+q+n+'n = '+q+s+'n'+q+n+'s = '+q+s+s+q"
foo = "foo = ... print(m1 + n + n + 'm1 = ' + m2 + n + 'm2 = ' + q + m2 + q + n + foo[:6] + q + foo + q + n + foo[10:])"
print(m1 + n + n + 'm1 = ' + m2 + n + 'm2 = ' + q + m2 + q + n + foo[:6] + q + foo + q + n + foo[10:])
```
_Credit to [Luke Miles](https://github.com/qpwo) for help spotting that 10 which was an 11 and for motivation._


Which I quickly brought down to two lines when I realized what chr() does in python:
```python
foo = "foo = ... print(foo[:6] + chr(34) + foo + chr(34) + chr(10) + foo[10:])"
print(foo[:6] + chr(34) + foo + chr(34) + chr(10) + foo[10:])
```


And the need to run it easily from plaintext motivated a pseudo-oneliner that only uses single quotes:
```python
foo = 'foo = ... print(foo[:6] + chr(39) + foo + chr(39) + chr(59) + foo[10:])';print(foo[:6] + chr(39) + foo + chr(39) + chr(59) + foo[10:])
```


Which leads finally to the single line that can be run straight from the command line as my times as you want:
```python
python -c "foo = 'python -c foo = ... print(foo[:10] + chr(34) + foo[10:16] + chr(39) + foo + chr(39) + chr(59) + foo[20:] + chr(34))';print(foo[:10] + chr(34) + foo[10:16] + chr(39) + foo + chr(39) + chr(59) + foo[20:] + chr(34))"
```

So what is going on and why are these possible? Are they possible in every programming language that is turing complete and has text output? The answer is yes, and I have not idea why. According the wikipedia it has something to do with a Mr. Kleene and his Recursion Theorom, where a quine would be considered a fixed point of the function that is the interpreter. I'll get back with you when I understand how it can be proved that fixed points always exist. 

Until then, here is a quine that also includes my favorite python error message:

```python
from sys import setrecursionlimit, stdout

def foo(x):
    setrecursionlimit(x)
    foo(x+1000)

bar = """from sys import setrecursionlimit, stdout

def foo(x):
    setrecursionlimit(x)
    foo(x+1000)

bar = ...
print(bar[:97]+chr(34)*3+bar+chr(34)*3+chr(10)*2+bar[101:]+chr(10)+chr(35), end=str())
stdout.flush()
foo(42)"""

print(bar[:97]+chr(34)*3+bar+chr(34)*3+chr(10)*2+bar[101:]+chr(10)+chr(35), end=str())
stdout.flush()
foo(42)
#Segmentation fault (core dumped)
```

The program appears on screen easily, but reading the output into a file is more difficult. Using bash redirects and some other [wizard](https://stackoverflow.com/questions/23954607/redirection-of-a-out-is-not-capturing-segmentation-fault) [stuff](https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file) I made this command to save the output to a file:

```bash
\{ python3 quinefault.py > quinefault2.py; \} 2>> quinefault2.py
```

## I Don't Understand Fixed Points

Do hash algorithms have fixed points? Encryption? What about f(x) = x+1, it seems like many computable functions don't have an x where f(x) = x. Maybe I am misunderstanding what is meant by computable function. 

## Taking the Whole Thing Too Far

Using a compiler/interpreter/etc as a function and finding a fixed point in it is neat and all, but what about neural networks? Can a neural net output its own weights? Most neural nets used today are capable of approximating universal computation, so shouldn't they be able to take in a zero vector and output the values of their weights? Using a plain feedforward network would be impossible because the output layer would make the net too large and the whole thing can't fit inside itself. A recurrent network or some sort of external attention mechanism would be needed. I think such a system would count as a quine. Even though it is supported by a great deal of external equipment, that shouldn't disqualify it. A python quine doesn't need to output python's source, and a neural quine doesn't need to output its own textual source code. Not saying that it couldn't... 

