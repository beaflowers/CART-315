import "CoreLibs/graphics"
import "CoreLibs/timer"
import "CoreLibs/sprites"

-- Localizing commonly used globals, everybody seems to do this for playdate
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Scenes
local carImage = gfx.image.new("images/side-view-dash_dither")
assert(carImage, "Failed to load car image")
local doorImage = gfx.image.new("images/car-door_dither")
assert(doorImage, "Failed to load door")
local knobsImage = gfx.image.new("images/stereo-and-thermo_dither")
assert(knobsImage, "failed to load knobs")
local backImage = gfx.image.new("images/backseat")
assert(backImage, "failed to load backseat")
local cursorImage = gfx.image.new("images/hand-icon")

--sprites
local cursorSprite = gfx.sprite.new(cursorImage)

-- Game States
local STATE_NEUTRAL = "neutral"
local STATE_DOOR = "door"
local STATE_KNOBS = "knobs"
local STATE_BACKSEAT = "backseat"

local gameState = STATE_NEUTRAL --initialized state
local QUEST_STATUS = false

-- Message variables
local driverCurrentMessage = ""
local driverMessageTimer

--debugging
local questTimer

--function for looking to the left - hold left arrow, returns to passenger view when lifted
local function updateSeatView()
    gfx.clear()
    carImage:draw(0,0) -- image at top left corner because its the exact same size as pd screen
    --print ("default game state")
    if pd.buttonIsPressed(pd.kButtonLeft) then
        gameState = STATE_KNOBS
    elseif pd.buttonIsPressed(pd.kButtonRight) then
        gameState = STATE_DOOR
    elseif pd.buttonIsPressed(pd.kButtonDown) then
        gameState = STATE_BACKSEAT
    end
end

-- function for returning to passenger view 
local function updateDoorView()
    gfx.clear()
    doorImage:draw(0,0)
    --print ("door game state")
    if pd.buttonJustReleased(pd.kButtonRight) then
        gameState = STATE_NEUTRAL
    end
end

-- function for returning to passenger view
local function updateKnobsView()
    gfx.clear()
    knobsImage:draw(0,0)
    --print ("knobs game state")
    if pd.buttonJustReleased(pd.kButtonLeft) then
        gameState = STATE_NEUTRAL
    
    end
end

-- function for returning to passenger view
local function updateBackView()
    gfx.clear()
    backImage:draw(0,0)
    --print ("backseat game state")
    if pd.buttonJustReleased(pd.kButtonDown) then
        gameState = STATE_NEUTRAL
    end
end

local driverMessages = {
    "Can you get me a snack from the back?",
    "How's the dog, are they doing ok?",
    "OMG that fly has been in here since New Mexico I swear to god. Get it out!!!",
    "Uh, I farted. You might wanna roll down the window...",
    "Phew, it's getting hot. Can you point the AC at me?",
    "Can you check and make sure we're going the right way?",
    "Did we miss our turn?",
    "I bet there's some good radio around here - find a station and turn it up!",
}

--function to randomly pick from chat messages
function updateDriverMessage()

    if QUEST_STATUS then
        return -- don't update if in a quest!
    end

    driverCurrentMessage = driverMessages[math.random(1, #driverMessages)] --lua arrays start at 1!!!!
    QUEST_STATUS = true
    print("new quest started")
    
    --set random timer
    local delay = math.random(3000,5000) -- 3 to 5 seconds
    driverMessageTimer = pd.timer.performAfterDelay(delay, updateDriverMessage)
    
end

function drawTextbox()
    if driverCurrentMessage ~= "" then
        local padding = 10
        local maxWidth = 300 -- limits text box width

        -- calculates width of text, up to 300, and height of text after wrapping it
        local textWidth, textHeight = gfx.getTextSizeForMaxWidth(driverCurrentMessage, maxWidth)


        local boxX, boxY = 10, 10
        local boxW = textWidth + padding * 2
        local boxH = textHeight + padding * 2

        -- make sure box doesn't go off screen
        if boxX + boxW > 400 then boxX = 400 - boxW end
        if boxY + boxH > 240 then boxY = 240 - boxH end

        gfx.setColor(gfx.kColorWhite)
        gfx.fillRect(boxX, boxY, boxW, boxH)

        gfx.setColor(gfx.kColorBlack)
        gfx.drawRect(boxX, boxY, boxW, boxH)

        gfx.setColor(gfx.kColorBlack)
        gfx.drawTextInRect(driverCurrentMessage, boxX + padding, boxY + padding, maxWidth, textHeight)
        
    end
end

--first message after 3 seconds
driverMessageTimer = pd.timer.performAfterDelay(3000, updateDriverMessage)

--knob state choices
local quest_choices = {"vent", "temp", "radio"}
local selectIndex = 1
local questPositions = { {200, 20}, {320, 40}, {240, 120} }


local function spriteInit()
    cursorSprite:add()
    cursorSprite:moveTo(200,120)
end

local function chooseQuest()
    --cycle through options
    cursorSprite:draw(200,120, 16, 16)
    if pd.buttonJustPressed(pd.kButtonA) then
        selectIndex = selectIndex + 1
        if selectIndex > #quest_choices then
            selectIndex = 1
        end
        print("Index: ", selectIndex)
    end

    cursorSprite:moveTo(questPositions[selectIndex][1], questPositions[selectIndex][2])

    gfx.sprite.update()
end

function doorQuest()
    if gameState == STATE_DOOR and QUEST_STATUS == true then
        if pd.buttonIsPressed(pd.kButtonA) then
            print("A button pressed!")
            resetQuest()
        end
    end
end

function knobsQuest()
    if gameState == STATE_KNOBS and QUEST_STATUS == true then
        if pd.buttonJustPressed(pd.kButtonB) then
            print("B button pressed!")
            resetQuest()
        end
    end
end 

function resetQuest()
    print("Reset!")
    QUEST_STATUS = false
    driverCurrentMessage = ""

    --restarts message timer 
    if not driverMessageTimer then
        updateDriverMessage()
    end    
end

--quest timer for debugging
questTimer = pd.timer.new(3000, function()
    print("QUEST STATUS: ", QUEST_STATUS)
end)
questTimer.repeats = true

-- primary update where things happen!
function pd.update()
    gfx.clear()

    chooseQuest()

    if gameState == STATE_NEUTRAL then
        updateSeatView()
    elseif gameState == STATE_KNOBS then
        updateKnobsView()
    elseif gameState == STATE_DOOR then
        updateDoorView()
    elseif gameState == STATE_BACKSEAT then
        updateBackView()
    end

    if driverCurrentMessage ~= "" then
        drawTextbox()
    end

    if QUEST_STATUS then
        doorQuest()
        knobsQuest()
    end

    pd.timer.updateTimers()
end





