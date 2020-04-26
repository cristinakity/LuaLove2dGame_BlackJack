Language = {}

function Language.init(name, values)
    local self = setmetatable({}, Language)
    self.name = name
    self.clickToDeal = values[languageValue.clickToDeal] --"Click deck to deal.",
    self.clickToHold = values[languageValue.clickToHold] --"Click anywhere to hold.",
    self.player = values[languageValue.player] --"Player",
    self.computer = values[languageValue.computer] --"Computer",
    self.reset = values[languageValue.reset] --"Restar game"
    self.changeLanguage = values[languageValue.changeLanguage] --"Restar game"
    self.changeDeck = values[languageValue.changeDeck] --"Restar game"
    self.english = values[languageValue.english]
    self.spanish = values[languageValue.spanish]
    self.you = values[languageValue.you]
    self.computer = values[languageValue.computer]
    self.tie = values[languageValue.tie]
    self.bust = values[languageValue.bust]
    self.winner = values[languageValue.winner]
    return self
end