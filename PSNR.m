function output = PSNR(image1, image2)
%PSNR Summary of this function goes here
%   Detailed explanation goes here

[w,h,~] = size(image1);
% compute square mean difference

c1 = im2uint8(image1);
c2 = im2uint8(image2);

d = (c1 - c2) .^ 2;
MSE = sum(d(:)) / (3 * w * h);

output = log10(1 / MSE) * 10;

end


