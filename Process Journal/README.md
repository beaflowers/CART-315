# Process Journal

## Make a Thing / 23.1.2025

I decided I wanted to make something with Processing, because I've been really curious about it for a long time but never done anything with it.

I had the vision of making something like a ribbon dancer toy that follows the mouse.  I wanted it to start thick and eventually trail off into a thin line. This ended up being... relatively uncomplicated, and I was able to create pretty much exactly what I envisioned? Which is crazy! How novel!

I started with reading the Processing tutorials chapter on interactivity: https://processing.org/tutorials/interactivity learned about tracking mouse movements and some basics of the environment, like creating shapes and changing colors.

Then I poked through some examples looking specifically for something that trails after the mouse. I found this by Keith Peters, which is pretty much exactly the bare bones thing of what I was looking for: https://processing.org/examples/follow3.html I asked ChatGPT to break down what was happening in the code line by line so I could understand clearly what was going on and how to alter it to fit what I wanted. I didn't change the hard math taking place in this code; the "dragSegment" function is basically untouched.

I wanted something smoother and less ladder like than the example. This involved shortening the length of the segment line and greatly increasing the size of the array of total segments; this took a few iterations to achieve the look I wanted. Next was creating the shooting-star-esque shape that I wanted, which was pretty easy using the map() function, which takes upper/lower bounds of the current value and updates them gradually to the upper/lower bounds of the target value. So for every ith segment the width of the line decreases gradually from 50 to 1. Processing is pretty generous for things like this.

Because this wasn't too hard to create I slapped some moving orbs in the background too - and the biggest struggle I had was getting it so that not every object had the same stroke/color, which Processing is pretty weird about! Everything is very flat, and I had to use what feels like, to me, a bit of excessive (though simple) code to get different orbs.

Pretty chill, I learned some things for sure, and didn't have to think about math much!

Playtest:

Everyone reactions were very positive and they thought it was really cool! But there isn't much to actually do so people only stuck to it for a few seconds before moving on. It could do more things to keep people engaged. 




