function out = myiq(img, compress)

[w,h,c] = size(img);

for i = 1:w
    for j = 1:h
        out(i,j,1) =compress(i,j,1) + 0.956 * compress(i,j,2) + 0.621 * compress(i,j,3);
        out(i,j,2) =compress(i,j,1) - 0.272 * compress(i,j,2) - 0.647 * compress(i,j,3);
        out(i,j,3) =compress(i,j,1) - 1.106 * compress(i,j,2) + 1.703 * compress(i,j,3);
    end
end

end

