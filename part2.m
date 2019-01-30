%% clear
clear all;
close all;
clc;

%% initialization
img = imread('data/cat2_gray.png');

figure, imshow(img);
title('original');

origin = imread('data/cat2_gray.png');

size = size(origin);
noise = zeros(size);
avg = zeros(size);
error = zeros(size);


%% 1. noise dithering
ran = unidrnd(256) - 1; % random a num between 0~255

for i=1:size(1)
     for j=1:size(2)
       if origin(i,j) <= ran
           noise(i,j) = 0; % black
       else
           noise(i,j) = 1; % white
       end
      
     end
end

noise_uint = im2uint8(noise);
figure, imshow(noise_uint);
title('noise dithering');

%% 2. average dithering

total = sum(origin(:));
average = total / (size(1) * size(2));
floor = floor(average);
for i=1:size(1)
     for j=1:size(2)
       if origin(i,j) > floor
           avg(i,j) = 1; % white
       else
           avg(i,j) = 0; % black
       end
     end
end

avg_uint = im2uint8(avg);
figure, imshow(avg_uint);
title('average dithering');

%% 3. error diffusion dithering
for i=1:size(1)
     for j=1:size(2)
         
       if origin(i,j) >= 128
           e = origin(i,j) - 255;  
       else
           e = origin(i,j);
       end
       
       % p(x+1,y) = p(x+1,y) + 7e/16
       if j < size(2)
           origin(i,j+1) = origin(i,j+1) + ((7/16)*e);
       end
       % p(x-1,y+1) = p(x-1,y+1) + 3e/16
       if i < size(1) && j > 1
           origin(i+1, j-1) = origin(i+1, j-1) + ((3/16)*e);
       end
       % p(x,y+1) = p(x,y+1) + 5e/16
       if i < size(1) 
           origin(i+1,j) = origin(i+1, j) + ((5/16)*e);
       end
       % p(x+1,y+1) = p(x+1,y+1) + 1e/16
       if i < size(1) && j < size(2)
           origin(i+1,j+1) = origin(i+1,j+1) + ((1/16)*e);
       end
     end
end

for i=1:size(1)
     for j=1:size(2)
         if origin(i,j) < 128
             error(i,j) = 0;
         else
             error(i,j) = 1;
         end
     end
end

error_uint=im2uint8(error);
figure, imshow(error_uint);
title('error diffusion dithering');