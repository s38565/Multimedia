function [ img, MV] = FullSearch( reference, target, macroblockSize, searchRange, x, y)

    s = size(target);
    MV = zeros(s(1)/macroblockSize, s(2)/macroblockSize, 2); 
    myTarget = target(x:x + macroblockSize - 1, y:y + macroblockSize - 1,:);
    SAD_min = 9999999;
    choosed_i = 0;
    choosed_j = 0;

    for i = 1-searchRange:searchRange-1
        for j = 1-searchRange:searchRange-1
            
            x1 = x + i;
            x2 = x1 + macroblockSize - 1;
            y1 = y + j;
            y2 = y1 + macroblockSize - 1;
            
            if x1 > 0 && x2 <= s(1) && y1 > 0 && y2 <= s(2)                  
                myRef = reference(x1:x2, y1:y2,:);
                SAD = abs( myTarget - myRef);
                SAD = sum(sum(sum(SAD)));

                if SAD < SAD_min
                    SAD_min = SAD;
                    choosed_i = x + i;
                    choosed_j = y + j;
                    MV(ceil(x/macroblockSize), ceil(y/macroblockSize), 1) = choosed_i - x;
                    MV(ceil(x/macroblockSize), ceil(y/macroblockSize), 2) = choosed_j - y;
                end
            end 
        end
    end
    x3 = choosed_i + macroblockSize - 1;
    y3 = choosed_j + macroblockSize - 1;
    img = reference(choosed_i:x3, choosed_j:y3, :);
end

