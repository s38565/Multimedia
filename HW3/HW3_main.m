
clear; clc; close all;

%% Question 1 
% Load reference image: frame437
% Load target image: frame439

ref_img = imread('data/frame437.jpg');
ref = im2double(ref_img);
tar_img = imread('data/frame439.jpg');
tar = im2double(tar_img);
[x,y,z] = size(ref_img);

%figure; imshow(ref/2+0.5); % "ref" is reference image
% Show motion vectors:
% - MV is your motion vectors matrix
% - Size of MV is (h/macroblockSize, w/macroblockSize, 2)
% - Frame size: (h, w, 3) 
%hold on, quiver(1:macroblockSize:w, 1:macroblockSize:h, MV(:,:, 2), MV(:,:,1)), hold off; 

% search range = กำ8 / macroblock size = 8x8

searchRange = 8;
macroblockSize = 8;
tic
[predicted_8_8, MV_8_8] = MotionEstimation(ref,tar, macroblockSize, searchRange, 'full_search');
toc
% search range = กำ8 / macroblock size = 16x16

searchRange = 8;
macroblockSize = 16;
[predicted_16_8, MV_16_8] = MotionEstimation(ref,tar, macroblockSize, searchRange, 'full_search');

% search range = กำ16 / macroblock size = 8x8

searchRange = 16;
macroblockSize = 8;
tic
[predicted_8_16, MV_8_16] = MotionEstimation(ref,tar, macroblockSize, searchRange, 'full_search');
toc
% search range = กำ16 / macroblock size = 16x16

searchRange = 16;
macroblockSize = 16;
[predicted_16_16, MV_16_16] = MotionEstimation(ref,tar, macroblockSize, searchRange, 'full_search');

% 2D Logarithmic Search

% search range = กำ8 / macroblock size = 8x8

searchRange = 8;
macroblockSize = 8;
tic
[twoD_8_8, MV2_8_8] = MotionEstimation(ref,tar, macroblockSize, searchRange, 'log');
toc
% search range = กำ8 / macroblock size = 16x16

searchRange = 8;
macroblockSize = 16;
[twoD_16_8, MV2_16_8] = MotionEstimation(ref,tar, macroblockSize, searchRange, 'log');

% search range = กำ16 / macroblock size = 8x8

searchRange = 16;
macroblockSize = 8;
tic
[twoD_8_16, MV2_8_16] = MotionEstimation(ref,tar, macroblockSize, searchRange, 'log');
toc
% search range = กำ16 / macroblock size = 16x16

searchRange = 16;
macroblockSize = 16;
[twoD_16_16, MV2_16_16] = MotionEstimation(ref,tar, macroblockSize, searchRange, 'log');


%SHOW predicted images
figure('name', 'Predicted images for full search');

subplot(2, 2, 1);
imshow(predicted_8_8);
title('full search with p=8 & N=8'); 

subplot(2, 2, 2);
imshow(predicted_16_8);
title('full search with p=8 & N=16'); 

subplot(2, 2, 3);
imshow(predicted_8_16);
title('full search with p=16 & N=8'); 

subplot(2, 2, 4);
imshow(predicted_16_16);
title('full search with p=16 & N=16'); 

figure('name', 'Predicted images for 2D Log');

subplot(2, 2, 1);
imshow(twoD_8_8);
title('2D Log with p=8 & N=8'); 

subplot(2, 2, 2);
imshow(twoD_16_8);
title('2D Log with p=8 & N=16'); 

subplot(2, 2, 3);
imshow(twoD_8_16);
title('2D Log with p=16 & N=8'); 

subplot(2, 2, 4);
imshow(twoD_16_16);
title('2D Log with p=16 & N=16'); 


%hold on, quiver(1:macroblockSize:w, 1:macroblockSize:h, MV(:,:, 2), MV(:,:,1)), hold off; 

figure('name','Motion vectors for full search');
subplot(2, 2, 1);
imshow(tar/2+0.5);
hold on, quiver(1:8:y, 1:8:x, MV_8_8(:,:, 2), MV_8_8(:,:,1)), hold off; 
title('p=8 & N=8'); 

subplot(2, 2, 2);
imshow(tar/2+0.5);
hold on, quiver(1:16:y, 1:16:x, MV_16_8(:,:, 2), MV_16_8(:,:,1)), hold off; 
title('p=8 & N=16'); 

subplot(2, 2, 3);
imshow(tar/2+0.5);
hold on, quiver(1:8:y, 1:8:x, MV_8_16(:,:, 2), MV_8_16(:,:,1)), hold off; 
title('p=16 & N=8'); 

subplot(2, 2, 4);
imshow(tar/2+0.5);
hold on, quiver(1:16:y, 1:16:x, MV_16_16(:,:, 2), MV_16_16(:,:,1)), hold off; 
title('p=16 & N=16'); 

figure('name','Motion vectors for 2D Log');
subplot(2, 2, 1);
imshow(tar/2+0.5);
hold on, quiver(1:8:y, 1:8:x, MV2_8_8(:,:, 2), MV2_8_8(:,:,1)), hold off; 
title('p=8 & N=8'); 

subplot(2, 2, 2);
imshow(tar/2+0.5);
hold on, quiver(1:16:y, 1:16:x, MV2_16_8(:,:, 2), MV2_16_8(:,:,1)), hold off; 
title('p=8 & N=16'); 

subplot(2, 2, 3);
imshow(tar/2+0.5);
hold on, quiver(1:8:y, 1:8:x, MV2_8_16(:,:, 2), MV2_8_16(:,:,1)), hold off; 
title('p=16 & N=8'); 

subplot(2, 2, 4);
imshow(tar/2+0.5);
hold on, quiver(1:16:y, 1:16:x, MV2_16_16(:,:, 2), MV2_16_16(:,:,1)), hold off; 
title('p=16 & N=16'); 


Residual_8_8 = Residual(tar, predicted_8_8);
Residual_16_8 = Residual(tar, predicted_16_8);
Residual_8_16 = Residual(tar, predicted_8_16);
Residual_16_16 = Residual(tar, predicted_16_16);

Residual_2_8_8 = Residual(tar,twoD_8_8);
Residual_2_16_8 = Residual(tar,twoD_16_8);
Residual_2_8_16 = Residual(tar,twoD_16_8);
Residual_2_16_16 = Residual(tar,twoD_16_16);


figure('name', 'Residual images for full search');
subplot(2, 2, 1);
imshow(Residual_8_8);
title('full search with p=8 & N=8'); 


subplot(2, 2, 2);
imshow(Residual_16_8);
title('full search with p=8 & N=16'); 


subplot(2, 2, 3);
imshow(Residual_8_16);
title('full search with p=16 & N=8'); 


subplot(2, 2, 4);
imshow(Residual_16_16);
title('full search with p=16 & N=16'); 

figure('name', 'Residual images for 2D Log');
subplot(2, 2, 1);
imshow(Residual_2_8_8);
title('2D Log with p=8 & N=8'); 


subplot(2, 2, 2);
imshow(Residual_2_16_8);
title('2D Log with p=8 & N=16'); 


subplot(2, 2, 3);
imshow(Residual_2_8_16);
title('2D Log with p=16 & N=8'); 


subplot(2, 2, 4);
imshow(Residual_2_16_16);
title('2D Log with p=16 & N=16'); 
%% Plot total SAD and PSNR
%SHOW SAD
figure('name', 'SAD values');

%full

full_SAD_8_8 = mySAD(tar,predicted_8_8);
full_SAD_16_8 = mySAD(tar,predicted_16_8);
full_SAD_8_16 = mySAD(tar,predicted_8_16);
full_SAD_16_16 = mySAD(tar,predicted_16_16);

SAD_full = [full_SAD_8_8, full_SAD_16_8, full_SAD_8_16, full_SAD_16_16];

%2D

twoD_SAD_8_8 = mySAD(tar,twoD_8_8);
twoD_SAD_16_8 = mySAD(tar,twoD_16_8);
twoD_SAD_8_16 = mySAD(tar,twoD_8_16);
twoD_SAD_16_16 = mySAD(tar,twoD_16_16);

SAD_2D = [twoD_SAD_8_8, twoD_SAD_16_8, twoD_SAD_8_16, twoD_SAD_16_16];

x = [1 2 3 4];
plot(x, SAD_full, x, SAD_2D);
legend('full', '2D');
xticks(x);
xticklabels({'8, 8x8', '8, 16x16', '16, 8x8', '16, 16x16'});
title('SAD');


figure('name', '(1). PSNR');
target = im2uint8(tar);

%full search
%n=8 p=8

predicted_8_8 = im2uint8(predicted_8_8);
full_PSNR_8_8 = myPSNR(target,predicted_8_8);

%n=16 p=8
predicted_16_8=im2uint8(predicted_16_8);
full_PSNR_16_8 = myPSNR(target,predicted_16_8);

%n=8 p=16
predicted_8_16=im2uint8(predicted_8_16);
full_PSNR_8_16 = myPSNR(target,predicted_8_16);

%n=16 p=16
predicted_16_16=im2uint8(predicted_16_16);
full_PSNR_16_16 = myPSNR(target,predicted_16_16);

PSNR_full = [full_PSNR_8_8, full_PSNR_16_8, full_PSNR_8_16, full_PSNR_16_16];  

%2D
%n=8 p=8
twoD_8_8=im2uint8(twoD_8_8);
PSNR_twoD_8_8 = myPSNR(target,twoD_8_8);

%n=16 p=8

twoD_16_8=im2uint8(twoD_16_8);
PSNR_twoD_16_8 = myPSNR(target,twoD_16_8);

%n=8 p=16
twoD_8_16=im2uint8(twoD_8_16);
PSNR_twoD_8_16 = myPSNR(target,twoD_8_16);

%n=16 p=16
twoD_16_16=im2uint8(twoD_16_16);
PSNR_twoD_16_16 = myPSNR(target,twoD_16_16);

PSNR_2D = [PSNR_twoD_8_8, PSNR_twoD_16_8, PSNR_twoD_8_16, PSNR_twoD_16_16];

x = [1 2 3 4];
plot(x, PSNR_full, x, PSNR_2D);
legend('full', '2D');
xticks(x);
xticklabels({'8, 8x8', '8, 16x16', '16, 8x8', '16, 16x16'});
title('PSNR');

%% Question 2
% Load reference image: frame432
% Target image is same as Q1: frame439

ref1 = imread('data/frame432.jpg');
ref1 = im2double(ref1);

% search range = กำ8 / macroblock size = 8x8

searchRange = 8;
macroblockSize = 8;
[predicted_Q2, MV_Q2] = MotionEstimation(ref1,tar, macroblockSize, searchRange, 'full_search');

% PSNR

target = im2uint8(tar);
predicted_Q2 = im2uint8(predicted_Q2);
PSNR_Q2 = myPSNR(predicted_Q2,target);

disp(full_PSNR_8_8);
disp(PSNR_Q2);
