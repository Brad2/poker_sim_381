function win_chance = MarkovChain_2iter(player_cards_in_play,oppo_cards_in_play,deck,cards_avail)
%MARKOVCHAIN_2ITER Summary of this function goes here
%   Detailed explanation goes here

a = [1:52];
MaCh_cards = nchoosek(a,2)';
num_wins = 0;
actl_sims = 0;

for i = 1:length(MaCh_cards)
    temp_player_card_list = player_cards_in_play; %temporary player card list that we want to reset each sim
    temp_oppo_card_list = oppo_cards_in_play; %temp oppo cards, resets each MC sim
    temp_cards_avail = cards_avail; %temp list of available cards
    if temp_cards_avail(MaCh_cards(1,i)) == 1
        temp_cards_avail(MaCh_cards(1,i)) = 0;
        temp_player_card_list = [temp_player_card_list MaCh_cards(1,i)];
        temp_oppo_card_list = [temp_oppo_card_list MaCh_cards(1,i)];
        
        if temp_cards_avail(MaCh_cards(2,i)) == 1
            temp_player_card_list = [temp_player_card_list MaCh_cards(2,i)];
            temp_oppo_card_list = [temp_oppo_card_list MaCh_cards(2,i)];
            
            [player_rank,player_rank_sec,player_pairs,~,player_highcard] = best_hand(temp_player_card_list,deck);
            [oppo_rank,oppo_rank_sec,oppo_pairs,~,oppo_highcard] = best_hand(temp_oppo_card_list,deck);
            
            if player_rank > oppo_rank
                num_wins = num_wins + 1;
            elseif player_rank == oppo_rank
                if player_pairs == 1 && oppo_pairs == 1
                    if player_rank_sec > oppo_rank_sec
                        num_wins = num_wins + 1;
                    elseif player_rank_sec == oppo_rank_sec
                        if player_highcard > oppo_highcard
                            num_wins = num_wins + 1;
                        end
                    end
                elseif player_highcard > oppo_highcard
                    num_wins = num_wins + 1;
                end
            end
            
            actl_sims = actl_sims + 1;
        end
    end
end

win_chance = num_wins/actl_sims;
end

