function out = mdct(img, n)

[w,h,c] = size(img);
tmp = zeros(w,h,c);
DCT = zeros(w,h,c);
out = zeros(w,h,c);
A = zeros(8, 8);

for i = 0:7
	for j = 0:7
        if i ~= 0
            a = sqrt(2/8);
        else
            a = sqrt(1/8);
        end
        A(i+1, j+1) = cos(pi * (j + 0.5) * i/8) * a;
	end
end

B = A';

for k = 1:8:w
    for l = 1:8:h
        for z = 1:c
            tmp = img(k:k+7,l:l+7,z);
            tmp = A * tmp * B;
            DCT(k:k+n-1,l:l+n-1,z) = tmp(1:n, 1:n, 1);
            out(k:k+7,l:l+7,z) = B * DCT(k:k+7,l:l+7,z) * A;
        end
    end
end
end