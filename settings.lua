require("languages")
decks = {
    adventureTime1 = 1,
    --adventureTime2 = 2,
    normal1 = 2,
    normal2 = 3,
    normal3 = 4,
    normal4 = 5
}

settings = {
    language = languagesNames.englishUS,
    deckSet = decks.adventureTime1,
    scale = 0.60
}

function getNextDeck()
    local maxDeckNumber = 5
    local nextDeck = 1
    if settings.deckSet == maxDeckNumber then
        nextDeck = 1
    else
        nextDeck = settings.deckSet + 1
    end
    return nextDeck
end

function getScale()
    local scale = 0.5
    if settings.deckSet == decks.adventureTime1 or settings.deckSet == decks.adventureTime2 then
        scale = 0.60
    elseif settings.deckSet == decks.normal1 then
        scale = 0.35
    elseif settings.deckSet == decks.normal2 then
        scale = 0.49    
    elseif settings.deckSet == decks.normal3 then
        scale = 0.75
    elseif settings.deckSet == decks.normal4 then
        scale = 1.05
    end
    return scale
end
