function deck_list(deck)
%Shows a list of the current deck with values that match to cards
disp('| Call Num | Card Num | Symbol |');

for i = 1:length(deck)
    setup = '|    %2d    |  %5s   |   %1s    |\n';
    fprintf(setup,i,deck(1,i),deck(2,i));
end
end

