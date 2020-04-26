require("language")

languageValue = {
    clickToDeal   = 1,
    clickToHold = 2,
    player = 3,
    computer  = 4,
    reset = 5,
    changeLanguage = 6,
    changeDeck = 7,
    english = 8,
    spanish = 9,
    you = 10,
    bust = 11,
    tie = 12,
    winner = 13
}

languagesNames = {
    englishUS = "englishUS",
    spanishMX = "spanishMX"
}

englishUS = {
    [languageValue.clickToDeal] = "Click deck to deal.",
    [languageValue.clickToHold] = "Click anywhere to hold.",
    [languageValue.player] = "Player",
    [languageValue.computer] = "Computer",
    [languageValue.reset] = "Restart game",
    [languageValue.changeLanguage] = "Language",
    [languageValue.changeDeck] = "Change deck",
    [languageValue.english] = "English",
    [languageValue.spanish] = "Spanish",
    [languageValue.you] = "You",
    [languageValue.tie] = "Tie",
    [languageValue.bust] = "Bust",
    [languageValue.winner] = "Winner"
}

spanishMX = {
    [languageValue.clickToDeal] = "Has clic en el mazo de cartas para jugar.",
    [languageValue.clickToHold] = "Para terminar el juego haz clic en la mesa.",
    [languageValue.player] = "Jugador",
    [languageValue.computer] = "Computadora",
    [languageValue.reset] = "Reinicar juego",
    [languageValue.changeLanguage] = "Idioma",
    [languageValue.changeDeck] = "Cambiar baraja",
    [languageValue.english] = "Ingles",
    [languageValue.spanish] = "Español",
    [languageValue.you] = "Tu",
    [languageValue.tie] = "Empate",
    [languageValue.bust] = "Fracaso",
    [languageValue.winner] = "Ganador"
}

languageList = {}
languageList[#languageList+1] = Language.init(languagesNames.englishUS,englishUS)
languageList[#languageList+1] = Language.init(languagesNames.spanishMX,spanishMX)