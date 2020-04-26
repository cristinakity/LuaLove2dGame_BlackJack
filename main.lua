require("card")
require("languages")
require("settings")
require("language")
require("button")

settingsFileName = 'settings.txt'
WIDE = 1280
HIGH = 720
pad = WIDE*0.04
-- scale = 0.60
suits = {"hearts","spades","clubs","diamonds"}
values = {"Ace","2","3","4","5","6","7","8","9","10","Jack","Queen","King"}
hand = {}
total = 0
comp = {}
hold =false
ai = 0
love.window.setTitle(' Blackjack ')
love.window.setMode( WIDE, HIGH)

-- print(suits[0]) --Will cause an nil, because the start number is 1
-- print(#suits)  -- see the number of items
-- print(#values)  -- see the number of items

function love.load()
    --loadSettings()
    settings.scale = getScale()
    math.randomseed(os.time())
    playback = Card.init("card","back",settings.deckSet) --create a deck graphics
    slot = playback.img:getWidth()*settings.scale -- calculate card sizes
    love.graphics.setBackgroundColor(0.3,0.5,0.3)--Green
    buttonsFont = love.graphics.setNewFont("font/ostrich-sans-regular.ttf",35)
    font = love.graphics.setNewFont("font/ostrich-sans-regular.ttf",65)
    love.graphics.setColor(1,1,1)
end

function love.draw()
    love.graphics.setFont(font)
    love.graphics.printf(getText(languageValue.clickToDeal), pad, 66, WIDE, 'left')
    love.graphics.printf(getText(languageValue.clickToHold), pad, 122, WIDE, 'left')
    love.graphics.draw(playback.img, WIDE-slot-pad,pad,0,settings.scale,settings.scale,0,0)

    if hold == false then
        -- love.graphics.printf(getText(languageValue.you)..": "..total.." vs. "..getText(languageValue.computer)..": "..ai,
        -- 0,HIGH-76,WIDE,'center')    
        love.graphics.printf(getText(languageValue.player)..":"..total, pad, HIGH-66, WIDE, 'left')
        love.graphics.printf(getText(languageValue.computer)..":"..ai, (WIDE*0.33)+(76)+pad, HIGH-66, WIDE, 'left')
    else
        win = winner()
        love.graphics.printf(getText(languageValue.winner)..": "..win.."!!",
        0,HIGH-76,WIDE,'center')
    end

    for i, card in ipairs(comp) do
        love.graphics.setColor(0.7,0.8,0.7)
        love.graphics.draw(card.img, (WIDE*0.33)+(76)+(pad*i),pad*i,0,settings.scale,settings.scale,0,0)
        love.graphics.setColor(1,1,1)
    end  
    for i, card in ipairs(hand) do
        love.graphics.draw(card.img,pad*i,pad*i,0,settings.scale,settings.scale,0,0)
    end
    setButtons()
	drawButtons()
end

function setButtons()
    resetButton = button:new(function() 
     end
      ,getText(languageValue.reset), WIDE-200, HIGH-66, 10, 10, {2,2,255}, buttonsFont, {0,0,0})
    
    -- languageButton = button:new(function() 
    --     hand = {}
    --     comp = {}
    --     ai = 0
    --     total = 0
    --  end
    --   ,getText(languageValue.changeLanguage), WIDE-200, HIGH-126, 10, 10, {2,2,255}, buttonsFont, {0,0,0})

      englishButton = button:new(function() 
     end
      ,getText(languageValue.english), WIDE-200, HIGH-126, 10, 10, {2,2,255}, buttonsFont, {0,0,0})

      spanishButton = button:new(function() 
       end
        ,getText(languageValue.spanish), WIDE-100, HIGH-126, 10, 10, {2,2,255}, buttonsFont, {0,0,0})

      deckButton = button:new(function() 
       end
        ,getText(languageValue.changeDeck), WIDE-200, HIGH-192, 10, 10, {2,2,255}, buttonsFont, {0,0,0})
end

function isClickButton(button)
    --print("Width:"..resetButton.width.."Height:"..resetButton.height)
    if (mouse_x >= button.x 
            and mouse_y >= button.y)
            and
            (mouse_x < button.x + button.width
            and mouse_y < button.y + button.height)
    then
        print("BOTON click: "..button.text)
        return true
    else
        return false
    end
end

function reset()
    ai=0
    total=0
    hand= {}
    comp ={}
    hold = false
end

function love.mousereleased(x,y,button)    
    mouse_x = x
    mouse_y = y
    if button == 1 then        
        if isClickButton(resetButton) then
            print("Reset!!!")
            reset()
        elseif isClickButton(englishButton) then
            print("Change to english!!!")
            settings.language = languagesNames.englishUS
        elseif isClickButton(spanishButton) then
            print("Change to spanish!!!")
            settings.language = languagesNames.spanishMX
        elseif isClickButton(deckButton) then
            print("Change deck!!!")
            reset()
            settings.deckSet = getNextDeck()
            settings.scale = getScale()
            print(settings.deckSet)
            playback = Card.init("card","back",settings.deckSet) --create a deck graphics
        else
            if hold == true and total > 1 then
                reset()
            end
            if ai < 16 then
                local var = cargen()
                comp[#comp+1] = var
                local val = face(var.value)
                ai = ai+val
                print(var.value)
            end

            if x > WIDE-slot-pad
                and y < slot*1.5 then
                    local var = cargen()
                hand[#hand+1] = var
                local val = face(var.value)
                total = total+ val
            else
                hold = true
            end
        end
    end
end

function love.update(dt)
    if tonumber(total) > 21 then
        hold = true
    end
end

function face(c)
    local val = 0
    if     c == values[11] -- "Jack"
        or c == values[12] -- "Queen"
        or c == values[13] then-- "King"
        val = 10
    elseif c== values[1] then-- Ace
        val = 1
    else
        val = tonumber(c)
    end
    return val
end

function cargen()
    local c = math.random(1,4)
    local s = suits[c]
    local c = math.random(1, 13)
    local v = values[c]
    local card = Card.init(s, v, settings.deckSet)
    return card
end

function getText(option)
    local text = "ERROR"
    local activeLanguage = nil
    for i, lan in ipairs(languageList) do
        if   lan.name          == languagesNames.englishUS and 
             settings.language == languagesNames.englishUS then
            activeLanguage = lan
        elseif   lan.name     == languagesNames.spanishMX and 
            settings.language == languagesNames.spanishMX then
           activeLanguage = lan
        end
    end
    if option == languageValue.clickToDeal then
        text = activeLanguage.clickToDeal
    elseif option == languageValue.clickToHold then
        text = activeLanguage.clickToHold 
    elseif option == languageValue.player then
        text = activeLanguage.player 
    elseif option == languageValue.computer then
        text = activeLanguage.computer 
    elseif option == languageValue.reset then
        text = activeLanguage.reset 
    elseif option == languageValue.changeLanguage then
        text = activeLanguage.changeLanguage 
    elseif option == languageValue.changeDeck then
        text = activeLanguage.changeDeck 
    elseif option == languageValue.english then
        text = activeLanguage.english 
    elseif option == languageValue.spanish then
        text = activeLanguage.spanish 
    elseif option == languageValue.you then
        text = activeLanguage.you 
    elseif option == languageValue.tie then
        text = activeLanguage.tie 
    elseif option == languageValue.bust then
        text = activeLanguage.bust 
    elseif option == languageValue.winner then
        text = activeLanguage.winner 
    end
    return text
end

function winner()
    if tonumber(total) <= 21 and tonumber(total) > tonumber(ai) then
        win = getText(languageValue.you)
    elseif tonumber(total) <= 21 and tonumber(ai) == tonumber(total) then
        win = getText(languageValue.tie)
    elseif tonumber(ai) > 21 and tonumber(total)> 21 then
        win = getText(languageValue.bust)
    elseif tonumber(ai) > 21 and tonumber(total) <= 21 then
        win = getText(languageValue.you)
    else
        win = getText(languageValue.computer)
    end
    return win
end
