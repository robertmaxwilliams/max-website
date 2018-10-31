#!/bin/bash
touch *
touch max-website-code/*
while true
do
    git -C ./ pull
    sbcl --load runner.lisp
done
