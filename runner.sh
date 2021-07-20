#!/bin/sh
while true
do
    git -C ./ pull
    sbcl --load runner.lisp
done
