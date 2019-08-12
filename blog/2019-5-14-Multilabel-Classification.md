---
layout: post
title: Multi-label Classification
---

I'm submitting my Optical Illusions Dataseet paper to INSAM journal - horray! However, they have a
3000 word requirement, and the body of my paper is only 2200 or 2000 if you don't count the
appendix. Adding more words is actually pretty easy, since I original wrote my paper in a terse
writeup format. There are plenty of things I can expand on, using the classic achademic paper
tropes: explaining basic concepts, including summaries of other papers, explaining the contents of a
figure in words, making long-winded subjective analysis of results. These are all things I would
rather not do, but they are fair game for increasing the word count to the required amout. In a
perfect world my paper could be let to live as the scrawny little thing that it is, but I'll have to
force feed it butter until it weights enough for market.

I'm also (perhaps foolishly) adding an additional experiment. I'm going to do multi-label
classification, which is what the MoIllusions dataset should have had done to it in the first place.

This is going to be a little bit tricky, but it's mostly a data task. I have the directory of
images, and JSON for the labels. The workflow will look like this:

- List all the images in the data directory, and keep the ones with the "mo" prefix
- Load the json into a dict that converts from filename to labels list
- Create a X's list of images, and a Y's list of binary vectors. These vectors will be of the length
  of the number of classes, with 1's representing that label being included for the image and 0
  mening the images does not have that label. 
  + The alternative is to "binarize" the labels but this would result in a very large output space,
    since it enumerates all possible combination of labels.
- Use a pretrained model, and retrain the last few layers on this data. Also, replace the softmax
  layers use in multiclass with sigmoid, since the output can be any combination of 1's and 0's. I
  suppose thresholding is needed to evaluate accuracy, a threshold of 0.5 seems pretty reasonable. 

This tutorial is going to be my base for how to work with images:

[https://blog.keras.io/building-powerful-image-classification-models-using-very-little-data.html](https://blog.keras.io/building-powerful-image-classification-models-using-very-little-data.html)

