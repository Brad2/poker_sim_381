function [deck,card_avail] = create_deck(type)
deck = [];
if strcmp(type,"standard")
    deck = ["2" "2" "2" "2" "3" "3" "3" "3" "4" "4" "4" "4" "5" "5" "5" "5" "6" "6"...
        "6" "6" "7" "7" "7" "7" "8" "8" "8" "8" "9" "9" "9" "9" "10" "10" "10"...
        "10" "Jack" "Jack" "Jack" "Jack" "Queen" "Queen" "Queen" "Queen" "King"...
        "King" "King" "King" "Ace" "Ace" "Ace" "Ace";convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))...
        convertCharsToStrings(char(9824)) convertCharsToStrings(char(9827)) convertCharsToStrings(char(9829)) convertCharsToStrings(char(9830))];
    card_avail = ones(1,52);
end
end

