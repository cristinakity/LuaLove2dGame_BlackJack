Card = {}

function Card.init(suit, value, deckSet)
    local self = setmetatable({}, Card)
    self.suit = suit
    self.value = value
    imageFile = "img/decks/"..deckSet.."/"..self.value.."-of-"..self.suit..".png"
    self.img = love.graphics.newImage(imageFile)
    return self
end