function [img, MV] = TwodLogSearch( reference, target,  macroblockSize, searchRange, x, y)
    
    s = size(target);
    MV = zeros(s(1)/macroblockSize, s(2)/macroblockSize, 2);
    myTarget = target(x:x+macroblockSize-1, y:y+macroblockSize-1,:);
    count = 2 ^ (floor(log2(searchRange))-1);
    n = max(2, count);
    q = 0; 
    l = 0;
   
    while true
        while true
            choosed = 1;
            SAD_min = realmax;
            
            for len = 1 : 5
                if(len == 1 || len == 3 || len == 5)
                    i = 0;
                end
                if len == 2
                    i = n;
                end
                if len == 4
                    i = -n;
                end
                
                if(len == 1 || len == 2 || len == 4)
                    j = 0;
                end
                if len == 3
                    j = n;
                end
                if len == 5
                    j = -n;
                end
                
                x1 = x + q + i;
                x2 = x1 + macroblockSize - 1;
                y1 = y + l + j;
                y2 = y1 + macroblockSize - 1;
                
                if(x1 > 0 && x2 <= s(1) && y1 > 0 && y2 <= s(2))
                    myRef = reference(x1:x2, y1:y2,:);
                    SAD = abs( myTarget - myRef);
                	SAD = sum(sum(sum(SAD)));
                    
                    if(SAD < SAD_min)
                        choosed = len;
                        SAD_min = SAD;
                    end
                    
                end
            end

            if choosed == 1
                break;
            end
            
            if(choosed == 1 || choosed == 3 || choosed == 5)
               i = 0;
            end
            if choosed == 2
               i = n;
            end
            if choosed == 4
                i = -n;
            end
            if(choosed == 1 || choosed == 2 || choosed == 4)
               j = 0;
            end
            if choosed == 3
                j = n;
            end
            if choosed == 5
               j = -n;
            end
            
            q = q + i; 
            l = l + j;
        end

        n = n / 2;
        
        if n == 1 
            break;   
        end
    end

    SAD_min = realmax;
    choosed_i = 0;
    choosed_j = 0;
    
   
    for i = -1:1
       for j = -1:1
            x1 = x + q + i;
            x2 = x1 + macroblockSize - 1;
            y1 = y + l + j;
            y2 = y1 + macroblockSize - 1;
            if(x1 > 0 && x2 <= s(1) && y1 > 0 && y2 <= s(2))
                myRef = reference(x1:x2, y1:y2,:);
                SAD = abs( myTarget - myRef);
                SAD = sum(sum(sum(SAD)));

                if(SAD < SAD_min)
                    SAD_min = SAD;
                    choosed_i = i;
                    choosed_j = j;     
                    %MV(ceil(x/macroblockSize), ceil(y/macroblockSize), 1) = choosed_i - x;
                    %MV(ceil(x/macroblockSize), ceil(y/macroblockSize), 2) = choosed_j - y;
                end
            end
            
       end      
    end
    
    
    
    
    q = q + choosed_i; 
    l = l + choosed_j;
    
    x3 = x + q;
    x4 = x3 + macroblockSize - 1;
    y3 = y + l;
    y4 = y3 + + macroblockSize - 1;
    
    img = reference( x3:x4, y3: y4,:);
    MV(ceil(x/macroblockSize), ceil(y/macroblockSize), 1) = x3 - x;
    MV(ceil(x/macroblockSize), ceil(y/macroblockSize), 2) = y3 - y;
end

