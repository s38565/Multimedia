clear all;
close all;
clc;

img = im2double(imread('data\cat1.png'));
[w,h,c] = size(img);

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

%% compressed by n=2
c2 = mdct(img, 2);

figure, imshow(c2);
title('(a) n=2');

[w1,h1,~] = size(img);
d = (img - c2) .^ 2;
MSE = sum(d(:)) / (3 * w1 * h1);
psnr_c2 = log10(1 / MSE) * 10;

disp("(a). PSNR(n=2): "+psnr_c2);
%% compressed by n=4

c4 = mdct(img, 4);

figure, imshow(c4);
title('(a) n=4');
[w1,h1,~] = size(img);
d = (img - c4) .^ 2;
MSE = sum(d(:)) / (3 * w1 * h1);
psnr_c4 = log10(1 / MSE) * 10;

disp("(a). PSNR(n=4): "+psnr_c4);
%% compressed by n=8
c8 = mdct(img, 8);
figure, imshow(c8);
title('(a) n=8');

psnr_c8 = PSNR(img, c8);
disp("(a). PSNR(n=8): "+psnr_c8);
%% YIQ

img1 = zeros(w,h,c);
YIQ = [0.299, 0.587, 0.114; 0.596, -0.275, -0.321; 0.212, -0.523, 0.311];

for i = 1:w
    for j = 1:h
        img1(i,j,1) = 0.2989 * img(i,j,1) + 0.5870*img(i,j,2) + 0.114 * img(i,j,3);
        img1(i,j,2) = 0.596 * img(i,j,1) - 0.275 * img(i,j,2) - 0.321 * img(i,j,3);
        img1(i,j,3) = 0.212 * img(i,j,1) - 0.523 * img(i,j,2) + 0.311 * img(i,j,3);
    end
end

%% compressed by n=2
c2 = mdct(img1,2);
y2 = myiq(img1,c2);

figure, imshow(y2);
title('(b) n=2');

[w1,h1,~] = size(img);
d = (img - y2) .^ 2;
MSE = sum(d(:)) / (3 * w1 * h1);
psnr_c2 = log10(1 / MSE) * 10;

disp("(b). PSNR(n=2): "+psnr_c2);

%% compressed by n=4
c4 = mdct(img1,4);
y4 = myiq(img1,c4);

figure, imshow(y4);
title('(b) n=4');

[w1,h1,~] = size(img);
d = (img - y4) .^ 2;
MSE = sum(d(:)) / (3 * w1 * h1);
psnr_c4 = log10(1 / MSE) * 10;

disp("(b). PSNR(n=4): "+psnr_c4);
%% compressed by n=8
c8 = mdct(img1, 8);
y8 = myiq(img1, c8);

figure, imshow(y8);
title('(b) n=8');

psnr_c8 = PSNR(img, y8);
disp("(b). PSNR(n=8): "+psnr_c8);
