%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parameters to change
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
number_of_MC_sims = 15000; %could make this input
MaCh_MoCa = 1; %Set to 0 for Markov Chain and 1 for Monte Carlo Sim

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
    prompt = ['How many opponents do you want?\n'];
    num_oppo = input(prompt);

    if num_oppo < 1
        disp('Too few opponents\n');
    elseif num_oppo > 1
        disp('Too many opponents\n');
    else
        num_oppo_chosen = 1;
    end
end


while length(player_hand) ~= 2
    if length(player_hand) < 1
        prompt = ['What is the first card you want to have in your hand?\n'...
            '(To see the list of cards enter "card")\n'];
    else
        prompt = ['What is the second card you want to have in your hand?\n'...
            '(To see the list of cards enter "card")\n'];
    end
    
    x = input(prompt);

    if strcmp(x,'card')
        deck_list(deck);
    elseif card_avail(x) == 0
        disp('Card already chosen');
    else
        player_hand = [player_hand x];
        card_avail(x) = 0;
    end
end

while length(oppo_hand) < 2*num_oppo
    if mod(length(oppo_hand),2) < 1
        prompt = ['What is the first card you want to have in your opponents hand?\n'...
            '(To see the list of cards enter "card")\n'];
    else
        prompt = ['What is the second card you want to have in your opponents hand?\n'...
            '(To see the list of cards enter "card")\n'];
    end
    
    x = input(prompt);

    if strcmp(x,'card')
        deck_list(deck);
    elseif card_avail(x) == 0
        disp('Card already chosen');
    else
        oppo_hand = [oppo_hand x];
        card_avail(x) = 0;
    end
end

while length(cards_on_table) < 5
    if length(cards_on_table) < 3
        prompt = ['What cards do you want in the flop?\n'...
            '(To see the list of cards enter "card")\n'];
    elseif length(cards_on_table) < 4
        prompt = ['What card do you want in the turn?\n'...
            '(To see the list of cards enter "card")\n'];
    else
        prompt = ['What card do you want in the river?\n'...
            '(To see the list of cards enter "card")\n'];
    end
    
    x = input(prompt);

    if strcmp(x,'card')
        deck_list(deck);
    elseif card_avail(x) == 0
        disp('Card already chosen');
    else
        cards_on_table = [cards_on_table x];
        card_avail(x) = 0;
    end
    
    if length(cards_on_table) == 3
        if MaCh_MoCa == 0
            win_per = MarkovChain_2iter([player_hand cards_on_table], ...
                [oppo_hand cards_on_table],deck,card_avail);
        else
            [win_per,~] = MonteCarloSim(number_of_MC_sims, ...
                [player_hand cards_on_table],[oppo_hand cards_on_table],deck,card_avail);
        end
        
        format = ['In your hand:\n   %5s%1s %5s%1s\nIn your opponents hand'...
            ':\n   %5s%1s %5s%1s\nCards on the table:\n   %5s%1s %5s%1s %5s%1s'...
            '\nYou have a %2.4g%% chance to win.\n'];
        fprintf(format,deck(1,player_hand(1)),deck(2,player_hand(1)),...
            deck(1,player_hand(2)),deck(2,player_hand(2)),...
            deck(1,oppo_hand(1)),deck(2,oppo_hand(1)),...
            deck(1,oppo_hand(2)),deck(2,oppo_hand(2)),...
            deck(1,cards_on_table(1)),deck(2,cards_on_table(1)),...
            deck(1,cards_on_table(2)),deck(2,cards_on_table(2)),...
            deck(1,cards_on_table(3)),deck(2,cards_on_table(3)),100*win_per);
    elseif length(cards_on_table) == 4
        win_per_MaCh = MarkovChain([player_hand cards_on_table],...
            [oppo_hand cards_on_table],deck,card_avail);
        format = ['In your hand:\n   %5s%1s %5s%1s\nIn your opponents hand'...
            ':\n   %5s%1s %5s%1s\nCards on the table:\n   %5s%1s %5s%1s %5s%1s'...
            ' %5s%1s\nYou have a %2.4g%% chance to win.\n'];
        fprintf(format,deck(1,player_hand(1)),deck(2,player_hand(1)),...
            deck(1,player_hand(2)),deck(2,player_hand(2)),...
            deck(1,oppo_hand(1)),deck(2,oppo_hand(1)),...
            deck(1,oppo_hand(2)),deck(2,oppo_hand(2)),...
            deck(1,cards_on_table(1)),deck(2,cards_on_table(1)),...
            deck(1,cards_on_table(2)),deck(2,cards_on_table(2)),...
            deck(1,cards_on_table(3)),deck(2,cards_on_table(3)),...
            deck(1,cards_on_table(4)),deck(2,cards_on_table(4)),100*win_per_MaCh);
    elseif length(cards_on_table) == 5
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
