function [img, MV] = MotionEstimation( reference, target, macroblockSize, searchRange, method)
    
    s = size(target);
    img = zeros(s(1), s(2), s(3));
    MV = zeros(s(1)/macroblockSize, s(2)/macroblockSize, 2);
    
    for i = 1:macroblockSize:s(1)
        for j = 1:macroblockSize:s(2)
            
            i1 = i + macroblockSize - 1;
            j1 = j + macroblockSize - 1;
            
            %full search
            if strcmp(method, 'full_search')
                [motion, MV1] = FullSearch(reference, target, macroblockSize, searchRange, i, j);
                MV(ceil(i/macroblockSize), ceil(j/macroblockSize), 1) = MV1(ceil(i/macroblockSize), ceil(j/macroblockSize), 1);
                MV(ceil(i/macroblockSize), ceil(j/macroblockSize), 2) = MV1(ceil(i/macroblockSize), ceil(j/macroblockSize), 2);
                img(i:i1, j:j1, :) = motion;
            end
            
            % 2D log
            if strcmp(method, 'log')
                [motion, MV1] = TwodLogSearch(reference, target, macroblockSize, searchRange, i, j);
                MV(ceil(i/macroblockSize), ceil(j/macroblockSize), 1) = MV1(ceil(i/macroblockSize), ceil(j/macroblockSize), 1);
                MV(ceil(i/macroblockSize), ceil(j/macroblockSize), 2) = MV1(ceil(i/macroblockSize), ceil(j/macroblockSize), 2);
                img(i:i1, j:j1, :) = motion;
            end 
        end
    end
end


