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


## Iterative Prototype 2 (and 1, kinda)

Schemeing ideation around making a game for the Playdate. Thinking: a game where you are a passenger on a road trip. Thinking about exploring ideas of reproductive labor, the easy soft skills of getting around. It's not all torque and gears and engines and going fast! It's navigating and finding gas stations and places to sleep and adjusting the thermostat and making a playlist.

Since it's on the playdate with a crank... Want to have the setting be a 90s Toyota, with the door with the manual crank. Maybe will use the crank for some knobs too.

Things for player to do:
Roll Down Window To Get a Fly Out Of the Car
Adjust the vents and temperature
Find a radio station and adjust volume
(Lmao this might already be too much for lil ole me)

Lua seems difficult but doable? Maybe? This might end up being made in Unity. 

Visuals: was messing around with pixel art programs, making all my own art seems WAY too difficult. What about converting images to 1bit black and white images? Played around with some automatic programs, didn't love the results, difficult to actually get things into 1bit dither... But found a comment on a forum (of course) about how to do something in photosthop and I like what I'm working with now. Art prototype! It's kinda shitty in a grunge way which is, frankly, what I'm capable of. The playdate has a screen that's 400 x 240 px with 173 DPI, so it can be very detailed for its size. 

![](https://github.com/beaflowers/CART-315/blob/main/Gifs/car-door_dither.png)
![](https://github.com/beaflowers/CART-315/blob/main/Gifs/side-view-dash_dither.png)
![](https://github.com/beaflowers/CART-315/blob/main/Gifs/stereo-and-thermo_dither.png)

## Iteration Prototype 3
I had a whole thing written and then I forgot to save. So that's nice.

Wrote some text, figured out how to draw a box the size of the text, and iterate through different texts to give car quests. Here it is just cycling through a few of the options:

![](https://github.com/beaflowers/CART-315/blob/main/Gifs/text.gif)

Figuring out how to wrap text so it didn't run off screen was fun.
Possible future things: [how to change text/font size](https://devforum.play.date/t/how-to-change-text-size-bigger/13720), [animated text over a sprite box](https://devforum.play.date/t/text-dialog-boxes-animated-text/4009)

Been trying to figure out how to get some quest functionality/interactivity going. My code looks ok to me but it's still not working (just trying to test out turning, and pressing "A" to solve a quest). Have a boolean quest value to determine whether new text should cycle through more options or not. Will need to sort text into car location, and activate quests based on that... Each quest will be its own function probably?

Things to Do:
Make backseat graphic
Add sound effects
Figure out crank! and other quest mechanics
Animation?

## Iteration Prototype 4
Slowly making progress to get all the visual elements working: today, we added a cursor for selecting what part of the car the driver is giving us a quest for. And a backseat and a cute dog exist now. 

This was actually such a pain and involved some re-tweaking of existing elememts. I wanted to make the cursor a sprite so it's easy to move around and reposition, but that interfered with EVERY background image I had already had - so I had to convert those to sprites as well to be able to set Z score, and then fix all the logic for changing between scenes to fit for sprites. It's actually hopefully much cleaner now. Cursor doesn't appear on main driver screen, but does appear on all others, and only moves on the knobs screne for now.

I only had time to pinpoit the exact cursor positions for the knobs screen, but that's the one with the most positions (I think backseat and cardoor will only have two). I don't know why the cursor image isn't transparent, that's annoying, will have to fix. (Maybe make it better, too?) 

![](https://github.com/beaflowers/CART-315/blob/main/Gifs/switch%20gif.gif)

I like the idea of having to put in "effort" to look at other screens, but this feels limiting for other activity in the car - we can cycle through with A, and then B to select... but that doesn't feel particularly intuitive, though it's not so bad on the playdate. If we cycled through with the arrow keys it might make more sense. But in practice I dont think it feels too bad.

Maybe B will just offer a boolean toggle on each knob - like vent pointed down or up, hot or cold, radio... on or off. Not ideal but maybe the best solution for now? 

I'm worried about getting the quests all working correctly because learning Lua is.... slow. And that logic might be tricky. 

Still no crank or audio. But soon I swear.

## Iteration Prototype 5
Okay nothing new visually or frankly even noticably different in gif form. But I got a whole quest logic system functioning that ties specific driver asks to specific things the passenger has to do, which took a bit of mucking around, and, as per usual, a whole re-write of some existing thing I already had. I'm really learning here why code ends up so spaghetti sometimes - like.. it just really does get really big and really confusing and held together by hopes and dreams and the bare minimum of human/computer logic. This is still small enough that I can re-write and adjust things, but oh my god! I can so easily see it getting too big to do that! 

I ALSO fixed A BUG I discovered during PLAYTESTING(!!!)(huge, exciting). Basically if a player switched from one screen to another it would sometimes throw an error and it would crash the game - this is because some of the arrays for the selection mechanic only have 2 possible outcomes, while 1 screen has 3. So if the selector was last on "3", when it went to a screen that only has two selection options, it would crash. But now included in the scene selection logic is a means to make sure the initial selector is always set back to 1. So that is cool!!! 

I've minimized the number of quests to just 6 and... will try and come up with some little gimmick for each of them. I'm not really sure how to convey to the player if what they're doing or not is correct without animation - like if the window isn't rolling down that's obviously incorrect... How do I indicate they should use the crank? I'm guessing I'll need to "zoom" in on the screens and have a closeup view and maybe some sound effects in a text box...? I wonder if there's like a default crank animation and a way to indicate goals there. 

Snack quest - uhhh idk that one might just be the select a bag. \
Dog - pet the dog with the crank, like wiggle it back and forth a coule times\
fly - roll down window\
fart - roll down window\
ac - adjust crank to be in a specific range\
radio - ???? ideally a way to scroll through a dial... maybe crank through and play *static* then *sound*\

notes to keep track of things when solving quest logics and make sure I get everything:\
QUESTS.SNACK,\
QUESTS.DOG,\
QUESTS.FLY, \
QUESTS.FART, \
QUESTS.AC, \
QUESTS.RADIO

knobs \
index 1 = vents\
index 2 = temperature\
index 3 = radio

door \
index 1 = window handle\
index 2 = door slot

backseat \
index 1 = dog\
index 2 = snacks

## Final Iteration Prototype
Why is my code all in one file??? How is this so poorly organized??? What have I done??? This keeps getting bigger???!!! Oh my god!!!! 

CRANK QUEST #1 DOOR HANDLE SUCCESS!!!! 

My best friend conveniently bought a truck with a window crank handle in it this past week. This unfortunately means they are leaving for several months but it did mean I got to take some more specific pictures of a car interior, with a driver, actually from the passenger seat perspective. Funnily enough, the pictures I got of the door and handle were the worst and didn't work at all so I'm sticking with the original door, but I updated everything else. There's really no good pictures of cars from the passenger seat view, because that's not who cares are being sold to. Funny. DID I NEED TO BE SPENDING SO MUCH TIME RE-DOING THE AESTHETICS??? One could argue "no" but I don't care. (Soooo many people commented on it being a "horror game" I think because it's in black and white, but also because the driver was a ghost.)

And finally, FINALLY??? Got all the mini-quest mechanics working. I feel like it feels good and makes sense narratively, but there's little indicating what to do to the player - I threw in the basic UI "use the crank" animation that comes in a library(!) but each element does use the crank differently and I don't indicate that much, and feel like I'd need different sprite animations to do so. 

For example:
- dog quest is "rub" back and forth with the crank at the top of its range
- window quest is go in circles with the crank several times (the sprite is animated to rotate, and it looks so stupid and funny)
- radio is find a specific angle of the crank (somewhat randomized!) (This one works the best, I think, since I give static sounds as feedback for an incorrect location)
- AC is turn the knob slightly in a clockwise direction using the crank (only 120 degrees)
- Snack quest is just pressing A but it's got some random text responses so it doesn't feel too dead. 

I tried to draw an arc indicating where the crank should be for the dog but it's basically invisible. Would be nice to have a big polygon or something representing the top of a circle, or a tracker pointing to where the crank is located. Just tying that made me tired right now. 

Would have been fun to work on this with other people, who wanted to do sprites/animations or sound. Oh wellllll that's what I get for doing some wingnut ass project I guess!!!
