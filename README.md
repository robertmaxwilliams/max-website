You run it something like this:

```
#!/bin/sh
touch max-website/*
touch max-website/max-website-code/*
sbcl --load "/home/public/max-website/runner.lisp"
```


The `touch` commands are mandated by quicklisp to notice code changes, for instance if a macro in the main file changes,
the change will not affect a dependent file unless the dependent file is changed. Maybe it's because I have unrecognized circular dependencies
between files.... ..... ...

1. install `sbcl` with your packages manager
1. got to  <https://www.quicklisp.org/beta/> and install quicklisp
1. should work? I think `runner.lisp` takes care of system directory stuff. Haven't tested in a vm yet.


TODO 
+ make a build script and test in a VM
+ add some neat things to start
+ finish writing bio
