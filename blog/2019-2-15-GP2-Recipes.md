---
layout: post
title: Computer Generated Dessert
---

A cake recipe based on analysis of [GP-2](https://blog.openai.com/better-language-models/)'s output!  

The AI is truly amazing, but its creators refuse to share it.  They tempt us with text samples. One
of these text samples is completions of a recipe, but not the whole thing. I seek to recreate the
true recipe, and prepare it every anniversary of the creation of the first wave of robot overlords.

It was prompted with the following passage:

    Aaron loves mint chocolate cake, but he requires that it be paired with mini chocolate chips, so
    I threw some of those in between the layers. I also had a few Peppermint Jo Jos on hand so I
    crushed them up and threw some of those in along with some crushed meringue cookies because, why
    not? It’s a total smorgasbord of minty chocolate chippy cookie crunchy goodness. I didn’t
    measure how much of each topping I used, but after I tasted the finished product, I wish I had
    added more. You can add anything you want- crushed candy canes, peppermint bark, etc. And don’t
    be afraid to use a heavy hand. Texture = good.  If you don’t have 7-inch cake pans, you can get
    3 shorter 8-inch layers out of this

Then it tried to complete the text. I'm going to assume it has some once of truth hidden between
these 6 partial recipes, and try to reconstruct it.

Basic facts about the original recipe, from the prompt:

+ It's a variety of mint chocolate cake, with mini choco chips and "Peppermint Jo Jos" added between
the layers, as well as "whatever you want"
+ Uses 7 inch cake pans, in 3 layers. 8 inches also works, but it's "shorter" (aka thinner).

Below are the huge model's generated completions, my personal sentence completions in __italics__.

### GPT-2 Completion 1

`If you don’t have 7-inch cake pans, you can get 3 shorter 8-inch layers out of this` recipe. I made
the longer version, then used the pan for a layer of buttercream frosting and stuck 1/3 of it into
the fridge for a frosting topper. Just make sure you have all of this frosting prepared earlier than
you make this cake and you won’t have to wait on it as your egg whites sit on the bottom of your
mixing bowl.

You want the egg whites whipped to stiff peaks? Then put your cake dish over a pot of simmering
water and heat it up until it’s just barely warm. It doesn't take more than 3-5 minutes; just enough
to get it started

#### Analysis

It sees that 8 inch cake pans make "shorter" cakes, and elects to make "longer" (what most of us
would call taller) cakes. The author's odd word choice made it use a complimentary word that really
wasn't appropriate here.

It describes a step of using "the" pan (but there are 3?) for a layer of **buttercream frosting**,
one third of which is set aside for "frosting topper".

It also starts to describe a trick for whipping egg whites to stiff peaks, something about
preheating the pan in hot water. I'll have to see if that's true.


### GPT-2 Completion 2

`If you don’t have 7-inch cake pans, you can get 3 shorter 8-inch layers out of this` recipe. If you
do, and you know how to make that cake, then your life will never be the same.

I have two very simple rules when it comes to cookie crumbs or chocolate chips. 1) When I buy raw
sugar, I do not use it until it’s cooled down and has at least half a teaspoon of sugar on it.
That’s my rule. And 2) If I have a recipe that calls for something and I want to use it in a recipe,
I do not substitute it with something else on-line. Like this.

I found this really cute card with cute little kittens on

#### Analysis

Here, "if you do" refers to having 7" cake pans, instead of 8". I think their claim is overstated,
but I'll stick with 7" for life changing cake.

The next bit... seems a bit cryptic. It claims to have 2 rules for cookie crumbs and chocolate chips
(the 2 additives that the prompt claimed to add) but gives two unrelated rules and a confusing
transition.

Ignoring the lack of continuity, it claims that when buying raw sugar it has to be cooled down. I
don't know where it's buying its sugar but that never happens to me. And I can't imagine why you
would put a teaspoon of sugar on top of it. Maybe something to do with inundating it with the old
batch, like some people do with fry oil or like how dough starters are transferred. 

The second point seems to be a general rule, don't use substitutions from the internet. That's
alright I guess. I'll keep that rule in mind when making this recipe.

When it says "like this", I really don't know what "this" is... nope no idea. And then the cute
kittens? Does that go in the cake?

### GPT-2 Completion 3

`If you don’t have 7-inch cake pans, you can get 3 shorter 8-inch layers out of this` recipe, which
will likely yield about the same amount of cake.

Chocolate Buttermilk Cake Print Chunks of chocolate cake, coated in buttermilk and topped with
crunchy chopped chocolate, drizzled with chocolate sauce.  Simple but a nice change from chocolate
cake! Author: Momma Made Ingredients For the chocolate buttermilk cake 1 1/2 cup unsalted butter ,
room temperature

+ 1 1/2 cup granulated sugar
+ 3 large eggs plus 1 egg yolk For
+ the chocolate glaze 1/3 cup cocoa powder
+ 1 3/4 cups powdered sugar
+ 6 ounces semis**weet chocolate chips**

#### Analysis 

It calls the recipe "Chocolate Buttermilk Cake Print Chunks of chocolate cake", but switches out of
"title mode" with capital first letters, and then goes into describing coating it in buttermilk (not
a bad idea, but that would run) and topping with chopped chocolate and drizzling chocolate on it 
(nothing wrong with that).

It's a variety of chocolate cake, so "but a nice change from chocolate cake" makes sense.

It switches from from the author's name into the first ingredient. I'm going to assume it meant to
put a newline before "For". This might actually be an artifact of badly formatted text in the
training data, where the html for the authors name didn't get a line break after it. Given that, the
author's name is "Momma Made Ingredients", a great bit of info!

The ingredients also have some formatting errors, fixed up in the ingredients list at the bottom.

I can't tell where the words "for the chocolate glaze" were supposed to go. I'm going to guess at
the top, and this is just the part of the recipe for the chocolate glaze.

### GPT-2 Completion 4

`If you don’t have 7-inch cake pans, you can get 3 shorter 8-inch layers out of this` recipe.

Meringue Cookies
<br>

+ 1 3/4 cup butter, softened
+ 1 cup sugar
+ 1 egg yolk
+ 3 T. heavy cream
+ 3 1/2-4 cups flour
+ pinch of salt
+ Peppermint-Jojo Topping
+ 1 1/4 cups powdered sugar
+ 1 cup chopped pecans
+ 1/2 cup finely chopped mint leaves
+ 1/2 cup chopped fresh mint (about
+ 1/2 sheet)
+ 1 tsp. peppermint extract
+ 1/4 tsp. sea salt
+ pinch of sea **salt.**


#### Analysis

This is tricky with no steps, but I think this will be the main ingredient list. There's no
guarantee it's complete, but it's a start. I'll just have to figure out what each ingredient is used
for.
 
### GPT-2 Completion 5

`If you don’t have 7-inch cake pans, you can get 3 shorter 8-inch layers out of this` recipe.

My 2 failures at Christmas morning were not due to poor frosting skills.  That was another success
story.  The cake was beautifully moist, and well, just a beautiful cake. It’s got very little air in
it or moisture, but all the chocolate and mint was perfectly blended together.

One thing that made me cringe a bit was that all those ingredients- egg yolks, sugar, melted butter,
chocolate chips, melted chocolate, and mint- had to be mixed right into the cake batter, which is
super time-consuming. A friend suggested that if I put the batter in a separate bowl, I**...**

#### Analysis

I'm not sure what kind of failures happened... but the author claims to have great frosting skills.
Also note that the cake should have minimal air and moisture, and blending the chocolate and mint
together is critical. Still not sure what those two failures were.

The second bit describes a step of mixing some specific ingredients right into the cake batter. So
one step is to make cake batter and mix these things in. I'll add this to the ingredients list.


### GPT-2 Completion 6

`If you don’t have 7-inch cake pans, you can get 3 shorter 8-inch layers out of this` recipe, which
will give you about 6-9 servings of delicious chocolate cake. To prevent your layers from sticking
together, I used my 8-inch round tart pan, lined it with parchment paper, then cut up 4 7-inch round
cakes from it and sandwiched the layers between them (this also worked well for the 1-layer
chocolate cake as well).  When you’re ready to bake this cake, remove the parchment paper, preheat
oven to 350 degrees and bake for about 30 – 40 minutes, until the top is golden and a tester comes
out clean.

Chocolate Buttermilk Layer Cake with Peppermint Jo **Joes**

#### Analysis 

A tart pan is a thin metal pan with about 1 inch tall ruffled edges, like a giant shallow Reece's
cup.  Oh I'm really confused about what it's describing. This thing has no mind's eye or intuitive
physics to guide it; this is mechanical gibberish.

Here's my best attempt at explaining it: Bake the 3 main 8-inch cake rounds normally, and bake an
8-inch round in a tart pan. Slice the thin tart pan cake into 4 layers. Now you have 3 big circles
and 4 thinner circles. Then you stack these somehow.

It says to bake at 350 for 30-40 minutes, I assume it means the cake rounds __before__ assembling,
otherwise it would be impossible.

It also gives another title: Chocolate Buttermilk Layer Cake with Peppermint Jo Joes.

## Name

The names it gives for the recipe are:

+ Chocolate Buttermilk Layer Cake with Peppermint Jo Joes.
+ Meringue Cookies
+ Chocolate Buttermilk Cake
+ Chocolate Buttermilk Cake Print Chunks of chocolate cake, coated in buttermilk and topped with
  crunchy chopped chocolate, drizzled with chocolate sauce

## Ingredients 

Completions 3 and 4 give extensive ingredient lists, copied here:

For the chocolate glaze 
<br>
+ 1 1/2 cup unsalted butter, room temperature
+ 1 1/2 cup granulated sugar
+ 3 large eggs plus 1 egg yolk 
+ 1/3 cup cocoa powder
+ 1 3/4 cups powdered sugar
+ 6 ounces semis**weet chocolate chips**
+ ...


(for "Meringue Cookies")
<br>
+ 1 3/4 cup butter, softened
+ 1 cup sugar
+ 1 egg yolk
+ 3 T. heavy cream
+ 3 1/2-4 cups flour
+ pinch of salt
+ Peppermint-Jojo Topping
+ 1 1/4 cups powdered sugar
+ 1 cup chopped pecans
+ 1/2 cup finely chopped mint leaves
+ 1/2 cup chopped fresh mint (about 1/2 sheet)
+ 1 tsp. peppermint extract
+ 1/4 tsp. sea salt
+ pinch of sea **salt.**
+ ...
 
Mix right into the cake batter
<br>
+ egg yolks
+ sugar
+ melted butter
+ chocolate chips
+ melted chocolate
+ mint

## Instructions

+ Egg whites sit at bottom of mixing bowl in fridge for making icing
+ Whip to stiff peaks, easier to do if you preheat the mixing bowl in warm water 3-5 minutes
+ Let raw sugar cool down, and put half a teaspoon of sugar on it
+ NO SUBSTITUTIONS
+ Main cake is 3 8" layers
+ Also make one extra layers in an 8" tart pan, to slice into 4 pieces sandwich between the layers.

<a id="recipe"></a>

# The Final Recipe!!

# Meringue Cookie Chocolate Buttermilk Cake with Peppermint Jo Joe's Print Chunks

**coated in buttermilk and topped with crunchy chopped chocolate, drizzled with chocolate sauce**

## NO SUBSTITUTIONS

Remember: let raw sugar cool down, and put half a teaspoon of sugar on it before using

### Make into cookie batter:

+ 1 3/4 cup butter, softened
+ 1 cup sugar
+ 1 egg yolk
+ 3 T. heavy cream
+ 3 1/2-4 cups flour
+ pinch of salt

### For mint chocolate topping:

Part 1:

Whip whites of 3 large eggs to hard peaks. Tip: heat the mixing bowl in warm water before you start,
3-5 minutes is all it takes.

Mix until smooth:
+ 1 1/2 cup unsalted butter, room temperature
+ 1 1/2 cup granulated sugar
+ The whipped egg whites
+ the yolks of the 3 large eggs plus 1 extra egg yolk 
+ 1/3 cup cocoa powder
+ 1 3/4 cups powdered sugar

Part 2:

Separately, blend until smooth to make chocolate sauce:
+ 6 ounces semisweet chocolate chips, melted
+ Peppermint-Jojo
+ 1 1/4 cups powdered sugar
+ 1 cup chopped pecans
+ 1/2 cup finely chopped mint leaves
+ 1/2 cup chopped fresh mint (about 1/2 sheet)
+ 1 tsp. peppermint extract
+ 1/4 tsp. sea salt
+ pinch of sea salt.

Set aside half of the chocolate sauce for later.

Combine remaining chocolate sauce with part 1 to make the cake stuffing stuff.

### Cake

Make a basic chocolate cake recipe, and mix the following into the batter in arbitrary amounts:
+ egg yolks
+ sugar
+ melted butter
+ chocolate chips
+ melted chocolate
+ mint

Enough to fill 3 8-inch cake pans and 1 parchment-lined tart pan. Bake at 350F for 30-40 minutes.
Slice 4 7-inch rounds from the tart pan cake, setting aside the edges. This will help keep layers
from sticking together.

Build the cake using these layers and the icing, like a sandwich. 

### Meringue Cookies

Meanwhile, make the cookie dough into balls (or a sheet) and bake however long you feel like.

### Topping 

+ Chopped chocolate
+ Chocolate sauce (from earlier) drizzled
+ Some buttermilk (coat the cake with it. Spray bottle helps!)

And maybe put those cookies on top or something. 
