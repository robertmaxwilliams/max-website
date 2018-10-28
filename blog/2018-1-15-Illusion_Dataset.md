---
layout: post
title: Optical Illusion Datasets
---

I have been digging around for optical illusion datasets. They don't seem to exist, so I will be laying the grounds for the creation of one and starting to collect data. I don't know all that much about copyright, so if anything I describe sounds legally dubious I would really like to know.

Things that need to be done:
* Find enough data to make a good dataset
* Clean it up, convert everything to the same format (png or jpeg?) and naming convention and organize metadata somehow
* Create different resolution versions and cropped version for easier usage
* Make it into an easy to use archive and host in on UofL server or github or something

## Find Enough Data for a Good Dataset

### <http://www.michaelbach.de/ot/> 
★★★★☆

This website is really amazing, but many of his illusions require video to work. Current ML research on these moving pictures is limited, including videos would likely be a waste of time for the current state of the art. If we exclude videos, this website only has a few dozen images, possible worth collecting if we need it.

### <https://www.moillusions.com/>

★★★★★

The bottom bar shows 414 pages, and each page has 8 posts, which appear to be a short article and a high quality illusion image each. Not only does this mean we have 3312 images, we also have textual metadata and categories! This is really something. Probably not enough to train a GAN but maybe some revolution will bring [capsule nets](https://arxiv.org/pdf/1710.09829.pdf) to general image generation. Besides, not having enough data is no reason not to try anyways and see what sorts of horrible blobs it generates. 
If this is the end-all beat-all source of data, it should be enough to train a classifier and then we can inspect it to see what it believes makes illusions what they are and perhaps find some new insights into human vision.

### <http://www-bcs.mit.edu/gaz/publications/gazzan.dir/gazzan.htm>

★★★☆☆

This article explains various illusions where the same color looks different in different contexts

### <http://www.cfar.umd.edu/~fer/optical/smoothing4.html>

★★☆☆☆

This page explains the wavy grid illusion. Not directly useful but certainly interesting.

### <http://www.cvrl.org/>

★☆☆☆☆

Here is some sort of scientific database, and a few low-power illusion images.

### <http://www.handprint.com/LS/CVS/color.html>

★☆☆☆☆

Not super relevant but a degree's worth of information about color and human perception. Maybe the authors would be of assistance.

### <http://illusionoftheyear.com/>

★★★★★

This contest collects and shares a large number of images, 20 this year and they've been at it for 12 years. 240 Images is pretty significant, but that's just the top rated. The almost certainly have a huge stash of submissions, now just to get in conact with them and see if they are willing to share.

### <http://www.cogsci.uci.edu/~ddhoff/illusions.html>

★★★☆☆

This is 30ish images, at least half of which are static. 

### <http://mathworld.wolfram.com/topics/Illusions.html>

★★★☆☆

These are probably worth downloading. 

### <http://www.sandlotscience.com/>

★★☆☆☆

These folks are selling a book that claims to have "200 optical illusions." I doubt they would be willing to just hand them all over, but it's worth a shot. It's not like having their images in a zip file out there for deep learning is going to hurt their sales.

### <http://viperlib.york.ac.uk/>

★★★★★

Oh shoot, they have 1,860 images on file. I'll have to look through and see what is usable for this research, but that is more than all of the other sources combined

### <https://www.reddit.com/r/opticalillusions/top/?sort=top&t=all>

★★★★☆

I've scraped reddit before for my meme-deepfryer based on cyclegan, so this should be a pretty easy way to collect many high quality images. It goes on for at least a few hundred posts, so it is worth it. Quality is lower and there are many photographic images, which is different from other datasets.

It seems that we will be able to get at most 1,000 to 2,000 images, which is alright. I don't think GANs will be able to do anything useful, but if I knew for sure I wouldn't be doing this. This dataset should be extremely valuable and development will continue full throttle. 

## Notes on Image Content

Many images have logos or text. This might confuse the GAN, like how cats from
the GAN paper had white impact font with illegible but English looking text
over them due to the large amount of impact font English text in the dataset.
Thankfully, the images don't seem to have watermarks, which would not only
confuse the network but would make the illusions less powerful. Most images are
non-photographic, and maybe 10% of the reddit images are photographs. A great
deal of sorting by hand could catagorize them, but I think using a deep
learning technique would be sufficient. But that is for the next post about
**what to do with all this data**.
