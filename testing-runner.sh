#!/bin/sh
#sbcl --non-interactive --load runner.lisp
sbcl --load runner.lisp
    #touch *
    #touch max-website-code/*
    #git -C ./ pull
