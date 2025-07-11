import "CoreLibs/graphics"
import "CoreLibs/timer"
import "CoreLibs/sprites"
import "CoreLibs/crank"
import "CoreLibs/ui"

-- Localizing commonly used globals, everybody seems to do this for playdate
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Importing images
local carImage = gfx.image.new("images/passengerview")
assert(carImage, "Failed to load car image")
local doorImage = gfx.image.new("images/car-door_dither")
assert(doorImage, "Failed to load door")
local knobsImage = gfx.image.new("images/knobs")
assert(knobsImage, "failed to load knobs")
local backImage = gfx.image.new("images/backseat")
assert(backImage, "failed to load backseat")
local cursorImage = gfx.image.new("images/hand-icon")
local handleImage = gfx.image.new("images/handle")
assert(handleImage, "Failed to load handle")
local ACImage = gfx.image.new("images/AC")
assert(ACImage, "Failed to load AC")
local radioImage = gfx.image.new("images/radio")
assert(radioImage, "failed to load radio image")

--sprites
local cursorSprite = gfx.sprite.new(cursorImage)
cursorSprite:setZIndex(10)
cursorSprite:moveTo(200,120)
cursorSprite:setVisible(false)
cursorSprite:add()

local carSprite = gfx.sprite.new(carImage)
carSprite:moveTo(200, 120)
carSprite:setZIndex(1)
carSprite:add()

local doorSprite = gfx.sprite.new(doorImage)
doorSprite:moveTo(200, 120)
doorSprite:setZIndex(1)
doorSprite:setVisible(false) -- Hide initially
doorSprite:add()

local knobsSprite = gfx.sprite.new(knobsImage)
knobsSprite:moveTo(200, 120)
knobsSprite:setZIndex(1)
knobsSprite:setVisible(false) -- Hide initially
knobsSprite:add()

local backSprite = gfx.sprite.new(backImage)
backSprite:moveTo(200, 120)
backSprite:setZIndex(1)
backSprite:setVisible(false) -- Hide initially
backSprite:add()

local handleSprite = gfx.sprite.new(handleImage)
handleSprite:moveTo(200,120)
handleSprite:setZIndex(2)
handleSprite:setVisible(false)
handleSprite:add()

local radioSprite = gfx.sprite.new(radioImage)
radioSprite:moveTo(200, 120)
radioSprite:setZIndex(2)
radioSprite:setVisible(false)
radioSprite:add()

local acSprite = gfx.sprite.new(ACImage)
acSprite:moveTo(200,120)
acSprite:setZIndex(2)
acSprite:setVisible(false)
acSprite:add()

-- Game States
local STATE_NEUTRAL = "neutral"
local STATE_DOOR = "door"
local STATE_KNOBS = "knobs"
local STATE_BACKSEAT = "backseat"
local STATE_HANDLE = "handle"
local STATE_RADIO = "radio"
local STATE_AC = "ac"

local gameState = STATE_NEUTRAL --initialized state
local QUEST_STATUS = false

-- Text variables
local driverCurrentMessage = ""
local driverMessageTimer
local msg = ""
local msgTimer
local driverMessagesLeft = {}

--index for quest selector
local selectIndex = 1

-- for crankin'
local crankVal = 0
local fullTurns = 0

--debugging
local questTimer

-- Scene sprite set so sprites only show in specific gamestates
local function updateScene()
    carSprite:setVisible(gameState == STATE_NEUTRAL)
    doorSprite:setVisible(gameState == STATE_DOOR or gameState == STATE_HANDLE)
    knobsSprite:setVisible(gameState == STATE_KNOBS)
    backSprite:setVisible(gameState == STATE_BACKSEAT)
    cursorSprite:setVisible(gameState == STATE_KNOBS or gameState == STATE_DOOR or gameState == STATE_BACKSEAT)
    handleSprite:setVisible(gameState == STATE_HANDLE)
    acSprite:setVisible(gameState == STATE_AC)
    radioSprite:setVisible(gameState == STATE_RADIO)
end

-- Scene switch logic
local function sceneSwitch()
    local previousState = gameState --for nil array check

    if gameState == STATE_NEUTRAL then
        if pd.buttonIsPressed(pd.kButtonLeft) then
            gameState = STATE_KNOBS
        elseif pd.buttonIsPressed(pd.kButtonRight) then
            gameState = STATE_DOOR
        elseif pd.buttonIsPressed(pd.kButtonDown) then
            gameState = STATE_BACKSEAT
        end
    elseif gameState == STATE_DOOR and pd.buttonJustReleased(pd.kButtonRight) then
        gameState = STATE_NEUTRAL
    elseif gameState == STATE_KNOBS and pd.buttonJustReleased(pd.kButtonLeft) then
        gameState = STATE_NEUTRAL
    elseif gameState == STATE_BACKSEAT and pd.buttonJustReleased(pd.kButtonDown) then
        gameState = STATE_NEUTRAL
    end

    --if screen changes, reset index to prevent out of bounds array error
    if previousState ~= gameState then
        selectIndex = 1
    end

    updateScene()
end

--maybe map quests but i never put in a map
--ROUTE = "Can you check and make sure we're going the right way?",
    --TURN = "Did we miss our turn?",

local QUESTS = {
    SNACK = "Can you get me a snack from the back?",
    DOG = "How's the dog, are they doing ok?",
    FLY = "OMG that fly has been in here since New Mexico I swear to god. Get it out!!!",
    FART = "Uh, I farted. You might wanna roll down the window...",
    AC = "Phew, it's getting hot. Can you turn up the AC?",
    RADIO = "I bet there's some good radio around here - find a station and turn it up!",
}

local driverMessages = {
    QUESTS.SNACK,
    QUESTS.DOG,
    QUESTS.FLY,
    QUESTS.FART,
    QUESTS.AC,
    QUESTS.RADIO
}

--shuffles and loads all messages into an external table, then goes through the table later 1 by 1. so quests dont repeat constantly 
local function initializeDriverMessages()
    driverMessagesLeft = {}
    for i, message in ipairs(driverMessages) do
        table.insert(driverMessagesLeft, message)
    end
    -- shuffle the messages so they appear in random order
    for i = #driverMessagesLeft, 2, -1 do
        local j = math.random(i)
        --this is how you swap in lua? idgi tbh
        driverMessagesLeft[i], driverMessagesLeft[j] = driverMessagesLeft[j], driverMessagesLeft[i]
    end
end

initializeDriverMessages()

--function to randomly pick from chat messages
function updateDriverMessage()

    if QUEST_STATUS then
        return -- don't update if in a quest!
    end

    if #driverMessagesLeft == 0 then
        initializeDriverMessages()
    end

    driverCurrentMessage = table.remove(driverMessagesLeft, 1) --lua arrays start at 1!!!!
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

--drawing vs setting the message needs to happen separately i am losing it
function drawAnyText(tempMsg, duration)
    if tempMsg ~= "" then
        msg = tempMsg

        if msgTimer then msgTimer:remove() end

        msgTimer = pd.timer.performAfterDelay(duration or 2000, function()
            msg = ""
        end)
    end
end

--am i too afraid to edit the driver message function right now and am just basically makingg the same function again for other text? yes it's fine
function renderText()
    if msg ~= "" then
        local padding = 10
        local maxWidth = 380 -- limits text box width

        -- calculates width of text, up to 300, and height of text after wrapping it
        local textWidth, textHeight = gfx.getTextSizeForMaxWidth(msg, maxWidth)

        local boxX, boxY = 10, 170
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
        gfx.drawTextInRect(msg, boxX + padding, boxY + padding, maxWidth, textHeight)
    end
end

--first message after 3 seconds
driverMessageTimer = pd.timer.performAfterDelay(3000, updateDriverMessage)

--screen state choices
local knobQuestPositions = {{340, 90}, {150, 120}, {95, 190}}
local doorQuestPositions = {{155, 155}, {350, 160}}
local backQuestPositions = {{120, 180}, {285, 160}}

-- quest selection functions
local function chooseKnobsQuest()
    --cycle through options
    cursorSprite:setVisible(true)
    if pd.buttonJustPressed(pd.kButtonB) then
        selectIndex = selectIndex + 1
        if selectIndex > #knobQuestPositions then
            selectIndex = 1
        end
        print("Index: ", selectIndex)
    end

    cursorSprite:moveTo(knobQuestPositions[selectIndex][1], knobQuestPositions[selectIndex][2])
   
end

local function chooseDoorQuest()
    cursorSprite:setVisible(true)
    if pd.buttonJustPressed(pd.kButtonB) then
        selectIndex = selectIndex + 1
        if selectIndex > #doorQuestPositions then
            selectIndex = 1
        end
        print("Index: ", selectIndex)
    end

    cursorSprite:moveTo(doorQuestPositions[selectIndex][1], doorQuestPositions[selectIndex][2])
end

local function chooseBackQuest()
    cursorSprite:setVisible(true)
    if pd.buttonJustPressed(pd.kButtonB) then
        selectIndex = selectIndex + 1
        if selectIndex > #backQuestPositions then
            selectIndex = 1
        end
        print("Index: ", selectIndex)
    end

    cursorSprite:moveTo(backQuestPositions[selectIndex][1], backQuestPositions[selectIndex][2])
end

--actual quest logics!


local radioPositions = {0, 60, 120, 180, 240, 300}
local goodRadio = nil
local radioTimer = nil

function knobsQuest()
    if gameState == STATE_KNOBS and QUEST_STATUS == true then
        if driverCurrentMessage == QUESTS.AC then
            if selectIndex == 3 and pd.buttonJustPressed(pd.kButtonA) then
                print("ac mini-game here")
                gameState = STATE_AC
                updateScene()
            end
        elseif driverCurrentMessage == QUESTS.RADIO then

            if selectIndex == 2 and pd.buttonJustPressed(pd.kButtonA) then
                print("radio mini-quest")
                goodRadio = radioPositions[math.random(#radioPositions)]

                --print out static noise randomly until quest resolved
                if radioTimer then radioTimer:remove() end  -- cancel any previous timer
                radioTimer = pd.timer.new(1000, function()
                    drawAnyText("skkkkkk...", 300)
                end)
                radioTimer.repeats = true

                gameState = STATE_RADIO
                updateScene()
            end
        end
    end
end 

local accumlatedCrankChange = 0

function ACQuest()
    if gameState == STATE_AC then
        pd.ui.crankIndicator:draw()
        local crankChange = pd.getCrankChange()

        if crankChange > 0 then
            accumlatedCrankChange += crankChange
        end

        if accumlatedCrankChange >= 120 then
            drawAnyText("Ahh, that's better. I'm so glad I fixed that before we left!")
            gameState = STATE_NEUTRAL
            updateScene()
            resetQuest()
            accumlatedCrankChange = 0
        end

        if pd.buttonJustPressed(pd.kButtonB) then
            gameState = STATE_NEUTRAL
            updateScene()
        end
    end
end

function radioQuest()
    if gameState == STATE_RADIO then
        pd.ui.crankIndicator:draw()
        local crankPos = pd.getCrankPosition()
        local angleDifference = math.abs(crankPos - goodRadio) --find difference between crank position and desired angle

        -- account for wrap-around stolen from chatGPT:
        if angleDifference > 180 then angleDifference = 360 - angleDifference end

        --if angle difference is within tolerance of 10
        if angleDifference <= 10 then
            drawAnyText("Oh my god stop here - this old man's gonna drop some KILLER country tracks, I can feel it...")
            gameState = STATE_NEUTRAL

            if radioTimer then
                radioTimer: remove()
                radioTimer = nil
            end

            goodRadio = nil
            resetQuest()
            updateScene()
        end

        if pd.buttonJustPressed(pd.kButtonB) then
            gameState = STATE_NEUTRAL
            updateScene()
        end
    end
end

function doorQuest()
    if gameState == STATE_DOOR and QUEST_STATUS == true then
        if driverCurrentMessage == QUESTS.FART or driverCurrentMessage == QUESTS.FLY then
            if selectIndex == 1 and pd.buttonJustPressed(pd.kButtonA) then
                gameState = STATE_HANDLE
                print("handle quest begun")
                updateScene()
            end
        end
    end
end

--quest for cranking the door handle specifically 
function doorCrank()
    print(gameState)
    if gameState == STATE_HANDLE then
        pd.ui.crankIndicator:draw()
        local crankGoal = 360 * 5 -- 5 rotations
        
        local crankPos = pd.getCrankChange()

        if crankPos > 0 then
            crankVal += crankPos --if moved in clockwise direction, add value

            --print out sound effect every full turn 
            local newFullTurns = math.floor(crankVal / 360)
            if newFullTurns > fullTurns then
                fullTurns = newFullTurns
                drawAnyText("*sqrrk*...", 300) 
            end
        end
 
        -- Rotate handle sprite based on crank movement(looks goofy)
        handleSprite:setRotation(handleSprite:getRotation() + crankPos)

        if crankVal >= crankGoal then
            print("window rolled")
            drawAnyText("Phew... thanks!", 3000)
            resetQuest()
            crankVal = 0 -- to reset
            fullTurns = 0
            gameState = STATE_NEUTRAL
            updateScene()
        end

        if pd.buttonJustPressed(pd.kButtonB) then
            gameState = STATE_NEUTRAL
            crankVal = 0
        end
    end
end

local snackMessages = {
    "Eh, an apple? Alright...",
    "We still had dolmas?? Hell yeah.",
    "Bless you, I am craaaaaving chocolate rn",
    "YES!! CHEESE AND SALAMI!!!"
}
local dogQuestBool = false

function backQuest()
    if gameState == STATE_BACKSEAT and QUEST_STATUS == true then
       if driverCurrentMessage == QUESTS.DOG then
            if selectIndex == 1 and pd.buttonJustPressed(pd.kButtonA) then
                print("dog quest mini game")
                drawAnyText("Give 'em a head scratch would ya?")
                dogQuestBool = true
            end
        elseif driverCurrentMessage == QUESTS.SNACK then
            if selectIndex == 2 and pd.buttonJustPressed(pd.kButtonA) then
                print("snacks mini game")
                drawAnyText(snackMessages[math.random(1, #snackMessages)])
                resetQuest()
            end
        end
    end
end

local petDir = 1 -- 1 = forward, -1 = back
local petCount = 0
local petGoal = 5 -- how many pets are needed
local inRange = false

function drawCrankRangeIndicator()
    local centerX = 350
    local centerY = 220
    local radius = 40

    -- Draw an arc between 300° and 60°
    gfx.setColor(gfx.kColorBlack)
    gfx.drawArc(centerX, centerY, radius, 300, 60) 
end

function dogQuest()
    pd.ui.crankIndicator:draw()
    local crankPos = pd.getCrankPosition()

    drawCrankRangeIndicator()

    -- Check if we're in the "petting" top zone:
    if crankPos >= 300 or crankPos <= 60 then
        if not inRange then
            -- Just entered range
            inRange = true
            petDir *= -1 -- switch direction
            petCount += 1
            print("pet count: "..petCount)
            drawAnyText("Aw, is that good?", 300)
        end
    else
        inRange = false
        drawAnyText("**whine** **pant**", 300)
end

    -- end quest
    if petCount >= petGoal then
        drawAnyText("Sweet baby, we'll be there soon I promise!", 2000)
        resetQuest()
        petCount = 0
        dogQuestBool = false
    end
end

--self explanatory, resets quest and driver timer
function resetQuest()
    print("Reset!")
    QUEST_STATUS = false
    driverCurrentMessage = ""

    -- Stop and restart driver message timer
    if driverMessageTimer then
        driverMessageTimer:remove() -- Stop the old timer
    end
    
    driverMessageTimer = pd.timer.performAfterDelay(math.random(3000, 5000), updateDriverMessage)
end

--quest timer for debugging
questTimer = pd.timer.new(3000, function()
    print("QUEST STATUS: ", QUEST_STATUS)
end)
questTimer.repeats = true

-- primary update where things happen!
function pd.update()
    --gfx.clear()
    gfx.sprite.update()

    sceneSwitch()

    --resets driver message when quest is cleared and it becomes empty 
    if driverCurrentMessage ~= "" then
        drawTextbox()
    end

    renderText()

    if cursorSprite:isVisible() then
        if gameState == STATE_KNOBS then
            chooseKnobsQuest()
        end
        if gameState == STATE_DOOR then
            chooseDoorQuest()
        end
        if gameState == STATE_BACKSEAT then
            chooseBackQuest()
        end
    end

    if gameState == STATE_HANDLE then
        doorCrank()
    end

    if gameState == STATE_AC then
        ACQuest()
    end

    if gameState == STATE_RADIO then
        radioQuest()
    end

    if dogQuestBool then
        dogQuest()
    end

    if QUEST_STATUS then
        doorQuest()
        knobsQuest()
        backQuest()
    end

    pd.timer.updateTimers()
    
end

updateScene()