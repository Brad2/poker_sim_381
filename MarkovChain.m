function win_chance = MarkovChain(player_cards_in_play,oppo_cards_in_play,deck,cards_avail)
%MARKOVCHAIN Summary of this function goes here
%   Detailed explanation goes here

num_MC_wins = 0;

for i = 1:52
    temp_player_cards = player_cards_in_play;
    temp_oppo_cards = oppo_cards_in_play;
    if cards_avail(i) == 1
        temp_player_cards = [temp_player_cards i];
        temp_oppo_cards = [temp_oppo_cards i];
        
        [player_rank,player_rank_sec,player_pairs,~,player_highcard] = best_hand(temp_player_cards,deck);
        [oppo_rank,oppo_rank_sec,oppo_pairs,~,oppo_highcard] = best_hand(temp_oppo_cards,deck);
           
        if player_rank > oppo_rank
            num_MC_wins = num_MC_wins + 1;
        elseif player_rank == oppo_rank
            if player_pairs == 1 && oppo_pairs == 1
                if player_rank_sec > oppo_rank_sec
                    num_MC_wins = num_MC_wins + 1;
                elseif player_rank_sec == oppo_rank_sec
                    if player_highcard > oppo_highcard
                        num_MC_wins = num_MC_wins + 1;
                    end
                end
            elseif player_highcard > oppo_highcard
                num_MC_wins = num_MC_wins + 1;
            end
        end
    end
end

win_chance = num_MC_wins/44;
end

