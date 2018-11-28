

The code is [here](https://github.com/robertmaxwilliams/max-website), if you aren't light of heart.
I would be careful though, given the informal and fun nature of this project, the code comprehensibility
is poor at best and maddening at worst. And forget about meaningful naming. You would almost think I'm
using [this style guide](https://www.se.rit.edu/~tabeec/RIT_441/Resources_files/How%20To%20Write%20Unmaintainable%20Code.pdf).



This website it written in lisp, using the `hunchentoot cl-who parenscript` stack. Why do this when
I already know how to use python's flask and javascript and a few python templating and reverse
templating systems? Because this is more fun! Also, it is much nicer. When you make a website in
python, you have your routing and your templates and some glue here and there. If you want to make
a template for a template or functions that return template bits, it all gets confusing and hacky.
In lisp, everything is already confusing and hacky! So you can go about and mix several mini
languages without ever losing the main language.

Lisp also allows you to turn your architecture ideas into programming constructs. This website uses
a "define-url-fn" macro that I adapted from a similar one, which allows for functions defined
in that way to be registered on the `/fun/` page and provides a url based on the name of the
function. And it's all done at compile time, so there's no performance difference than if you did it
painstakingly by hand. By using this macro to define these functions, there's no way you could
ever forget to register a function with the routing parts.
