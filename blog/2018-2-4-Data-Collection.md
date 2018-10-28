---
layout: post
title: Data Collection Results
---

None of the website owners replied to my emails, so I collected the images myself. All of the content on these sites has been collected from other sources, so I don't think there is any issue with copyright. I have collected all of the image URLs and some metadata for every illusion images on both websites, and some percent of non-illusion images. 


## [Mighty Optical Illusions](https://www.moillusions.com/4-dots-illusion/)

To obtain images, I started at this page
<https://www.moillusions.com/one-two-face-illusion/>. I used python's Beuatiful
Soup library to copy all image links and then follow the previous button to the
next page, and repeated until I was out of next pages. This leads to a grand
total of **6436 images**. It's hard to know how many are duds, but that is a
good start.


## [ViperLib](http://viperlib.york.ac.uk/)

Here I changed the page number in the url, and all of the relevant areas on the
site. I was able to get **1454** images. The descriptions might end up being
useful weeding out some of the illusions that require video.

## Reddit

On closer inspection, there are only a hundred or so good illusions here. I do
not plan to download them.


I think between these two sites I have about as many illusion images as I'll
get. I am waiting to hear back from <http://illusionoftheyear.com/> to see if
they would share their images for the good of science, but I have not heard
back from them. The JSON files and scraping code will be available here:
<https://github.com/robertmaxwilliams/optical-illusion-dataset>. The next step
is to combine the JSON files and actually download all of the images and find a
place to host them.


## Next Steps

I was able to obtain **7890** images from my top two websites, and maybe a few
more thousand if IllusionsOfTheYear wants to help.

I plan to learn to use a Variational Autoencoder and apply it to this data. It
should be able to come up with a good latent space for these images, and then I
can cluster them and see what sorts of clusters appear. At this point I can try
training a GAN on specific classes, perhaps certain illusions are easy for a
GAN to reproduce than others. I expect that texture based geometric illusions
will be obtainable, but anything with large scale structure will not be
possible without a major revolution in AI or a few orders of magnitude more
images.w
