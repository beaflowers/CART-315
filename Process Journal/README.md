# Process Journal

## Make a Thing / 23.01.2025

I decided I wanted to make something with Processing, because I've been really curious about it for a long time but never done anything with it.

I had the vision of making something like a ribbon dancer toy that follows the mouse.  I wanted it to start thick and eventually trail off into a thin line. This ended up being... relatively uncomplicated, and I was able to create pretty much exactly what I envisioned? Which is crazy! How novel!

I started with reading the Processing tutorials chapter on interactivity: https://processing.org/tutorials/interactivity learned about tracking mouse movements and some basics of the environment, like creating shapes and changing colors.

Then I poked through some examples looking specifically for something that trails after the mouse. I found this by Keith Peters, which is pretty much exactly the bare bones thing of what I was looking for: https://processing.org/examples/follow3.html I asked ChatGPT to break down what was happening in the code line by line so I could understand clearly what was going on and how to alter it to fit what I wanted. I didn't change the hard math taking place in this code; the "dragSegment" function is basically untouched.

I wanted something smoother and less ladder like than the example. This involved shortening the length of the segment line and greatly increasing the size of the array of total segments; this took a few iterations to achieve the look I wanted. Next was creating the shooting-star-esque shape that I wanted, which was pretty easy using the map() function, which takes upper/lower bounds of the current value and updates them gradually to the upper/lower bounds of the target value. So for every ith segment the width of the line decreases gradually from 50 to 1. Processing is pretty generous for things like this.

Because this wasn't too hard to create I slapped some moving orbs in the background too - and the biggest struggle I had was getting it so that not every object had the same stroke/color, which Processing is pretty weird about! Everything is very flat, and I had to use what feels like, to me, a bit of excessive (though simple) code to get different orbs.

Pretty chill, I learned some things for sure, and didn't have to think about math much!

Playtest:

Everyone reactions were very positive and they thought it was really cool! But there isn't much to actually do so people only stuck to it for a few seconds before moving on. It could do more things to keep people engaged. 

## Exploration Prototype 1 / 30.01.25
okay after stupid struggle getting basic things working because unity is massive and im struggling to keep track of 800 different asset windows and everything collapses if one little preset isn't there:

the face grows! the dots appear around the screen! trying to make an "eater" - player controllers an object that moves around the screen, every time it collides with another object it absorbs it and grows, eventually taking over the whole world and revealing a secret message. 

struggles:
- dots appear mostly in the center, which causes the main thing to grow without player interaction. implemented sort of wonky hack to make things appear along the edges
- dots appear forever, character grows infinitely - limited with a counter (i want the face to grow really really big, big enough to cover the screen, but not forever)
- speed slowdown reducing speed to 0....... woops. change to subtract rather from speed value than divide. still could potentially get to 0 but hasn't happened yet?

added a background: https://gamedevbeginner.com/how-to-add-a-background-image-in-unity/ (i want to try that parallax one sometime!!)

okay i have no idea why the speed keeps changing for the eater and isn't working like i programmed. it feels like every time i add a new component it forgets whatever I've programmed in the script and starts zooming wildly around instead. at first this was because i forgot to add the box collider and had no actual physics for it, but then it changed again when i added the appear element, and now again that I've added a canvas element... why??? why would this effect that? it says the speed is 0.5 in the inspector but that's clearly not right, and it's also definitely not slowing down like i had programmed either. I sort of tweaked this within unity itself and it sort of works a little better now, though it keeps skipping past my boundaries once it gets large, and i can't return... unsure why that is?

the text idea i had looks sick though, exactly like how i wanted. now if only this moved how i wanted and the face wouldn't bounce off screen 

FINAL EDIT: jfc i restarted unity and it worked basically exactly how i wanted? what am i supposed to learn from this??? anyway here's a gif

![](https://github.com/beaflowers/CART-315/blob/main/Gifs/eatheworld.gif)

## Exploration Prototype 2 6/2/2025

I made the pong paddles into pinball flippers. Looked up some youtube tutorials on how to do this - didn't actually use much of what we learned in class necessarily, but I did learn about motors and hinges! It was tricky getting the angles right and I can't say it made total sense the way things were flipping around but after trial and error it worked. 

Flippers flip!









