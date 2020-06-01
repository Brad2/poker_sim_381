%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parameters to change
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
number_of_MC_sims = 10000; %could make this input
%MaCh_MoCa = 0; %Set to 0 for Markov Chain and 1 for Monte Carlo Sim

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Don't play with stuff after this
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[deck,card_avail] = create_deck("standard");
num_oppo_chosen = 0;
oppo_hand = []; %Each opponent has 2 cards in their hand
player_hand = [];
cards_on_table = [];
player_wins = 0;
player_ties = 0;

while num_oppo_chosen ~= 1
    prompt = 'How many opponents do you want?\n';
    num_oppo = input(prompt);
    if num_oppo < 1
        disp('Too few opponents\n');
    elseif num_oppo > 1
        disp('Too many opponents\n');
    else
        num_oppo_chosen = 1;
    end
end

true_deck = [1:52];
true_deck = true_deck(randperm(length(true_deck))); %shuffle deck

player_hand = [true_deck(1) true_deck(3)]; %pick up those cards fool
oppo_hand = [true_deck(2) true_deck(4)];

for i = 1:2
    card_avail(player_hand(i)) = 0;
    card_avail(oppo_hand(i)) = 0;
end

format = 'Your hand:\n   %5s%1s %5s%1s\n';
fprintf(format,deck(1,player_hand(1)),deck(2,player_hand(1)),...
    deck(1,player_hand(2)),deck(2,player_hand(2)));

prompt = 'Continue to flop? (y/n)\n';

cont = 0;
while cont ~= 1
    x = input(prompt);
    if x == 'y'
        cont = 1;
    elseif x == 'n'
        cont = 1;
    end
end

cards_on_table = [true_deck(5) true_deck(6) true_deck(7)]; %flop flop flop
for i = 1:3
    cards_avail(cards_on_table(i)) = 0;
end

[win_per,~] = MonteCarloSim(number_of_MC_sims, ...
    [player_hand cards_on_table],[oppo_hand cards_on_table],deck,card_avail);

format = ['In your hand:\n   %5s%1s %5s%1s\nIn your opponents hand'...
    ':\n   ?????? ??????\nCards on the table:\n   %5s%1s %5s%1s %5s%1s'...
    '\nYou have a %2.4g%% chance to win.\n'];
fprintf(format,deck(1,player_hand(1)),deck(2,player_hand(1)),...
    deck(1,player_hand(2)),deck(2,player_hand(2)),...
    deck(1,cards_on_table(1)),deck(2,cards_on_table(1)),...
    deck(1,cards_on_table(2)),deck(2,cards_on_table(2)),...
    deck(1,cards_on_table(3)),deck(2,cards_on_table(3)),100*win_per);

prompt = 'Continue to turn? (y/n)\n';

cont = 0;
while cont ~= 1
    x = input(prompt);
    if x == 'y'
        cont = 1;
    elseif x == 'n'
        cont = 1;
    end
end

cards_on_table = [cards_on_table true_deck(8)];

win_per_MaCh = MarkovChain([player_hand cards_on_table],...
    [oppo_hand cards_on_table],deck,card_avail);
format = ['In your hand:\n   %5s%1s %5s%1s\nIn your opponents hand'...
    ':\n   ?????? ??????\nCards on the table:\n   %5s%1s %5s%1s %5s%1s'...
    ' %5s%1s\nYou have a %2.4g%% chance to win.\n'];
fprintf(format,deck(1,player_hand(1)),deck(2,player_hand(1)),...
    deck(1,player_hand(2)),deck(2,player_hand(2)),...
    deck(1,cards_on_table(1)),deck(2,cards_on_table(1)),...
    deck(1,cards_on_table(2)),deck(2,cards_on_table(2)),...
    deck(1,cards_on_table(3)),deck(2,cards_on_table(3)),...
    deck(1,cards_on_table(4)),deck(2,cards_on_table(4)),100*win_per_MaCh);

cont = 0;
while cont ~= 1
    x = input(prompt);
    if x == 'y'
        cont = 1;
    elseif x == 'n'
        cont = 1;
    end
end

cards_on_table = [cards_on_table true_deck(9)];
[final_player_rank,final_player_rank_sec,player_has_pairs,final_player_hand_array,...
    final_player_highcard] = best_hand([player_hand cards_on_table],deck);
[final_oppo_rank,final_oppo_rank_sec,oppo_has_pairs,final_oppo_hand_array,...
    final_oppo_highcard] = best_hand([oppo_hand cards_on_table],deck);

if final_player_rank > final_oppo_rank
    player_wins = 1;
elseif final_player_rank == final_oppo_rank
    if player_has_pairs == 1 && oppo_has_pairs == 1
        if final_player_rank_sec > final_oppo_rank_sec
            player_wins = 1;
        elseif final_player_rank_sec == final_oppo_rank_sec
            if final_player_highcard > final_oppo_highcard
                player_wins = 1;
            else
                player_ties = 1;
            end
        end
    elseif final_player_highcard > final_oppo_highcard
        player_wins = 1;
    elseif final_player_highcard == final_oppo_highcard
        player_ties = 1;
    end
end

format = ['Final Board State:\nIn your hand:\n   %5s%1s %5s%1s\nIn your opponents hand'...
    ':\n   %5s%1s %5s%1s\nCards on the table:\n   %5s%1s %5s%1s %5s%1s'...
    ' %5s%1s %5s%1s\n'];
fprintf(format,deck(1,player_hand(1)),deck(2,player_hand(1)),...
    deck(1,player_hand(2)),deck(2,player_hand(2)),...
    deck(1,oppo_hand(1)),deck(2,oppo_hand(1)),...
    deck(1,oppo_hand(2)),deck(2,oppo_hand(2)),...
    deck(1,cards_on_table(1)),deck(2,cards_on_table(1)),...
    deck(1,cards_on_table(2)),deck(2,cards_on_table(2)),...
    deck(1,cards_on_table(3)),deck(2,cards_on_table(3)),...
    deck(1,cards_on_table(4)),deck(2,cards_on_table(4)),...
    deck(1,cards_on_table(5)),deck(2,cards_on_table(5)));

if player_wins == 1
    format = 'You win!\n';
    win_style = final_player_hand_array;
elseif player_ties == 1
    format = 'You tied.\n';
    win_style = final_player_hand_array;
else
    format = 'You lose.\n';
    win_style = final_oppo_hand_array;
end
fprintf(['The winning hand was a ' win_style '.\n']);
fprintf(format);
