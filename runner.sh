#!/bin/sh
while true
do
    touch *
    touch max-website-code/*
    git -C ./ pull
    sbcl --load runner.lisp
done
