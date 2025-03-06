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

I made the pong paddles into pinball flippers. Looked up some youtube tutorials on how to do this - didn't actually use much of what we learned in class necessarily, but I did learn about motors and hinges! It was tricky getting the angles of flip right and I can't say it made total sense the way things were flipping around but after trial and error it worked. It was a lot of reversing negative values to positive values, trying to get everything to move correctly and then totally reversing the limit angle of the right flipper... 

Motor has torque, motor has force, needs to move in a negative direction to go up, positive direction to go down.

Flippers flip! (I moved this weekend, it was -30C, I am tired.)

![](https://github.com/beaflowers/CART-315/blob/main/Gifs/pawngpinball.gif)

## Exploration Prototype 3 13/2/2025

Okay I have this idea but I think it's gonna require more playtesting because the idea is very technically simple but I'm not sure if it's going to "read" well. The idea of an escape room game, but in order to escape you need to be able to conceptualize of the computer (or controller, or whatever) as an object itself... So I tested out setting up scenes and changing them to remember how to do it (I didn't remember how to do it at all) and currently it switches when a key on the keyboard is pressed (F, because... why would you press F when playing a game?? Want to challenge WASD/arrow keys/spacebar/game literacy). Trying to break out of the computer itself???? 

I have some text on there but it looks terrible so I wanted to tweak the text some more but then I didn't do that. It looks like you have to manually install fonts as assets which I guess makes sense but seems like a whole pain in the ass tbh. Why can't I adjust textbox size and stuff easily idk it's fine Unity is not a text editor. Gotta figure this out more

## Exploration Prototype 4 

Okay had an idea to try and connect raspberry pi to Unity to try and get a custom button working. Involved a lot of navigating serials and installing .net frameworks. Gegnerated a script that allows Unity to recieve input from an outside source - it doesn't seem too complicated? And my button thing works over Thonny so the circuit is good. Still not able to get this to work but it feels really close. I am getting debug errors within Unity itself... 

## Extra Credit - Game Analysis

I think the peak game mechanics moment I’ve experienced was from Echodog’s [Signs of the Sojourner](https://echodog-games.itch.io/signs-of-the-sojourner). 

You are a trader taking on the legacy of your mother, beginning to travel around with your village’s caravan to bring back necessary goods. The main gameplay (aside from dialogue options) is a conversational card-game dynamic. A character you are speaking to plays a card, and you must match the symbol on the card from a card in your hand in order to continue the conversation, as well as ideally provide a symbol that the person you are speaking to can also continue to match. This needs to successfully happen 4 times in order for the conversation to be collaborative and meaningful - either this particular storyline progresses, or you get something to bring back to your home. 

![](https://img.itch.zone/aW1hZ2UvNDgxNDEyLzM0MjQ2MzMucG5n/original/cPCoTF.png)

As you travel throughout the world, you have the option to pick up new cards with new symbols from different places you have visited and returned to. This inherently/mechanically expands your ability to connect with more people. The catch, however, is your deck only has a limited size of around 10 cards, and there are are A LOT of different symbols. The deck and hand size limits make it basically impossible to be capable of communicating with every part of the map, because you need certain number of matching symbols in your base deck to complete the 5-card conversations successfully. So, as I discovered when I returned home - it can also inhibit your ability to speak to people you once could communicate with so easily, which was devastating (on a mechanical as well as story level) to not be able to complete a conversation with  my sibling! And also absolutly reflected my real-world experiences leaving home and traveling a lot (I lived out of a truck for like 5 years, it was a good time). 

The inerently limiting/punishing nature of this mechanic I found so incredibly effective at conveying what it is like to travel, to adopt new cultural affects or modes of being, and feeling how incompatible those modes of being are with other places or where one is from. The game is pretty short, maybe a few hours long at most, so it is replayable for different endings depending on which card symbols the player focuses on. I found it pretty difficult to get a good ending, and it does seem required to return home regularly to rest (another mechanic is that as you get more tired, your hand size also decreases, which obviously also makes it harder to speak to others) meaning that it is sort of default assumed that you will keep the circles and squares of your homeland, which feels a bit limiting in a less-interesting way - I can't freely integrate with other parts of the map no matter what. 

I'd love to take on and use this idea of change, but not free/unlimited change in future projects. I like the idea of having a mechanic that doesn't reward typical gamer min/maxing, but subverts the ability of continuing to get stronger without any barriers. Mechanics that make the player feel weaker but not by confusing or obfuscating are so powerful and interesting! 











