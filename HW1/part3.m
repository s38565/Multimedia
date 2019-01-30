%% clear
clear all; 
close all; 
clc;
image = im2double(imread('data/cat3_LR.png'));
image1 = im2double(imread('data/cat3_HR.png'));
[w, h, z] = size(image);
scale_w = 4*w;
scale_h = 4*h;
nn_image = zeros(scale_w, scale_h, z);
bilinear_image = zeros(scale_w, scale_h, z);

%% nearest-neighbor interpolation

for i = 1:scale_w
	for j = 1:scale_h
        floor_i = 1 + floor((i-1)/4);
        floor_j = 1 + floor((j-1)/4);
		i1 = min(w, floor_i);
		j1 = min(h, floor_j);
		nn_image(i, j, :) = image(i1, j1, :);
	end
end

figure, imshow(nn_image);
title('nearest-neighbor interpolation');
[w1,h1,~] = size(image1);
d = (image1 - nn_image) .^ 2;
MSE = sum(d(:)) / (3 * w1 * h1);
psnr_nn = log10(1 / MSE) * 10;

%% bilinear interpolation

image_b = bilinear(image);
figure, imshow(image_b);
title('Bilinear interpolation');
[w1,h1,~] = size(image1);
d = (image1 - image_b) .^ 2;
MSE = sum(d(:)) / (3 * w1 * h1);
psnr_bilinear = log10(1 / MSE) * 10;

%% bicubic interpolation

image = imread('data/cat3_LR.png');
test = bicubic(image, 4);
figure, imshow(test);
title('Bicubic interpolation');
test = im2double(test);
[w1,h1,~] = size(image1);
d = (image1 - test) .^ 2;
MSE = sum(d(:)) / (3 * w1 * h1);
psnr_bicubic = log10(1 / MSE) * 10;
