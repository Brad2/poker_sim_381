function [hand_rank,sec_hand_rank,pairs,hand_array,highcard] = best_hand(card_list,deck)
%BEST_HAND Summary of this function goes here
%   Detailed explanation goes here
%clubs = [1:4:52];
%spades = [2:4:52];
%hearts = [3:4:52];
%diamonds = [4:4:52];
%
%twos = [1:4];
%threes = [5:8];
%fours = [9:12];
%fives = [13:16];
%sixes = [17:20];
%sevens = [21:24];
%eights = [25:28];
%nines = [29:32];
%tens = [33:36];
%jacks = [37:40];
%queens = [41:44];
%kings = [45:48];
%aces = [49:52];

card_list = sort(card_list);

hand_rank = 0;
sec_hand_rank = 0;
pairs = 0;


%find the high card in hand
highcard = ((card_list(7)-(mod(card_list(7)+3,4)+1))/4)+2;
hand_array = 'high card';

%check if card_list has a Two of a kind
for i = 1:6
    if deck(1,card_list(i))==deck(1,card_list(i+1))
        hand_rank = 2+((card_list(i)-(mod(card_list(i)+3,4)+1))/4)/12;
        hand_array = 'two of a kind';
        if i == 6
            highcard = ((card_list(5)-(mod(card_list(5)+3,4)+1))/4)+2;
        end
    end
end

%check if card_list has a Pair
for i = 1:4
    for j = 1+i:6
        if (deck(1,card_list(i))==deck(1,card_list(i+1))) && ...
                (deck(1,card_list(j))==deck(1,card_list(j+1)))
            hand_rank = 3+((card_list(j)-(mod(card_list(j)+3,4)+1))/4)/12;
            sec_hand_rank = 3+((card_list(i)-(mod(card_list(i)+3,4)+1))/4)/12;
            pairs = 1;
            hand_array = 'pair';
            if j == 6
                if i == 4
                    highcard = ((card_list(3)-(mod(card_list(3)+3,4)+1))/4)+2;
                else
                    highcard = ((card_list(5)-(mod(card_list(5)+3,4)+1))/4)+2;
                end
            end
        end
    end
end

%check if card_list has a Three of a kind
for i = 1:5
    if deck(1,card_list(i))==deck(1,card_list(i+1)) && ...
            deck(1,card_list(i+1))==deck(1,card_list(i+2))
        hand_rank = 4+((card_list(i)-(mod(card_list(i)+3,4)+1))/4)/12;
        hand_array = 'three of a kind';
        if i == 5
            highcard = ((card_list(4)-(mod(card_list(4)+3,4)+1))/4)+2;
        end
    end
end

%check if card_list has a Straight
ugly_hand = [((card_list(1)-(mod(card_list(1)+3,4)+1))/4) ...
    ((card_list(2)-(mod(card_list(2)+3,4)+1))/4) ...
    ((card_list(3)-(mod(card_list(3)+3,4)+1))/4) ...
    ((card_list(4)-(mod(card_list(4)+3,4)+1))/4) ...
    ((card_list(5)-(mod(card_list(5)+3,4)+1))/4) ...
    ((card_list(6)-(mod(card_list(6)+3,4)+1))/4) ...
    ((card_list(7)-(mod(card_list(7)+3,4)+1))/4)];
for i = 1:6
    if i == 1
        for j = 1:6
            temp_ugly_hand = ugly_hand(2:end);
            if j == 1
                compare_ugly_hand = temp_ugly_hand(2:end);
            elseif j == 6
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:end-1)];
            else
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:j-1) temp_ugly_hand(j+1:end)];
            end
        end   
    elseif i == 2
        for j = 2:6
            temp_ugly_hand = [ugly_hand(1:1) ugly_hand(3:end)];
            if j == 6
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:end-1)];
            else
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:j-1) temp_ugly_hand(j+1:end)];
            end
        end
    elseif i == 3
        for j = 3:6
            temp_ugly_hand = [ugly_hand(1:2) ugly_hand(4:end)];
            if j == 6
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:end-1)];
            else
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:j-1) temp_ugly_hand(j+1:end)];
            end
        end
    elseif i == 4
        for j = 4:6
            temp_ugly_hand = [ugly_hand(1:3) ugly_hand(5:end)];
            if j == 6
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:end-1)];
            else
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:j-1) temp_ugly_hand(j+1:end)];
            end
        end
    elseif i == 5
        for j = 5:6
            temp_ugly_hand = [ugly_hand(1:4) ugly_hand(6:end)];
            if j == 6
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:end-1)];
            else
                compare_ugly_hand = [compare_ugly_hand;temp_ugly_hand(1:j-1) temp_ugly_hand(j+1:end)];
            end
        end
    else
        compare_ugly_hand = [compare_ugly_hand;ugly_hand(1:end-2)];
    end
end
for i = 1:length(compare_ugly_hand)
    if compare_ugly_hand(i,5) == compare_ugly_hand(i,4)+1 && ...
            compare_ugly_hand(i,4) == compare_ugly_hand(i,3)+1 && ...
            compare_ugly_hand(i,3) == compare_ugly_hand(i,2)+1 && ...
            compare_ugly_hand(i,2) == compare_ugly_hand(i,1)+1
        hand_rank = 5;
        hand_array = 'straight';
    end
end

%check if card_list has a Flush
for i = 1:6
    if i == 1
        for j = 1:6
            temp_card_list = card_list(2:end);
            if j == 1
                compare_card_list = temp_card_list(2:end);
            elseif j == 6
                compare_card_list = [compare_card_list;temp_card_list(1:end-1)];
            else
                compare_card_list = [compare_card_list;temp_card_list(1:j-1) temp_card_list(j+1:end)];
            end
        end   
    elseif i == 2
        for j = 2:6
            temp_card_list = [card_list(1:1) card_list(3:end)];
            if j == 6
                compare_card_list = [compare_card_list;temp_card_list(1:end-1)];
            else
                compare_card_list = [compare_card_list;temp_card_list(1:j-1) temp_card_list(j+1:end)];
            end
        end
    elseif i == 3
        for j = 3:6
            temp_card_list = [card_list(1:2) card_list(4:end)];
            if j == 6
                compare_card_list = [compare_card_list;temp_card_list(1:end-1)];
            else
                compare_card_list = [compare_card_list;temp_card_list(1:j-1) temp_card_list(j+1:end)];
            end
        end
    elseif i == 4
        for j = 4:6
            temp_card_list = [card_list(1:3) card_list(5:end)];
            if j == 6
                compare_card_list = [compare_card_list;temp_card_list(1:end-1)];
            else
                compare_card_list = [compare_card_list;temp_card_list(1:j-1) temp_card_list(j+1:end)];
            end
        end
    elseif i == 5
        for j = 5:6
            temp_card_list = [card_list(1:4) card_list(6:end)];
            if j == 6
                compare_card_list = [compare_card_list;temp_card_list(1:end-1)];
            else
                compare_card_list = [compare_card_list;temp_card_list(1:j-1) temp_card_list(j+1:end)];
            end
        end
    else
        compare_card_list = [compare_card_list;card_list(1:end-2)];
    end
end
for i = 1:length(compare_card_list)
    if mod(compare_card_list(i,1),4) == mod(compare_card_list(i,2),4) && ...
            mod(compare_card_list(i,1),4) == mod(compare_card_list(i,3),4) && ...
            mod(compare_card_list(i,1),4) == mod(compare_card_list(i,4),4) && ...
            mod(compare_card_list(i,1),4) == mod(compare_card_list(i,5),4)
        hand_rank = 6;
        hand_array = 'flush';
    end
end


%check if card_list has a Full House
for j = 1:length(compare_card_list)
    for i = 1:2:3
        if deck(1,compare_card_list(j,i))==deck(1,compare_card_list(j,i+1)) && ...
                deck(1,compare_card_list(j,i+1))==deck(1,compare_card_list(j,i+2))
            if i == 1
                if deck(1,compare_card_list(j,4))==deck(1,compare_card_list(j,5))
                    hand_rank = 7+((compare_card_list(j,1)-(mod(compare_card_list(j,1)+3,4)+1))/4)/12;
                    sec_hand_rank = 7+((compare_card_list(j,5)-(mod(compare_card_list(j,5)+3,4)+1))/4)/12;
                    hand_array = 'full house';
                    index = wrong_way_to_calc_highcard(i,j);
                    highcard = ((card_list(index)-(mod(card_list(index)+3,4)+1))/4)+2;
                end
            else
                if deck(1,compare_card_list(j,1))==deck(1,compare_card_list(j,2))
                    hand_rank = 7+((compare_card_list(j,3)-(mod(compare_card_list(j,3)+3,4)+1))/4)/12;
                    sec_hand_rank = 7+((compare_card_list(j,1)-(mod(compare_card_list(j,1)+3,4)+1))/4)/12;
                    hand_array = 'full house';
                    index = wrong_way_to_calc_highcard(i,j);
                    highcard = ((card_list(index)-(mod(card_list(index)+3,4)+1))/4)+2;
                end
            end
        end
    end
end

%check if card_list has a 4 of a kind
for j = 1:length(compare_card_list)
    for i = 1:2
        if mod(compare_card_list(j,i),4) == 1
            if isequal([compare_card_list(j,i) compare_card_list(j,i+1) compare_card_list(j,i+2) compare_card_list(j,i+3)], ...
                    [compare_card_list(j,i) compare_card_list(j,i)+1 compare_card_list(j,i)+2 compare_card_list(j,i)+3])
                if i == 1
                    hand_rank = 8+((compare_card_list(j,4)-(mod(compare_card_list(j,4)+3,4)+1))/4)/12;
                    index = wrong_way_to_calc_highcard(i,j);
                    highcard = ((card_list(index)-(mod(card_list(index)+3,4)+1))/4)+2;
                else
                    hand_rank = 8+((compare_card_list(j,5)-(mod(compare_card_list(j,5)+3,4)+1))/4)/12;
                    index = wrong_way_to_calc_highcard(i,j);
                    highcard = ((card_list(index)-(mod(card_list(index)+3,4)+1))/4)+2;
                end
                hand_array = 'four of a kind';
            end
        end
    end
end
    

%check if card_list has a Straight Flush
for j = 1:length(compare_card_list)
    if compare_card_list(j,1) < 33
        if isequal(compare_card_list(j,1:end),[compare_card_list(j,1) compare_card_list(j,1)+4 compare_card_list(j,1)+8 ...
                compare_card_list(j,1)+12 compare_card_list(j,1)+16])
            hand_rank = 9;
            hand_array = 'straight flush';
        end
    end
end

    

%check if card_list has a Royal Flush
for j = 1:length(compare_card_list)
    for i = 1:5
        RF = 1;
        if compare_card_list(j,i)<33
            RF = 0;
        end
    end
    if RF == 1
        RF0 = [33 37 41 45 49];
        RF0 = [RF0;RF0 + 1;RF0 + 2;RF0 + 3];
        for i = 1:4
            if isequal(compare_card_list(j,1:end),RF0(i,1:end))
                hand_rank = 10;
                hand_array = 'royal flush';
            end
        end
    end
end

    

